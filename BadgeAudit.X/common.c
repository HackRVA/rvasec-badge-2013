#include "common.h"

void led_setup(void)
{
    TRISA &= 0b11000000;    //Green LEDs pin
    PORTA &= 0b11000000;    //Green LEDs OFF

    TRISB &= 0b11011111;    //IR LED pin
    PORTB &= 0b11011111;    //IR LED OFF

    TRISC &= 0b11111000;    //Last two Green LED and Red Status
    PORTC &= 0b11111000;    //C port LEDs OFF

    LATCbits.LATC2 = 1;     //turn on red status LED
}

void serial_setup(void)
{
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
}

void interrupt_setup(void)
{
    //Port B interrupt
    INTCON3 = 0b00010000;       //INT2 enable, low priority, clear IF

    //---------------------
    //Timer Interrupt Setup
    //---------------------
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

    T0CONbits.TMR0ON = 0;           //turn timer 0 on/off (1/0)
    T1CONbits.TMR1ON = 0;           //turn timer 1 on/off (1/0)
}

void i2c_setup(void)
{

    //-------------------
    //Setup I2C
    //-------------------
    //TRISB |= 0x03;                  //B0 and B1 must be inputs
    //SSPADD = 0x7F;                  //127
    SSPADD = 0x78;                  //120 (from Paul)
    OpenI2C(MASTER, SLEW_OFF);      //Init I2C module

    printf("Configuring I2C...");
    StartI2C();
        WriteI2C(0x98);             //announse address (accel is 0x98?)
        WriteI2C(0x07);             //select the mode register
        WriteI2C(0x01);             //Place in active mode
    StopI2C();
    printf("Finished!\r\n");
}

void setup(void)
{
    led_setup();

    serial_setup();

    interrupt_setup();

    i2c_setup();

    //Print a welcome message in case someone plugs it up
    printf("Welcome to the RVAsec Badge!\n\r\n\r");
}