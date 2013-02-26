/******************************************************************************/
/* Files to Include                                                           */
/******************************************************************************/
#if defined(__XC)
    #include <xc.h>        /* XC8 General Include File */
#elif defined(HI_TECH_C)
    #include <htc.h>       /* HiTech General Include File */
#elif defined(__18CXX)
    #include <p18cxxx.h>   /* C18 General Include File */
#endif

#if defined(__XC) || defined(HI_TECH_C)

#include <stdint.h>        /* For uint8_t definition */
#include <stdbool.h>       /* For true/false definition */

#endif

#pragma config WDTEN = OFF
#pragma config DEBUG = OFF
//#pragma config FOSC = INTOSCIO_EC

#include "system.h"        /* System funct/params, like osc/peripheral config */
#include "user.h"          /* User funct/params, such as InitApp */
#include <delays.h>

#define BUZZ 0


void IdleLoop(void);
void Test_LED_Buzz();
void Buzz_Test();
/******************************************************************************/
/* User Global Variable Declaration                                           */
/******************************************************************************/

/******************************************************************************/
/* Main Program                                                               */
/******************************************************************************/


void main(void)
{
    /* Configure the oscillator for the device */
    ConfigureOscillator();

    /* Initialize I/O and Peripherals for application */
    InitApp();
    
    //IdleLoop();
    Test_LED_Buzz();
    //Buzz_Test();
}

void IdleLoop()
{
    while(1)
    {
        PORTA |= 0x01;
    }
}

void Test_LED_Buzz()
{
  unsigned int i = 0;
  char pA = 0x01, pC = 0x01;

  //Bit 1 of port A starts it off
  PORTA = 0x01;

  //turn on IR
  //PORTB |= 0b00100000;

  //C port is off
  PORTC = 0x00;
    
    while(1)
    {
       if(i>700)
       {
            //last port a was LED on
            if(pA == 0x40)
            {
                PORTA = 0x00;
                //last of port C LED was on
                if(pC == 0x04)
                {
                    //reset port As var
                    pA = 0x01;

                    //reset port C
                    pC = 0x01;

                    //toggle status led
                    LATCbits.LATC2 = ~LATCbits.LATC2;

                    //Mask to only leave the status bit
                    PORTC &= 0x04;
                }
                else
                {
                   //Mask out the Green LEDs, leave status
                   PORTC &= 0x04;

                   //Set low 2 bits
                   PORTC |= pC;

                   //move down C port bits
                   pC = pC<<1;
                }
            }
            else
            {
               PORTA = (pA & 0x3F);
               pA = (pA<<1);
            }
            i=0;
       }
       if(LATCbits.LATC2 && BUZZ)
       {
        LATBbits.LATB3 = ~LATBbits.LATB3;
        LATBbits.LATB3 = ~LATBbits.LATB3;
        LATBbits.LATB3 = ~LATBbits.LATB3;
       }
       i = i + 1;
    }
}

void Buzz_Test()
{
    unsigned int i = 0, j = 0;
    TRISBbits.TRISB3 = 0;
    while(1)
    {
        if(i > j++)
        {
            LATBbits.LATB3 = ~LATBbits.LATB3;
            i=0;
        }
        if(j>90000)
            j = 0;
        i++;
    }
}
