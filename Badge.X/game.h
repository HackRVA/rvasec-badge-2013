/* 
 * File:   game.h
 * Author: morgan
 *
 * Created on May 1, 2013, 4:00 PM
 */

#ifndef GAME_H
#define	GAME_H
#include "common.h"

//===========
//Globals and Defines
//===========
#define Accel_Write_Addr 0x98
#define Accel_Read_Addr 0x99

//bitwise AND these with tilt to get badge accel state
#define alert_t 0x40
#define shake_t 0x80
#define tap_t 0x20
#define landscape_left_t 0x04
#define landscape_right_t 0x08
#define vertical_invert_t 0x14
#define vertical_normal_t 0x18

void Init_Game();
void Run_Game();

/////////////////////
//---Stages---
/////////////////////
void Stage_Idle();
void Stage_Welcome();
void Stage_Mimicry();
void Stage_Balance();
void Stage_Fib();
void Stage_CylonSeek();
void Stage_PeerCount();

void Stage_GoL_Living();
void Stage_GoL_Zombie();


/////////////////////
//---Led Sequences---
/////////////////////
void led_seq_null(void);
void led_seq_Loading(void);
void led_seq_Cylon(void);
void led_seq_sectionWin(void);
void led_seq_stageWin(void);
void led_seq_sonar(void);
void led_seq_death(void); //oh no!
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



#endif	/* GAME_H */
