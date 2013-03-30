
#include <p18f2455.h>
#include <i2c.h>
#include <delays.h>
#include <stdio.h>           //needed for printf, may remove to save space

#ifndef COMMON_H
#define	COMMON_H
#define TONE_LOW_BYTE 0x0f

#define ATOMIC_BEGIN INTCONbits.GIE = 0;
#define ATOMIC_END INTCONbits.GIE = 1;\
                   if(INTCON3bits.INT2IF == 1)\
                        check_tilt();

//===========
//Globals and Defines
//===========
#define Accel_Write_Addr 0x98
#define Accel_Read_Addr 0x99

//Logical AND these with tilt to get badge accel state
#define alert_t 0x40
#define shake_t 0x80
#define tap_t 0x20
#define landscape_left_t 0x04
#define landscape_right_t 0x08
#define vertical_invert_t 0x14
#define vertical_normal_t 0x18

//states
typedef enum State {idle, ir_respond, ir_receive, speak, handle_tilt};

typedef enum LED_mode {startup, cylon};

typedef enum Event {empty_ev, tilt_ev, shake_ev, tap_ev, button_ev, led};

struct song_desc {
    volatile unsigned char note_length;
    volatile unsigned char song_index;
    volatile unsigned char *song;       //point this to song array
};

struct event_buffer
{
    enum Event *current_seq;
    enum Event seq0;
    enum Event seq1;

    enum Event front;
    enum Event middle;
    enum Event back;
};




void led_setup(void);

void interrupt_setup(void);

void i2c_setup(void);

void setup(void);


#define D_TONE_l 0x00
#define Dsh_TONE_l 0x0F

#define E_TONE_l 0x10

#define F_TONE_l 0x1F
#define Fsh_TONE_l 0x20

#define G_TONE_l 0x2F
#define Gsh_TONE_l 0x30


#define A_TONE_h 0x3F
#define Ash_TONE_h 0x40

#define B_TONE_h 0x4F
#define C_TONE_h 0x50
#define Csh_TONE_h 0x5F

#define D_TONE_h 0x60
#define Dsh_TONE_h 0x6F

#define E_TONE_h 0x70

#define F_TONE_h 0x7F
#define Fsh_TONE_h 0x80

#define G_TONE_h 0x8F
#define Gsh_TONE_h 0x90

#endif	/* COMMON_H */
