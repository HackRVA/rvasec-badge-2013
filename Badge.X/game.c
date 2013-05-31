#include "game.h"
#include <p18f2455.h>
#include <i2c.h>

//===========
//Globals and Defines
//===========
#define Accel_Write_Addr 0x98
#define Accel_Read_Addr 0x99

//Logical AND these with tilt to get badge accel state
#define alert 0x40
#define shake 0x80
#define tap 0x20
#define landscape_left 0x04
#define landscape_right 0x08
#define vertical_invert 0x14
#define vertical_normal 0x18

#define IR_LISTENING    0
#define IR_SAMPLING     1
#define IR_SAMPLEREADY  2
#define IR_SILENT       3

//base value for IR back off delay
#define base_backoff 55

extern void SendRC5(void);
extern volatile unsigned char IRstate;
extern volatile unsigned char IRbitCnt;
extern volatile unsigned char IRbits[4];
extern volatile unsigned char unIRbits[4];

extern volatile unsigned char AddrByte;
extern volatile unsigned char ToggByte;
extern volatile unsigned char DataByte;

//need to be able to play sounds
extern volatile short timer1Value;
extern volatile short timer1Counts;
extern rom far short freq[];

#define TIMER1HZ 1000000
#define TIMER1VAL 4096
#pragma udata

unsigned char irPayload_type = 0x00, irPayload_data = 0x00;

//Accelerometer related vars
unsigned char   shake_debounce,
                shake_count,
                tap_count,
                orientation_count;

char xA, yA, zA;  //Accel vectors

//the interrupt and the main code keep their own seq
//the interrupt increments its respective count and
//the main code will see the !=, and insert a tilt_ev
//into the main buffer
volatile unsigned char int_tilt_count = 0;
volatile unsigned char main_tilt_count = 0;

//keep track of the main leds
unsigned char green_leds = 0;

//tilt register contents from the accelerometer
volatile unsigned char tilt = 0;

//the badge id, you might say this is important
//should be stored in flash, but for now this will do
#define standard_backoff 300
unsigned char badge_id = 35; //min is 55
unsigned short slotted_backoff;// = base_backoff + badge_id;
unsigned short backoff_time = 0;

//keep track of game stage, start in welcome stage
enum Stage current_stage = welcome;

struct event_buffer *current_ev;

struct event_buffer main_ev = { empty_ev,   //back
                                empty_ev,   //middle
                                empty_ev};  //front

struct event_buffer sleep_ev = { empty_ev,
                                empty_ev,
                                empty_ev};

//function pointers replace switch case
void (*run_stage)(void) = Stage_Welcome; //stage running now
void (*return_stage)(void);          //stage to run after idle
void (*led_seq)(void);               //led seq to run if led_ev
void (*ir_resp)(unsigned char data); //ir method to run if irResp_ev

//Some more globals
unsigned short response_delay = 0;
unsigned short IR_backoff = 500;
unsigned short delay_count = 0;
unsigned short iteratorCount = 0;
unsigned short speed = 0;
unsigned char blink_loc = 0x80;
unsigned char seq = 0;
unsigned char hp = 20;
unsigned char errBits = 0x00;
unsigned char send_data = 0x00;
unsigned char next_life = reg_life;
unsigned short btn_debounce = 1;

unsigned char peers_met[10] = {0,0,0,0,0,0,0,0,0,0};

#pragma code
void Init_Game()
{
    current_ev = &main_ev;

    //beep when turned on
    PIE1bits.TMR1IE = 1;

    //set empty led event
    led_seq = led_seq_null;

    //run stages setup first
    enqueue(&main_ev, setup_ev);

    if(badge_id)
        //set backoff time based on badge id
        slotted_backoff = base_backoff + (unsigned short)badge_id * 20 ;
    else
         slotted_backoff = base_backoff;
    //backoff_time = badge_id;
}

void Run_Game()
{
    //execute the current stage (function ptr)
    run_stage();

    //unpack and check for errors, if type is ping request, setup
    //the send here
    if(IRstate == IR_SAMPLEREADY)
    {
        IRbitCnt = 0;
        
        //if not 14, then error and ignore
        if (14 == unManchester(IRbits, unIRbits))
        {
            //check that data sent was correct
            extractPayload(unIRbits, &irPayload_type, &irPayload_data);
            
            //if it is a ping, respond no matter what
            if(irPayload_type == type_ping_req)
            {
                //response method is ping response
                ir_resp = irCB_pingResp;

                //send the badges id
                send_data = badge_id;

                //enqueue a send/response event, initiate backoff
                enqueue(&main_ev, irResp_ev);

                //reset backoff counter
                response_delay = 0;

                //need to slot ping responses
                backoff_time = slotted_backoff;
            }
            else //otherwise, the stage handles it (not a ping)
                enqueue(&main_ev, irRec_ev);
        }
        IRstate = IR_LISTENING;
    }

    if(PORTCbits.RC2 == 0)
    {
        btn_debounce++;
        if(btn_debounce == 200)
            enqueue(&main_ev, button_ev);
    }
    else
        btn_debounce = 0x01;
}

///////////////////
//--Stages--
///////////////////
void Stage_Idle()
{
    switch(get_next(&sleep_ev))
    {
        case(empty_ev):
        {
            break;
        }
        case(setup_ev):
        {
//            response_delay = 0;
//            irPayload_type = 0xFF;
//
//            led_seq = led_seq_Loading;
//            enqueue(&main_ev, led_ev);
            enqueue(&sleep_ev, tilt_ev);
            set_leds(0x00);
            break;
        }
        case(tilt_ev):
        {
            check_tilt();
            break;
        }
//        case(shake_ev):
//        {
//            break;
//        }
//        case(tap_ev):
//        {
//            break;
//        }
//        case(button_ev):
//        {
//            break;
//        }
//        case(led_ev):
//        {
//            led_seq();
//            break;
//        }
//        case(irRec_ev):
//        {
//            break;
//        }
        case(irResp_ev):
        {
            response_delay++;
            if(response_delay > slotted_backoff)
            {
                response_delay = 0;
                ir_resp(send_data);
            }
            else
                enqueue(&main_ev, irResp_ev);

            break;
        }
    }
}

void Stage_Welcome()
{
    switch(get_next(&main_ev))
    {
        case(empty_ev):
        {
            break;
        }
        case(setup_ev):
        {
            response_delay = 0;
            irPayload_type = 0xFF;

            led_seq = led_seq_Loading;
            enqueue(&main_ev, led_ev);
            break;
        }
        case(tilt_ev):
        {
            check_tilt();
            break;
        }
        case(shake_ev):
        {
            break;
        }
        case(tap_ev):
        {
            break;
        }
        case(button_ev):
        {
            read_set_stage();
            break;
        }
        case(led_ev):
        {
            led_seq();
            break;
        }
        case(irRec_ev):
        {
            break;
        }
        case(irResp_ev):
        {
            response_delay++;
            if(response_delay > backoff_time)
            {
                response_delay = 0;
                ir_resp(send_data);
            }
            else
                enqueue(&main_ev, irResp_ev);

            break;
        }
    }
}

void Stage_Mimicry()
{
    switch(get_next(&main_ev))
    {
        case(empty_ev):
        {
            break;
        }
        case(setup_ev):
        {
            response_delay = 0;
            irPayload_type = 0xFF;

            break;
        }
        case(tilt_ev):
        {
            check_tilt();
            break;
        }
        case(shake_ev):
        {
            break;
        }
        case(tap_ev):
        {
            //was the tap at the right time?
            if((green_leds & blink_loc))
            {
                //did they win the round?
                if(blink_loc == 0x01)
                {
                    //round complete if they made it to the top speed
                    if(speed == 600)
                    {
                        //current_stage = balance;
                        run_stage = Stage_Balance;
                        green_leds = 0x00;
                        set_leds(0x00);

                        //set led event
                        enqueue(&main_ev, led_ev);

                        led_seq = led_seq_stageWin;
                        
                        enqueue(&main_ev, setup_ev);
                    }
                    else
                    {
                        speed += 200;
                        set_leds(0x00);
                        green_leds = 0x00;
                        blink_loc = 0x80;
                        

                        //set led event
                        enqueue(&main_ev, led_ev);

                        led_seq = led_seq_sectionWin;
                    }    
                }
                else
                {
                    //move blinking led up
                    blink_loc =  blink_loc >> 1;
                    green_leds = (green_leds >> 1) | (blink_loc | 0x80); 
                }
            }
            else//MISSED!
            {
                if(blink_loc != 0x80)
                {
                    blink_loc = blink_loc << 1;
                    green_leds = (green_leds << 1);
                }
            }
            break;
        }
        case(button_ev):
        {
            store_stage(0x00);
            break;
        }
        case(led_ev):
        {
            led_seq();

            return; //dont want to mess with delay count
        }
        case(irRec_ev):
        {    
            break;
        }
        case(irResp_ev):
        {
            response_delay++;
            if(response_delay > backoff_time)
            {
                response_delay = 0;
                ir_resp(send_data);
            }
            else
                enqueue(&main_ev, irResp_ev);

            break;
        }
    }

    if(!delay_count)
    {
        green_leds ^= blink_loc;
        delay_count++;
    }
    else
    {
        delay_count++;

        if(delay_count > (1600 - speed))
            delay_count = 0;
    }

    set_leds(green_leds);
}

void Stage_Balance()
{
    static unsigned char temp_leds = 0x00, time = 0x00, count = 0x00;
    
    switch(get_next(&main_ev))
    {
        case(empty_ev):
        {
            break;
        }
        case(setup_ev):
        {
            response_delay = 0;
            irPayload_type = 0xFF;
            accel_standby();
            blink_loc = 0x40;
            store_stage(0x01);
            break;
        }
        case(tilt_ev):
        {
            check_tilt();
            break;
        }
        case(shake_ev):
        {
            break;
        }
        case(tap_ev):
        {
            break;
        }
        case(button_ev):
        {
            break;
        }
        case(led_ev):
        {
            led_seq();

            return; //dont want to mess with delay count
        }
        case(irRec_ev):
        {
            break;
        }
        case(irResp_ev):
        {
            response_delay++;
            if(response_delay > backoff_time)
            {
                response_delay = 0;
                ir_resp(send_data);
            }
            else
                enqueue(&main_ev, irResp_ev);

            break;
        }
    }

    if(!delay_count)
    {
        check_accel();
        delay_count++;

       if(xA > 2)//(xA < -2)
       {
           if(temp_leds == 0x00)
               temp_leds = 0x28;

           if(temp_leds != 0xA0)
               temp_leds <<= 1;
       }
       else if (xA < -2)//(xA > 2)
       {
            if(temp_leds == 0x00)
               temp_leds = 0x14;

            if(temp_leds != 0x05)
               temp_leds >>= 1;
       }

        if( ((blink_loc << 1) & temp_leds)
                && ((blink_loc >> 1) & temp_leds))
            time++;
        else
            time = 0x00;

       if(!((unsigned int)time % 25) && time)
       {
           //set led event
            enqueue(&main_ev, led_ev);
            time = 0x00;
            green_leds = 0x00;
            led_seq = led_seq_sectionWin;
            count++;

            if(count == 1)
                blink_loc = 0x02;
            else if(count == 2)
                blink_loc = 0x10;
             else if(count == 3)
                blink_loc = 0x04;
            else
            {
               //set led event
               // enqueue(&main_ev, led_ev);
                led_seq = led_seq_stageWin;
                //current_stage = fib;
                run_stage = Stage_Fib;
                green_leds = 0x00;
                delay_count = 0;
                enqueue(&main_ev, setup_ev);
            }
       }
       else
        green_leds ^= blink_loc;
    }
    else
    {
        delay_count++;

        if(delay_count > (175))
            delay_count = 0;
    }

    set_leds(green_leds ^ temp_leds);
}

void Stage_Fib()
{
    static unsigned char found = 0x00;
    //do we need to display the sequence?
    if(seq)
    {
        set_leds(Get_Fib_Num(seq));

        if(!delay_count)
        {
            seq++;
            delay_count++;

            if(seq > 7)
            {
                seq = 0;
                set_leds(green_leds);
            }
            else
            {
                timer1Value = freq[5 + seq];
                timer1Counts = TIMER1HZ / (timer1Value << 2);
                PIE1bits.TMR1IE = 1;
                T1CONbits.TMR1ON = 1;
            }
        }
        else
        {
            delay_count++;

            if(delay_count > (1600))
                delay_count = 0;
        }
    }
    switch(get_next(&main_ev))
    {
        case(empty_ev):
        {
            break;
        }
        case(setup_ev):
        {
            response_delay = 0;
            irPayload_type = 0xFF;
            i2c_setup();
            green_leds = 0x00;
            store_stage(0x02);
            break;
        }
        case(tilt_ev):
        {
            check_tilt();
            break;
        }
        case(shake_ev):
        {
            seq = 1;
            break;
        }
        case(tap_ev):
        {
            //only do increment tap if not in sequence
            if(!seq)
            {
                green_leds++;
   


                set_leds(green_leds);
            }
            break;
        }
        case(button_ev):
        {
            if(green_leds == 13)
            {
                found |= green_leds;

                //set led event
                enqueue(&main_ev, led_ev);

                led_seq = led_seq_sectionWin;
            }
            else if(green_leds == 21)
            {
                found |= green_leds;

                //set led event
                enqueue(&main_ev, led_ev);

                led_seq = led_seq_sectionWin;
            }
            else if(green_leds == 34)
            {
                found |= green_leds;

                //set led event
                enqueue(&main_ev, led_ev);

                led_seq = led_seq_sectionWin;
            }
            else
            {
                green_leds = 0;
                
                //set led event
                enqueue(&main_ev, led_ev);

                led_seq = led_seq_hurt;
            }

            if(found == (34 | 21 | 13))
            {
                //show stage three?
                green_leds = 0;

                //current_stage = cylonSeek;
                run_stage = Stage_CylonSeek;

                //set led event
                enqueue(&main_ev, led_ev);

                led_seq = led_seq_stageWin;
            }
            break;
        }
        case(led_ev):
        {
            led_seq();

            break;
        }
        case(irRec_ev):
        {
            break;
        }
        case(irResp_ev):
        {
            response_delay++;
            if(response_delay > backoff_time)
            {
                response_delay = 0;
                ir_resp(send_data);
            }
            else
                enqueue(&main_ev, irResp_ev);

            break;
        }
    }
}

void Stage_CylonSeek()
{
    switch(get_next(&main_ev))
    {
        case(empty_ev):
        {
            break;
        }
        case(setup_ev):
        {
            response_delay = 0;
            irPayload_type = 0xFF;
            led_seq = led_seq_Cylon;
            enqueue(&main_ev, led_ev);
            break;
        }
        case(tilt_ev):
        {
            check_tilt();
            break;
        }
        case(shake_ev):
        {
            //set led event
            enqueue(&main_ev, led_ev);

            led_seq = led_seq_Cylon;

            break;
        }
        case(tap_ev):
        {
            break;
        }
        case(button_ev):
        {
            store_stage(0x03);
            break;
        }
        case(led_ev):
        {
            led_seq();

            break;
        }
        case(irRec_ev):
        {
            //game special type and cylon stage data
            if(irPayload_type == type_game_special
                    && irPayload_data == data_gSpecial_cylonHello)
            {
                //set led event
                enqueue(&main_ev, led_ev);

                led_seq = led_seq_stageWin;

                //current_stage = peerCount;
                run_stage = Stage_PeerCount;

                green_leds = 0x00;
            }
            break;
        }
        case(irResp_ev):
        {
            response_delay++;
            if(response_delay > backoff_time)
            {
                response_delay = 0;
                ir_resp(send_data);
            }
            else
                enqueue(&main_ev, irResp_ev);
            break;
        }
    }
}

//amount needed to get OVER in order to win
#define peer_count_goal 5
void Stage_PeerCount()
{
    static unsigned char peer_count = 0x00;
    
    switch(get_next(&main_ev))
    {
        case(empty_ev):
        {
            break;
        }
        case(setup_ev):
        {
            response_delay = 0;
            irPayload_type = 0xFF;
            led_seq = led_seq_sonar;
            enqueue(&main_ev, led_ev);
            store_stage(0x04);
            break;
        }
        case(tilt_ev):
        {
            check_tilt();
            break;
        }
        case(shake_ev):
        {
            //add led event
            enqueue(&main_ev, led_ev);

            led_seq = led_seq_sonar;
            
            irCB_gSpecialReq();

            break;
        }
        case(tap_ev):
        {
            break;
        }
        case(button_ev):
        {
            break;
        }
        case(led_ev):
        {
            led_seq();
            break;
        }
        case(irRec_ev):
        {
            //game special type and peer stage data
            if(irPayload_type == type_game_special
                    && irPayload_data == data_gSpecial_peerCountReq)
            {
                timer1Value = freq[25];
                timer1Counts = TIMER1HZ / (timer1Value << 2);
                PIE1bits.TMR1IE = 1;
                T1CONbits.TMR1ON = 1;

                ir_resp = irCB_gSpecialResp;

                send_data = badge_id;

                enqueue(&main_ev, irResp_ev);

                response_delay = 0;

                backoff_time = standard_backoff;
            }
            //game special type and peer stage data
            else if(irPayload_type == type_game_special_resp)
            {
                if(!check_peers(irPayload_data))
                {
                    enqueue_peer(irPayload_data);

                    //set led event
                    enqueue(&main_ev, led_ev);

                    led_seq = led_seq_sectionWin;

                    green_leds = ++peer_count;

                    //move on 5 peers
                    if(peer_count > peer_count_goal)
                    {
                        //set led event
                        enqueue(&main_ev, led_ev);

                        led_seq = led_seq_stageWin;

                        //current_stage = GoL_Living;
                        run_stage = Stage_GoL_Living;
                    }
//                    timer1Value = freq[55];
//                    timer1Counts = TIMER1HZ / (timer1Value << 2);
//                    PIE1bits.TMR1IE = 1;
//                    T1CONbits.TMR1ON = 1;
                }
                else
                {
                    timer1Value = freq[15];
                    timer1Counts = TIMER1HZ / (timer1Value << 2);
                    PIE1bits.TMR1IE = 1;
                    T1CONbits.TMR1ON = 1;
                }
            }

            break;
        }
        case(irResp_ev):
        {
            response_delay++;
            if(response_delay > backoff_time)
            {
                response_delay = 0;
                ir_resp(send_data);
            }
            else
                enqueue(&main_ev, irResp_ev);
            break;
        }
    }
    set_leds(green_leds);
}

#define decay_interval 6000
#define decay_amount 0x01
#define hp_seed 30
void Stage_GoL_Living()
{
    switch(get_next(&main_ev))
    {
        case(empty_ev):
        {
            break;
        }
        case(setup_ev):
        {
            response_delay = 0; //reset IR backoff timer
            irPayload_type = 0xFF;
            delay_count = 1;
            led_seq = led_seq_null;
            //enqueue(&main_ev, led_ev);

            //max health is 250 (start with a level badge for max health ;P)
            hp = 5;//(hp_seed % (xA ^ yA)) + hp_seed;
            set_leds(0x00);
            store_stage(0x05);
            break;
        }
        case(tilt_ev):
        {
            check_tilt();
            break;
        }
        case(shake_ev):
        {
            //attack (needs to be changed to button event)
            irCB_GoLTrade(0x02);
            timer1Value = freq[25];
            timer1Counts = TIMER1HZ / (timer1Value << 2);
            PIE1bits.TMR1IE = 1;
            T1CONbits.TMR1ON = 1;
            //hp -= 0x0A;
            break;
        }
        case(tap_ev):
        {
            break;
        }
        case(button_ev):
        {
            irCB_GoLAttack(0x0A);
            timer1Value = freq[15];
            timer1Counts = TIMER1HZ / (timer1Value << 2);
            PIE1bits.TMR1IE = 1;
            T1CONbits.TMR1ON = 1;
            break;
        }
        case(led_ev):
        {
            led_seq();
            //break;
            return;
        }
        case(irRec_ev):
        {
            if(irPayload_type == type_GoL_L_food)
            {
                //set led event
                enqueue(&main_ev, led_ev);

                led_seq = led_seq_sectionWin;

                //check for overflow on health
                if( (255 - hp)<irPayload_data)
                    hp = 255;
                else
                    hp += irPayload_data;

                green_leds = hp;
            }
            else if(irPayload_type == type_GoL_L_attack)
            {
                //set led event
                enqueue(&main_ev, led_ev);

                led_seq = led_seq_hurt;

                //check for overflow on health
                hp >>= 1;

                green_leds = hp;
            }
            else if(irPayload_type == type_GoL_Z_attack)
            {
                //set led event
                enqueue(&main_ev, led_ev);

                led_seq = led_seq_hurt;

                //turn into zombie if hit with less than 50 health
                if(hp <50)
                {
                    //set led event
                    enqueue(&main_ev, setup_ev);

                    //current_stage = GoL_Zombie;
                    run_stage = Stage_GoL_Purgatory;

                    next_life = zombie_life;
                }
                else
                {
                    //check for overflow on health
                    hp >>= 1;

                    green_leds = hp;
                }
            }
            else if(irPayload_type == type_GoL_L_hpTrade)
            {
//                //set led event
//                enqueue(&main_ev, led_ev);
//
//                led_seq = led_seq_sectionWin;
//
//                //check for overflow on health
//                if( (255 - hp)<irPayload_data)
//                    hp = 255;
//                else
//                    hp += irPayload_data;
//
//                green_leds = hp;
            }
            else if(irPayload_type == type_game_special)
            {
                if(irPayload_data == data_gSpecial_virus)
                {
                    //set led event
                    enqueue(&main_ev, setup_ev);

                    //current_stage = GoL_Zombie;
                    run_stage = Stage_GoL_Purgatory;
                    next_life = zombie_life;
                }
            }

            break;
        }
        case(irResp_ev):
        {
            response_delay++;
            if(response_delay > backoff_time)
            {
                response_delay = 0;
                ir_resp(send_data);
            }
            else
                enqueue(&main_ev, irResp_ev);

            break;
        }
    }

    //is it decaying?
    if(delay_count)
    {
        delay_count++;
        if(delay_count > decay_interval)
        {
            delay_count = 1;
            hp -= decay_amount;
            set_leds(hp);
            if(!hp)
            {
                run_stage = Stage_GoL_Purgatory;
                //led_seq = led_seq_death;
                enqueue(&main_ev, setup_ev);
                next_life = reg_life;
            }
            else if(hp < 15)
            {
                timer1Value = freq[50 - hp];
                timer1Counts = TIMER1HZ / (timer1Value << 2);
                PIE1bits.TMR1IE = 1;
                T1CONbits.TMR1ON = 1;
            }
        }
    }
}

void Stage_GoL_Zombie()
{
    switch(get_next(&main_ev))
    {
        case(empty_ev):
        {
            break;
        }
        case(setup_ev):
        {
            response_delay = 0; //reset IR backoff timer
            irPayload_type = 0xFF;
            iteratorCount = 1000;
            delay_count = 0;
            seq = 0;
            green_leds = 0b10111101;
            led_seq = led_seq_mutate;
            enqueue(&main_ev, led_ev);
            store_stage(0x06);
            break;
        }
        case(tilt_ev):
        {
            check_tilt();
            break;
        }
        case(shake_ev):
        {
            break;
        }
        case(tap_ev):
        {
            break;
        }
        case(button_ev):
        {
            break;
        }
        case(led_ev):
        {
            led_seq();
            return;
        }
        case(irRec_ev):
        {
            if(irPayload_type == type_GoL_L_attack)
            {
                if(green_leds)
                {
                    //set led event
                    enqueue(&main_ev, led_ev);

                    led_seq = led_seq_death;
                }
                else
                {
                    iteratorCount -= 20;
                }
                
            }
            else if(irPayload_type == type_GoL_Z_rally)
            {
                //set led event
                enqueue(&main_ev, led_ev);

                led_seq = led_seq_sectionWin;

                iteratorCount -= irPayload_data;
            }
            else if(irPayload_type == type_game_special)
            {
//                if(irPayload_data == data_gSpecial_virus)
//                {
//                    //set led event
//                    enqueue(&main_ev, setup_ev);
//
//                    //current_stage = GoL_Zombie;
//                    run_stage = Stage_GoL_Zombie;
//                }
            }

            break;
        }
        case(irResp_ev):
        {
            response_delay++;
            if(response_delay > backoff_time)
            {
                response_delay = 0;
                ir_resp(send_data);
            }
            else
                enqueue(&main_ev, irResp_ev);

            break;
        }
      }


    if(delay_count > iteratorCount)
        green_leds = 0x00;
    else
    {
        green_leds = 0b10111101;
    }

        delay_count++;

        if(delay_count > (2000))
        {
            check_accel();
            
            delay_count = 0;
        }
    
    set_leds(green_leds);
}

void Stage_GoL_Purgatory()
{
    switch(get_next(&main_ev))
    {
        case(empty_ev):
        {
            break;
        }
        case(setup_ev):
        {
            response_delay = 0; //reset IR backoff timer
            irPayload_type = 0xFF;
            iteratorCount = 1000;
            delay_count = 0;
            seq = 0;
            green_leds = 0x00;

            if(next_life == zombie_life)
            {
                led_seq = led_seq_mutate;
                enqueue(&main_ev, led_ev);
            }
            else
            {
                led_seq = led_seq_death;
                enqueue(&main_ev, led_ev);
            }
            
            break;
        }
        case(tilt_ev):
        {
            check_tilt();
            break;
        }
        case(shake_ev):
        {
            break;
        }
        case(tap_ev):
        {
            break;
        }
        case(button_ev):
        {
            break;
        }
        case(led_ev):
        {
            led_seq();
            return;
        }
        case(irRec_ev):
        {
            break;
        }
        case(irResp_ev):
        {
            response_delay++;
            if(response_delay > backoff_time)
            {
                response_delay = 0;
                ir_resp(send_data);
            }
            else
                enqueue(&main_ev, irResp_ev);

            break;
        }
    }

    if(!delay_count)
    {
        if(next_life == zombie_life)
        {
            green_leds >>= 1;
            green_leds |= 0x80;
            irCB_GoLRally(250);
        }
        else
        {
            green_leds <<= 1;
            green_leds |= 0x01;
            irCB_GoLFood(20);
        }
        delay_count++;
    }
    else
    {
        delay_count++;

        if(delay_count > 8300)
            delay_count = 0;

        if(green_leds == 0xff)
        {
            //set led event
            enqueue(&main_ev, setup_ev);

            if(next_life == zombie_life)
                //current_stage = GoL_Zombie;
                run_stage = Stage_GoL_Zombie;
            else
                run_stage = Stage_GoL_Living;
        }
    }

    set_leds(green_leds);
}

///////////////////
//--LED Sequences--
///////////////////
void led_seq_null(void)
{
    
}

void led_seq_Loading(void)
{
    //persistent count
    static unsigned char i = 0;
    static unsigned char count_tens = 0;
    
    unsigned char led = 0x00;

    //slowly light the 8 leds (first one starts on)
    if(i < 8)
    {
        count_tens += 1;

        //sequence not over
        enqueue(&main_ev, led_ev);

       if(count_tens > 200)
        {
            i++;
            count_tens = 0;

            //shift out less and less
            led = 0xFF >> (7 - i);
            set_leds(led);

            //loading noise!
            timer1Value = freq[15 + i];
            timer1Counts = TIMER1HZ / (timer1Value << 2);
            PIE1bits.TMR1IE = 1;
            T1CONbits.TMR1ON = 1;
        }
    }
    //accelerating blink
    else if(i < 250)
    {
        if( count_tens > 255 - i)
        {
            if(i%2)
            {
                set_leds(0x0);

                timer1Value = freq[15];
                timer1Counts = TIMER1HZ / (timer1Value << 2);
                PIE1bits.TMR1IE = 1;
                T1CONbits.TMR1ON = 1;
            }
            else
            {
                set_leds(0xFF);

                timer1Value = freq[25];
                timer1Counts = TIMER1HZ / (timer1Value << 2);
                PIE1bits.TMR1IE = 1;
                T1CONbits.TMR1ON = 1;
            }

            i += 5;

            count_tens = 0;
        }

        count_tens++;
        
        //still not done
        enqueue(&main_ev, led_ev);
    }
    else
    {
        led_seq = led_seq_null;
        set_leds(0x0); //all done
        //current_stage = mimicry;
        run_stage = Stage_Mimicry;
    }
}

void led_seq_sectionWin(void)
{
    static unsigned short led_delay = 0;

    if(led_delay < 500)
    {
        set_leds(0x03);

        timer1Value = freq[25];
        timer1Counts = TIMER1HZ / (4096 << 2);
        PIE1bits.TMR1IE = 1;
        T1CONbits.TMR1ON = 1;
    }
    else if(led_delay < 750)
    {
        set_leds(0x0f);
        
        PIE1bits.TMR1IE = 0;
        T1CONbits.TMR1ON = 0;
        PIR1bits.TMR1IF = 0;

    }
    else if(led_delay < 1000)
    {
        set_leds(0x3F);

        PIE1bits.TMR1IE = 1;
        T1CONbits.TMR1ON = 1;

        timer1Value = freq[18];
        timer1Counts = TIMER1HZ / (4096 << 2);
    }
    else if(led_delay < 1900)
    {
        set_leds(0xff);

        timer1Value = freq[40];
        timer1Counts = TIMER1HZ / (4096 << 2);
        T1CONbits.TMR1ON = 1;
        PIE1bits.TMR1IE = 1;
    }
    else if(led_delay < 2000)
    {        
        PIE1bits.TMR1IE = 0;
        T1CONbits.TMR1ON = 0;
        PIR1bits.TMR1IF = 0;

        set_leds(0x00);
    }
    else if(led_delay)
    {
        led_seq = led_seq_null;
        set_leds(green_leds);
        led_delay = 0;
        return;
    }

    //set led event
    enqueue(&main_ev, led_ev);

//    leds_mode = sectionWin;

    led_delay++;
}

void led_seq_stageWin(void)
{
    //persistent count
    static unsigned char i = 0, j = 0;
    static unsigned char count_tens = 0;

    unsigned char led = 0x00;

    //slowly light the 8 leds (first one starts on)
    if(i < 8)
    {
        count_tens += 1;

        //sequence not over
        enqueue(&main_ev, led_ev);

       if(count_tens > 50)
        {
            i++;
            count_tens = 0;

            //shift out less and less
            led = 0xFF >> (7 - i);
            set_leds(led);

            //loading noise!
            timer1Value = freq[25 + i];
            timer1Counts = TIMER1HZ / (timer1Value << 2);
            PIE1bits.TMR1IE = 1;
            T1CONbits.TMR1ON = 1;
        }
    }
    else if ( j < 4)
    {
        i = 0;
        j++;
        
        //sequence not over
        enqueue(&main_ev, led_ev);
    }
    else
    {
        led_seq = led_seq_null;
        //set_leds(0x00);
        set_leds(green_leds);
        i = j = 0;
        
        timer1Value = freq[41];
        timer1Counts = TIMER1HZ / (timer1Value << 2);
    }
}

#define first_seq_up 0x1f
#define second_seq_up 0x0E
#define third_seq_up 0x04

#define first_seq_down 0xf8
#define second_seq_down 0x70
#define third_seq_down 0x20

#define cylon_speed 3
void led_seq_Cylon(void)
{
    //persistent state of the sequence
    static unsigned char i = 0, j = 0;
    short k = 0;

    //count moving top to bottom
    if(j < 12)
    {
        if(j < 4)
        {
            if(delay_count < 1)
                set_leds((first_seq_up << j) >> 4);

            else if(delay_count < 10 )
                set_leds((second_seq_up << j) >> 4);

            else if(delay_count < 40)
                set_leds((third_seq_up << j) >> 4);

            timer1Value = freq[7];
            timer1Counts = TIMER1HZ / (4096 << 2);
            PIE1bits.TMR1IE = 1;
            T1CONbits.TMR1ON = 1;
        }
        else
        {
            if(delay_count < 1)
                set_leds(first_seq_up << (j-4) );

            else if(delay_count < 10 )
                set_leds(second_seq_up << (j-4) );

            else if(delay_count < 40)
                set_leds(third_seq_up << (j-4) );

            timer1Value = freq[9];
            timer1Counts = TIMER1HZ / (4096 << 2);
            PIE1bits.TMR1IE = 1;
            T1CONbits.TMR1ON = 1;
        }

        delay_count++;

        if(delay_count >= 40)
        {
            delay_count = 0;
            iteratorCount++;

            if(iteratorCount > cylon_speed)
            {
                iteratorCount = 0;
                j++;
            }
        }

    }
    //count moving bottom to top
    else if (j < 24)
    {
        if(j < 16)
        {
            if(delay_count < 1)
                set_leds((first_seq_down >> j - 12) << 4);

            else if(delay_count < 10 )
                set_leds((second_seq_down >> j- 12) << 4);

            else if(delay_count < 40)
                set_leds((third_seq_down >> j - 12) << 4);

            timer1Value = freq[7];
            timer1Counts = TIMER1HZ / (4096 << 2);
            PIE1bits.TMR1IE = 1;
            T1CONbits.TMR1ON = 1;
        }
        else
        {
             if(delay_count < 1)
                set_leds(first_seq_down >> j - 16);


             else if(delay_count < 10 )
                set_leds(second_seq_down >> j - 16);


             else if(delay_count < 40)
                set_leds( third_seq_down >> j - 16);

            timer1Value = freq[9];
            timer1Counts = TIMER1HZ / (4096 << 2);
            PIE1bits.TMR1IE = 1;
            T1CONbits.TMR1ON = 1;
        }


        delay_count++;

        if(delay_count >= 40)
        {
            delay_count = 0;
            iteratorCount++;

            if(iteratorCount > cylon_speed)
            {
                iteratorCount = 0;
                j++;
            }
        }
    }
    //one oscilation completed
    else
    {
      j = 0;

      //i counts number of repeats
      i++;
    }

    //do it four times
    if(i < 3)
    {
        //not done, run it again
       enqueue(&main_ev, led_ev);
    }
    else
    {
        //shouldnt have to
        reset_globals();

        i = 0; //all done
        set_leds(green_leds);
    }
}

//higher equals slower
#define sonar_speed 500
void led_seq_sonar(void)
{
    static unsigned char iter = 0x00;

    //first time in
    if(!iter)
    {
        delay_count = 0;
        set_leds(0x18);
        iter++;
    }
    else if(iter == 0x01)
    {
        if(delay_count > sonar_speed)
        {
            set_leds(0x24);
            iter++;
            delay_count = 0;
        }
    }
    else if(iter == 0x02)
    {
        if(delay_count > sonar_speed)
        {
            set_leds(0x5A);
            iter++;
            delay_count = 0;
        }
    }
    else if(iter == 0x03)
    {
         if(delay_count > sonar_speed)
        {
            set_leds(0xA5);
            iter++;
            delay_count = 0;
        }
    }
    else if(iter == 0x04)
    {
        if(delay_count > sonar_speed)
        {
            set_leds(0x42);
            iter++;
            delay_count = 0;
        }
    }
    else if(iter == 0x05)
    {
        if(delay_count > sonar_speed)
        {
            set_leds(0x81);
            iter++;
            delay_count = 0;
        }
    }
    else
    {
        if(delay_count > sonar_speed)
        {
            iter = 0x00;
            set_leds(green_leds);
            delay_count = 0;
            return;
        }
    }

    //set led event
    enqueue(&main_ev, led_ev);

    delay_count++;
}

void led_seq_death(void)
{
    //persistent count
    static unsigned char i = 0, j = 0;
    static unsigned char count_tens = 0;

    unsigned char led = 0x00;

    if(i < 8 )
    {
        count_tens += 1;

        //sequence not over
        enqueue(&main_ev, led_ev);

       if(count_tens > 200 + i + j)
        {            
            count_tens = 0;

            //shift out less and less
            led = 0xFF >> (i);
            set_leds(led);

            i++;

            //loading noise!
            timer1Value = freq[35 - i - j];
            timer1Counts = TIMER1HZ / (timer1Value << 2);
            PIE1bits.TMR1IE = 1;
            T1CONbits.TMR1ON = 1;
        }
    }
    else if ( j < 6)
    {
        //i = 0;
        j++;
        i = j;
        //sequence not over
        enqueue(&main_ev, led_ev);
    }
    else
    {
        set_leds(green_leds);
        led_seq = led_seq_null;
        i = j = 0;
    }
}

void led_seq_hurt(void)
{
    //persistent count
    static unsigned char i = 0, j = 0;
    static unsigned char count_tens = 0;

    unsigned char led = 0x00;

    if(i < 8 )
    {
        count_tens += 1;

        //sequence not over
        enqueue(&main_ev, led_ev);

       if(count_tens > 50 + i)
        {
            count_tens = 0;

            //shift out less and less
            led = 0xFF >> (i);
            set_leds(led);

            i++;

            //loading noise!
            timer1Value = freq[45 - i];
            timer1Counts = TIMER1HZ / (timer1Value << 2);
            PIE1bits.TMR1IE = 1;
            T1CONbits.TMR1ON = 1;
        }
    }
    else if ( j < 3)
    {
        //i = 0;
        j++;
        i = 0;
        //sequence not over
        enqueue(&main_ev, led_ev);
    }
    else
    {
        set_leds(green_leds);
        led_seq = led_seq_null;
        i = j = 0;
    }
}

void led_seq_mutate(void)
{
    //persistent count
    static unsigned char i = 0, j = 0;
    static unsigned char count_tens = 0;

    unsigned char led = 0x00;

    if(i < 14 )
    {
        count_tens += 1;

        //sequence not over
        enqueue(&main_ev, led_ev);

       if(count_tens > 20 + i)
        {
            count_tens = 0;

            //shift out less and less
            led = (i) + j;
            set_leds(led);

            i++;

            //loading noise!
            timer1Value = freq[15 - i + (j<<2)];
            timer1Counts = TIMER1HZ / (timer1Value << 2);
            PIE1bits.TMR1IE = 1;
            T1CONbits.TMR1ON = 1;
        }
    }
    else if ( j < 14)
    {
        //i = 0;
        j++;
        i = 0;
        //sequence not over
        enqueue(&main_ev, led_ev);
    }
    else
    {
        set_leds(green_leds);
        led_seq = led_seq_null;
        i = j = 0;
    }
}

///////////////////
//--Othe Methods--
///////////////////
void check_tilt(void)
{
    static unsigned char sleeping = 0x00;
     //use I2C to read accelerometer's tilt register
    StartI2C();

    //Tell Badge we want tilt register
    WriteI2C(Accel_Write_Addr);
    WriteI2C(0x03);

    RestartI2C();

    //Get the the contents of tilt register
    WriteI2C(Accel_Read_Addr);
    tilt = ReadI2C();

    //was it shaken?
    if(tilt & shake_t)
    {
        shake_debounce++;

        //must get 10 shake samples to register
        if(shake_debounce > 10)
        {
           shake_debounce = 0;
           enqueue(&main_ev, shake_ev);
        }
    }
    else//not shaken, reset counters
    {
        shake_debounce = 0;
    }

    //was it tapped?
    if(tilt & tap_t)
    {
        enqueue(&main_ev, tap_ev);
    }
    else
    {
        tap_count = 0;
    }

    if((tilt & 0x02) && !sleeping)
    {
        //come back to current stage after idle
        return_stage = run_stage;

        //enter idle mode
        run_stage = Stage_Idle;
        enqueue(&sleep_ev, setup_ev);

        sleeping = 0xFF;

        //set_leds(tilt);
    }
    else if(!(tilt & 0x02) && sleeping)
    {
        sleeping = 0x00;
        run_stage = return_stage;
    }

    return;
}

void check_accel(void)
{
//    printf("Reading I2C\n\r");
    char temp = 0x00;
    StartI2C();
    WriteI2C(Accel_Write_Addr);
    WriteI2C(0x00); //Tell Badge we want X axis
    RestartI2C();
    WriteI2C(Accel_Read_Addr);
    temp = ReadI2C(); //Get the X axis

    //check error
    if(!(temp & 0x40))
    {
        xA = temp;
        if(xA & 0x20)
        {
            //remove sign bit
            xA &= 0b11011111;

            //make it negative
            xA *= -1;
        }
    }

    StopI2C();

    StartI2C();
    WriteI2C(Accel_Write_Addr);
    WriteI2C(0x01); //Tell Badge we want Y axis
    RestartI2C();
    WriteI2C(Accel_Read_Addr);
    temp = ReadI2C(); //Get the Y axis

    //check error
    if(!(temp & 0x40))
    {
        yA = temp;
        if(yA & 0x20)
        {
            //remove sign bit
            yA &= 0b11011111;

            //make it negative
            yA *= -1;
        }
    }
    StopI2C();

    StartI2C();
    WriteI2C(Accel_Write_Addr);
    WriteI2C(0x02); //Tell Badge we want Z axis
    RestartI2C();
    WriteI2C(Accel_Read_Addr);
    temp = ReadI2C(); //Get the Y axis

    //check error
    if(!(temp & 0x40))
    {
        zA = temp;
        if(zA & 0x20)
        {
            //remove sign bit
            zA &= 0b11011111;

            //make it negative
            zA *= -1;
        }
    }
    StopI2C();

/*
    if(xA & 0b00100000)
        printf("X: -%u\n\r", (unsigned int)(xA & 0x0F));
    else
        printf("X: +%u\n\r", (unsigned int)(xA & 0x0F));

    if(yA & 0b00100000)
        printf("Y: -%u\n\r", (unsigned int)(yA & 0x0F));
    else
        printf("Y: +%u\n\r", (unsigned int)(yA & 0x0F));

    if(zA & 0b00100000)
        printf("Z: -%u\n\n\n\r", (unsigned int)(zA & 0x0F));
    else
        printf("Z: +%u\n\n\n\r", (unsigned int)(zA & 0x0F));

    Delay10KTCYx(400);
*/
}

unsigned char Get_Fib_Num(unsigned char seq_num)
{
    if(seq_num == 1)
        return 0;
    else if(seq_num < 4)
        return 1;
    else if(seq_num == 4)
        return 2;
    else if(seq_num == 5)
        return 3;
    else if(seq_num == 6)
        return 5;
    else if(seq_num == 7)
        return 8;
    else if(seq_num == 8)
        return 13;
    else if(seq_num == 9)
        return 21;
    else if(seq_num == 10)
        return 34;
    else if(seq_num == 11)
        return 55;
    else if(seq_num == 12)
        return 89;
    else if(seq_num == 13)
        return 144;
    else if(seq_num == 14)
        return 233;
}

//returns the sequence/index of a number if it is a fib number
unsigned char Is_Fib_Num(unsigned char num)
{
    if(num == 0 )
        return 1;
    else if(num == 1)
        return 2; // or three?
    else if(num == 2)
        return 4 ;
    else if(num == 3)
        return 5;
    else if(num == 5)
        return 6;
    else if(num == 8)
        return 7;
    else if(num == 13)
        return 8;
    else if(num == 21)
        return 9;
    else if(num == 34)
        return 10;
    else if(num == 55)
        return 11;
    else if(num == 89)
        return 12;
    else if(num == 144)
        return 13;
    else if(num == 233)
        return 14;
    else
        return 0xFF; //not a fib number!
}

enum Event get_next(struct event_buffer *buff_ev)
{
    //need to return the event at front of queue
    enum Event ret_ev = buff_ev->front;

    //shift events down the queue
    buff_ev->front = buff_ev->middle;
    buff_ev->middle = buff_ev->back;

    //check correct event sequence to fill queue with
    //buff_ev->back = *buff_ev->current_seq;
    if(main_tilt_count == int_tilt_count)
        buff_ev->back = empty_ev;
    else
    {
        main_tilt_count = ~main_tilt_count;
        buff_ev->back = tilt_ev;
    }

    return ret_ev;
}

void enqueue(struct event_buffer *buf_ev, enum Event ev)
{
    //enqueue as far up as possible
    if(buf_ev->front == empty_ev)
        buf_ev->front = ev;
    else if(buf_ev->middle == empty_ev)
        buf_ev->middle = ev;
    else if(buf_ev->back == empty_ev)
        buf_ev->back = ev;

    return;
}

void set_leds(unsigned char leds)
{
    //mask out the lower 5 bits
    PORTA = (leds & 0x3F);

    //get upper bits, keep status LED on
    PORTC = (leds >>6) | 0x04;

    return;
}

void xor_leds(unsigned char bits)
{
    unsigned char masked;

    masked = ~(LATA & bits & 0x3F);
    //mask out the lower 5 bits
    LATA = (LATA & masked) | (bits & masked);

    masked = ~(LATC & (bits >> 6));
    //get upper bits, keep status LED on
    LATC = (LATC & masked) | ((bits >> 6) & masked);

    return;
}

//put accelerometer into standby mode
void accel_standby(void)
{
     SSPADD = 0x78;                  //120
    OpenI2C(MASTER, SLEW_OFF);      //Init I2C module

    StartI2C();
        WriteI2C(0x98);
        WriteI2C(0x07);                //mode register
        WriteI2C(0x01);                //Standby mode
        //WriteI2C(0x00);                //Standby mode
    StopI2C();
}

//setup acclerometer for interrupts
void i2c_setup(void)
{
    //-------------------
    //Setup I2C
    //-------------------

    SSPADD = 0x78;                  //120
    OpenI2C(MASTER, SLEW_OFF);      //Init I2C module

//    printf("\n\n\rConfiguring I2C...");

    StartI2C();
        WriteI2C(0x98);
        WriteI2C(0x07);                //mode register
        //WriteI2C(0x01);                //Standby mode
        WriteI2C(0x00);                //Standby mode
    StopI2C();

    IdleI2C();

   StartI2C();
        WriteI2C(0x98);
        WriteI2C(0x05);                //SPCNT register
        WriteI2C(0x00);                //No sleep count
    StopI2C();
    IdleI2C();

    StartI2C();
        WriteI2C(0x98);
        WriteI2C(0x06);                //interrupt register (INTSU)
        //1110 0100
        WriteI2C(0xE4);                //shake INT on 3-axis, and tap detect
        
        //(INTSU)1110 0101
        WriteI2C(0xE5);                //shake INT on 3-axis, and tap detect
                                        // also add position detection

     StopI2C();
    IdleI2C();

    StartI2C();
        WriteI2C(0x98);
        WriteI2C(0x09);                //PDET register
        WriteI2C(0x84);                //tap detection on  z-axis
    StopI2C();
    IdleI2C();

    StartI2C();
        WriteI2C(0x98);
        WriteI2C(0x08);                //SR register
        WriteI2C(0x00);                //Sample rate at 32/sec
    StopI2C();
    IdleI2C();
    StartI2C();
        WriteI2C(0x98);
        WriteI2C(0x0A);                //PD register
        WriteI2C(0x2F);                //test tap detection, debounce
    StopI2C();
    IdleI2C();
    StartI2C();
        WriteI2C(0x98);
        WriteI2C(0x07);             //select the mode register
        WriteI2C(0x41);             //active mode, int push pull
    StopI2C();

//    printf("Finished!\r\n");
}

void reset_globals(void)
{
    delay_count = 0;
    iteratorCount = 0;
}

void extractPayload(unsigned char *raw,
                    unsigned char *type,
                    unsigned char *data)
{
    //need to mirror the typ bits
//    *type = (raw[1] & 0b10000000) >> 7;
//    *type |= (raw[1] & 0b010000000) >> 6;
//    *type |= (raw[1] & 0b001000000) >> 5;
//    *type |= (raw[1] & 0b000100000) >> 4;

//    *type = (raw[1] & 0b00010000) >> 5;
//    *type |= (raw[1] & 0b000010000) >> 4;
//    *type |= (raw[1] & 0b000001000) >> 3;
//    *type |= (raw[1] & 0b000000100) >> 2;

    *type = (raw[1] & 0b11111100)>>4;

    *data = (raw[1] & 0b00001100) << 4;
    *data |= (raw[0] & 0b00111111);
}


void enqueue_peer(unsigned char id)
{
    peers_met[9] = peers_met[8];
    peers_met[8] = peers_met[7];
    peers_met[7] = peers_met[6];
    peers_met[6] = peers_met[5];
    peers_met[5] = peers_met[4];
    peers_met[4] = peers_met[3];
    peers_met[3] = peers_met[2];
    peers_met[2] = peers_met[1];
    peers_met[1] = peers_met[0];
    peers_met[0] = id;
}

unsigned char check_peers(unsigned char id)
{
    unsigned char i = 0;
    for(i = 0; i < 9; i++)
    {
        if(peers_met[i] == id)
            return 0xff;
    }

    return 0x00;
}

void store_stage(unsigned char stage)
{
    extern unsigned char EEbyte, EEaddr;
    extern void EEfetch(void);
    extern void EEstore(void);


    EEbyte = stage;

    EEaddr = 0; // read address 32
    EEstore();
}

unsigned char read_stage()
{
    extern void EEfetch(void);
    extern void EEstore(void);
    extern unsigned char EEbyte, EEaddr;

    EEbyte = 0;

    EEaddr = 0; // read address 32
    EEfetch();
    return EEbyte;
}

void read_set_stage()
{
    switch(read_stage())
    {
        case(0x00):
        {
            //current_stage = balance;
            run_stage = Stage_Mimicry;
            break;
        }

        case(0x01):
        {
            run_stage = Stage_Balance;
            break;
        }

        case(0x02):
        {
            run_stage = Stage_Fib;
            break;
        }

        case(0x03):
        {
            run_stage = Stage_CylonSeek;
            break;
        }

        case(0x04):
        {
            run_stage = Stage_PeerCount;
            break;
        }

        case(0x05):
        {
            run_stage = Stage_GoL_Living;
            break;
        }

        case(0x06):
        {
            run_stage = Stage_GoL_Zombie;
            break;
        }
    }
    green_leds = 0x00;
    set_leds(0x00);

    enqueue(&main_ev, setup_ev);
    led_seq = led_seq_null;
}