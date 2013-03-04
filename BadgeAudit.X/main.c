/*
 * RVAsec Badge Audit
 */
#include <p18f2455.h>
#include <i2c.h>
#include <delays.h>
#include <stdio.h>              //needed for printf, may remove to save space

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

//===========
//Prototypes
//===========
void tmr0_routine(void);
void highIntHandle(void);
void lowIntHandle(void);
void check_accel(void);

//===========
//Interrupt Vectors
//===========
#pragma code high_isr=0x08
void high_isr(void)
{
    _asm goto highIntHandle _endasm
}

#pragma code low_isr=0x22
void low_isr(void)
{
    _asm goto lowIntHandle _endasm
}


//===========
//Globals and Defines
//===========
#define idle 0
#define ir_respond 1

unsigned short badge_id = 0;        //identify badges, 0 is test program
unsigned char state_id = 0;
unsigned char status_count = 0;


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
      else if (PIR1bits.TMR1IF)
      {

      }
      else
      {

      }
}

#pragma interruptlow lowIntHandle
void lowIntHandle(void)
{

}

void tmr0_routine(void)
{
//    status_count += 1;
//
//    if(!status_count)
//        LATCbits.LATC2 = ~LATCbits.LATC2;
}




void setup(void)
{
    //--------------------------
    //Setup LED Outputs
    //--------------------------
    TRISA &= 0b11000000;    //Green LEDs pin
    PORTA &= 0b11000000;    //Green LEDs OFF

    TRISB &= 0b11011111;    //IR LED pin
    PORTB &= 0b11011111;    //IR LED OFF

    TRISC &= 0b11111000;    //Last two Green LED and Red Status
    PORTC &= 0b11111000;    //C port LEDs OFF

    LATCbits.LATC2 = 1;     //turn on red status LED
    
    //--------------------------
    //Setup Serial Communication
    //--------------------------
    stdout = _H_USART;      //setup printf to use RS232

    BAUDCON = 0x00;         //Baud rate control register
    TXSTAbits.TX9 = 0;      //8 bit transmission
    TXSTAbits.TXEN = 1;     //enable transmit
    TXSTAbits.SYNC = 0;     // Asychronous Mode
    TXSTAbits.BRGH = 1;     //high speed mode

    RCSTAbits.SPEN = 1;     //USB circuitry in power conserve mode
    RCSTAbits.RX9 = 0;      //8 bit
    RCSTAbits.CREN = 1;     //enable receiver

    SPBRG = 25;             //set to 25 to get ~115200 baud

    TRISCbits.RC6 = 0;      //TX pin needs to be output
    TRISCbits.RC7 = 1;      //RX pin needs to be input

    //--------------------------
    //Setup Interrupts
    //--------------------------
    INTCONbits.TMR0IF = 0;          //Clear timer 0 flag
    PIR1bits.TMR1IF = 0;            //Clear time 1 flag

    RCONbits.IPEN = 1;              //Interrupt priority enable (0 = off)

    //Timer 0 setup
    INTCONbits.TMR0IE = 1;          //Enable Timer 0
    T0CONbits.T08BIT = 0;           //timer 0 set to 16 bit (1 = 8 bit)
    T0CONbits.T0PS = 0b00;          //Timer 0 Prescalar select (0b00 = 1:2)
    T0CONbits.T0CS = 0;             //Timer 0 source select (0 = inter inst. clk
    T0CONbits.PSA = 0;              //Timer 0 turn scalar off
    INTCON2bits.TMR0IP = 1;         //Timer 0 interrupt priority (1 = high)

    //Timer 1 setup
    T1CONbits.TMR1CS = 0;           //Timer 1, external or internal osc
    T1CONbits.T1CKPS = 0b01;        //Timer 1 Prescalar Select (0b01 = 1:2)
    IPR1bits.TMR1IP = 1;            //Timer 1 overflow priority
    PIE1bits.TMR1IE = 1;            //Enable timer 1 overflow interrupt

    INTCONbits.PEIE = 1;            //Peripheral interrupt enable
    INTCONbits.GIE = 1;             //enable global interrupt

    TMR0L = 0;                      //Timer 0 counts up from 0
    TMR0H = 0;

    TMR1L = 0;                      //Timer 1 counts up from 0
    TMR1H = 0;

    T0CONbits.TMR0ON = 1;           //turn on timer 0
    T1CONbits.TMR1ON = 0;           //turn on timer 1

    //-------------------
    //Setup I2C
    //-------------------
    //TRISB |= 0x03;                  //B0 and B1 must be inputs
    SSPADD = 0x7F;                  //127
    OpenI2C(MASTER, SLEW_OFF);      //Init I2C module

    printf("Configuring I2C\n\r");
    StartI2C();
        IdleI2C();
    WriteI2C(0x98);             //announse address (accel is 0x98?)
        IdleI2C();
    WriteI2C(0x07);             //select the mode register
        IdleI2C();
    WriteI2C(0x01);             //Place in active mode
        IdleI2C();
    StopI2C();

    //Print a welcome message in case someone plugs it up
    printf("Welcome to the RVAsec Badge!\n\r\n\r");
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
                check_accel();
                break;
            }

            case(ir_respond):
            {
                break;
            }
        }
        printf("Hello World!!\n\r");
    }
}

void check_accel(void)
{
    unsigned char result;

    StartI2C();
        IdleI2C();
    WriteI2C(0x98);
        IdleI2C();
    WriteI2C(0x00);

    result = ReadI2C();
    Delay1KTCYx(2);
    printf("Result from I2C: %u\n\n\n\r", (unsigned int)result);
    Delay10KTCYx(20);
}