/*
 * RVAsec Badge Audit
 */
#include "common.h"

#pragma config WDT = OFF                 //Watch Dog Timer off
#pragma config FCMEN = OFF               //Disable Fail-Safe Clock Monitor
#pragma config IESO = OFF                //Oscilator switchover off
#pragma config PWRT = OFF                //power up timer off
#pragma config BOR = OFF                 //disable drown out reset
#pragma config STVREN = OFF              //stack under/over flow not reset
#pragma config LVP = OFF
#pragma config DEBUG = OFF
#pragma config PLLDIV = 1
#pragma config CPUDIV = OSC1_PLL2        //Post Scalar:96MHz/2 = 48MHz
#pragma config USBDIV = 2
#pragma config FOSC = XTPLL_XT
#pragma config PBADEN = OFF
#pragma config XINST = OFF
#pragma config CCP2MX = OFF              //CCP2 outputs to RB3 (PWM on RB3)

//===========
//Prototypes
//===========
void highIntHandle(void);
void lowIntHandle(void);
void tmr0_routine(void);
void handle_song(void);
void check_accel(void);
void check_tilt(void);
void set_leds(unsigned char leds);
enum Event get_next(struct event_buffer *in_ev);
void enqueue(struct event_buffer *ev_buff, enum Event ev);
void led_seq_Loading(void);
void led_seq_Cylon(void);
void Stage_Welcome();
void Stage_Mimicry();
void Stage_Fib();
unsigned char Get_Fib_Num(unsigned char seq_num);

//===========
//Interrupt Vectors
//===========
#pragma code high_isr=0x08
void high_isr(void)
{
    _asm goto highIntHandle _endasm
}

#pragma code low_isr=0x18
void low_isr(void)
{
    _asm goto lowIntHandle _endasm
}

#pragma code

//char seq_num = 0;
//enum Event seq0 = empty_ev, seq1 = empty_ev;

struct event_buffer main_ev = {NULL,        //current seq ptr
                                empty_ev,   //seq 0
                                empty_ev,   //seq 1
                                empty_ev,   //back
                                empty_ev,   //middle
                                empty_ev};  //front

enum Stage current_stage = welcome;

//may want buffer for led?
enum LED_mode leds_mode = startup;

volatile enum State state = idle;

unsigned short badge_id = 0;        //identify badges, 0 is test program

//volatile unsigned char status_count = 0;

volatile unsigned char green_leds = 0;

volatile unsigned char int_tilt_count = 0;

volatile unsigned char main_tilt_count = 0;

//Accelerometer related vars
unsigned char xA, yA, zA,           //Accel vectors
                shake_debounce = 0,
                shake_count = 0,
                tap_count = 0;

#define SONG_SIZE 32
volatile unsigned char tilt = 0;
volatile unsigned char timer0_value;// = A_TONE;
volatile unsigned char timer0_count = 0;

volatile unsigned char excite[SONG_SIZE]
={A_TONE_h, Ash_TONE_h, B_TONE_h, C_TONE_h, Csh_TONE_h, D_TONE_h, Dsh_TONE_h, 0,
  B_TONE_h, C_TONE_h, Csh_TONE_h, D_TONE_h, E_TONE_h, F_TONE_h, Fsh_TONE_h, 0,
  C_TONE_h, Csh_TONE_h, D_TONE_h, E_TONE_h, F_TONE_h, Fsh_TONE_h, G_TONE_h, 0,
  Fsh_TONE_h, G_TONE_h, Gsh_TONE_h, Fsh_TONE_h, G_TONE_h, Gsh_TONE_h, Gsh_TONE_h, 0};

struct song_desc excite_song = {35, 0, excite};
struct song_desc *playing;

//===========
//Interrupt handler routines
//===========
#pragma interrupt highIntHandle
void highIntHandle(void)
{
      //timer 0 flag
      if(INTCONbits.TMR0IF)
      {
          //state_id = speak;
          handle_song();
      }
      else
      {}
}

#pragma interruptlow lowIntHandle
void lowIntHandle(void)
{
    if(INTCON3bits.INT2IF) //check for INT2 (B2-Accel INT)
    {
         INTCON3bits.INT2IF = 0;  //clear flag

         int_tilt_count++;
         //check_tilt();
    }
    return;
}

void tmr0_routine(void)
{

}

//----Entry Point----
void main(void)
{
    //set the starting song
    playing = &excite_song;
    
    //initialize all the things
    setup();

    //do the set led event
    enqueue(&main_ev, led_ev);

    //current_stage = fib;
    
    //main loop
    while(1)
    {
        switch(current_stage)
        {
            case(welcome):
            {
                Stage_Welcome();
                break;
            }

            case(mimicry):
            {
                Stage_Mimicry();
                break;
            }

            case(fib):
            {
                Stage_Fib();
                break;
            }
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
        case(tilt_ev):
        {
            check_tilt();
            break;
        }
        case(shake_ev):
        {
            green_leds = 0;
            set_leds(green_leds);
            break;
        }
        case(tap_ev):
        {
            green_leds +=1;
            set_leds(green_leds);

            //enter cylon mode if they reach some num
            if(green_leds == 10)
            {
                leds_mode = cylon;
                enqueue(&main_ev,led_ev);
            }
            break;
        }
        case(button_ev):
        {
            break;
        }
        case(led_ev):
        {
            if(leds_mode == startup)
            {
                //ATOMIC_BEGIN
                    led_seq_Loading();
                //ATOMIC_END
            }
            else if (leds_mode == cylon)
            {
                //ATOMIC_BEGIN
                    led_seq_Cylon();
                //ATOMIC_END
            }
            break;
        }
    }
}

unsigned char delay_count = 0;
unsigned char speed = 0;
unsigned char blink_loc = 0x80;
void Stage_Mimicry()
{
    if(!delay_count)
    {
        green_leds ^= blink_loc;
        delay_count++;
    }
    else
    {
        Delay10KTCYx(10);
        delay_count++;

        if(delay_count > (100 - speed))
            delay_count = 0;
    }

    set_leds(green_leds);

    switch(get_next(&main_ev))
    {
        case(empty_ev):
        {
            break;
        }
        case(tilt_ev):
        {
            check_tilt();
            break;
        }
        case(shake_ev):
        {
//            green_leds = 0;
//            set_leds(green_leds);
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
                    if(speed == 60)
                    {
                        current_stage = fib;
                        set_leds(0x00);
                    }
                    else
                    {
                        speed += 20;
                        green_leds = 0x00;
                        blink_loc = 0x80;
                    }
                }
                else
                {
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
            break;
        }
        case(led_ev):
        {
            break;
        }
    }
}

unsigned char seq = 0;
void Stage_Fib()
{
    //do we need to display the sequence?
    if(seq)
    {
        set_leds(Get_Fib_Num(seq));

        if(!delay_count)
        {
            seq++;
            delay_count++;

            if(seq > 14)
                seq = 0;
        }
        else
        {
            Delay10KTCYx(100);
            delay_count++;

            if(delay_count > (10 - speed))
                delay_count = 0;
        }
    }
    set_leds(green_leds);

    switch(get_next(&main_ev))
    {
        case(empty_ev):
        {
            break;
        }
        case(tilt_ev):
        {
            check_tilt();
            break;
        }
        case(shake_ev):
        {
//            green_leds = 0;
//            set_leds(green_leds);
            seq = 1;
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
                    if(speed == 60)
                    {
                        current_stage = fib;
                        set_leds(0x00);
                    }
                    else
                    {
                        speed += 20;
                        green_leds = 0x00;
                        blink_loc = 0x80;
                    }
                }
                else
                {
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
            break;
        }
        case(led_ev):
        {
            break;
        }
    }

//    switch(get_next(&main_ev))
//    {
//        case(empty_ev):
//        {
//            break;
//        }
//        case(tilt_ev):
//        {
//            check_tilt();
//            break;
//        }
//        case(shake_ev):
//        {
//            green_leds = 0;
//            set_leds(green_leds);
//            break;
//        }
//        case(tap_ev):
//        {
//            green_leds +=1;
//            set_leds(green_leds);
//
//            //enter cylon mode if they reach some num
//            if(green_leds == 10)
//            {
//                leds_mode = cylon;
//                enqueue(&main_ev,led_ev);
//            }
//            break;
//        }
//        case(button_ev):
//        {
//            break;
//        }
//        case(led_ev):
//        {
//            if(leds_mode == startup)
//            {
//                //ATOMIC_BEGIN
//                    led_seq_Loading();
//                //ATOMIC_END
//            }
//            else if (leds_mode == cylon)
//            {
//                //ATOMIC_BEGIN
//                    led_seq_Cylon();
//                //ATOMIC_END
//            }
//            break;
//        }
//    }
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
        main_tilt_count++;
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

void handle_song(void)
{
  timer0_count += 1;

  //has the note been playing long enough?
  if(playing->note_length == timer0_count)
  {
      //at the end of the song?
      if(playing->song_index < SONG_SIZE - 1)
      {
          //move to next note
          playing->song_index += 1;
      }
      else//start song over
      {
          playing->song_index = 0;
      }

      //reset counter
      timer0_count = 0;
  }
  else//keep playing note
  {
      timer0_count += 1;
  }

  //if note not a rest
  if(playing->song[playing->song_index])
  {
        TMR0H = playing->song[playing->song_index];
        TMR0L = TONE_LOW_BYTE;

        //play tone
        LATBbits.LATB3 = ~LATBbits.LATB3;
  }
  else
  {
      TMR0H = A_TONE_h;
      TMR0L = TONE_LOW_BYTE;

      //keep speaker off
      LATBbits.LATB3 = 0;
  }

  //clear interrupt flag
  INTCONbits.TMR0IF = 0;
}

void check_accel(void)
{
    printf("Reading I2C\n\r");
        
    StartI2C();

        //Tell Badge we want X axis
        WriteI2C(Accel_Write_Addr);
        WriteI2C(0x00);
        
    RestartI2C();

        //Get the X axis
        WriteI2C(Accel_Read_Addr);
        xA = ReadI2C();

    RestartI2C();
        //Tell Badge we want Y axis
        WriteI2C(Accel_Write_Addr);
        WriteI2C(0x01);

    RestartI2C();

        //Get the Y axis
        WriteI2C(Accel_Read_Addr);
        yA = ReadI2C();

    RestartI2C();
        //Tell Badge we want Z axis
        WriteI2C(Accel_Write_Addr);
        WriteI2C(0x02);

    RestartI2C();

        //Get the Z axis
        WriteI2C(Accel_Read_Addr);
        zA = ReadI2C();
    StopI2C();

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
}

void check_tilt(void)
{
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

void led_seq_Loading(void)
{
    //persistent count
    static unsigned char i = 0;
    unsigned char led = 0x00;

    //slowly light the 8 leds (first one starts on)
    if(i < 8)
    {
        //shift out less and less
        led = 0xFF >> (7 - i);
        set_leds(led);

        //the "load" gets faster and faster
        Delay10KTCYx(200 - (i << i));

        //sequence not over
        enqueue(&main_ev, led_ev);
        
        i++;
    }
    //accelerating blink
    else if(i < 95)
    {
        set_leds(0x0);
            Delay10KTCYx(100 - i);
        set_leds(0xFF);
            Delay10KTCYx(100 - i);
        i += 5;

        //still not done
        enqueue(&main_ev, led_ev);
    }
    else
    {
        set_leds(0x0); //all done
        current_stage = mimicry;
    }
}
 
void led_seq_Cylon(void)
{
    //persistent state of the sequence
    static unsigned char i = 0, j = 0;
    short k = 0;
    unsigned char delay = 100;

    //count moving top to bottom
    if(j < 8)
    {
        //bit bang dimming
        for(k = 0; k < 10; k++)
        {
            set_leds(0x07 << j);
            Delay1KTCYx(delay>>4);

            set_leds(0x06 << j);
            Delay1KTCYx(delay>>2);

            set_leds(0x04 << j);
            Delay1KTCYx(delay);
        }
        j++;
    }
    //count moving bottom to top
    else if (j < 16)
    {
      //bit bang dimming
      for(k = 0; k < 10; k++)
      {
          set_leds(0xE0 >> j - 8);
          Delay1KTCYx(delay>>4);

          set_leds(0x60 >> j - 8);
          Delay1KTCYx(delay>>2);

          set_leds( 0x20 >> j - 8);
          Delay1KTCYx(delay);
      }
      j++;
    }
    //one oscilation completed
    else
    {
      j = 0;

      //i counts number of repeats
      i++;
    }

    //do it four times
    if(i < 4)
    {
        //not done, run it again
       enqueue(&main_ev, led_ev);
    }
    else
    {
        i = 0; //all done
        set_leds(green_leds);
    }
}
