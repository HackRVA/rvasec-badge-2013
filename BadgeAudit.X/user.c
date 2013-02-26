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
    /* TODO Initialize User Ports/Peripherals/Project here */
    //Set A bits to output
    TRISA = 0x00;

    //Set C bits to output
    TRISC = 0x00;

    //B5 is the IR Lead
    TRISB &= 0b11011111;

    /* Setup analog functionality and port direction */

    /* Initialize peripherals */

    /* Configure the IPEN bit (1=on) in RCON to turn on/off int priorities */

    /* Enable interrupts */

    //interrupt testing
    INTCONbits.TMR0IF = 0;
    PIR1bits.TMR1IF = 0;
    T0CONbits.T08BIT = 0;
    
    T1CONbits.TMR1CS1 = 0;
    //T1CONbits
    T1CONbits.T1CKPS = 0b01;
    //T1CONbits.T1RUN = 0;

    T0CONbits.T0PS = 0b00;
    T0CONbits.T0CS = 0;
    T0CONbits.PSA = 0; //turn scalar off

    RCONbits.IPEN = 1;
    INTCON2bits.TMR0IP = 1;
    //RCON |= 0b10000000;     //enable priority interrupts
    //INTCON |= 0b10000000;   //enable high priority interrupts
    //INTCON |= 0b01000000;   //enable low priority interrupts
    INTCONbits.TMR0IE = 1;
    PIE1bits.TMR1IE = 1;
    INTCONbits.PEIE = 1;
    INTCONbits.GIE = 1; //enable global interrupt
    IPR1bits.TMR1IP = 1;


    T0CONbits.TMR0ON = 0; //turn on timer 0
    T1CONbits.TMR1ON = 0; //turn on timer 1
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