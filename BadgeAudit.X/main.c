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
//#include <p18f2455.h>
#if defined(__XC) || defined(HI_TECH_C)

#include <stdint.h>        /* For uint8_t definition */
#include <stdbool.h>       /* For true/false definition */

#endif

#pragma config WDT = OFF                 //Watch Dog Timer off
#pragma config DEBUG = OFF
#pragma config CPUDIV = OSC1_PLL2        //Post Scalar:96MHz/2 = 48MHz
#pragma config FOSC = HSPLL_HS           //HS Crystal, Phase-Locked Loop

#include "system.h"        /* System funct/params, like osc/peripheral config */
#include "user.h"          /* User funct/params, such as InitApp */

#define BUZZ 0

void IdleLoop(void);
void Test_LED_Buzz();
void Buzz_Test();
void IR_Test();


void main(void)
{
    //Configure Oscillator
    ConfigureOscillator();

    //Init function
    InitApp();
    
    //IdleLoop();
    Test_LED_Buzz();
    //IR_Test();
    //Buzz_Test();

}
void IR_Test()
{
    LATBbits.LATB5 = 1;
    while(1)
    {
        LATAbits.LATA0 = ~LATAbits.LATA0;
    }
}

void IdleLoop()
{
    PORTA |= 0x01;
    while(1)
    {
        
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
       if(i>7000)
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
                    //LATCbits.LATC2 = ~LATCbits.LATC2;

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
