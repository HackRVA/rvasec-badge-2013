// old microchip user/user.c
// nothing left of the original

#include <p18cxxx.h>
#include "system/typedefs.h"
#include "system/usb/usb.h"
#include "system/usb/class/cdc/cdc.h"

#include "io_cfg.h"             // I/O pin mapping
#include "user/user.h"
#include "common.h"
#include "game.h"

// this is for a 36KHZ receiver
// #define IR_BIT_LENGTH   1778
//+-----------------------------+
//| (1000000 / 36000)  * 32 * 2 |
//+-----------------------------+
//|                   1777.7778 |
//+-----------------------------+

// badge is 37khz
// 1000000 / 37000 == 27, transmit half bit == 32 cycles of 27 (864), 864 * 2 half bits = 1728
#define IR_BIT_LENGTH   1728
#define IR_BIT_LENGTH_DIV2   ((IR_BIT_LENGTH / 2) - 0)
#define IR_BIT_LENGTH_DIV4   ((IR_BIT_LENGTH / 4) - 0/2)

//#define DEV
//#define accel_on
#define base_station

/** globals for IR lib functions ********************************************************/
extern void SendRC5(void);
extern volatile byte DataByte, AddrByte, ToggByte;
unsigned char usbOn;
extern volatile unsigned char int_tilt_count;
extern struct event_buffer main_ev;
static unsigned char badge_id;
unsigned char do_led_seq = 0x00;

// global ram variables
#pragma udata

/* volatile */ byte input_buffer[64]={0,0,0,0};
/* volatile */ byte output_buffer[64]={0,0,0,0};

/* state for printing menus to usb serial/modem */
byte inMenu=0;


/* ------------------------------------------- */
/* ------             IR READ vars    -------- */
/* ------------------------------------------- */

// listening     -- listening block
// 
// preamble      -- S1 1.778ms "1"
//                  S2 1.778ms "1"  
//                  T  1.778ms "0/1"  
//
// address       -- A4 1.778ms "0/1"  
//                  A3 1.778ms "0/1"  
//                  A2 1.778ms "0/1"  
//                  A1 1.778ms "0/1"  
//                  A0 1.778ms "0/1"  
//
// data          -- D5 1.778ms "0/1"  
//               -- D4 1.778ms "0/1"  
//               -- D3 1.778ms "0/1"  
//               -- D2 1.778ms "0/1"  
//               -- D1 1.778ms "0/1"  
//               -- D0 1.778ms "0/1"  
//
// silent      ?? --  1.778ms "0/1"  

#define IR_LISTENING    0
#define IR_SAMPLING     1
#define IR_SAMPLEREADY  2
#define IR_SILENT       3

// 
// globals used in the interupt and main ProcessIO
// 
//
volatile byte IRstate = IR_LISTENING;
volatile byte IRbitCnt = 0;            // current bit being read
/* volatile */ byte IRbits[4] = {0,0,0,0};   // bits sampled array, not valid until state==IR_SAMPLEREADY
/* volatile */ byte unIRbits[2] = {0,0};     // array for unManchester() output decoded bits

// every 1000000 / 4000 = 250 uSec, divide by 2 to get period 125
#define TIMER1HZ 1000000
#define TIMER1VAL 4096
volatile long timer1HZ = TIMER1HZ;
volatile short timer1Value = TIMER1VAL;
volatile short timer1Counts = TIMER1HZ / TIMER1VAL ;

//demo mode, base station mode, or ???
unsigned char inputMode = 0x00;
unsigned char do_callback = 0x00;
void (*ir_callback)(unsigned char type, unsigned char data);
unsigned short delayCount = 0;
unsigned short iterator_count = 0;

extern unsigned char irPayload_type;
extern unsigned char irPayload_data;
/* ---------------------------------------------------------- */
/* this is code from the pong game for writing to flash       */
/* may end up removing it                                     */
/* ---------------------------------------------------------- */

typedef struct coreVars {
   byte mtimerL;
   byte mtimerH;
   byte mtimerH2;
} coreVars ;

typedef struct coreBlock {
   byte block[16];
} coreBlock ;

typedef union coreMemory {
   coreVars cV;
   coreBlock cB;
} coreMemory;
coreMemory core;

rom far char *dataArea;
/* ---------------------------------------------------------- */


// global rom variables

/* frequency table for audio notes */
// I added an extra note at the end of the 7 notes
// eg: 15291, 13624, 12136, 11452, 10204, 9091, 8099, 7646,
// should be:
// eg: 15291, 13624, 12136, 11452, 10204, 9091, 8099, 
// this allows easy mapping by 8's for the theramin
#pragma romdata
rom far short freq[] = {
    15291, 13624, 12136, 11452, 10204, 9091, 8099, 7646,
    7646, 6810, 6068, 5728, 5102, 4546, 4049, 3822,
    3822, 3405, 3034, 2864, 2551, 2273, 2025, 1911,
    1911, 1703, 1517, 1432, 1276, 1137, 1013, 956,
    956, 852, 759, 716, 638, 568, 506, 478,
    478, 426, 379, 358, 319, 284, 253, 239,
    239, 213, 190, 179, 160, 142, 127, 120,
    120, 107, 95, 90, 80, 71, 64, 64
};

/*
  To create a bitmap create it in gimp using BW/monochrome colors 
  at 8px high by NN px wide. Then rotate 90 clockwise so it reads from top to bottom
  then transform->mirror on x and save as "xbm" X11 bitmap it should look something 
  like the file below.
  finally, change the "static" to "rom" to save ram space
*/
#include "hackRVA.xbm"

// hex table- for printing
rom far char htab[]={"0123456789ABCDEF"};

// test data for flash
rom far char writeMe[]={"  TEST WRITE      "};


// internal global prototypes
void InitializeUSART(void);
void InterruptHandlerHigh(void);
void InterruptHandlerLow(void);


#pragma code InterruptVectorHigh = 0x08
void InterruptVectorHigh (void)
{
  _asm
    goto InterruptHandlerHigh //jump to interrupt routine
  _endasm
}

#pragma code InterruptVectorLow = 0x18
void InterruptVectorLow (void)
{
  _asm
    goto InterruptHandlerLow //jump to interrupt routine
  _endasm
}

//----------------------------------------------------------------------------
// Lo priority interrupt routine

#pragma code
//#pragma interrupt InterruptHandlerHigh
#pragma interrupt InterruptHandlerHigh

void InterruptHandlerHigh()
{
    //PORTAbits.RA5 = 1;

    //
    // note- RB change may be the cause for the interupt
    //
    if (INTCONbits.TMR0IE && INTCONbits.TMR0IF) { // TMR0 went off
        /* reload tmr0first */
        TMR0H = (65535 - IR_BIT_LENGTH_DIV2) >> 8;
        TMR0L = (65535 - IR_BIT_LENGTH_DIV2) & 0xFF;

        /* sample IRbit and store in table. not sure if this is faster than */
        /* setting up for an array */
        if (IRstate == IR_SAMPLING) {
            byte tmpIRbyte;
            byte tmpVal;

            tmpVal = PORTBbits.RB4 ;   // get bit 

            //PORTCbits.RC6 = tmpVal;              // out debug pin

            tmpIRbyte = IRbitCnt >> 3; // which byte is in use?
            if (tmpIRbyte < 4) {
                IRbits[tmpIRbyte] = IRbits[tmpIRbyte] << 1;
                IRbits[tmpIRbyte] |= tmpVal;
            }
            else {
                // done disable TMR0 interupt. audio sounds better with this off
                INTCONbits.TMR0IE = 0;
                INTCONbits.RBIE = 1; // reenable port B interupts
                IRstate = IR_SAMPLEREADY;

                //if(!usbOn)
                    //let game loop know of IR recv
                    //enqueue(&main_ev, irRec_ev);
            }
            IRbitCnt++;
        }
        INTCONbits.TMR0IF = 0;            //clear interrupt flag
    }

    //
    // note- TMR0 may be the cause for the interupt
    //
    if (INTCONbits.RBIE && INTCONbits.RBIF) { // port B int enabled and port B went off
        byte IRport;

        IRport = PORTBbits.RB4 ; // read bit to clear inter. discard, will read again in IR_BIT...DIV4 uSec
        if ( IRstate == IR_LISTENING ) {
            TMR0H = (65535 - IR_BIT_LENGTH_DIV4) >> 8;      // sync to read middle of bit
            TMR0L = (65535 - IR_BIT_LENGTH_DIV4) & 0xFF;    // sync to read middle of bit

            INTCONbits.RBIE = 0;    //  disable port B int until done sampling
            IRstate = IR_SAMPLING ;

            IRbits[0] = 1;    // first half of start bit. It is implied by the RB changed
            IRbitCnt = 1;

            INTCONbits.TMR0IE = 1;  // enable TMR0 interupt
        }
        INTCONbits.RBIF = 0;     // clear interrupt flag
    }
}


//#pragma interrupt InterruptHandlerLow
#pragma interruptlow InterruptHandlerLow

void InterruptHandlerLow()
{
    //PORTAbits.RA6 = 1;

    //
    // TMR1 logic- TMR1IE is 1 when 'a' audio on toggle == 1
    //             TMR1ON/OFF is set when a note is to be played/stoped
    //
    if (PIR1bits.TMR1IF && PIE1bits.TMR1IE) { 
        static int toggle=0;

        if (timer1Counts <= 0) { // '<=' in case of math underflows somewhere else
            timer1Counts = 0;    // also in case timer1Counts becomes odd
            T1CONbits.TMR1ON = 0;
            PORTBbits.RB3 = 0;         // the piezo bit
        }
        else {
            TMR1H = (65535 - timer1Value) >> 8;
            TMR1L = (65535 - timer1Value) & 0xFF;

            toggle = !toggle;
            PORTBbits.RB3 = toggle;         // the piezo bit
            timer1Counts--;
        } 
        PIR1bits.TMR1IF = 0;            //clear interrupt flag
    }


#ifdef accel_on
    if(INTCON3bits.INT2IF) //check for INT2 (B2-Accel INT)
    {
         INTCON3bits.INT2IF = 0;  //clear flag

         int_tilt_count = ~int_tilt_count;
    }
#endif
}


//
// non interupt c code 
//
#pragma code
void UserInit(void)
{
    void i2c_setup(void);

    TRISBbits.TRISB0 = 1; // input data for I2C
    TRISBbits.TRISB1 = 0; // clock for I2C
    TRISBbits.TRISB2 = 1; // input interupt for I2C
    TRISBbits.TRISB3 = 0; // output piezo
    TRISBbits.TRISB4 = 1; // input input IR receive.
    TRISBbits.TRISB5 = 0; // output IR transmit
    TRISBbits.TRISB6 = 0; // programming clock (unused)
    TRISBbits.TRISB7 = 0; // programming data (unused)
    LATB = 0;           // this clears up spurious interupts

    TRISAbits.TRISA0 = 0; // led
    TRISAbits.TRISA1 = 0; // led
    TRISAbits.TRISA2 = 0; // led
    TRISAbits.TRISA3 = 0; // led
    TRISAbits.TRISA4 = 0; // led
    TRISAbits.TRISA5 = 0; // led
    LATA = 0;

    PORTAbits.RA0 = 1; // board is UP!
    TRISCbits.TRISC0=0; // led
    TRISCbits.TRISC1=0; // led
    TRISCbits.TRISC2=1; // button
    //TRISCbits.TRISC3=1; // i2c
    //TRISCbits.TRISC4=1; // i2c not sure if I2C open does this?
    //TRISCbits.TRISC5=1; // i2c

    TRISCbits.TRISC6=0; // output rs232 TX
    TRISCbits.TRISC7=1; // input rs232 RX
    LATC = 0;

    /* for morgan_code.c */
    #ifdef accel_on
        i2c_setup();

        //INTCON3bits.INT2IE = 1;         //Enable INT2 == i2c  accelerator
        INTCON3 = 0;

        //Port B interrupt
        INTCON3bits.INT2IP = 0;         //INT2 low priority
        INTCON3bits.INT2IF = 0;         //Clear INT2 flag
      //  INTCON2bits.RBPU = 0;           //pull up disable
        INTCON2bits.INTEDG2 = 0;        //rising/falling (1/0)
        INTCON3bits.INT2IE = 1;         //Enable INT2
    #else
        INTCON3 = 0;
    #endif


    //InitializeUSART();


    // TMR0ON T08BIT T0CS T0SE PSA T0PS2 T0PS1 T0PS0
    // bit 7                                   bit 0
    // T0CON = 0xC8;    // C-> 8=TMR0ON, 4=8 bit timer, 8=prescaler off
    T0CON = 0x88;    // 8 = TMR0ON, 8=prescaler off

    // RD16   T1RUN  T1CKPS1  T1CKPS0  T1OSCEN T1SYNC TMR1CS TMR1ON
    // bit 7                                                  bit 0
    //T1CON = 0x89;    // 8=RD16/16 bit reads, 9 = timer on/TMR1ON, oscilator enable (internal)
    T1CON = 0x81;    // 8=RD16/16 bit reads, 1 = TMR1on

    // 
    // timer 0 interupts - IR bit timing and sampling
    // 
    INTCONbits.TMR0IF = 0;      // clear overflow bit
    INTCONbits.TMR0IE = 0;      // Timer 0 initially off enabled by IR int routine
    INTCON2bits.TMR0IP = 1;     // TMR0 high priority
    TMR0H = (65535 - IR_BIT_LENGTH_DIV2) >> 8;
    TMR0L = (65535 - IR_BIT_LENGTH_DIV2) & 0xFF;

    // 
    // timer 1 interupts - audio frequency and timing generation 
    // 
    PIR1bits.TMR1IF = 0;     // clear overflow bit
    PIE1bits.TMR1IE = 0;    // Timer 0 overflow interupt enable
    IPR1bits.TMR1IP = 0;    // TMR1 low priority
    timer1Counts = timer1HZ / (timer1Value << 2);
    TMR1H = (65535 - timer1Value) >> 8;
    TMR1L = (65535 - timer1Value) & 0xFF;

    // port b interupt on change
    INTCONbits.RBIF = 0;   // clear overflow bit
    INTCONbits.RBIE = 1;    // enable int
    INTCON2bits.RBIP = 1;   // port b change high priority
    INTCON2bits.RBPU = 1;   // pullups disable

    INTCONbits.PEIE = 1;     //Peripheral interrupt enable
//
    RCONbits.IPEN = 1;       // enable priority levels
    INTCONbits.GIEL = 1;     // low interrupts
    INTCONbits.GIEH = 1;     // high interrupts

 } //end UserInit

void InitializeUSART(void)
{
    unsigned char c;

    TRISCbits.TRISC7=1; // RX
    TRISCbits.TRISC6=0; // TX

    // SPBRG = 0x88; // 2400 baud
    SPBRG = 0xE1; // 9600 baud
    // SPBRGH = 0x13;      // 2400 baud
    SPBRGH = 0x04;      // 9600
    TXSTA = 0x24;       // TX enable BRGH=1
    RCSTA = 0x90;       // continuous RX
    BAUDCON = 0x08;     // BRG16 = 1

    // +----------+-------+-----------+------------+
    // | Fosc     | baud  | baudClk   | baudClkHex |
    // +----------+-------+-----------+------------+
    // | 48000000 |  1200 | 9999.0000 | 270F       |
    // | 48000000 |  2400 | 4999.0000 | 1387       |
    // | 48000000 |  4800 | 2499.0000 | 9C3        |
    // | 48000000 |  9600 | 1249.0000 | 4E1        |
    // | 48000000 | 19200 |  624.0000 | 270        |
    // | 48000000 | 38400 |  311.5000 | 138        |
    // +----------+-------+-----------+------------+

    c = RCREG;                              // read
}//end InitializeUSART

#if defined(__18CXX)
    #define mDataRdyUSART() PIR1bits.RCIF
    #define mTxRdyUSART()   TXSTAbits.TRMT
#elif defined(__C30__) || defined(__C32__)
    #define mDataRdyUSART() UART2IsPressed()
    #define mTxRdyUSART()   U2STAbits.TRMT
#endif

void putcUSART(char data)
{
    TXREG = data;      // Write the data byte to the USART, 8-bit mode only
}

unsigned char getcUSART()
{
    char  c;

    if (RCSTAbits.OERR)  // in case of overrun error
    {                    // we should never see an overrun error, but if we do, 
        RCSTAbits.CREN = 0;  // reset the port
        c = RCREG;
        RCSTAbits.CREN = 1;  // and keep going.
    }
    else
        c = RCREG;

    return c;
}

#define EECON1_RD       EECON1bits.RD
#define EECON1_WR       EECON1bits.WR

void StartWrite(void) {
    EECON2 = 0x55;
    EECON2 = 0xAA;
    EECON1_WR = 1;
}

void PrintProgMem(void) {
    byte counter, byteTemp;

    for (counter = 0; counter < 15; counter++) {
        byteTemp = *(dataArea + counter);
        output_buffer[counter*2  ] = htab[(byteTemp >> 4) & 0xF];
        output_buffer[counter*2+1] = htab[(byteTemp     ) & 0xF];
    }
    output_buffer[30] = '\r';
    output_buffer[31] = 0;
    inMenu = 6;
    
    TBLPTRU = 0x00;         // forces upper byte back to 0x00
                            // optional fix is to set large code model
}

void ReadProgMem(void) {
    byte counter, byteTemp;

    for (counter = 0; counter < 16; counter++) {
        byteTemp = *(dataArea + counter);
        core.cB.block[counter] = byteTemp;
    }
    
    TBLPTRU = 0x00;         // forces upper byte back to 0x00
                            // optional fix is to set large code model
}

void WriteProgMem(void) {
    byte counter, byteTemp;

    EECON1 = 0b10000100;        // Setup writes: EEPGD=1, WREN=1

    for (counter = 0; counter < 16; counter++) {
        byteTemp = core.cB.block[counter];
        *(dataArea + counter) = byteTemp;
    }
    StartWrite();

//    counter = 0;
//    for (counter = 0; counter < 32; counter++) {
//        pMem[counter] = pMem[counter];
//        if (((counter & 0b00011111) == 0b00011111) || (counter == 16)) {
//           StartWrite();
//        }
//    }

    TBLPTRU = 0x00;         // forces upper byte back to 0x00
}

void EraseProgMem(void) {
    byte byteTemp;

    // The most significant 16 bits of the address pointer points to the block
    // being erased. Bits 5:0 are ignored. (In hardware).
    // LEN = # of 64-byte block to erase
    EECON1 = 0b10010100;     // Setup writes: EEPGD=1, FREE=1, WREN=1
    byteTemp = *(dataArea);
    StartWrite();

//    byte counter;
//    for(counter=0; counter < dataPacket.len; counter++) {
//        EECON1 = 0b10010100;     // Setup writes: EEPGD=1, FREE=1, WREN=1
//        *(dataPacket.ADR.pAdr+(((int)counter) << 6));  // Load TBLPTR
//        StartWrite();
//
//    }
//
    TBLPTRU = 0;            // forces upper byte back to 0x00
                            // optional fix is to set large code model
                            // (for USER ID 0x20 0x00 0x00)
}


extern unsigned char xA, yA, zA;           //Accel vectors

byte unManchester(byte *in, byte *out); // 4 bytes in/2 bytes out. returns 0=no error, error bit # on encoding error
void doUSBOutput(void);
void doUSBInput(void);
void xor_leds(unsigned char bits);
void set_leds(unsigned char leds);

static byte theramin=0;
static byte freqIndex = 0;
static byte freqBase = 3 * 8; // 7 notes per, start at 3rd
static byte LEDByte=0;
static byte playLED = 1, doTimer = 0;

/* assume usb is detected 0xFF=uninited, 0=no, 1=yes */
static unsigned char usbCheck=0xFF;

//
// RC2 switch inits the USB check variable on startup only
// after startup the stored value is returned to the USB framework
// this routine is called very early in startup, even before even 
// the Init() code
//
unsigned char usbBusSense() {

#ifdef DEV
    if (usbCheck == 0xFF) usbCheck = (PORTCbits.RC2 != 0);  // DEV version, usbCheck=1 (USB on), switch is not pressed/1
#else
    if (usbCheck == 0xFF) usbCheck = (PORTCbits.RC2 == 0);  // REL version, usbCheck=1 (USB on), switch is pressed/0
#endif
    return usbCheck;
}

//
// main function for user.c called from usb main()
//
void ProcessIO(void)
{
    // local proto
    void check_accel(void);
    void mymemcpy(byte *dest, byte *src, byte n);
    static byte checkCount=0, i, tempHexByte[2] = {0,0};
    void hexDump(byte value, byte *out);

    // 
    // DOESNT WORK ON BOARD WITH STATUS LED
    // DOESNT WORK ON BOARD WITH STATUS LED
    // DOESNT WORK ON BOARD WITH STATUS LED
    //
    // play logo if switch press, RC2 == normally pulled high
    // should make this an incrementing toggle
    // 
#define OLDBOARD
#ifndef OLDBOARD
    if (PORTCbits.RC2 == 0) {
        if (playLED) {
            playLED = 0;
            theramin = 1;
        }
        else {
            playLED = 1;
            theramin = 0;
        }
    }
#endif

    // process IR -> audio if a sample is ready
    // recieved bits to the in (counts right number of bits)
    if (IRstate == IR_SAMPLEREADY) {
        byte errBit; 

        errBit = unManchester(IRbits, unIRbits);
        // unIRbits == SST43210 543210XX
        //             xxfreqcy TmrCntXX
       // set_leds(0xff ^ errBit);
        if (errBit == 14) {

            //handle the ir message
            if(inputMode == 0x00)
            {
                timer1Value = freq[(unIRbits[0] & 0b00111111)];
                timer1Counts = ((unIRbits[1] & 0b11111100) );
                T1CONbits.TMR1ON = 1;
            }
            else
            {
               // ir_receive();
                extractPayload(unIRbits, &irPayload_type, &irPayload_data);

                set_leds(irPayload_type);
                switch(irPayload_type)
                {
                    case(type_game_special):
                    {
                        if(irPayload_data = data_gSpecial_peerCountReq)
                        {
                            //set_leds(0xff ^ irPayload_data);
                            do_callback = 0x01;

                            //mymemcpy(&(output_buffer[b]), tmpbuf, 8);
                            output_buffer[0] = 'P';
                            output_buffer[1] = 'e';
                            output_buffer[2] = 'e';
                            output_buffer[3] = 'r';
                            output_buffer[4] = ' ';
                            output_buffer[5] = 'C';
                            output_buffer[6] = 'n';
                            output_buffer[7] = 't';
                            output_buffer[8] = '\n';
                            output_buffer[9] = '\r';
                            output_buffer[10] = '\0';


                            putsUSBUSART((char *)output_buffer);

                            //loading noise!
                            timer1Value = freq[18];
                            timer1Counts = TIMER1HZ / (timer1Value << 2);
                            PIE1bits.TMR1IE = 1;
                            T1CONbits.TMR1ON = 1;
                        }
                        
                        break;
                    }
                    case(type_ping_req):
                    {
                            do_callback = 0x01;

                            output_buffer[0] = 'R';
                            output_buffer[1] = 'e';
                            output_buffer[2] = 's';
                            output_buffer[3] = 'p';
                            output_buffer[4] = 'd';
                            output_buffer[5] = '\n';
                            output_buffer[6] = '\r';
                            output_buffer[7] = '\0';
                            putsUSBUSART((char *)output_buffer);

                        break;
                    }
                    case(type_ping_resp):
                    {
                            //set_leds(0xff ^ irPayload_data);
                            //do_callback = 0x01;

                            //mymemcpy(&(output_buffer[b]), tmpbuf, 8);
                            output_buffer[0] = 'P';
                            output_buffer[1] = 'i';
                            output_buffer[2] = 'n';
                            output_buffer[3] = 'g';
                            output_buffer[4] = ':';

                            hexDump(irPayload_data, tempHexByte);
                            output_buffer[5] = tempHexByte[0];
                            output_buffer[6] = tempHexByte[1];
                            
                            output_buffer[7] = '\n';
                            output_buffer[8] = '\r';
                            output_buffer[9] = '\0';
                            putsUSBUSART((char *)output_buffer);

                            //loading noise!
                            timer1Value = freq[18];
                            timer1Counts = TIMER1HZ / (timer1Value << 2);
                            PIE1bits.TMR1IE = 1;
                            T1CONbits.TMR1ON = 1;
                        break;
                    }
                }
            }
        }

        // prep to receive new IR data
        IRbitCnt = 0;

        //IRstate = IR_SILENT; should go through this state if using RC5
        IRstate = IR_LISTENING;
    }
    
    if(do_callback)
        do_callback++;

    if(do_callback == 255)
    {
        do_callback = 0x00;

        if(irPayload_type == type_ping_req)
        {
            irCB_pingResp(badge_id);
        }
        else
            irCB_gSpecialResp(badge_id);
    }

    // checkCount should only be incremented once per loop
    // used to limit the number of times processes are done
    checkCount++;
    if(inputMode)
    {
        if(do_led_seq)
            led_seq_Cylon_NoSound();

    }
    /* theramin */
    /* try not to check i2c too often */
    else if (!inputMode && theramin & ((checkCount % 64) == 0)) {
        // also do the led if enabled
        check_accel();


        /* 0x40 == error in accelerometer*/
        if ((xA & 0x40) | (yA & 0x40)) {
            // error. do again next loop
            checkCount--;
        } else { //handle accel data
            short x, y;

            // FIXME bit 6 -> xA & 0x2 == upside/down 
            // does not test of orientation
            // 5 bits +/- 32

            if (xA & 0x10) // ? negative
                x = -(short)(0x1F & ~xA); // ones complement
            else 
                x = xA;

            x >>= 2; // +-32/4 => +-8 -> 360/16 == 22.5 degrees each
            if (x > 3) x = 3;
            if (x < -4) x = -4;



            if (yA & 0x10) 
                y = -(short)(0x1F & ~yA); // make negative positive.
            else
                y = yA;

            y >>= 2; // +-32/4 => +-8 -> 360/16 == 22.5 degrees each
            if (y > 3) y = 3;
            if (y < -4) y = -4;


            // absolute mapping doesnt work real well (noisy)
            //freqBase = (x + 4)*8; // map to 8 scales
            //timer1Value = freq[freqBase + (y + 4)];
            freqBase = (x+4) * 8;
            //if (freqBase > 63) freqBase = 63;
        
            freqBase += (y+4);
            if (freqBase > 63) freqBase = 63;
     
            timer1Value = freq[freqBase];
            timer1Counts = timer1HZ / (timer1Value << 2);
            //ready to play
            T1CONbits.TMR1ON = 1;
        }
    }
    else if (!inputMode){ //theramins not enabled
        //enable back and forthaccel display
        /* the theramin's I2C reads slows the timing for this way down */
        /* so they should not be run at the same time */

        // 
        // timing changes with USB status. it takes less time 
        // when usb is not enabled
        // 
        // if (playLED & ((checkCount % 8) == 0)) {

        if (playLED & ((checkCount % 32) == 0)) {
            if (LEDByte == (hackRVA_height-1)) 
                LEDByte = 0;
            else
                LEDByte++;
           set_leds(hackRVA_bits[LEDByte]);
        }
    }

    //is it plugged in? If not, return (USB BUS sense altered)
    if ((usb_device_state < CONFIGURED_STATE)||(UCONbits.SUSPND==1))
        return;

    // USB UART output in progress?
    if (!mUSBUSARTIsTxTrfReady()) return;

    // USB UART input?
    if (!getsUSBUSART((char *)input_buffer,1))
        doUSBOutput();
    else 
        doUSBInput();


#ifdef EXAMPLE_UART
   if (mDataRdyUSART()) {
      unsigned char getcUSART();

      input_buffer[bptr] = getcUSART();
      bptr++;
      input_buffer[bptr] = 0;
      bchanged=1;
   }

   putcUSART(input_buffer[bptr-1]);
#endif

} //end ProcessIO

void doUSBOutput() {
    void binaryDump(byte value, byte *out);
    void hexDump(byte value, byte *out);
    void mymemcpy(byte *dest, byte *src, byte n);

    byte b, tmpbuf[8];

    // 
    // printing is pretty slow, since it has to goto the host
    // and that happens maybe 100 times a second and we get 12 MB/S max
    // at best. and the buffer is pretty small- 64 bytes
    // 
    // a better way to do this would be to do a print and double buffer 
    // the output buffer so that the USB routines can own it while we
    // print to the other. it would still require waiting if both buffers are full
    // 
    if (inMenu)  {                      // See we are outputting anything
        b = 0;

        if (inMenu == 1) {
            extern byte EEbyte, EEaddr;

            output_buffer[b++] = 'E';
            output_buffer[b++] = 'E';
            output_buffer[b++] = ':';
            hexDump(EEbyte, tmpbuf);
            mymemcpy(&(output_buffer[b]), tmpbuf, 2);
            output_buffer[b++] = ' ';

            hexDump(EEaddr, tmpbuf);
            mymemcpy(&(output_buffer[b]), tmpbuf, 2);
            b += 2;
//            byte i;
//
//            output_buffer[b++] = 'I';
//            output_buffer[b++] = 'R';
//            output_buffer[b++] = ' ';
//
//            for (i=0; i<4; i++) {
//                byte j;
//
//                binaryDump(IRbits[i], tmpbuf);
//                mymemcpy(&(output_buffer[b]), tmpbuf, 8);
//                b += 8;
//                output_buffer[b++] = ' ';
//            }
//
//            output_buffer[b++] = 10;
//            output_buffer[b++] = 13;
//            output_buffer[b++] = 0;
        }

         if (inMenu == 2) {
            byte errBit; 

            output_buffer[b++] = 'I';
            output_buffer[b++] = 'R';
            output_buffer[b++] = ' ';

            errBit = unManchester(IRbits, unIRbits);
    
            if (errBit == 14) {
                int i;
                for (i=0; i<2; i++) {
                    byte j;

                    binaryDump(unIRbits[i], tmpbuf);
                    mymemcpy(&(output_buffer[b]), tmpbuf, 8);
                    b += 8;
                    output_buffer[b++] = ' ';
                }
            }
            else {
                byte i;

                output_buffer[b++] = 'E';
                output_buffer[b++] = ' ';
                hexDump(errBit, tmpbuf); // hex dump only uses 2 bytes
                mymemcpy(&(output_buffer[b]), tmpbuf, 2);
                b += 2;
            }
            output_buffer[b++] = 10;
            output_buffer[b++] = 13;
            output_buffer[b++] = 0;
         }

         if (inMenu == 3) {
            byte i;

            output_buffer[b++] = 'T';
            output_buffer[b++] = '1';
            output_buffer[b++] = ':';

            hexDump(((timer1Value & 0xFF00) >> 8), tmpbuf); // hex dump only uses 2 bytes
            for (i=0; i< 2; i++) output_buffer[b++] = tmpbuf[i];

            hexDump(((timer1Value & 0x00FF)     ), tmpbuf); // hex dump only uses 2 bytes
            mymemcpy(&(output_buffer[b]), tmpbuf, 2);
            b+=2;

            output_buffer[b++] = ' ';
            output_buffer[b++] = 'I';
            output_buffer[b++] = ':';

            hexDump(freqIndex, tmpbuf); // hex dump only uses 2 bytes
            mymemcpy(&(output_buffer[b]), tmpbuf, 2);
            b+=2;

            output_buffer[b++] = ' ';
            output_buffer[b++] = 'A';
            output_buffer[b++] = 'C';
            output_buffer[b++] = 'C';
            output_buffer[b++] = ':';
            // X
            if (xA & 0x20) {
                xA = (0x1F & ~xA); // make negative positive.
                output_buffer[b++] = '-';
            }
            else
               output_buffer[b++] = ' ';

            hexDump(xA, tmpbuf); // hex dump only uses 2 bytes
            mymemcpy(&(output_buffer[b]), tmpbuf, 2);
            b+=2;
            output_buffer[b++] = ' ';
            // Y
            if (yA & 0x20) {
                yA = (0x1F & ~yA);
                output_buffer[b++] = '-';
            }
            else
               output_buffer[b++] = ' ';

            hexDump(yA, tmpbuf); // hex dump only uses 2 bytes
            mymemcpy(&(output_buffer[b]), tmpbuf, 2);
            b+=2;
            output_buffer[b++] = ' ';
            // Z
            if (zA & 0x20) {
                zA = (0x1F & ~zA);
                output_buffer[b++] = '-';
            }
            else
               output_buffer[b++] = ' ';

            hexDump(zA, tmpbuf); // hex dump only uses 2 bytes
            mymemcpy(&(output_buffer[b]), tmpbuf, 2);
            b+=2;

            output_buffer[b++] = ' ';
            output_buffer[b++] = 'T';
            output_buffer[b++] = 'H';
            output_buffer[b++] = ':';
            output_buffer[b++] = ' ';

            hexDump(theramin, tmpbuf); // hex dump only uses 2 bytes
            mymemcpy(&(output_buffer[b]), tmpbuf, 2);
            b+=2;

            output_buffer[b++] = 10;
            output_buffer[b++] = 13;
            output_buffer[b++] = 0;

            inMenu = 0;
         }
         else
            inMenu++;
   
         putsUSBUSART((char *)output_buffer);
    }
}

void doUSBInput() {
    // 
    // Something in the USB/UART buffer
    // 

#define TV1             0x00    // Address for device TV1
#define CD_PLAYER       0x14    // Address value for 'RC5' CD Player
#define PLAY_CMD        0x35    // Command value for RC5 Data "Play"
#define STOP_CMD        0x36    // Command value for RC5 Data "Stop"
#define VOLUP_CMD       0x10    // Command values for volume up
#define VOLDOWN_CMD     0x11    //  and volume down.


    // reset and dump info
    if (input_buffer[0] == 'R')  {
        inputMode = 0x00;
    }
    
    if(inputMode == 0x01)//station
    {
        //go back to fun demo mode
        if (input_buffer[0] == 't') {
            inputMode = 0x00;
        }

        //turn on cylon Led
        if(input_buffer[0] == '1')
        {
            do_led_seq ^= 0x01;
        }

        //send cylon seek message
        if (input_buffer[0] == 'c') {
            //data indicates cylon stage
            ToggByte = (0b00100000 & data_gSpecial_cylonHello) >> 5;
            AddrByte = (0b00011111 & data_gSpecial_cylonHello);

            //type = game special
            //DataByte = 0b00110000;
            //type is upper four bits
            DataByte = type_game_special << 2;

            //put the top two bits of the data at the 2 LSBs
            DataByte |= (0b11000000 & data_gSpecial_cylonHello)>>6;

            SendRC5();
        }

        //send peer count (not actually a base station, but w/e)
        if (input_buffer[0] == 'p') {
            irCB_gSpecialReq();
        }

        //ping (fake icmp)
        if(input_buffer[0] == 'i')
        {
            irCB_pingReq(0x77);
        }

        //give food
        if(input_buffer[0] == 'f')
        {
            irCB_GoLFood(0x0A);
        }

        //attack
        if(input_buffer[0] == 'a')
        {
            irCB_GoLAttack(0x0A);
        }

        //give hp
        if(input_buffer[0] == 'g')
        {
            irCB_GoLTrade(0x05);
        }
        
        //mutate
        if(input_buffer[0] == 'm')
        {
            irCB_GoLMutate();
        }

        //rally
        if(input_buffer[0] == 'r')
        {
            irCB_GoLRally(200);
        }

        if(input_buffer[0] == 'z')
        {
            irCB_GoL_Z_Attack(10);
        }
    }
    else if(inputMode == 0x00)
    {
        #ifdef base_station
            //change mode to base station
            if (input_buffer[0] == 't') {
                inputMode = 0x01;
            }
        #endif
        // hit the space bar to dump info
        if (input_buffer[0] == ' ')  {
            inMenu = 1;
        }

        if (input_buffer[0] == '?')  {
            extern void EEfetch(void);
            extern void EEstore(void);
            extern byte EEbyte, EEaddr;

            EEbyte = 0;

            EEaddr = 32; // read address 32
            EEfetch();
            EEbyte++;
            EEstore();
            inMenu = 1;
        }


        // reset and dump info
        if (input_buffer[0] == 'r')  {
            IRstate = IR_LISTENING;
            IRbitCnt = 0;
            IRbits[0] = 0;

            //turn off leds
            set_leds(0);
            PIE1bits.TMR1IE = 0;  // toggle piezo interupt off

        }

        if (input_buffer[0] == 's')  {
            static byte IRfreqBase=32, IRTimerCount=255;

            //DataByte = VOLUP_CMD; // command byte
            // AddrByte = TV1; // device ID
            // ToggByte = 1; // on or off (button press)

            //   IRbits == SST43210 543210XX
            //             SSTAAAAA DDDDDDXX  S=start T=tog A=addr D=data X=not xmitted
            //             xxfreqcy TmrCntXX

            // ick. interface to RC5 lib

            ToggByte = (0b00100000 & IRfreqBase) >> 5 ;
            AddrByte = (0b00011111 & IRfreqBase) ;

            //IRTimerCount = timer1HZ / (freq[IRfreqBase] << 2) ;
            DataByte = 0b11111100 & IRTimerCount ;  // lose low order bits result is multiplied
                                                    // by 16 when actual playing occurs
            IRfreqBase++;

            SendRC5();
            // MAY NEED A DELAY HERE FOR REAL TV AND SUCH
            // REMOVED FROM Send LIB

            // inMenu = 2;
        }

        if (input_buffer[0] == '1') xor_leds(1);
        if (input_buffer[0] == '2') xor_leds(2);
        if (input_buffer[0] == '3') xor_leds(4);
        if (input_buffer[0] == '4') xor_leds(8);
        if (input_buffer[0] == '5') xor_leds(16);
        if (input_buffer[0] == '6') xor_leds(32);
        if (input_buffer[0] == '7') xor_leds(64);
        if (input_buffer[0] == '8') xor_leds(128);

        doTimer = 0;
        if (input_buffer[0] == '<') {
            if (freqIndex > 0) freqIndex--;
            timer1Value = freq[freqIndex];
            timer1Counts = 4096;
            T1CONbits.TMR1ON = 1;
        }
        if (input_buffer[0] == '>') {
            if (freqIndex < 63) freqIndex++;
            timer1Value = freq[freqIndex];
            timer1Counts = 4096;
            T1CONbits.TMR1ON = 1;
        }

        // shift octave - or +
        if (input_buffer[0] == ',') {
            freqBase -= 8;
            freqBase &= 0xF8; // nuke lower 0-7
            if (freqBase < 0) freqBase = 0;
            timer1Value = freq[freqBase];
            doTimer = 1;
        }

        if (input_buffer[0] == '.') {
            freqBase += 8;
            freqBase &= 0xF8; // nuke lower 0-7
            if (freqBase > 48) freqBase = 48;
            timer1Value = freq[freqBase];
            doTimer = 1;
        }

        // map keyboard z -> m to notes 1-7
        if (input_buffer[0] == 'z') {
            // ascii 1==49, 9==57 map to base freq index 27
            timer1Value = freq[freqBase];
            doTimer = 1;
        }

        // map keyboard z -> m to notes 1-7
        if (input_buffer[0] == 'x') {
            // ascii 1==49, 9==57 map to base freq index 27
            timer1Value = freq[freqBase+1];
            doTimer = 1;
        }

        // map keyboard z -> m to notes 1-7
        if (input_buffer[0] == 'c') {
            // ascii 1==49, 9==57 map to base freq index 27
            timer1Value = freq[freqBase+2];
            doTimer = 1;
        }

        // map keyboard z -> m to notes 1-7
        if (input_buffer[0] == 'v') {
            // ascii 1==49, 9==57 map to base freq index 27
            timer1Value = freq[freqBase+3];
            doTimer = 1;
        }

        // map keyboard z -> m to notes 1-7
        if (input_buffer[0] == 'b') {
            // ascii 1==49, 9==57 map to base freq index 27
            timer1Value = freq[freqBase+4];
            doTimer = 1;
        }

        // map keyboard z -> m to notes 1-7
        if (input_buffer[0] == 'n') {
            // ascii 1==49, 9==57 map to base freq index 27
            timer1Value = freq[freqBase+5];
            doTimer = 1;
        }

        // map keyboard z -> m to notes 1-7
        if (input_buffer[0] == 'm') {
            // ascii 1==49, 9==57 map to base freq index 27
            timer1Value = freq[freqBase+6];
            doTimer = 1;
        }

        // map keyboard p -> play out hackRVA bitmap
        if (input_buffer[0] == 'p') {
            LEDByte = 0;
            playLED ^= 1;
        }

        if (input_buffer[0] == 'a')  {
            PIE1bits.TMR1IE ^= 1;  // toggle piezo interupt on/off

            PIR1bits.TMR1IF = 0;     // clear overflow bit
            timer1Value = freq[freqBase];
            TMR1H = (65535 - timer1Value) >> 8;
            TMR1L = (65535 - timer1Value) & 0xFF;
            doTimer = 1;
        }

        if (doTimer) {
            timer1Counts = timer1HZ / (timer1Value << 2) ;
            T1CONbits.TMR1ON = 1;
        }

        if (input_buffer[0] == 'w')  {
            theramin ^= 1;
        }

        if (input_buffer[0] == '[') {
            if (LEDByte != 0) LEDByte--;
            set_leds(hackRVA_bits[LEDByte]);
        }

        if (input_buffer[0] == ']') {
            if (LEDByte != (hackRVA_height-1)) LEDByte++;
            set_leds(hackRVA_bits[LEDByte]);
        }
    }

}

#define first_seq_up 0x1f
#define second_seq_up 0x0E
#define third_seq_up 0x04

#define first_seq_down 0xf8
#define second_seq_down 0x70
#define third_seq_down 0x20

#define cylon_speed 3
void led_seq_Cylon_NoSound(void)
{
    //persistent state of the sequence
    static unsigned char i = 0, j = 0;
    short k = 0;

    //count moving top to bottom
    if(j < 12)
    {
        if(j < 4)
        {
            if(delayCount < 1)
                set_leds((first_seq_up << j) >> 4);

            else if(delayCount < 10 )
                set_leds((second_seq_up << j) >> 4);

            else if(delayCount < 40)
                set_leds((third_seq_up << j) >> 4);

            timer1Value = freq[7];
            timer1Counts = TIMER1HZ / (4096 << 2);
            PIE1bits.TMR1IE = 1;
            T1CONbits.TMR1ON = 1;
        }
        else
        {
            if(delayCount < 1)
                set_leds(first_seq_up << (j-4) );

            else if(delayCount < 10 )
                set_leds(second_seq_up << (j-4) );

            else if(delayCount < 40)
                set_leds(third_seq_up << (j-4) );

            timer1Value = freq[9];
            timer1Counts = TIMER1HZ / (4096 << 2);
            PIE1bits.TMR1IE = 1;
            T1CONbits.TMR1ON = 1;
        }

        delayCount++;

        if(delayCount >= 40)
        {
            delayCount = 0;
            iterator_count++;

            if(iterator_count > cylon_speed)
            {
                iterator_count = 0;
                j++;
            }
        }

    }
    //count moving bottom to top
    else if (j < 24)
    {
        if(j < 16)
        {
            if(delayCount < 1)
                set_leds((first_seq_down >> j - 12) << 4);

            else if(delayCount < 10 )
                set_leds((second_seq_down >> j- 12) << 4);

            else if(delayCount < 40)
                set_leds((third_seq_down >> j - 12) << 4);

            timer1Value = freq[7];
            timer1Counts = TIMER1HZ / (4096 << 2);
            PIE1bits.TMR1IE = 1;
            T1CONbits.TMR1ON = 1;
        }
        else
        {
             if(delayCount < 1)
                set_leds(first_seq_down >> j - 16);


             else if(delayCount < 10 )
                set_leds(second_seq_down >> j - 16);


             else if(delayCount < 40)
                set_leds( third_seq_down >> j - 16);

            timer1Value = freq[9];
            timer1Counts = TIMER1HZ / (4096 << 2);
            PIE1bits.TMR1IE = 1;
            T1CONbits.TMR1ON = 1;
        }


        delayCount++;

        if(delayCount >= 40)
        {
            delayCount = 0;
            iterator_count++;

            if(iterator_count > cylon_speed)
            {
                iterator_count = 0;
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
        //reset_globals();

        i = j = k = 0; //all done
        delayCount = 0;
        set_leds(0x00);
    }
}

// RC5 is 14 bits, not 16 so the top bit 28-31 are not transmitted
// and will show up as an error, so this routine returns a 14 for RC5
byte unManchester(byte *IRbits, byte *outBits) {
    byte bitCnt=0, validIRbit, i, errBit=0;

    outBits[0] = outBits[1] = 0;

    /* bits are inverted */
    /* because with the IR decoder off = 1 on = 0 */
    /* 10 inverted-> 01 == manchester "1" */
    /* 01 inverted-> 10 == manchester "0" */
    /* but the math works out the we can */
    /* just subtract 1 from the inverted bits */
    for (i=0; i<4; i++) {

        //shift working byte up 1 bit
        //makes room for the next bit
        outBits[(i>>1)] <<= 1;

        //get a pair of bits from the received IR bits
        validIRbit = (IRbits[i] & 0b11000000) >> 6;

        //bits shouldn't be the same (manchester based on bit change)
        if ((!( (validIRbit == 1) || (validIRbit == 2) )) & (errBit == 0)) 
            errBit = bitCnt; // remember first bad bit number
        else
           outBits[(i>>1)] |= (validIRbit - 1);  // or decoded bit with proper output byte
        //keep track of working bit to locate error
        bitCnt++;


        outBits[(i>>1)] <<= 1;
        validIRbit = (IRbits[i] & 0b00110000) >> 4;
        if ((!( (validIRbit == 1) || (validIRbit == 2) )) & (errBit == 0)) 
            errBit = bitCnt; // remember first bad bit number
        else
           outBits[(i>>1)] |= (validIRbit - 1);
        bitCnt++;

        outBits[(i>>1)] <<= 1;
        validIRbit = (IRbits[i] & 0b00001100) >> 2;
        if ((!( (validIRbit == 1) || (validIRbit == 2) )) & (errBit == 0)) 
            errBit = bitCnt; // remember first bad bit number
        else
           outBits[(i>>1)] |= (validIRbit - 1);
        bitCnt++;

        outBits[(i>>1)] <<= 1;
        validIRbit = (IRbits[i] & 0b00000011)     ;
        if ((!( (validIRbit == 1) || (validIRbit == 2) )) & (errBit == 0)) 
            errBit = bitCnt; // remember first bad bit number
        else
           outBits[(i>>1)] |= (validIRbit - 1);
        bitCnt++;
    }
    return errBit;
}

void binaryDump(byte value, byte *out) {
    *out = htab[ (value & 0b10000000) >> 7 ];
    out++;
    *out = htab[ (value & 0b01000000) >> 6 ];
    out++;
    *out = htab[ (value & 0b00100000) >> 5 ];
    out++;
    *out = htab[ (value & 0b00010000) >> 4 ];
    out++;
    *out = htab[ (value & 0b00001000) >> 3 ];
    out++;
    *out = htab[ (value & 0b00000100) >> 2 ];
    out++;
    *out = htab[ (value & 0b00000010) >> 1 ];
    out++;
    *out = htab[ (value & 0b00000001)      ];
    out++;
}

void hexDump(byte value, byte *out) {
    *out = htab[(value >>  4)];
    out++;
    *out = htab[value & 0xF];
    out++;
}

void mymemcpy(byte *dest, byte *src, byte n) {
    byte i;

    for (i=0; i<n; i++) dest[i] = src[i];
}
