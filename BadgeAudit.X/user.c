/******************************************************************************/
/* Files to Include                                                           */
/******************************************************************************/

#if defined(__XC)
    #include <xc.h>         /* XC8 General Include File */
#elif defined(HI_TECH_C)
    #include <htc.h>        /* HiTech General Include File */
#elif defined(__18CXX)
    #include <p18cxxx.h>    /* C18 General Include File */
#endif

#if defined(__XC) || defined(HI_TECH_C)

#include <stdint.h>         /* For uint8_t definition */
#include <stdbool.h>        /* For true/false definition */

#endif

#include "user.h"

/******************************************************************************/
/* User Functions                                                             */
/******************************************************************************/

/* <Initialize variables in user.h and insert code for user algorithms.> */

void InitApp(void)
{
    //Set A bits to output
    TRISA = 0x00;

    //Set C bits to output
    TRISC = 0x00;

    //B5 is the IR Lead
    TRISB &= 0b11011111;

    //Outputs off
    PORTA = 0x00;
    PORTC = 0x00;
    PORTB = 0x00;

    //interrupt testing
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
    //T1CONbits.TMR1CS1 = 0;        //Timer 1, external or internal osc
    T1CONbits.T1CKPS = 0b01;        //Timer 1 Prescalar Select (0b01 = 1:2)
    IPR1bits.TMR1IP = 1;            //Timer 1 overflow priority
    PIE1bits.TMR1IE = 1;            //Enable timer 1 overflow interrupt

    INTCONbits.PEIE = 1;            //Peripheral interrupt enable
    INTCONbits.GIE = 1;             //enable global interrupt

    T0CONbits.TMR0ON = 1;           //turn on timer 0
    T1CONbits.TMR1ON = 0;           //turn on timer 1
}


void long_delay(unsigned int amount, unsigned int multiplier)
{
    //int i = amount;
    while(multiplier--)
    {
        my_delay(amount);
    }
}
void my_delay(unsigned int amount)
{
    unsigned int i = amount, dumb=0;
    while(i--)
    {
        while(amount--)
        {
            dumb = i * amount/2;
        }
    }
}