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

//Notes for IR transmission
//2.25 ms of assert for a logic 1
//1.125 ms of zero for a logc 0
//  - rest of the zero time is spent off

//===========
//Prototypes
//===========
void highIntHandle(void);
void lowIntHandle(void);
void tmr0_routine(void);
void check_accel(void);
void check_tilt(void);
void set_leds(unsigned char leds);

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

//states
#define idle 0
#define ir_respond 1
#define speak 2
#define handle_tilt 3

unsigned short badge_id = 0;        //identify badges, 0 is test program
volatile unsigned char state_id = 0;
unsigned char status_count = 0;

unsigned char green_leds = 0;

//Accelerometer related vars
unsigned char xA, yA, zA,           //Accel vectors
                shake_debounce = 0,
                shake_count = 0,
                tap_count = 0;

volatile unsigned char tilt = 0;

//===========
//Interrupt handler routines
//===========
#pragma interrupt highIntHandle
void highIntHandle(void)
{
      if(INTCONbits.TMR0IF)
      {
          //jump to some function
          tmr0_routine();

          //clear interrupt flag
          INTCONbits.TMR0IF = 0;
      }
      else if (INTCON3bits.INT2IF)//(PIR1bits.TMR1IF)
      {
            LATAbits.LATA1 = 1;
      }
      else
      {

      }
      
}

#pragma interruptlow lowIntHandle
void lowIntHandle(void)
{
    if(INTCON3bits.INT2IF) //check for INT2 (B2-Accel INT)
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

        //make sure the upadte is handled
        state_id = handle_tilt;

        INTCON3bits.INT2IF = 0;  //clear flag
    }
}

void tmr0_routine(void)
{
//    status_count += 1;
//
//    if(!status_count)
//        LATCbits.LATC2 = ~LATCbits.LATC2;
}

void main(void)
{
    //initialize all the things
    setup();

    //main loop
    while(1)
    {
        switch(state_id)
        {
            case (idle):
            {
                break;
            }

            case (handle_tilt):
            {
                check_tilt();

                if(green_leds == 0xFF)
                    state_id = speak;
                else
                    state_id = idle;

                set_leds(green_leds);
                
                break;
            }

            case(ir_respond):
            {
                break;
            }

            case(speak):
            {
                //toggle speaker port to create buzz
                LATBbits.LATB3 = ~LATBbits.LATB3;

                //PIC is way faster than Piezo freq
                Delay10KTCYx(4);
                break;
            }
        }
    }
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
        //was it shaken?
        if(tilt & shake)
        {
            shake_debounce++;

            //must get 10 shake samples to register
            if(shake_debounce > 10)
            {
               //unused
               shake_count++;

               //state_id = idle;
               shake_debounce = 0;
               green_leds = 0;
               printf("Shaken! (count = %u)\n\r", shake_count);
            }
        }
        else//not shaken, reset counters
        {
            shake_debounce = 0;
            shake_count = 0;
        }

        //was it tapped?
        if(tilt & tap)
        {
            //unused at this point
            tap_count++;

            //turn reset if they are all on
            if(green_leds == 0xFF)
            {
                green_leds = 0;
                //state_id = idle;
            }
            else
            {
                green_leds = green_leds << 1;
                green_leds |= 0x01;
            }

            printf("Tapped! (count = %u)\n\r", tap_count);
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