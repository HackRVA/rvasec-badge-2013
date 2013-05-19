#line 1 "../../Badge.X/user/user.c"
#line 1 "../../Badge.X/user/user.c"



#line 1 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"

#line 3 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"

#line 5 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 7 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 9 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 11 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 13 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 15 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 17 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 19 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 21 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 23 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 25 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 27 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 29 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 31 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 33 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 35 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 37 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 39 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 41 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 43 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 45 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 47 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 49 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 51 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 53 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 55 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 57 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 59 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 61 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 63 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 65 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 67 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 1 "/opt/microchip/mplabc18/v3.40/bin/../h/p18f2455.h"

#line 5 "/opt/microchip/mplabc18/v3.40/bin/../h/p18f2455.h"
 


#line 9 "/opt/microchip/mplabc18/v3.40/bin/../h/p18f2455.h"

extern volatile near unsigned            UFRM;
extern volatile near unsigned char       UFRML;
extern volatile near union {
  struct {
    unsigned FRM:8;
  };
  struct {
    unsigned FRM0:1;
    unsigned FRM1:1;
    unsigned FRM2:1;
    unsigned FRM3:1;
    unsigned FRM4:1;
    unsigned FRM5:1;
    unsigned FRM6:1;
    unsigned FRM7:1;
  };
} UFRMLbits;
extern volatile near unsigned char       UFRMH;
extern volatile near union {
  struct {
    unsigned FRM:3;
  };
  struct {
    unsigned FRM8:1;
    unsigned FRM9:1;
    unsigned FRM10:1;
  };
} UFRMHbits;
extern volatile near unsigned char       UIR;
extern volatile near struct {
  unsigned URSTIF:1;
  unsigned UERRIF:1;
  unsigned ACTVIF:1;
  unsigned TRNIF:1;
  unsigned IDLEIF:1;
  unsigned STALLIF:1;
  unsigned SOFIF:1;
} UIRbits;
extern volatile near unsigned char       UIE;
extern volatile near struct {
  unsigned URSTIE:1;
  unsigned UERRIE:1;
  unsigned ACTVIE:1;
  unsigned TRNIE:1;
  unsigned IDLEIE:1;
  unsigned STALLIE:1;
  unsigned SOFIE:1;
} UIEbits;
extern volatile near unsigned char       UEIR;
extern volatile near struct {
  unsigned PIDEF:1;
  unsigned CRC5EF:1;
  unsigned CRC16EF:1;
  unsigned DFN8EF:1;
  unsigned BTOEF:1;
  unsigned :2;
  unsigned BTSEF:1;
} UEIRbits;
extern volatile near unsigned char       UEIE;
extern volatile near struct {
  unsigned PIDEE:1;
  unsigned CRC5EE:1;
  unsigned CRC16EE:1;
  unsigned DFN8EE:1;
  unsigned BTOEE:1;
  unsigned :2;
  unsigned BTSEE:1;
} UEIEbits;
extern volatile near unsigned char       USTAT;
extern volatile near union {
  struct {
    unsigned :1;
    unsigned PPBI:1;
    unsigned DIR:1;
    unsigned ENDP:4;
  };
  struct {
    unsigned :3;
    unsigned ENDP0:1;
    unsigned ENDP1:1;
    unsigned ENDP2:1;
    unsigned ENDP3:1;
  };
} USTATbits;
extern volatile near unsigned char       UCON;
extern volatile near struct {
  unsigned :1;
  unsigned SUSPND:1;
  unsigned RESUME:1;
  unsigned USBEN:1;
  unsigned PKTDIS:1;
  unsigned SE0:1;
  unsigned PPBRST:1;
} UCONbits;
extern volatile near unsigned char       UADDR;
extern volatile near union {
  struct {
    unsigned ADDR:7;
  };
  struct {
    unsigned ADDR0:1;
    unsigned ADDR1:1;
    unsigned ADDR2:1;
    unsigned ADDR3:1;
    unsigned ADDR4:1;
    unsigned ADDR5:1;
    unsigned ADDR6:1;
  };
} UADDRbits;
extern volatile near unsigned char       UCFG;
extern volatile near union {
  struct {
    unsigned PPB:2;
    unsigned FSEN:1;
    unsigned UTRDIS:1;
    unsigned UPUEN:1;
    unsigned :1;
    unsigned UOEMON:1;
    unsigned UTEYE:1;
  };
  struct {
    unsigned PPB0:1;
    unsigned PPB1:1;
  };
} UCFGbits;
extern volatile near unsigned char       UEP0;
extern volatile near struct {
  unsigned EPSTALL:1;
  unsigned EPINEN:1;
  unsigned EPOUTEN:1;
  unsigned EPCONDIS:1;
  unsigned EPHSHK:1;
} UEP0bits;
extern volatile near unsigned char       UEP1;
extern volatile near struct {
  unsigned EPSTALL:1;
  unsigned EPINEN:1;
  unsigned EPOUTEN:1;
  unsigned EPCONDIS:1;
  unsigned EPHSHK:1;
} UEP1bits;
extern volatile near unsigned char       UEP2;
extern volatile near struct {
  unsigned EPSTALL:1;
  unsigned EPINEN:1;
  unsigned EPOUTEN:1;
  unsigned EPCONDIS:1;
  unsigned EPHSHK:1;
} UEP2bits;
extern volatile near unsigned char       UEP3;
extern volatile near struct {
  unsigned EPSTALL:1;
  unsigned EPINEN:1;
  unsigned EPOUTEN:1;
  unsigned EPCONDIS:1;
  unsigned EPHSHK:1;
} UEP3bits;
extern volatile near unsigned char       UEP4;
extern volatile near struct {
  unsigned EPSTALL:1;
  unsigned EPINEN:1;
  unsigned EPOUTEN:1;
  unsigned EPCONDIS:1;
  unsigned EPHSHK:1;
} UEP4bits;
extern volatile near unsigned char       UEP5;
extern volatile near struct {
  unsigned EPSTALL:1;
  unsigned EPINEN:1;
  unsigned EPOUTEN:1;
  unsigned EPCONDIS:1;
  unsigned EPHSHK:1;
} UEP5bits;
extern volatile near unsigned char       UEP6;
extern volatile near struct {
  unsigned EPSTALL:1;
  unsigned EPINEN:1;
  unsigned EPOUTEN:1;
  unsigned EPCONDIS:1;
  unsigned EPHSHK:1;
} UEP6bits;
extern volatile near unsigned char       UEP7;
extern volatile near struct {
  unsigned EPSTALL:1;
  unsigned EPINEN:1;
  unsigned EPOUTEN:1;
  unsigned EPCONDIS:1;
  unsigned EPHSHK:1;
} UEP7bits;
extern volatile near unsigned char       UEP8;
extern volatile near struct {
  unsigned EPSTALL:1;
  unsigned EPINEN:1;
  unsigned EPOUTEN:1;
  unsigned EPCONDIS:1;
  unsigned EPHSHK:1;
} UEP8bits;
extern volatile near unsigned char       UEP9;
extern volatile near struct {
  unsigned EPSTALL:1;
  unsigned EPINEN:1;
  unsigned EPOUTEN:1;
  unsigned EPCONDIS:1;
  unsigned EPHSHK:1;
} UEP9bits;
extern volatile near unsigned char       UEP10;
extern volatile near struct {
  unsigned EPSTALL:1;
  unsigned EPINEN:1;
  unsigned EPOUTEN:1;
  unsigned EPCONDIS:1;
  unsigned EPHSHK:1;
} UEP10bits;
extern volatile near unsigned char       UEP11;
extern volatile near struct {
  unsigned EPSTALL:1;
  unsigned EPINEN:1;
  unsigned EPOUTEN:1;
  unsigned EPCONDIS:1;
  unsigned EPHSHK:1;
} UEP11bits;
extern volatile near unsigned char       UEP12;
extern volatile near struct {
  unsigned EPSTALL:1;
  unsigned EPINEN:1;
  unsigned EPOUTEN:1;
  unsigned EPCONDIS:1;
  unsigned EPHSHK:1;
} UEP12bits;
extern volatile near unsigned char       UEP13;
extern volatile near struct {
  unsigned EPSTALL:1;
  unsigned EPINEN:1;
  unsigned EPOUTEN:1;
  unsigned EPCONDIS:1;
  unsigned EPHSHK:1;
} UEP13bits;
extern volatile near unsigned char       UEP14;
extern volatile near struct {
  unsigned EPSTALL:1;
  unsigned EPINEN:1;
  unsigned EPOUTEN:1;
  unsigned EPCONDIS:1;
  unsigned EPHSHK:1;
} UEP14bits;
extern volatile near unsigned char       UEP15;
extern volatile near struct {
  unsigned EPSTALL:1;
  unsigned EPINEN:1;
  unsigned EPOUTEN:1;
  unsigned EPCONDIS:1;
  unsigned EPHSHK:1;
} UEP15bits;
extern volatile near unsigned char       PORTA;
extern volatile near union {
  struct {
    unsigned RA0:1;
    unsigned RA1:1;
    unsigned RA2:1;
    unsigned RA3:1;
    unsigned RA4:1;
    unsigned RA5:1;
    unsigned RA6:1;
  };
  struct {
    unsigned AN0:1;
    unsigned AN1:1;
    unsigned AN2:1;
    unsigned AN3:1;
    unsigned T0CKI:1;
    unsigned AN4:1;
    unsigned OSC2:1;
  };
  struct {
    unsigned :2;
    unsigned VREFM:1;
    unsigned VREFP:1;
    unsigned :1;
    unsigned LVDIN:1;
  };
  struct {
    unsigned :5;
    unsigned HLVDIN:1;
  };
} PORTAbits;
extern volatile near unsigned char       PORTB;
extern volatile near union {
  struct {
    unsigned RB0:1;
    unsigned RB1:1;
    unsigned RB2:1;
    unsigned RB3:1;
    unsigned RB4:1;
    unsigned RB5:1;
    unsigned RB6:1;
    unsigned RB7:1;
  };
  struct {
    unsigned INT0:1;
    unsigned INT1:1;
    unsigned INT2:1;
    unsigned :2;
    unsigned PGM:1;
    unsigned PGC:1;
    unsigned PGD:1;
  };
} PORTBbits;
extern volatile near unsigned char       PORTC;
extern volatile near union {
  struct {
    unsigned RC0:1;
    unsigned RC1:1;
    unsigned RC2:1;
    unsigned :1;
    unsigned RC4:1;
    unsigned RC5:1;
    unsigned RC6:1;
    unsigned RC7:1;
  };
  struct {
    unsigned T1OSO:1;
    unsigned T1OSI:1;
    unsigned CCP1:1;
    unsigned :3;
    unsigned TX:1;
    unsigned RX:1;
  };
  struct {
    unsigned T13CKI:1;
    unsigned :1;
    unsigned P1A:1;
    unsigned :3;
    unsigned CK:1;
    unsigned DT:1;
  };
} PORTCbits;
extern volatile near unsigned char       PORTE;
extern volatile near struct {
  unsigned :3;
  unsigned RE3:1;
} PORTEbits;
extern volatile near unsigned char       LATA;
extern volatile near struct {
  unsigned LATA0:1;
  unsigned LATA1:1;
  unsigned LATA2:1;
  unsigned LATA3:1;
  unsigned LATA4:1;
  unsigned LATA5:1;
  unsigned LATA6:1;
} LATAbits;
extern volatile near unsigned char       LATB;
extern volatile near struct {
  unsigned LATB0:1;
  unsigned LATB1:1;
  unsigned LATB2:1;
  unsigned LATB3:1;
  unsigned LATB4:1;
  unsigned LATB5:1;
  unsigned LATB6:1;
  unsigned LATB7:1;
} LATBbits;
extern volatile near unsigned char       LATC;
extern volatile near struct {
  unsigned LATC0:1;
  unsigned LATC1:1;
  unsigned LATC2:1;
  unsigned :3;
  unsigned LATC6:1;
  unsigned LATC7:1;
} LATCbits;
extern volatile near unsigned char       DDRA;
extern volatile near union {
  struct {
    unsigned TRISA0:1;
    unsigned TRISA1:1;
    unsigned TRISA2:1;
    unsigned TRISA3:1;
    unsigned TRISA4:1;
    unsigned TRISA5:1;
    unsigned TRISA6:1;
  };
  struct {
    unsigned RA0:1;
    unsigned RA1:1;
    unsigned RA2:1;
    unsigned RA3:1;
    unsigned RA4:1;
    unsigned RA5:1;
    unsigned RA6:1;
  };
} DDRAbits;
extern volatile near unsigned char       TRISA;
extern volatile near union {
  struct {
    unsigned TRISA0:1;
    unsigned TRISA1:1;
    unsigned TRISA2:1;
    unsigned TRISA3:1;
    unsigned TRISA4:1;
    unsigned TRISA5:1;
    unsigned TRISA6:1;
  };
  struct {
    unsigned RA0:1;
    unsigned RA1:1;
    unsigned RA2:1;
    unsigned RA3:1;
    unsigned RA4:1;
    unsigned RA5:1;
    unsigned RA6:1;
  };
} TRISAbits;
extern volatile near unsigned char       DDRB;
extern volatile near union {
  struct {
    unsigned TRISB0:1;
    unsigned TRISB1:1;
    unsigned TRISB2:1;
    unsigned TRISB3:1;
    unsigned TRISB4:1;
    unsigned TRISB5:1;
    unsigned TRISB6:1;
    unsigned TRISB7:1;
  };
  struct {
    unsigned RB0:1;
    unsigned RB1:1;
    unsigned RB2:1;
    unsigned RB3:1;
    unsigned RB4:1;
    unsigned RB5:1;
    unsigned RB6:1;
    unsigned RB7:1;
  };
} DDRBbits;
extern volatile near unsigned char       TRISB;
extern volatile near union {
  struct {
    unsigned TRISB0:1;
    unsigned TRISB1:1;
    unsigned TRISB2:1;
    unsigned TRISB3:1;
    unsigned TRISB4:1;
    unsigned TRISB5:1;
    unsigned TRISB6:1;
    unsigned TRISB7:1;
  };
  struct {
    unsigned RB0:1;
    unsigned RB1:1;
    unsigned RB2:1;
    unsigned RB3:1;
    unsigned RB4:1;
    unsigned RB5:1;
    unsigned RB6:1;
    unsigned RB7:1;
  };
} TRISBbits;
extern volatile near unsigned char       DDRC;
extern volatile near union {
  struct {
    unsigned TRISC0:1;
    unsigned TRISC1:1;
    unsigned TRISC2:1;
    unsigned :3;
    unsigned TRISC6:1;
    unsigned TRISC7:1;
  };
  struct {
    unsigned RC0:1;
    unsigned RC1:1;
    unsigned RC2:1;
    unsigned :3;
    unsigned RC6:1;
    unsigned RC7:1;
  };
} DDRCbits;
extern volatile near unsigned char       TRISC;
extern volatile near union {
  struct {
    unsigned TRISC0:1;
    unsigned TRISC1:1;
    unsigned TRISC2:1;
    unsigned :3;
    unsigned TRISC6:1;
    unsigned TRISC7:1;
  };
  struct {
    unsigned RC0:1;
    unsigned RC1:1;
    unsigned RC2:1;
    unsigned :3;
    unsigned RC6:1;
    unsigned RC7:1;
  };
} TRISCbits;
extern volatile near unsigned char       OSCTUNE;
extern volatile near union {
  struct {
    unsigned TUN:5;
    unsigned :2;
    unsigned INTSRC:1;
  };
  struct {
    unsigned TUN0:1;
    unsigned TUN1:1;
    unsigned TUN2:1;
    unsigned TUN3:1;
    unsigned TUN4:1;
  };
} OSCTUNEbits;
extern volatile near unsigned char       PIE1;
extern volatile near struct {
  unsigned TMR1IE:1;
  unsigned TMR2IE:1;
  unsigned CCP1IE:1;
  unsigned SSPIE:1;
  unsigned TXIE:1;
  unsigned RCIE:1;
  unsigned ADIE:1;
} PIE1bits;
extern volatile near unsigned char       PIR1;
extern volatile near struct {
  unsigned TMR1IF:1;
  unsigned TMR2IF:1;
  unsigned CCP1IF:1;
  unsigned SSPIF:1;
  unsigned TXIF:1;
  unsigned RCIF:1;
  unsigned ADIF:1;
} PIR1bits;
extern volatile near unsigned char       IPR1;
extern volatile near struct {
  unsigned TMR1IP:1;
  unsigned TMR2IP:1;
  unsigned CCP1IP:1;
  unsigned SSPIP:1;
  unsigned TXIP:1;
  unsigned RCIP:1;
  unsigned ADIP:1;
} IPR1bits;
extern volatile near unsigned char       PIE2;
extern volatile near union {
  struct {
    unsigned CCP2IE:1;
    unsigned TMR3IE:1;
    unsigned HLVDIE:1;
    unsigned BCLIE:1;
    unsigned EEIE:1;
    unsigned USBIE:1;
    unsigned CMIE:1;
    unsigned OSCFIE:1;
  };
  struct {
    unsigned :2;
    unsigned LVDIE:1;
  };
} PIE2bits;
extern volatile near unsigned char       PIR2;
extern volatile near union {
  struct {
    unsigned CCP2IF:1;
    unsigned TMR3IF:1;
    unsigned HLVDIF:1;
    unsigned BCLIF:1;
    unsigned EEIF:1;
    unsigned USBIF:1;
    unsigned CMIF:1;
    unsigned OSCFIF:1;
  };
  struct {
    unsigned :2;
    unsigned LVDIF:1;
  };
} PIR2bits;
extern volatile near unsigned char       IPR2;
extern volatile near union {
  struct {
    unsigned CCP2IP:1;
    unsigned TMR3IP:1;
    unsigned HLVDIP:1;
    unsigned BCLIP:1;
    unsigned EEIP:1;
    unsigned USBIP:1;
    unsigned CMIP:1;
    unsigned OSCFIP:1;
  };
  struct {
    unsigned :2;
    unsigned LVDIP:1;
  };
} IPR2bits;
extern volatile near unsigned char       EECON1;
extern volatile near struct {
  unsigned RD:1;
  unsigned WR:1;
  unsigned WREN:1;
  unsigned WRERR:1;
  unsigned FREE:1;
  unsigned :1;
  unsigned CFGS:1;
  unsigned EEPGD:1;
} EECON1bits;
extern volatile near unsigned char       EECON2;
extern volatile near unsigned char       EEDATA;
extern volatile near unsigned char       EEADR;
extern volatile near unsigned char       RCSTA;
extern volatile near union {
  struct {
    unsigned RX9D:1;
    unsigned OERR:1;
    unsigned FERR:1;
    unsigned ADDEN:1;
    unsigned CREN:1;
    unsigned SREN:1;
    unsigned RX9:1;
    unsigned SPEN:1;
  };
  struct {
    unsigned :3;
    unsigned ADEN:1;
  };
} RCSTAbits;
extern volatile near unsigned char       TXSTA;
extern volatile near struct {
  unsigned TX9D:1;
  unsigned TRMT:1;
  unsigned BRGH:1;
  unsigned SENDB:1;
  unsigned SYNC:1;
  unsigned TXEN:1;
  unsigned TX9:1;
  unsigned CSRC:1;
} TXSTAbits;
extern volatile near unsigned char       TXREG;
extern volatile near unsigned char       RCREG;
extern volatile near unsigned char       SPBRG;
extern volatile near unsigned char       SPBRGH;
extern volatile near unsigned char       T3CON;
extern volatile near union {
  struct {
    unsigned TMR3ON:1;
    unsigned TMR3CS:1;
    unsigned NOT_T3SYNC:1;
    unsigned T3CCP1:1;
    unsigned T3CKPS:2;
    unsigned T3CCP2:1;
    unsigned RD16:1;
  };
  struct {
    unsigned :2;
    unsigned T3SYNC:1;
    unsigned :1;
    unsigned T3CKPS0:1;
    unsigned T3CKPS1:1;
  };
  struct {
    unsigned :2;
    unsigned T3NSYNC:1;
  };
} T3CONbits;
extern volatile near unsigned char       TMR3L;
extern volatile near unsigned char       TMR3H;
extern volatile near unsigned char       CMCON;
extern volatile near union {
  struct {
    unsigned CM:3;
    unsigned CIS:1;
    unsigned C1INV:1;
    unsigned C2INV:1;
    unsigned C1OUT:1;
    unsigned C2OUT:1;
  };
  struct {
    unsigned CM0:1;
    unsigned CM1:1;
    unsigned CM2:1;
  };
} CMCONbits;
extern volatile near unsigned char       CVRCON;
extern volatile near union {
  struct {
    unsigned CVR:4;
    unsigned CVRSS:1;
    unsigned CVRR:1;
    unsigned CVROE:1;
    unsigned CVREN:1;
  };
  struct {
    unsigned CVR0:1;
    unsigned CVR1:1;
    unsigned CVR2:1;
    unsigned CVR3:1;
    unsigned CVREF:1;
  };
} CVRCONbits;
extern volatile near unsigned char       CCP1AS;
extern volatile near union {
  struct {
    unsigned :2;
    unsigned PSSAC:2;
    unsigned ECCPAS:3;
    unsigned ECCPASE:1;
  };
  struct {
    unsigned :2;
    unsigned PSSAC0:1;
    unsigned PSSAC1:1;
    unsigned ECCPAS0:1;
    unsigned ECCPAS1:1;
    unsigned ECCPAS2:1;
  };
} CCP1ASbits;
extern volatile near unsigned char       ECCP1AS;
extern volatile near union {
  struct {
    unsigned :2;
    unsigned PSSAC:2;
    unsigned ECCPAS:3;
    unsigned ECCPASE:1;
  };
  struct {
    unsigned :2;
    unsigned PSSAC0:1;
    unsigned PSSAC1:1;
    unsigned ECCPAS0:1;
    unsigned ECCPAS1:1;
    unsigned ECCPAS2:1;
  };
} ECCP1ASbits;
extern volatile near unsigned char       CCP1DEL;
extern volatile near struct {
  unsigned :7;
  unsigned PRSEN:1;
} CCP1DELbits;
extern volatile near unsigned char       ECCP1DEL;
extern volatile near struct {
  unsigned :7;
  unsigned PRSEN:1;
} ECCP1DELbits;
extern volatile near unsigned char       BAUDCON;
extern volatile near union {
  struct {
    unsigned ABDEN:1;
    unsigned WUE:1;
    unsigned :1;
    unsigned BRG16:1;
    unsigned TXCKP:1;
    unsigned RXDTP:1;
    unsigned RCIDL:1;
    unsigned ABDOVF:1;
  };
  struct {
    unsigned :4;
    unsigned SCKP:1;
    unsigned :1;
    unsigned RCMT:1;
  };
} BAUDCONbits;
extern volatile near unsigned char       BAUDCTL;
extern volatile near union {
  struct {
    unsigned ABDEN:1;
    unsigned WUE:1;
    unsigned :1;
    unsigned BRG16:1;
    unsigned TXCKP:1;
    unsigned RXDTP:1;
    unsigned RCIDL:1;
    unsigned ABDOVF:1;
  };
  struct {
    unsigned :4;
    unsigned SCKP:1;
    unsigned :1;
    unsigned RCMT:1;
  };
} BAUDCTLbits;
extern volatile near unsigned char       CCP2CON;
extern volatile near union {
  struct {
    unsigned CCP2M:4;
    unsigned DC2B:2;
  };
  struct {
    unsigned CCP2M0:1;
    unsigned CCP2M1:1;
    unsigned CCP2M2:1;
    unsigned CCP2M3:1;
    unsigned DC2B0:1;
    unsigned DC2B1:1;
  };
} CCP2CONbits;
extern volatile near unsigned            CCPR2;
extern volatile near unsigned char       CCPR2L;
extern volatile near unsigned char       CCPR2H;
extern volatile near unsigned char       CCP1CON;
extern volatile near union {
  struct {
    unsigned CCP1M:4;
    unsigned DC1B:2;
  };
  struct {
    unsigned CCP1M0:1;
    unsigned CCP1M1:1;
    unsigned CCP1M2:1;
    unsigned CCP1M3:1;
    unsigned DC1B0:1;
    unsigned DC1B1:1;
  };
} CCP1CONbits;
extern volatile near unsigned            CCPR1;
extern volatile near unsigned char       CCPR1L;
extern volatile near unsigned char       CCPR1H;
extern volatile near unsigned char       ADCON2;
extern volatile near union {
  struct {
    unsigned ADCS:3;
    unsigned ACQT:3;
    unsigned :1;
    unsigned ADFM:1;
  };
  struct {
    unsigned ADCS0:1;
    unsigned ADCS1:1;
    unsigned ADCS2:1;
    unsigned ACQT0:1;
    unsigned ACQT1:1;
    unsigned ACQT2:1;
  };
} ADCON2bits;
extern volatile near unsigned char       ADCON1;
extern volatile near union {
  struct {
    unsigned PCFG:4;
    unsigned VCFG:2;
  };
  struct {
    unsigned PCFG0:1;
    unsigned PCFG1:1;
    unsigned PCFG2:1;
    unsigned PCFG3:1;
    unsigned VCFG0:1;
    unsigned VCFG1:1;
  };
} ADCON1bits;
extern volatile near unsigned char       ADCON0;
extern volatile near union {
  struct {
    unsigned ADON:1;
    unsigned GO_NOT_DONE:1;
    unsigned CHS:4;
  };
  struct {
    unsigned :1;
    unsigned GO_DONE:1;
    unsigned CHS0:1;
    unsigned CHS1:1;
    unsigned CHS2:1;
    unsigned CHS3:1;
  };
  struct {
    unsigned :1;
    unsigned DONE:1;
  };
  struct {
    unsigned :1;
    unsigned GO:1;
  };
  struct {
    unsigned :1;
    unsigned NOT_DONE:1;
  };
} ADCON0bits;
extern volatile near unsigned            ADRES;
extern volatile near unsigned char       ADRESL;
extern volatile near unsigned char       ADRESH;
extern volatile near unsigned char       SSPCON2;
extern volatile near struct {
  unsigned SEN:1;
  unsigned RSEN:1;
  unsigned PEN:1;
  unsigned RCEN:1;
  unsigned ACKEN:1;
  unsigned ACKDT:1;
  unsigned ACKSTAT:1;
  unsigned GCEN:1;
} SSPCON2bits;
extern volatile near unsigned char       SSPCON1;
extern volatile near union {
  struct {
    unsigned SSPM:4;
    unsigned CKP:1;
    unsigned SSPEN:1;
    unsigned SSPOV:1;
    unsigned WCOL:1;
  };
  struct {
    unsigned SSPM0:1;
    unsigned SSPM1:1;
    unsigned SSPM2:1;
    unsigned SSPM3:1;
  };
} SSPCON1bits;
extern volatile near unsigned char       SSPSTAT;
extern volatile near union {
  struct {
    unsigned BF:1;
    unsigned UA:1;
    unsigned R_NOT_W:1;
    unsigned S:1;
    unsigned P:1;
    unsigned D_NOT_A:1;
    unsigned CKE:1;
    unsigned SMP:1;
  };
  struct {
    unsigned :2;
    unsigned R_W:1;
    unsigned :2;
    unsigned D_A:1;
  };
  struct {
    unsigned :2;
    unsigned I2C_READ:1;
    unsigned I2C_START:1;
    unsigned I2C_STOP:1;
    unsigned I2C_DAT:1;
  };
  struct {
    unsigned :2;
    unsigned NOT_W:1;
    unsigned :2;
    unsigned NOT_A:1;
  };
  struct {
    unsigned :2;
    unsigned NOT_WRITE:1;
    unsigned :2;
    unsigned NOT_ADDRESS:1;
  };
  struct {
    unsigned :2;
    unsigned READ_WRITE:1;
    unsigned :2;
    unsigned DATA_ADDRESS:1;
  };
  struct {
    unsigned :2;
    unsigned R:1;
    unsigned :2;
    unsigned D:1;
  };
} SSPSTATbits;
extern volatile near unsigned char       SSPADD;
extern volatile near unsigned char       SSPBUF;
extern volatile near unsigned char       T2CON;
extern volatile near union {
  struct {
    unsigned T2CKPS:2;
    unsigned TMR2ON:1;
    unsigned TOUTPS:4;
  };
  struct {
    unsigned T2CKPS0:1;
    unsigned T2CKPS1:1;
    unsigned :1;
    unsigned T2OUTPS0:1;
    unsigned T2OUTPS1:1;
    unsigned T2OUTPS2:1;
    unsigned T2OUTPS3:1;
  };
  struct {
    unsigned :3;
    unsigned TOUTPS0:1;
    unsigned TOUTPS1:1;
    unsigned TOUTPS2:1;
    unsigned TOUTPS3:1;
  };
} T2CONbits;
extern volatile near unsigned char       PR2;
extern volatile near unsigned char       TMR2;
extern volatile near unsigned char       T1CON;
extern volatile near union {
  struct {
    unsigned TMR1ON:1;
    unsigned TMR1CS:1;
    unsigned NOT_T1SYNC:1;
    unsigned T1OSCEN:1;
    unsigned T1CKPS:2;
    unsigned T1RUN:1;
    unsigned RD16:1;
  };
  struct {
    unsigned :2;
    unsigned T1SYNC:1;
    unsigned :1;
    unsigned T1CKPS0:1;
    unsigned T1CKPS1:1;
  };
} T1CONbits;
extern volatile near unsigned char       TMR1L;
extern volatile near unsigned char       TMR1H;
extern volatile near unsigned char       RCON;
extern volatile near union {
  struct {
    unsigned NOT_BOR:1;
    unsigned NOT_POR:1;
    unsigned NOT_PD:1;
    unsigned NOT_TO:1;
    unsigned NOT_RI:1;
    unsigned :1;
    unsigned SBOREN:1;
    unsigned IPEN:1;
  };
  struct {
    unsigned BOR:1;
    unsigned POR:1;
    unsigned PD:1;
    unsigned TO:1;
    unsigned RI:1;
    unsigned :2;
    unsigned NOT_IPEN:1;
  };
} RCONbits;
extern volatile near unsigned char       WDTCON;
extern volatile near union {
  struct {
    unsigned SWDTEN:1;
  };
  struct {
    unsigned SWDTE:1;
  };
} WDTCONbits;
extern volatile near unsigned char       HLVDCON;
extern volatile near union {
  struct {
    unsigned HLVDL:4;
    unsigned HLVDEN:1;
    unsigned IRVST:1;
    unsigned :1;
    unsigned VDIRMAG:1;
  };
  struct {
    unsigned HLVDL0:1;
    unsigned HLVDL1:1;
    unsigned HLVDL2:1;
    unsigned HLVDL3:1;
  };
  struct {
    unsigned LVDL0:1;
    unsigned LVDL1:1;
    unsigned LVDL2:1;
    unsigned LVDL3:1;
    unsigned LVDEN:1;
    unsigned IVRST:1;
  };
  struct {
    unsigned LVV0:1;
    unsigned LVV1:1;
    unsigned LVV2:1;
    unsigned LVV3:1;
    unsigned :1;
    unsigned BGST:1;
  };
} HLVDCONbits;
extern volatile near unsigned char       LVDCON;
extern volatile near union {
  struct {
    unsigned HLVDL:4;
    unsigned HLVDEN:1;
    unsigned IRVST:1;
    unsigned :1;
    unsigned VDIRMAG:1;
  };
  struct {
    unsigned HLVDL0:1;
    unsigned HLVDL1:1;
    unsigned HLVDL2:1;
    unsigned HLVDL3:1;
  };
  struct {
    unsigned LVDL0:1;
    unsigned LVDL1:1;
    unsigned LVDL2:1;
    unsigned LVDL3:1;
    unsigned LVDEN:1;
    unsigned IVRST:1;
  };
  struct {
    unsigned LVV0:1;
    unsigned LVV1:1;
    unsigned LVV2:1;
    unsigned LVV3:1;
    unsigned :1;
    unsigned BGST:1;
  };
} LVDCONbits;
extern volatile near unsigned char       OSCCON;
extern volatile near union {
  struct {
    unsigned SCS:2;
    unsigned IOFS:1;
    unsigned OSTS:1;
    unsigned IRCF:3;
    unsigned IDLEN:1;
  };
  struct {
    unsigned SCS0:1;
    unsigned SCS1:1;
    unsigned FLTS:1;
    unsigned :1;
    unsigned IRCF0:1;
    unsigned IRCF1:1;
    unsigned IRCF2:1;
  };
} OSCCONbits;
extern volatile near unsigned char       T0CON;
extern volatile near union {
  struct {
    unsigned T0PS:3;
    unsigned PSA:1;
    unsigned T0SE:1;
    unsigned T0CS:1;
    unsigned T08BIT:1;
    unsigned TMR0ON:1;
  };
  struct {
    unsigned T0PS0:1;
    unsigned T0PS1:1;
    unsigned T0PS2:1;
  };
} T0CONbits;
extern volatile near unsigned char       TMR0L;
extern volatile near unsigned char       TMR0H;
extern          near unsigned char       STATUS;
extern          near struct {
  unsigned C:1;
  unsigned DC:1;
  unsigned Z:1;
  unsigned OV:1;
  unsigned N:1;
} STATUSbits;
extern          near unsigned            FSR2;
extern          near unsigned char       FSR2L;
extern          near unsigned char       FSR2H;
extern volatile near unsigned char       PLUSW2;
extern volatile near unsigned char       PREINC2;
extern volatile near unsigned char       POSTDEC2;
extern volatile near unsigned char       POSTINC2;
extern          near unsigned char       INDF2;
extern          near unsigned char       BSR;
extern          near unsigned            FSR1;
extern          near unsigned char       FSR1L;
extern          near unsigned char       FSR1H;
extern volatile near unsigned char       PLUSW1;
extern volatile near unsigned char       PREINC1;
extern volatile near unsigned char       POSTDEC1;
extern volatile near unsigned char       POSTINC1;
extern          near unsigned char       INDF1;
extern          near unsigned char       WREG;
extern          near unsigned            FSR0;
extern          near unsigned char       FSR0L;
extern          near unsigned char       FSR0H;
extern volatile near unsigned char       PLUSW0;
extern volatile near unsigned char       PREINC0;
extern volatile near unsigned char       POSTDEC0;
extern volatile near unsigned char       POSTINC0;
extern          near unsigned char       INDF0;
extern volatile near unsigned char       INTCON3;
extern volatile near union {
  struct {
    unsigned INT1IF:1;
    unsigned INT2IF:1;
    unsigned :1;
    unsigned INT1IE:1;
    unsigned INT2IE:1;
    unsigned :1;
    unsigned INT1IP:1;
    unsigned INT2IP:1;
  };
  struct {
    unsigned INT1F:1;
    unsigned INT2F:1;
    unsigned :1;
    unsigned INT1E:1;
    unsigned INT2E:1;
    unsigned :1;
    unsigned INT1P:1;
    unsigned INT2P:1;
  };
} INTCON3bits;
extern volatile near unsigned char       INTCON2;
extern volatile near union {
  struct {
    unsigned RBIP:1;
    unsigned :1;
    unsigned TMR0IP:1;
    unsigned :1;
    unsigned INTEDG2:1;
    unsigned INTEDG1:1;
    unsigned INTEDG0:1;
    unsigned NOT_RBPU:1;
  };
  struct {
    unsigned :2;
    unsigned T0IP:1;
    unsigned :4;
    unsigned RBPU:1;
  };
} INTCON2bits;
extern volatile near unsigned char       INTCON;
extern volatile near union {
  struct {
    unsigned RBIF:1;
    unsigned INT0IF:1;
    unsigned TMR0IF:1;
    unsigned RBIE:1;
    unsigned INT0IE:1;
    unsigned TMR0IE:1;
    unsigned PEIE_GIEL:1;
    unsigned GIE_GIEH:1;
  };
  struct {
    unsigned :1;
    unsigned INT0F:1;
    unsigned T0IF:1;
    unsigned :1;
    unsigned INT0E:1;
    unsigned T0IE:1;
    unsigned PEIE:1;
    unsigned GIE:1;
  };
  struct {
    unsigned :6;
    unsigned GIEL:1;
    unsigned GIEH:1;
  };
} INTCONbits;
extern          near unsigned            PROD;
extern          near unsigned char       PRODL;
extern          near unsigned char       PRODH;
extern volatile near unsigned char       TABLAT;
extern volatile near unsigned short long TBLPTR;
extern volatile near unsigned char       TBLPTRL;
extern volatile near unsigned char       TBLPTRH;
extern volatile near unsigned char       TBLPTRU;
extern volatile near unsigned short long PC;
extern volatile near unsigned char       PCL;
extern volatile near unsigned char       PCLATH;
extern volatile near unsigned char       PCLATU;
extern volatile near unsigned char       STKPTR;
extern volatile near union {
  struct {
    unsigned STKPTR:5;
    unsigned :1;
    unsigned STKUNF:1;
    unsigned STKFUL:1;
  };
  struct {
    unsigned STKPTR0:1;
    unsigned STKPTR1:1;
    unsigned STKPTR2:1;
    unsigned STKPTR3:1;
    unsigned STKPTR4:1;
  };
  struct {
    unsigned :7;
    unsigned STKOVF:1;
  };
} STKPTRbits;
extern          near unsigned short long TOS;
extern          near unsigned char       TOSL;
extern          near unsigned char       TOSH;
extern          near unsigned char       TOSU;



#line 1290 "/opt/microchip/mplabc18/v3.40/bin/../h/p18f2455.h"
 
#line 1292 "/opt/microchip/mplabc18/v3.40/bin/../h/p18f2455.h"
#line 1293 "/opt/microchip/mplabc18/v3.40/bin/../h/p18f2455.h"


#line 1296 "/opt/microchip/mplabc18/v3.40/bin/../h/p18f2455.h"
 
#line 1298 "/opt/microchip/mplabc18/v3.40/bin/../h/p18f2455.h"
#line 1299 "/opt/microchip/mplabc18/v3.40/bin/../h/p18f2455.h"
#line 1300 "/opt/microchip/mplabc18/v3.40/bin/../h/p18f2455.h"
#line 1301 "/opt/microchip/mplabc18/v3.40/bin/../h/p18f2455.h"

#line 1303 "/opt/microchip/mplabc18/v3.40/bin/../h/p18f2455.h"
#line 1304 "/opt/microchip/mplabc18/v3.40/bin/../h/p18f2455.h"
#line 1305 "/opt/microchip/mplabc18/v3.40/bin/../h/p18f2455.h"
#line 1306 "/opt/microchip/mplabc18/v3.40/bin/../h/p18f2455.h"
#line 1307 "/opt/microchip/mplabc18/v3.40/bin/../h/p18f2455.h"


#line 1311 "/opt/microchip/mplabc18/v3.40/bin/../h/p18f2455.h"
 
#line 1313 "/opt/microchip/mplabc18/v3.40/bin/../h/p18f2455.h"


#line 1316 "/opt/microchip/mplabc18/v3.40/bin/../h/p18f2455.h"
#line 67 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"

#line 69 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 71 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 73 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 75 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 77 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 79 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 81 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 83 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 85 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 87 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 89 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 91 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 93 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 95 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 97 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 99 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 101 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 103 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 105 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 107 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 109 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 111 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 113 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 115 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 117 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 119 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 121 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 123 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 125 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 127 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 129 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 131 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 133 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 135 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 137 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 139 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 141 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 143 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 145 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 147 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 149 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 151 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 153 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 155 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 157 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 159 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 161 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 163 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 165 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 167 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 169 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 171 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 173 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 175 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 177 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 179 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 181 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 183 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 185 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 187 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 189 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 191 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 193 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 195 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 197 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 199 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 201 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 203 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 205 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 207 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 209 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 211 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 213 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 215 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 217 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 219 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 221 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 223 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 225 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 227 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 229 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 231 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 233 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 235 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 237 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 239 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 241 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 243 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 245 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 247 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 249 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 251 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 253 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 255 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 257 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 259 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 261 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 263 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 265 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 267 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 269 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 271 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 273 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 275 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 277 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 279 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 281 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 283 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 285 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 287 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 289 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 291 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 293 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 295 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 297 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 299 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 301 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 303 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 305 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 307 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 309 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 311 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 313 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 315 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 317 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 319 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 321 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 323 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 325 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 327 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 329 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 331 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 333 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 335 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 337 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 339 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 341 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 343 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 345 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 347 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 349 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 351 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 353 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 355 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 357 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 359 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 361 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 363 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 365 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 367 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 369 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 371 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 373 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 375 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 377 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 379 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 381 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 383 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 385 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 387 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 389 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 391 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 393 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 395 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 397 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 399 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 401 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 403 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 405 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 407 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 409 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 411 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 413 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 415 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 417 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 419 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 421 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 423 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 425 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 427 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 429 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 431 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 433 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 435 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 437 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 439 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 441 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 443 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 445 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 447 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 449 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 451 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 453 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 455 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 457 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 459 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 461 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 463 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 465 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 467 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 469 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 471 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 473 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 475 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 477 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 479 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 481 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 483 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 485 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 487 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 489 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 491 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 493 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 495 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 497 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 499 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 501 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 503 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 505 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 507 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 509 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 511 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 513 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 515 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 517 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 519 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 521 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 523 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 525 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 527 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 529 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 531 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 533 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 535 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 537 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 539 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 541 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 543 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 545 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 547 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 549 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 551 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 553 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 555 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 557 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 559 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 561 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"

#line 563 "/opt/microchip/mplabc18/v3.40/bin/../h/p18cxxx.h"
#line 4 "../../Badge.X/user/user.c"

#line 1 "system/typedefs.h"

#line 35 "system/typedefs.h"
 


#line 39 "system/typedefs.h"

typedef unsigned char   byte;           
typedef unsigned int    word;           
typedef unsigned long   dword;          

typedef union _BYTE
{
    byte _byte;
    struct
    {
        unsigned b0:1;
        unsigned b1:1;
        unsigned b2:1;
        unsigned b3:1;
        unsigned b4:1;
        unsigned b5:1;
        unsigned b6:1;
        unsigned b7:1;
    };
} BYTE;

typedef union _WORD
{
    word _word;
    struct
    {
        byte byte0;
        byte byte1;
    };
    struct
    {
        BYTE Byte0;
        BYTE Byte1;
    };
    struct
    {
        BYTE LowB;
        BYTE HighB;
    };
    struct
    {
        byte v[2];
    };
} WORD;
#line 84 "system/typedefs.h"
#line 85 "system/typedefs.h"

typedef union _DWORD
{
    dword _dword;
    struct
    {
        byte byte0;
        byte byte1;
        byte byte2;
        byte byte3;
    };
    struct
    {
        word word0;
        word word1;
    };
    struct
    {
        BYTE Byte0;
        BYTE Byte1;
        BYTE Byte2;
        BYTE Byte3;
    };
    struct
    {
        WORD Word0;
        WORD Word1;
    };
    struct
    {
        byte v[4];
    };
} DWORD;
#line 119 "system/typedefs.h"
#line 120 "system/typedefs.h"
#line 121 "system/typedefs.h"
#line 122 "system/typedefs.h"

typedef void(*pFunc)(void);

typedef union _POINTER
{
    struct
    {
        byte bLow;
        byte bHigh;
        
    };
    word _word;                         
    
    

    byte* bRam;                         
                                        
    word* wRam;                         
                                        

    rom byte* bRom;                     
    rom word* wRom;
    
    
    
    
} POINTER;

typedef enum _BOOL { FALSE = 0, TRUE } BOOL;

#line 153 "system/typedefs.h"
#line 154 "system/typedefs.h"

#line 156 "system/typedefs.h"
#line 5 "../../Badge.X/user/user.c"

#line 1 "system/usb/usb.h"

#line 35 "system/usb/usb.h"
 

#line 38 "system/usb/usb.h"


#line 45 "system/usb/usb.h"
 


#line 1 "autofiles/usbcfg.h"

#line 32 "autofiles/usbcfg.h"
 


#line 36 "autofiles/usbcfg.h"

 
#line 39 "autofiles/usbcfg.h"
#line 40 "autofiles/usbcfg.h"
									
									
									

 
#line 46 "autofiles/usbcfg.h"
#line 47 "autofiles/usbcfg.h"


 
#line 51 "autofiles/usbcfg.h"




#line 56 "autofiles/usbcfg.h"

  

#line 60 "autofiles/usbcfg.h"
#line 69 "autofiles/usbcfg.h"
#line 72 "autofiles/usbcfg.h"

 
#line 75 "autofiles/usbcfg.h"


#line 80 "autofiles/usbcfg.h"
 
#line 82 "autofiles/usbcfg.h"
#line 83 "autofiles/usbcfg.h"
#line 84 "autofiles/usbcfg.h"
#line 85 "autofiles/usbcfg.h"
#line 86 "autofiles/usbcfg.h"

 

#line 90 "autofiles/usbcfg.h"
 

 
#line 94 "autofiles/usbcfg.h"
#line 95 "autofiles/usbcfg.h"
#line 96 "autofiles/usbcfg.h"
#line 97 "autofiles/usbcfg.h"

#line 99 "autofiles/usbcfg.h"
#line 100 "autofiles/usbcfg.h"
#line 101 "autofiles/usbcfg.h"
#line 102 "autofiles/usbcfg.h"
#line 103 "autofiles/usbcfg.h"
#line 104 "autofiles/usbcfg.h"

#line 106 "autofiles/usbcfg.h"

#line 108 "autofiles/usbcfg.h"
#line 48 "system/usb/usb.h"

#line 1 "system/usb/usbdefs/usbdefs_std_dsc.h"

#line 35 "system/usb/usbdefs/usbdefs_std_dsc.h"
 


#line 39 "system/usb/usbdefs/usbdefs_std_dsc.h"
 

#line 42 "system/usb/usbdefs/usbdefs_std_dsc.h"

 
#line 1 "system/typedefs.h"

#line 35 "system/typedefs.h"
 

#line 156 "system/typedefs.h"
#line 44 "system/usb/usbdefs/usbdefs_std_dsc.h"


 

 
#line 50 "system/usb/usbdefs/usbdefs_std_dsc.h"
#line 51 "system/usb/usbdefs/usbdefs_std_dsc.h"
#line 52 "system/usb/usbdefs/usbdefs_std_dsc.h"
#line 53 "system/usb/usbdefs/usbdefs_std_dsc.h"
#line 54 "system/usb/usbdefs/usbdefs_std_dsc.h"


#line 62 "system/usb/usbdefs/usbdefs_std_dsc.h"
 
#line 64 "system/usb/usbdefs/usbdefs_std_dsc.h"
#line 65 "system/usb/usbdefs/usbdefs_std_dsc.h"
#line 66 "system/usb/usbdefs/usbdefs_std_dsc.h"
#line 67 "system/usb/usbdefs/usbdefs_std_dsc.h"
#line 68 "system/usb/usbdefs/usbdefs_std_dsc.h"
#line 69 "system/usb/usbdefs/usbdefs_std_dsc.h"
#line 70 "system/usb/usbdefs/usbdefs_std_dsc.h"
#line 71 "system/usb/usbdefs/usbdefs_std_dsc.h"
#line 72 "system/usb/usbdefs/usbdefs_std_dsc.h"
#line 73 "system/usb/usbdefs/usbdefs_std_dsc.h"
#line 74 "system/usb/usbdefs/usbdefs_std_dsc.h"
#line 75 "system/usb/usbdefs/usbdefs_std_dsc.h"
#line 76 "system/usb/usbdefs/usbdefs_std_dsc.h"
#line 77 "system/usb/usbdefs/usbdefs_std_dsc.h"
#line 78 "system/usb/usbdefs/usbdefs_std_dsc.h"
#line 79 "system/usb/usbdefs/usbdefs_std_dsc.h"
#line 80 "system/usb/usbdefs/usbdefs_std_dsc.h"
#line 81 "system/usb/usbdefs/usbdefs_std_dsc.h"
#line 82 "system/usb/usbdefs/usbdefs_std_dsc.h"
#line 83 "system/usb/usbdefs/usbdefs_std_dsc.h"
#line 84 "system/usb/usbdefs/usbdefs_std_dsc.h"
#line 85 "system/usb/usbdefs/usbdefs_std_dsc.h"
#line 86 "system/usb/usbdefs/usbdefs_std_dsc.h"
#line 87 "system/usb/usbdefs/usbdefs_std_dsc.h"
#line 88 "system/usb/usbdefs/usbdefs_std_dsc.h"
#line 89 "system/usb/usbdefs/usbdefs_std_dsc.h"
#line 90 "system/usb/usbdefs/usbdefs_std_dsc.h"
#line 91 "system/usb/usbdefs/usbdefs_std_dsc.h"
#line 92 "system/usb/usbdefs/usbdefs_std_dsc.h"
#line 93 "system/usb/usbdefs/usbdefs_std_dsc.h"

 
#line 96 "system/usb/usbdefs/usbdefs_std_dsc.h"
#line 97 "system/usb/usbdefs/usbdefs_std_dsc.h"
#line 98 "system/usb/usbdefs/usbdefs_std_dsc.h"

 
#line 101 "system/usb/usbdefs/usbdefs_std_dsc.h"
#line 102 "system/usb/usbdefs/usbdefs_std_dsc.h"
#line 103 "system/usb/usbdefs/usbdefs_std_dsc.h"
#line 104 "system/usb/usbdefs/usbdefs_std_dsc.h"

 
#line 107 "system/usb/usbdefs/usbdefs_std_dsc.h"
#line 108 "system/usb/usbdefs/usbdefs_std_dsc.h"
#line 109 "system/usb/usbdefs/usbdefs_std_dsc.h"
#line 110 "system/usb/usbdefs/usbdefs_std_dsc.h"

 
#line 113 "system/usb/usbdefs/usbdefs_std_dsc.h"
#line 114 "system/usb/usbdefs/usbdefs_std_dsc.h"
#line 115 "system/usb/usbdefs/usbdefs_std_dsc.h"


 


#line 121 "system/usb/usbdefs/usbdefs_std_dsc.h"
 
typedef struct _USB_DEV_DSC
{
    byte bLength;       byte bDscType;      word bcdUSB;
    byte bDevCls;       byte bDevSubCls;    byte bDevProtocol;
    byte bMaxPktSize0;  word idVendor;      word idProduct;
    word bcdDevice;     byte iMFR;          byte iProduct;
    byte iSerialNum;    byte bNumCfg;
} USB_DEV_DSC;


#line 133 "system/usb/usbdefs/usbdefs_std_dsc.h"
 
typedef struct _USB_CFG_DSC
{
    byte bLength;       byte bDscType;      word wTotalLength;
    byte bNumIntf;      byte bCfgValue;     byte iCfg;
    byte bmAttributes;  byte bMaxPower;
} USB_CFG_DSC;


#line 143 "system/usb/usbdefs/usbdefs_std_dsc.h"
 
typedef struct _USB_INTF_DSC
{
    byte bLength;       byte bDscType;      byte bIntfNum;
    byte bAltSetting;   byte bNumEPs;       byte bIntfCls;
    byte bIntfSubCls;   byte bIntfProtocol; byte iIntf;
} USB_INTF_DSC;


#line 153 "system/usb/usbdefs/usbdefs_std_dsc.h"
 
typedef struct _USB_EP_DSC
{
    byte bLength;       byte bDscType;      byte bEPAdr;
    byte bmAttributes;  word wMaxPktSize;   byte bInterval;
} USB_EP_DSC;

#line 161 "system/usb/usbdefs/usbdefs_std_dsc.h"
#line 49 "system/usb/usb.h"

#line 1 "autofiles/usbdsc.h"

#line 32 "autofiles/usbdsc.h"
 


#line 37 "autofiles/usbdsc.h"
 


#line 41 "autofiles/usbdsc.h"

 
#line 1 "system/typedefs.h"

#line 35 "system/typedefs.h"
 

#line 156 "system/typedefs.h"
#line 43 "autofiles/usbdsc.h"

#line 1 "autofiles/usbcfg.h"

#line 32 "autofiles/usbcfg.h"
 

#line 56 "autofiles/usbcfg.h"
#line 60 "autofiles/usbcfg.h"
#line 69 "autofiles/usbcfg.h"
#line 72 "autofiles/usbcfg.h"

#line 80 "autofiles/usbcfg.h"

#line 90 "autofiles/usbcfg.h"
#line 108 "autofiles/usbcfg.h"
#line 44 "autofiles/usbdsc.h"


#line 47 "autofiles/usbdsc.h"
#line 1 "system/usb/class/cdc/cdc.h"

#line 36 "system/usb/class/cdc/cdc.h"
 

#line 39 "system/usb/class/cdc/cdc.h"

 
#line 1 "system/typedefs.h"

#line 35 "system/typedefs.h"
 

#line 156 "system/typedefs.h"
#line 41 "system/usb/class/cdc/cdc.h"


 

 
#line 47 "system/usb/class/cdc/cdc.h"
#line 48 "system/usb/class/cdc/cdc.h"
#line 49 "system/usb/class/cdc/cdc.h"
#line 50 "system/usb/class/cdc/cdc.h"
#line 51 "system/usb/class/cdc/cdc.h"
#line 52 "system/usb/class/cdc/cdc.h"
#line 53 "system/usb/class/cdc/cdc.h"
#line 54 "system/usb/class/cdc/cdc.h"
#line 55 "system/usb/class/cdc/cdc.h"


#line 59 "system/usb/class/cdc/cdc.h"
 
#line 61 "system/usb/class/cdc/cdc.h"
#line 62 "system/usb/class/cdc/cdc.h"
#line 63 "system/usb/class/cdc/cdc.h"


 
#line 67 "system/usb/class/cdc/cdc.h"

 
#line 70 "system/usb/class/cdc/cdc.h"

 
#line 73 "system/usb/class/cdc/cdc.h"

 
#line 76 "system/usb/class/cdc/cdc.h"


 
#line 80 "system/usb/class/cdc/cdc.h"

 
#line 83 "system/usb/class/cdc/cdc.h"


 
#line 87 "system/usb/class/cdc/cdc.h"
#line 88 "system/usb/class/cdc/cdc.h"

 
 
#line 92 "system/usb/class/cdc/cdc.h"
#line 93 "system/usb/class/cdc/cdc.h"

 
#line 96 "system/usb/class/cdc/cdc.h"
#line 97 "system/usb/class/cdc/cdc.h"
#line 98 "system/usb/class/cdc/cdc.h"
#line 99 "system/usb/class/cdc/cdc.h"
#line 100 "system/usb/class/cdc/cdc.h"
#line 101 "system/usb/class/cdc/cdc.h"
#line 102 "system/usb/class/cdc/cdc.h"
#line 103 "system/usb/class/cdc/cdc.h"
#line 104 "system/usb/class/cdc/cdc.h"
#line 105 "system/usb/class/cdc/cdc.h"
 

 
#line 109 "system/usb/class/cdc/cdc.h"
#line 110 "system/usb/class/cdc/cdc.h"
#line 111 "system/usb/class/cdc/cdc.h"
#line 112 "system/usb/class/cdc/cdc.h"


#line 129 "system/usb/class/cdc/cdc.h"
 
#line 131 "system/usb/class/cdc/cdc.h"


#line 148 "system/usb/class/cdc/cdc.h"
 
#line 150 "system/usb/class/cdc/cdc.h"


#line 167 "system/usb/class/cdc/cdc.h"
 
#line 169 "system/usb/class/cdc/cdc.h"


#line 186 "system/usb/class/cdc/cdc.h"
 
#line 188 "system/usb/class/cdc/cdc.h"


#line 215 "system/usb/class/cdc/cdc.h"
 

#line 222 "system/usb/class/cdc/cdc.h"
#line 223 "system/usb/class/cdc/cdc.h"


#line 250 "system/usb/class/cdc/cdc.h"
 

#line 257 "system/usb/class/cdc/cdc.h"
#line 258 "system/usb/class/cdc/cdc.h"

 

 
#line 263 "system/usb/class/cdc/cdc.h"

typedef union _LINE_CODING
{
    struct
    {
        byte _byte[0x07 ];
    };
    struct
    {
        DWORD   dwDTERate;          
        byte    bCharFormat;
        byte    bParityType;
        byte    bDataBits;
    };
} LINE_CODING;

typedef union _CONTROL_SIGNAL_BITMAP
{
    byte _byte;
    struct
    {

#line 294 "system/usb/class/cdc/cdc.h"
 
        unsigned DTE_PRESENT:1;     
        unsigned CARRIER_CONTROL:1; 
    };
} CONTROL_SIGNAL_BITMAP;


 

 
typedef struct _USB_CDC_HEADER_FN_DSC
{
    byte bFNLength;
    byte bDscType;
    byte bDscSubType;
    word bcdCDC;
} USB_CDC_HEADER_FN_DSC;

 
typedef struct _USB_CDC_ACM_FN_DSC
{
    byte bFNLength;
    byte bDscType;
    byte bDscSubType;
    byte bmCapabilities;
} USB_CDC_ACM_FN_DSC;

 
typedef struct _USB_CDC_UNION_FN_DSC
{
    byte bFNLength;
    byte bDscType;
    byte bDscSubType;
    byte bMasterIntf;
    byte bSaveIntf0;
} USB_CDC_UNION_FN_DSC;

 
typedef struct _USB_CDC_CALL_MGT_FN_DSC
{
    byte bFNLength;
    byte bDscType;
    byte bDscSubType;
    byte bmCapabilities;
    byte bDataInterface;
} USB_CDC_CALL_MGT_FN_DSC;

 
extern byte cdc_rx_len;

extern byte cdc_trf_state;
extern POINTER pCDCSrc;
extern byte cdc_tx_len;
extern byte cdc_mem_type;

 
void USBCheckCDCRequest(void);
void CDCInitEP(void);
byte getsUSBUSART(char *buffer, byte len);
void putrsUSBUSART(const rom char *data);
void putsUSBUSART(char *data);
void CDCTxService(void);

#line 358 "system/usb/class/cdc/cdc.h"
#line 47 "autofiles/usbdsc.h"

#line 49 "autofiles/usbdsc.h"

#line 1 "system/usb/usb.h"

#line 35 "system/usb/usb.h"
 

#line 45 "system/usb/usb.h"
#line 60 "system/usb/usb.h"
#line 62 "system/usb/usb.h"
#line 64 "system/usb/usb.h"
#line 50 "autofiles/usbdsc.h"


 


#line 65 "autofiles/usbdsc.h"
#line 66 "autofiles/usbdsc.h"

 
extern rom USB_DEV_DSC device_dsc;
extern rom struct { USB_CFG_DSC cd01; USB_INTF_DSC i01a00; USB_CDC_HEADER_FN_DSC cdc_header_fn_i01a00; USB_CDC_ACM_FN_DSC cdc_acm_fn_i01a00; USB_CDC_UNION_FN_DSC cdc_union_fn_i01a00; USB_CDC_CALL_MGT_FN_DSC cdc_call_mgt_fn_i01a00; USB_EP_DSC ep02i_i01a00; USB_INTF_DSC i02a00; USB_EP_DSC ep03o_i02a00; USB_EP_DSC ep03i_i02a00; } cfg01 ;
extern rom const unsigned char *rom USB_CD_Ptr[];
extern rom const unsigned char *rom USB_SD_Ptr[];

extern rom pFunc ClassReqHandler[1];

#line 76 "autofiles/usbdsc.h"
#line 50 "system/usb/usb.h"


#line 1 "system/usb/usbdefs/usbdefs_ep0_buff.h"

#line 35 "system/usb/usbdefs/usbdefs_ep0_buff.h"
 


#line 39 "system/usb/usbdefs/usbdefs_ep0_buff.h"
 

#line 42 "system/usb/usbdefs/usbdefs_ep0_buff.h"

 
#line 1 "system/typedefs.h"

#line 35 "system/typedefs.h"
 

#line 156 "system/typedefs.h"
#line 44 "system/usb/usbdefs/usbdefs_ep0_buff.h"

#line 1 "autofiles/usbcfg.h"

#line 32 "autofiles/usbcfg.h"
 

#line 56 "autofiles/usbcfg.h"
#line 60 "autofiles/usbcfg.h"
#line 69 "autofiles/usbcfg.h"
#line 72 "autofiles/usbcfg.h"

#line 80 "autofiles/usbcfg.h"

#line 90 "autofiles/usbcfg.h"
#line 108 "autofiles/usbcfg.h"
#line 45 "system/usb/usbdefs/usbdefs_ep0_buff.h"
       


#line 58 "system/usb/usbdefs/usbdefs_ep0_buff.h"
 
typedef union _CTRL_TRF_SETUP
{
     
    struct
    {
        byte _byte[8 ];
    };
    
     
    struct
    {
        byte bmRequestType;
        byte bRequest;    
        word wValue;
        word wIndex;
        word wLength;
    };
    struct
    {
        unsigned :8;
        unsigned :8;
        WORD W_Value;
        WORD W_Index;
        WORD W_Length;
    };
    struct
    {
        unsigned Recipient:5;           
        unsigned RequestType:2;         
        unsigned DataDir:1;             
        unsigned :8;
        byte bFeature;                  
        unsigned :8;
        unsigned :8;
        unsigned :8;
        unsigned :8;
        unsigned :8;
    };
    struct
    {
        unsigned :8;
        unsigned :8;
        byte bDscIndex;                 
        byte bDscType;                  
        word wLangID;                   
        unsigned :8;
        unsigned :8;
    };
    struct
    {
        unsigned :8;
        unsigned :8;
        BYTE bDevADR;                   
        byte bDevADRH;                  
        unsigned :8;
        unsigned :8;
        unsigned :8;
        unsigned :8;
    };
    struct
    {
        unsigned :8;
        unsigned :8;
        byte bCfgValue;                 
        byte bCfgRSD;                   
        unsigned :8;
        unsigned :8;
        unsigned :8;
        unsigned :8;
    };
    struct
    {
        unsigned :8;
        unsigned :8;
        byte bAltID;                    
        byte bAltID_H;                  
        byte bIntfID;                   
        byte bIntfID_H;                 
        unsigned :8;
        unsigned :8;
    };
    struct
    {
        unsigned :8;
        unsigned :8;
        unsigned :8;
        unsigned :8;
        byte bEPID;                     
        byte bEPID_H;                   
        unsigned :8;
        unsigned :8;
    };
    struct
    {
        unsigned :8;
        unsigned :8;
        unsigned :8;
        unsigned :8;
        unsigned EPNum:4;               
        unsigned :3;
        unsigned EPDir:1;               
        unsigned :8;
        unsigned :8;
        unsigned :8;
    };
     
    
} CTRL_TRF_SETUP;


#line 178 "system/usb/usbdefs/usbdefs_ep0_buff.h"
 
typedef union _CTRL_TRF_DATA
{
     
    struct
    {
        byte _byte[8 ];
    };
    
     
    struct
    {
        byte _byte0;
        byte _byte1;
        byte _byte2;
        byte _byte3;
        byte _byte4;
        byte _byte5;
        byte _byte6;
        byte _byte7;
    };
    struct
    {
        word _word0;
        word _word1;
        word _word2;
        word _word3;
    };

} CTRL_TRF_DATA;

#line 210 "system/usb/usbdefs/usbdefs_ep0_buff.h"
#line 52 "system/usb/usb.h"

#line 1 "system/usb/usbmmap.h"

#line 35 "system/usb/usbmmap.h"
 


#line 39 "system/usb/usbmmap.h"

 
#line 1 "system/typedefs.h"

#line 35 "system/typedefs.h"
 

#line 156 "system/typedefs.h"
#line 41 "system/usb/usbmmap.h"


 

 
#line 47 "system/usb/usbmmap.h"
#line 48 "system/usb/usbmmap.h"
#line 49 "system/usb/usbmmap.h"
#line 50 "system/usb/usbmmap.h"
#line 51 "system/usb/usbmmap.h"
#line 52 "system/usb/usbmmap.h"
#line 53 "system/usb/usbmmap.h"
#line 54 "system/usb/usbmmap.h"
#line 55 "system/usb/usbmmap.h"

 
#line 58 "system/usb/usbmmap.h"
#line 59 "system/usb/usbmmap.h"
#line 60 "system/usb/usbmmap.h"
#line 61 "system/usb/usbmmap.h"
#line 62 "system/usb/usbmmap.h"
#line 63 "system/usb/usbmmap.h"
#line 64 "system/usb/usbmmap.h"

 
#line 67 "system/usb/usbmmap.h"
#line 68 "system/usb/usbmmap.h"

 
typedef union _USB_DEVICE_STATUS
{
    byte _byte;
    struct
    {
        unsigned RemoteWakeup:1;
        unsigned ctrl_trf_mem:1;
    };
} USB_DEVICE_STATUS;

typedef union _BD_STAT
{
    byte _byte;
    struct{
        unsigned BC8:1;
        unsigned BC9:1;
        unsigned BSTALL:1;              
        unsigned DTSEN:1;               
        unsigned INCDIS:1;              
        unsigned KEN:1;                 
        unsigned DTS:1;                 
        unsigned UOWN:1;                
    };
    struct{
        unsigned BC8:1;
        unsigned BC9:1;
        unsigned PID0:1;
        unsigned PID1:1;
        unsigned PID2:1;
        unsigned PID3:1;
        unsigned :1;
        unsigned UOWN:1;
    };
    struct{
        unsigned :2;
        unsigned PID:4;                 
        unsigned :2;
    };
} BD_STAT;                              

typedef union _BDT
{
    struct
    {
        BD_STAT Stat;
        byte Cnt;
        byte ADRL;                      
        byte ADRH;                      
    };
    struct
    {
        unsigned :8;
        unsigned :8;
        byte* ADR;                      
    };
} BDT;                                  

 
extern byte usb_device_state;
extern USB_DEVICE_STATUS usb_stat;
extern byte usb_active_cfg;
extern byte usb_alt_intf[1 ];

extern volatile far BDT ep0Bo;          
extern volatile far BDT ep0Bi;          
extern volatile far BDT ep1Bo;          
extern volatile far BDT ep1Bi;          
extern volatile far BDT ep2Bo;          
extern volatile far BDT ep2Bi;          
extern volatile far BDT ep3Bo;          
extern volatile far BDT ep3Bi;          
extern volatile far BDT ep4Bo;          
extern volatile far BDT ep4Bi;          
extern volatile far BDT ep5Bo;          
extern volatile far BDT ep5Bi;          
extern volatile far BDT ep6Bo;          
extern volatile far BDT ep6Bi;          
extern volatile far BDT ep7Bo;          
extern volatile far BDT ep7Bi;          
extern volatile far BDT ep8Bo;          
extern volatile far BDT ep8Bi;          
extern volatile far BDT ep9Bo;          
extern volatile far BDT ep9Bi;          
extern volatile far BDT ep10Bo;         
extern volatile far BDT ep10Bi;         
extern volatile far BDT ep11Bo;         
extern volatile far BDT ep11Bi;         
extern volatile far BDT ep12Bo;         
extern volatile far BDT ep12Bi;         
extern volatile far BDT ep13Bo;         
extern volatile far BDT ep13Bi;         
extern volatile far BDT ep14Bo;         
extern volatile far BDT ep14Bi;         
extern volatile far BDT ep15Bo;         
extern volatile far BDT ep15Bi;         

extern volatile far CTRL_TRF_SETUP SetupPkt;
extern volatile far CTRL_TRF_DATA CtrlTrfData;

#line 170 "system/usb/usbmmap.h"
extern volatile far unsigned char cdc_notice[8 ];
extern volatile far unsigned char cdc_data_rx[64 ];
extern volatile far unsigned char cdc_data_tx[64 ];
#line 174 "system/usb/usbmmap.h"

#line 176 "system/usb/usbmmap.h"
#line 53 "system/usb/usb.h"


#line 1 "system/usb/usbdrv/usbdrv.h"

#line 36 "system/usb/usbdrv/usbdrv.h"
 


#line 40 "system/usb/usbdrv/usbdrv.h"

 
#line 1 "system/typedefs.h"

#line 35 "system/typedefs.h"
 

#line 156 "system/typedefs.h"
#line 42 "system/usb/usbdrv/usbdrv.h"

#line 1 "system/usb/usb.h"

#line 35 "system/usb/usb.h"
 

#line 45 "system/usb/usb.h"
#line 60 "system/usb/usb.h"
#line 62 "system/usb/usb.h"
#line 64 "system/usb/usb.h"
#line 43 "system/usb/usbdrv/usbdrv.h"


 

 
#line 49 "system/usb/usbdrv/usbdrv.h"
#line 50 "system/usb/usbdrv/usbdrv.h"
#line 51 "system/usb/usbdrv/usbdrv.h"
#line 52 "system/usb/usbdrv/usbdrv.h"
#line 53 "system/usb/usbdrv/usbdrv.h"
#line 54 "system/usb/usbdrv/usbdrv.h"
#line 55 "system/usb/usbdrv/usbdrv.h"
#line 56 "system/usb/usbdrv/usbdrv.h"
#line 57 "system/usb/usbdrv/usbdrv.h"
#line 58 "system/usb/usbdrv/usbdrv.h"

 
#line 61 "system/usb/usbdrv/usbdrv.h"
#line 62 "system/usb/usbdrv/usbdrv.h"
#line 63 "system/usb/usbdrv/usbdrv.h"
#line 64 "system/usb/usbdrv/usbdrv.h"
#line 65 "system/usb/usbdrv/usbdrv.h"
                                    


#line 75 "system/usb/usbdrv/usbdrv.h"
 
#line 77 "system/usb/usbdrv/usbdrv.h"
#line 78 "system/usb/usbdrv/usbdrv.h"

#line 80 "system/usb/usbdrv/usbdrv.h"
#line 81 "system/usb/usbdrv/usbdrv.h"

#line 83 "system/usb/usbdrv/usbdrv.h"
#line 84 "system/usb/usbdrv/usbdrv.h"
#line 85 "system/usb/usbdrv/usbdrv.h"
#line 86 "system/usb/usbdrv/usbdrv.h"
#line 87 "system/usb/usbdrv/usbdrv.h"
#line 88 "system/usb/usbdrv/usbdrv.h"
#line 89 "system/usb/usbdrv/usbdrv.h"
#line 90 "system/usb/usbdrv/usbdrv.h"
#line 91 "system/usb/usbdrv/usbdrv.h"
#line 92 "system/usb/usbdrv/usbdrv.h"
#line 93 "system/usb/usbdrv/usbdrv.h"
#line 94 "system/usb/usbdrv/usbdrv.h"
#line 95 "system/usb/usbdrv/usbdrv.h"
#line 96 "system/usb/usbdrv/usbdrv.h"
#line 97 "system/usb/usbdrv/usbdrv.h"
#line 98 "system/usb/usbdrv/usbdrv.h"
#line 99 "system/usb/usbdrv/usbdrv.h"
#line 100 "system/usb/usbdrv/usbdrv.h"
#line 101 "system/usb/usbdrv/usbdrv.h"
#line 102 "system/usb/usbdrv/usbdrv.h"
#line 103 "system/usb/usbdrv/usbdrv.h"
#line 104 "system/usb/usbdrv/usbdrv.h"
#line 105 "system/usb/usbdrv/usbdrv.h"
#line 106 "system/usb/usbdrv/usbdrv.h"
#line 107 "system/usb/usbdrv/usbdrv.h"
#line 108 "system/usb/usbdrv/usbdrv.h"
#line 109 "system/usb/usbdrv/usbdrv.h"
#line 110 "system/usb/usbdrv/usbdrv.h"
#line 111 "system/usb/usbdrv/usbdrv.h"
#line 112 "system/usb/usbdrv/usbdrv.h"
#line 113 "system/usb/usbdrv/usbdrv.h"
#line 114 "system/usb/usbdrv/usbdrv.h"


#line 135 "system/usb/usbdrv/usbdrv.h"
 

#line 139 "system/usb/usbdrv/usbdrv.h"
#line 140 "system/usb/usbdrv/usbdrv.h"


#line 157 "system/usb/usbdrv/usbdrv.h"
 
#line 159 "system/usb/usbdrv/usbdrv.h"

#line 163 "system/usb/usbdrv/usbdrv.h"

#line 164 "system/usb/usbdrv/usbdrv.h"
 


#line 188 "system/usb/usbdrv/usbdrv.h"
 

#line 194 "system/usb/usbdrv/usbdrv.h"
#line 195 "system/usb/usbdrv/usbdrv.h"

 

 

 
void USBCheckBusStatus(void);
void USBDriverService(void);
void USBRemoteWakeup(void);
void USBSoftDetach(void);

void ClearArray(byte* startAdr,byte count);
#line 208 "system/usb/usbdrv/usbdrv.h"
#line 55 "system/usb/usb.h"

#line 1 "system/usb/usbctrltrf/usbctrltrf.h"

#line 36 "system/usb/usbctrltrf/usbctrltrf.h"
 

#line 39 "system/usb/usbctrltrf/usbctrltrf.h"

 
#line 1 "system/typedefs.h"

#line 35 "system/typedefs.h"
 

#line 156 "system/typedefs.h"
#line 41 "system/usb/usbctrltrf/usbctrltrf.h"


 

 
#line 47 "system/usb/usbctrltrf/usbctrltrf.h"
#line 48 "system/usb/usbctrltrf/usbctrltrf.h"
#line 49 "system/usb/usbctrltrf/usbctrltrf.h"


#line 63 "system/usb/usbctrltrf/usbctrltrf.h"
 
 
#line 66 "system/usb/usbctrltrf/usbctrltrf.h"
#line 67 "system/usb/usbctrltrf/usbctrltrf.h"
#line 68 "system/usb/usbctrltrf/usbctrltrf.h"

 
#line 71 "system/usb/usbctrltrf/usbctrltrf.h"
#line 72 "system/usb/usbctrltrf/usbctrltrf.h"
#line 73 "system/usb/usbctrltrf/usbctrltrf.h"

 
#line 76 "system/usb/usbctrltrf/usbctrltrf.h"
#line 77 "system/usb/usbctrltrf/usbctrltrf.h"

#line 79 "system/usb/usbctrltrf/usbctrltrf.h"
#line 80 "system/usb/usbctrltrf/usbctrltrf.h"
#line 81 "system/usb/usbctrltrf/usbctrltrf.h"

#line 83 "system/usb/usbctrltrf/usbctrltrf.h"
#line 84 "system/usb/usbctrltrf/usbctrltrf.h"
#line 85 "system/usb/usbctrltrf/usbctrltrf.h"
#line 86 "system/usb/usbctrltrf/usbctrltrf.h"

 
extern byte ctrl_trf_session_owner;

extern POINTER pSrc;
extern POINTER pDst;
extern WORD wCount;

 
byte USBCtrlEPService(void);			
void USBCtrlTrfTxService(void);
void USBCtrlTrfRxService(void);
void USBCtrlEPServiceComplete(void);
void USBPrepareForNextSetupTrf(void);


#line 103 "system/usb/usbctrltrf/usbctrltrf.h"
#line 56 "system/usb/usb.h"

#line 1 "system/usb/usb9/usb9.h"

#line 35 "system/usb/usb9/usb9.h"
 

#line 38 "system/usb/usb9/usb9.h"

 
#line 1 "system/typedefs.h"

#line 35 "system/typedefs.h"
 

#line 156 "system/typedefs.h"
#line 40 "system/usb/usb9/usb9.h"


 


#line 47 "system/usb/usb9/usb9.h"
 
#line 49 "system/usb/usb9/usb9.h"
#line 50 "system/usb/usb9/usb9.h"
#line 51 "system/usb/usb9/usb9.h"
#line 52 "system/usb/usb9/usb9.h"
#line 53 "system/usb/usb9/usb9.h"
#line 54 "system/usb/usb9/usb9.h"
#line 55 "system/usb/usb9/usb9.h"
#line 56 "system/usb/usb9/usb9.h"
#line 57 "system/usb/usb9/usb9.h"
#line 58 "system/usb/usb9/usb9.h"
#line 59 "system/usb/usb9/usb9.h"

 
#line 62 "system/usb/usb9/usb9.h"
#line 63 "system/usb/usb9/usb9.h"


#line 79 "system/usb/usb9/usb9.h"
 

#line 87 "system/usb/usb9/usb9.h"
#line 88 "system/usb/usb9/usb9.h"

 

 
void USBCheckStdRequest(void);

#line 95 "system/usb/usb9/usb9.h"
#line 57 "system/usb/usb.h"


#line 60 "system/usb/usb.h"
#line 1 "system/usb/class/cdc/cdc.h"

#line 36 "system/usb/class/cdc/cdc.h"
 

#line 59 "system/usb/class/cdc/cdc.h"

#line 129 "system/usb/class/cdc/cdc.h"

#line 148 "system/usb/class/cdc/cdc.h"

#line 167 "system/usb/class/cdc/cdc.h"

#line 186 "system/usb/class/cdc/cdc.h"

#line 215 "system/usb/class/cdc/cdc.h"

#line 222 "system/usb/class/cdc/cdc.h"

#line 250 "system/usb/class/cdc/cdc.h"

#line 257 "system/usb/class/cdc/cdc.h"

#line 294 "system/usb/class/cdc/cdc.h"
#line 358 "system/usb/class/cdc/cdc.h"
#line 60 "system/usb/usb.h"

#line 62 "system/usb/usb.h"

#line 64 "system/usb/usb.h"
#line 6 "../../Badge.X/user/user.c"

#line 1 "system/usb/class/cdc/cdc.h"

#line 36 "system/usb/class/cdc/cdc.h"
 

#line 59 "system/usb/class/cdc/cdc.h"

#line 129 "system/usb/class/cdc/cdc.h"

#line 148 "system/usb/class/cdc/cdc.h"

#line 167 "system/usb/class/cdc/cdc.h"

#line 186 "system/usb/class/cdc/cdc.h"

#line 215 "system/usb/class/cdc/cdc.h"

#line 222 "system/usb/class/cdc/cdc.h"

#line 250 "system/usb/class/cdc/cdc.h"

#line 257 "system/usb/class/cdc/cdc.h"

#line 294 "system/usb/class/cdc/cdc.h"
#line 358 "system/usb/class/cdc/cdc.h"
#line 7 "../../Badge.X/user/user.c"


             

#line 1 "common.h"

#line 6 "common.h"
 


#line 10 "common.h"






#line 17 "common.h"
#line 18 "common.h"
#line 19 "common.h"
#line 20 "common.h"
#line 21 "common.h"
#line 22 "common.h"

#line 24 "common.h"
#line 25 "common.h"
#line 26 "common.h"

#line 28 "common.h"
#line 29 "common.h"


#line 32 "common.h"
#line 33 "common.h"
#line 34 "common.h"


typedef enum LED_mode {startup, 
                        cylon,
                        sectionWin,
                        stageWin,
                        sonar};


typedef enum Event {empty_ev,
                    tilt_ev,
                    shake_ev,
                    tap_ev,
                    button_ev,
                    led_ev,
                    irRec_ev,
                    pingResp_ev,
                    irResp_ev,
                    setup_ev};


typedef enum Stage {welcome, 
                        mimicry,
                        balance,
                        fib,
                        cylonSeek,
                        peerCount,
                        GoL_Living,
                        GoL_Zombie};

struct state_data {
    unsigned short score;
    unsigned short count;
    unsigned char last_delay_res;
};

struct event_buffer
{
    enum Event front;
    enum Event middle;
    enum Event back;
};
void ir_receive();
void ir_audio();
void ir_gameSpecial();

void irCB_gSpecialReq();
void irCB_gSpecialResp(unsigned char data);
void irCB_send(unsigned char type, unsigned char data);
void irCB_pingResp( unsigned char data);
void irCB_pingReq( unsigned char data);

void irCB_GoLFood(unsigned char amount);
void irCB_GoLAttack(unsigned char amount);

#line 90 "common.h"

#line 11 "../../Badge.X/user/user.c"

#line 1 "game.h"

#line 6 "game.h"
 


#line 10 "game.h"
#line 1 "common.h"

#line 6 "common.h"
 

#line 90 "common.h"

#line 10 "game.h"





#line 16 "game.h"
#line 17 "game.h"


#line 20 "game.h"
#line 21 "game.h"
#line 22 "game.h"
#line 23 "game.h"
#line 24 "game.h"
#line 25 "game.h"
#line 26 "game.h"

void Init_Game();
void Run_Game();




void Stage_Idle();
void Stage_Welcome();
void Stage_Mimicry();
void Stage_Balance();
void Stage_Fib();
void Stage_CylonSeek();
void Stage_PeerCount();

void Stage_GoL_Living();
void Stage_GoL_Zombie();





void led_seq_null(void);
void led_seq_Loading(void);
void led_seq_Cylon(void);
void led_seq_sectionWin(void);
void led_seq_stageWin(void);
void led_seq_sonar(void);
void led_seq_death(void); 
void led_seq_hurt(void);

void check_tilt(void);
void check_accel(void);

unsigned char Get_Fib_Num(unsigned char seq_num);
unsigned char Is_Fib_Num(unsigned char num);

enum Event get_next(struct event_buffer *in_ev);
void enqueue(struct event_buffer *ev_buff, enum Event ev);

void set_leds();
void xor_leds();

void accel_standby(void);
void i2c_setup(void);

void reset_globals(void);
void extractPayload(unsigned char *raw,
                    unsigned char *type,
                    unsigned char *data);

unsigned char unManchester(unsigned char *IRbits, unsigned char *outBits);



#line 82 "game.h"
#line 12 "../../Badge.X/user/user.c"












#line 25 "../../Badge.X/user/user.c"
#line 26 "../../Badge.X/user/user.c"
#line 27 "../../Badge.X/user/user.c"

 
extern void SendRC5(void);
extern volatile byte DataByte, AddrByte, ToggByte;
unsigned char usbOn;
extern volatile unsigned char int_tilt_count;
extern struct event_buffer main_ev;



#pragma udata

  byte input_buffer[64]={0,0,0,0};
  byte output_buffer[64]={0,0,0,0};

 
byte inMenu=0;


 
 
 






















#line 72 "../../Badge.X/user/user.c"
#line 73 "../../Badge.X/user/user.c"
#line 74 "../../Badge.X/user/user.c"
#line 75 "../../Badge.X/user/user.c"





volatile byte IRstate = 0 ;
volatile byte IRbitCnt = 0;            
  byte IRbits[4] = {0,0,0,0};   
  byte unIRbits[2] = {0,0};     


#line 87 "../../Badge.X/user/user.c"
#line 88 "../../Badge.X/user/user.c"
volatile long timer1HZ = 1000000 ;
volatile short timer1Value = 4096 ;
volatile short timer1Counts = 1000000  / 4096  ;


unsigned char inputMode = 0x00;
unsigned char do_callback = 0x00;
void (*ir_callback)(unsigned char type, unsigned char data);


extern unsigned char irPayload_type;
extern unsigned char irPayload_data;
 
 
 
 

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


#line 151 "../../Badge.X/user/user.c"
 
#line 1 "hackRVA.xbm"
#line 2 "hackRVA.xbm"
#line 3 "hackRVA.xbm"
rom unsigned char hackRVA_bits[] = {
   0xff, 0x0c, 0x04, 0x0c, 0xf8, 0x00, 0x60, 0xf4, 0x9c, 0xbc, 0xfc, 0x00,
   0x78, 0xc8, 0x8c, 0x8c, 0x80, 0x00, 0xff, 0x38, 0x38, 0xec, 0x00, 0x00,
   0xff, 0x1b, 0x11, 0x7f, 0xc4, 0x00, 0x0f, 0xf8, 0xe0, 0x7c, 0x07, 0x00,
   0xf0, 0x3f, 0x27, 0x7e, 0xe0 };
#line 152 "../../Badge.X/user/user.c"



rom far char htab[]={"0123456789ABCDEF"};


rom far char writeMe[]={"  TEST WRITE      "};



void InitializeUSART(void);
void InterruptHandlerHigh(void);
void InterruptHandlerLow(void);


#pragma code InterruptVectorHigh = 0x08
void InterruptVectorHigh (void)
{
  _asm
    goto InterruptHandlerHigh 
  _endasm
}

#pragma code InterruptVectorLow = 0x18
void InterruptVectorLow (void)
{
  _asm
    goto InterruptHandlerLow 
  _endasm
}




#pragma code

#pragma interrupt InterruptHandlerHigh

void InterruptHandlerHigh()
{
    

    
    
    
    if (INTCONbits.TMR0IE && INTCONbits.TMR0IF) { 
         
        TMR0H = (65535 - ((1728  / 2) - 0) ) >> 8;
        TMR0L = (65535 - ((1728  / 2) - 0) ) & 0xFF;

         
         
        if (IRstate == 1 ) {
            byte tmpIRbyte;
            byte tmpVal;

            tmpVal = PORTBbits.RB4 ;   

            

            tmpIRbyte = IRbitCnt >> 3; 
            if (tmpIRbyte < 4) {
                IRbits[tmpIRbyte] = IRbits[tmpIRbyte] << 1;
                IRbits[tmpIRbyte] |= tmpVal;
            }
            else {
                
                INTCONbits.TMR0IE = 0;
                INTCONbits.RBIE = 1; 
                IRstate = 2 ;

                
                    
                    
            }
            IRbitCnt++;
        }
        INTCONbits.TMR0IF = 0;            
    }

    
    
    
    if (INTCONbits.RBIE && INTCONbits.RBIF) { 
        byte IRport;

        IRport = PORTBbits.RB4 ; 
        if ( IRstate == 0  ) {
            TMR0H = (65535 - ((1728  / 4) - 0/2) ) >> 8;      
            TMR0L = (65535 - ((1728  / 4) - 0/2) ) & 0xFF;    

            INTCONbits.RBIE = 0;    
            IRstate = 1  ;

            IRbits[0] = 1;    
            IRbitCnt = 1;

            INTCONbits.TMR0IE = 1;  
        }
        INTCONbits.RBIF = 0;     
    }
}



#pragma interruptlow InterruptHandlerLow

void InterruptHandlerLow()
{
    

    
    
    
    
    if (PIR1bits.TMR1IF && PIE1bits.TMR1IE) { 
        static int toggle=0;

        if (timer1Counts <= 0) { 
            timer1Counts = 0;    
            T1CONbits.TMR1ON = 0;
            PORTBbits.RB3 = 0;         
        }
        else {
            TMR1H = (65535 - timer1Value) >> 8;
            TMR1L = (65535 - timer1Value) & 0xFF;

            toggle = !toggle;
            PORTBbits.RB3 = toggle;         
            timer1Counts--;
        } 
        PIR1bits.TMR1IF = 0;            
    }

    if(INTCON3bits.INT2IF) 
    {
         INTCON3bits.INT2IF = 0;  

         int_tilt_count = ~int_tilt_count;
    }
}





#pragma code
void UserInit(void)
{
    void i2c_setup(void);

    TRISBbits.TRISB0 = 1; 
    TRISBbits.TRISB1 = 0; 
    TRISBbits.TRISB2 = 1; 
    TRISBbits.TRISB3 = 0; 
    TRISBbits.TRISB4 = 1; 
    TRISBbits.TRISB5 = 0; 
    TRISBbits.TRISB6 = 0; 
    TRISBbits.TRISB7 = 0; 
    LATB = 0;           

    TRISAbits.TRISA0 = 0; 
    TRISAbits.TRISA1 = 0; 
    TRISAbits.TRISA2 = 0; 
    TRISAbits.TRISA3 = 0; 
    TRISAbits.TRISA4 = 0; 
    TRISAbits.TRISA5 = 0; 
    LATA = 0;

    PORTAbits.RA0 = 1; 
    TRISCbits.TRISC0=0; 
    TRISCbits.TRISC1=0; 
    TRISCbits.TRISC2=1; 
    
    
    

    TRISCbits.TRISC6=0; 
    TRISCbits.TRISC7=1; 
    LATC = 0;

     
    i2c_setup();
    
    INTCON3 = 0;

    
    INTCON3bits.INT2IP = 0;         
    INTCON3bits.INT2IF = 0;         
  
    INTCON2bits.INTEDG2 = 0;        
    INTCON3bits.INT2IE = 1;         


    


    
    
    
    T0CON = 0x88;    

    
    
    
    T1CON = 0x81;    

    
    
    
    INTCONbits.TMR0IF = 0;      
    INTCONbits.TMR0IE = 0;      
    INTCON2bits.TMR0IP = 1;     
    TMR0H = (65535 - ((1728  / 2) - 0) ) >> 8;
    TMR0L = (65535 - ((1728  / 2) - 0) ) & 0xFF;

    
    
    
    PIR1bits.TMR1IF = 0;     
    PIE1bits.TMR1IE = 0;    
    IPR1bits.TMR1IP = 0;    
    timer1Counts = timer1HZ / (timer1Value << 2);
    TMR1H = (65535 - timer1Value) >> 8;
    TMR1L = (65535 - timer1Value) & 0xFF;

    
    INTCONbits.RBIF = 0;   
    INTCONbits.RBIE = 1;    
    INTCON2bits.RBIP = 1;   
    INTCON2bits.RBPU = 1;   

    INTCONbits.PEIE = 1;     

    RCONbits.IPEN = 1;       
    INTCONbits.GIEL = 1;     
    INTCONbits.GIEH = 1;     

 } 

void InitializeUSART(void)
{
    unsigned char c;

    TRISCbits.TRISC7=1; 
    TRISCbits.TRISC6=0; 

    
    SPBRG = 0xE1; 
    
    SPBRGH = 0x04;      
    TXSTA = 0x24;       
    RCSTA = 0x90;       
    BAUDCON = 0x08;     

    
    
    
    
    
    
    
    
    
    

    c = RCREG;                              
}

#line 422 "../../Badge.X/user/user.c"
#line 423 "../../Badge.X/user/user.c"
#line 424 "../../Badge.X/user/user.c"
#line 425 "../../Badge.X/user/user.c"
#line 428 "../../Badge.X/user/user.c"

void putcUSART(char data)
{
    TXREG = data;      
}

unsigned char getcUSART()
{
    char  c;

    if (RCSTAbits.OERR)  
    {                    
        RCSTAbits.CREN = 0;  
        c = RCREG;
        RCSTAbits.CREN = 1;  
    }
    else
        c = RCREG;

    return c;
}

#line 451 "../../Badge.X/user/user.c"
#line 452 "../../Badge.X/user/user.c"

void StartWrite(void) {
    EECON2 = 0x55;
    EECON2 = 0xAA;
    EECON1bits.WR  = 1;
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
    
    TBLPTRU = 0x00;         
                            
}

void ReadProgMem(void) {
    byte counter, byteTemp;

    for (counter = 0; counter < 16; counter++) {
        byteTemp = *(dataArea + counter);
        core.cB.block[counter] = byteTemp;
    }
    
    TBLPTRU = 0x00;         
                            
}

void WriteProgMem(void) {
    byte counter, byteTemp;

    EECON1 = 0b10000100;        

    for (counter = 0; counter < 16; counter++) {
        byteTemp = core.cB.block[counter];
        *(dataArea + counter) = byteTemp;
    }
    StartWrite();









    TBLPTRU = 0x00;         
}

void EraseProgMem(void) {
    byte byteTemp;

    
    
    
    EECON1 = 0b10010100;     
    byteTemp = *(dataArea);
    StartWrite();









    TBLPTRU = 0;            
                            
                            
}


extern unsigned char xA, yA, zA;           

byte unManchester(byte *in, byte *out); 
void doUSBOutput(void);
void doUSBInput(void);
void xor_leds(unsigned char bits);
void set_leds(unsigned char leds);

static byte theramin=0;
static byte freqIndex = 0;
static byte freqBase = 3 * 8; 
static byte LEDByte=0;
static byte playLED = 1, doTimer = 0;

 
static unsigned char usbCheck=0xFF;







unsigned char usbBusSense() {

#line 561 "../../Badge.X/user/user.c"
    if (usbCheck == 0xFF) usbCheck = (PORTCbits.RC2 == 0);  
#line 563 "../../Badge.X/user/user.c"
    return usbCheck;
}




void ProcessIO(void)
{
    
    void check_accel(void);
    void mymemcpy(byte *dest, byte *src, byte n);
    static byte checkCount=0, i, tempHexByte[2] = {0,0};
    void hexDump(byte value, byte *out);

    
    
    
    
    
    
    
    
#line 586 "../../Badge.X/user/user.c"
#line 598 "../../Badge.X/user/user.c"

    
    
    if (IRstate == 2 ) {
        byte errBit; 

        errBit = unManchester(IRbits, unIRbits);
        
        
       
        if (errBit == 14) {

            
            if(inputMode == 0x00)
            {
                timer1Value = freq[(unIRbits[0] & 0b00111111)];
                timer1Counts = ((unIRbits[1] & 0b11111100) );
                T1CONbits.TMR1ON = 1;
            }
            else
            {
               
                extractPayload(unIRbits, &irPayload_type, &irPayload_data);

                set_leds(irPayload_type);
                switch(irPayload_type)
                {
                    case(0x04 ):
                    {
                        if(irPayload_data = 0x02 )
                        {
                            
                            do_callback = 0x01;

                            
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

                            
                            timer1Value = freq[18];
                            timer1Counts = 1000000  / (timer1Value << 2);
                            PIE1bits.TMR1IE = 1;
                            T1CONbits.TMR1ON = 1;
                        }
                        
                        break;
                    }
                    case(0x01 ):
                    {
                            
                            

                            
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

                            
                            timer1Value = freq[18];
                            timer1Counts = 1000000  / (timer1Value << 2);
                            PIE1bits.TMR1IE = 1;
                            T1CONbits.TMR1ON = 1;
                        break;
                    }
                }
            }
        }

        
        IRbitCnt = 0;

        
        IRstate = 0 ;
    }
    
    if(do_callback)
        do_callback++;

    if(do_callback == 255)
    {
        do_callback = 0x00;

        irCB_gSpecialResp(0x77);
    }

    
    
    checkCount++;

     
     
    if (!inputMode && theramin & ((checkCount % 64) == 0)) {
        
        check_accel();


         
        if ((xA & 0x40) | (yA & 0x40)) {
            
            checkCount--;
        } else { 
            short x, y;

            
            
            

            if (xA & 0x10) 
                x = -(short)(0x1F & ~xA); 
            else 
                x = xA;

            x >>= 2; 
            if (x > 3) x = 3;
            if (x < -4) x = -4;



            if (yA & 0x10) 
                y = -(short)(0x1F & ~yA); 
            else
                y = yA;

            y >>= 2; 
            if (y > 3) y = 3;
            if (y < -4) y = -4;


            
            
            
            freqBase = (x+4) * 8;
            
        
            freqBase += (y+4);
            if (freqBase > 63) freqBase = 63;
     
            timer1Value = freq[freqBase];
            timer1Counts = timer1HZ / (timer1Value << 2);
            
            T1CONbits.TMR1ON = 1;
        }
    }
    else if (!inputMode){ 
        
         
         

        
        
        
        
        

        if (playLED & ((checkCount % 32) == 0)) {
            if (LEDByte == (41 -1)) 
                LEDByte = 0;
            else
                LEDByte++;
           set_leds(hackRVA_bits[LEDByte]);
        }
    }

    
    if ((usb_device_state < 6 )||(UCONbits.SUSPND==1))
        return;

    
    if (!(cdc_trf_state == 0 ) ) return;

    
    if (!getsUSBUSART((char *)input_buffer,1))
        doUSBOutput();
    else 
        doUSBInput();


#line 810 "../../Badge.X/user/user.c"

} 

void doUSBOutput() {
    void binaryDump(byte value, byte *out);
    void hexDump(byte value, byte *out);
    void mymemcpy(byte *dest, byte *src, byte n);

    byte b, tmpbuf[8];

    
    
    
    
    
    
    
    
    
    if (inMenu)  {                      
        b = 0;

        if (inMenu == 1) {
            byte i;

            output_buffer[b++] = 'I';
            output_buffer[b++] = 'R';
            output_buffer[b++] = ' ';

            for (i=0; i<4; i++) {
                byte j;

                binaryDump(IRbits[i], tmpbuf);
                mymemcpy(&(output_buffer[b]), tmpbuf, 8);
                b += 8;
                output_buffer[b++] = ' ';
            }

            output_buffer[b++] = 10;
            output_buffer[b++] = 13;
            output_buffer[b++] = 0;
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
                hexDump(errBit, tmpbuf); 
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

            hexDump(((timer1Value & 0xFF00) >> 8), tmpbuf); 
            for (i=0; i< 2; i++) output_buffer[b++] = tmpbuf[i];

            hexDump(((timer1Value & 0x00FF)     ), tmpbuf); 
            mymemcpy(&(output_buffer[b]), tmpbuf, 2);
            b+=2;

            output_buffer[b++] = ' ';
            output_buffer[b++] = 'I';
            output_buffer[b++] = ':';

            hexDump(freqIndex, tmpbuf); 
            mymemcpy(&(output_buffer[b]), tmpbuf, 2);
            b+=2;

            output_buffer[b++] = ' ';
            output_buffer[b++] = 'A';
            output_buffer[b++] = 'C';
            output_buffer[b++] = 'C';
            output_buffer[b++] = ':';
            
            if (xA & 0x20) {
                xA = (0x1F & ~xA); 
                output_buffer[b++] = '-';
            }
            else
               output_buffer[b++] = ' ';

            hexDump(xA, tmpbuf); 
            mymemcpy(&(output_buffer[b]), tmpbuf, 2);
            b+=2;
            output_buffer[b++] = ' ';
            
            if (yA & 0x20) {
                yA = (0x1F & ~yA);
                output_buffer[b++] = '-';
            }
            else
               output_buffer[b++] = ' ';

            hexDump(yA, tmpbuf); 
            mymemcpy(&(output_buffer[b]), tmpbuf, 2);
            b+=2;
            output_buffer[b++] = ' ';
            
            if (zA & 0x20) {
                zA = (0x1F & ~zA);
                output_buffer[b++] = '-';
            }
            else
               output_buffer[b++] = ' ';

            hexDump(zA, tmpbuf); 
            mymemcpy(&(output_buffer[b]), tmpbuf, 2);
            b+=2;

            output_buffer[b++] = ' ';
            output_buffer[b++] = 'T';
            output_buffer[b++] = 'H';
            output_buffer[b++] = ':';
            output_buffer[b++] = ' ';

            hexDump(theramin, tmpbuf); 
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
    
    
    

#line 979 "../../Badge.X/user/user.c"
#line 980 "../../Badge.X/user/user.c"
#line 981 "../../Badge.X/user/user.c"
#line 982 "../../Badge.X/user/user.c"
#line 983 "../../Badge.X/user/user.c"
#line 984 "../../Badge.X/user/user.c"


    
    if (input_buffer[0] == 'R')  {
        inputMode = 0x00;
    }
    
    if(inputMode == 0x01)
    {
        
        if (input_buffer[0] == 't') {
            inputMode = 0x00;
        }

        
        if (input_buffer[0] == 'c') {
            
            ToggByte = (0b00100000 & 0x01 ) >> 5;
            AddrByte = (0b00011111 & 0x01 );

            
            
            
            DataByte = 0x04  << 2;

            
            DataByte |= (0b11000000 & 0x01 )>>6;

            SendRC5();
        }

        
        if (input_buffer[0] == 'p') {
            irCB_gSpecialReq();
        }

        
        if(input_buffer[0] == 'i')
        {
            irCB_pingReq(0x77);
        }

        
        if(input_buffer[0] == 'f')
        {
            irCB_GoLFood(0x0A);
        }

        
        if(input_buffer[0] == 'a')
        {
            irCB_GoLAttack(0x0A);
        }
    }
    else if(inputMode == 0x00)
    {
        
        if (input_buffer[0] == 't') {
            inputMode = 0x01;
        }
        
        
        if (input_buffer[0] == ' ')  {
            inMenu = 1;
        }

        
        if (input_buffer[0] == 'r')  {
            IRstate = 0 ;
            IRbitCnt = 0;
            IRbits[0] = 0;

            
            set_leds(0);
            PIE1bits.TMR1IE = 0;  

        }

        if (input_buffer[0] == 's')  {
            static byte IRfreqBase=32, IRTimerCount=255;

            
            
            

            
            
            

            

            ToggByte = (0b00100000 & IRfreqBase) >> 5 ;
            AddrByte = (0b00011111 & IRfreqBase) ;

            
            DataByte = 0b11111100 & IRTimerCount ;  
                                                    
            IRfreqBase++;

            SendRC5();
            
            

            
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

        
        if (input_buffer[0] == ',') {
            freqBase -= 8;
            freqBase &= 0xF8; 
            if (freqBase < 0) freqBase = 0;
            timer1Value = freq[freqBase];
            doTimer = 1;
        }

        if (input_buffer[0] == '.') {
            freqBase += 8;
            freqBase &= 0xF8; 
            if (freqBase > 48) freqBase = 48;
            timer1Value = freq[freqBase];
            doTimer = 1;
        }

        
        if (input_buffer[0] == 'z') {
            
            timer1Value = freq[freqBase];
            doTimer = 1;
        }

        
        if (input_buffer[0] == 'x') {
            
            timer1Value = freq[freqBase+1];
            doTimer = 1;
        }

        
        if (input_buffer[0] == 'c') {
            
            timer1Value = freq[freqBase+2];
            doTimer = 1;
        }

        
        if (input_buffer[0] == 'v') {
            
            timer1Value = freq[freqBase+3];
            doTimer = 1;
        }

        
        if (input_buffer[0] == 'b') {
            
            timer1Value = freq[freqBase+4];
            doTimer = 1;
        }

        
        if (input_buffer[0] == 'n') {
            
            timer1Value = freq[freqBase+5];
            doTimer = 1;
        }

        
        if (input_buffer[0] == 'm') {
            
            timer1Value = freq[freqBase+6];
            doTimer = 1;
        }

        
        if (input_buffer[0] == 'p') {
            LEDByte = 0;
            playLED ^= 1;
        }

        if (input_buffer[0] == 'a')  {
            PIE1bits.TMR1IE ^= 1;  

            PIR1bits.TMR1IF = 0;     
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
            if (LEDByte != (41 -1)) LEDByte++;
            set_leds(hackRVA_bits[LEDByte]);
        }
    }

}




byte unManchester(byte *IRbits, byte *outBits) {
    byte bitCnt=0, validIRbit, i, errBit=0;

    outBits[0] = outBits[1] = 0;

     
     
     
     
     
     
    for (i=0; i<4; i++) {

        
        
        outBits[(i>>1)] <<= 1;

        
        validIRbit = (IRbits[i] & 0b11000000) >> 6;

        
        if ((!( (validIRbit == 1) || (validIRbit == 2) )) & (errBit == 0)) 
            errBit = bitCnt; 
        else
           outBits[(i>>1)] |= (validIRbit - 1);  
        
        bitCnt++;


        outBits[(i>>1)] <<= 1;
        validIRbit = (IRbits[i] & 0b00110000) >> 4;
        if ((!( (validIRbit == 1) || (validIRbit == 2) )) & (errBit == 0)) 
            errBit = bitCnt; 
        else
           outBits[(i>>1)] |= (validIRbit - 1);
        bitCnt++;

        outBits[(i>>1)] <<= 1;
        validIRbit = (IRbits[i] & 0b00001100) >> 2;
        if ((!( (validIRbit == 1) || (validIRbit == 2) )) & (errBit == 0)) 
            errBit = bitCnt; 
        else
           outBits[(i>>1)] |= (validIRbit - 1);
        bitCnt++;

        outBits[(i>>1)] <<= 1;
        validIRbit = (IRbits[i] & 0b00000011)     ;
        if ((!( (validIRbit == 1) || (validIRbit == 2) )) & (errBit == 0)) 
            errBit = bitCnt; 
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
