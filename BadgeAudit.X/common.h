
#include <p18f2455.h>
#include <i2c.h>
#include <delays.h>
#include <stdio.h>           //needed for printf, may remove to save space

#ifndef COMMON_H
#define	COMMON_H
#define A_TONE_h 0x5F
#define B_TONE_h 0x6F
#define C_TONE_h 0x7F
#define A_TONE_l 0x0f

void led_setup(void);

void interrupt_setup(void);

void i2c_setup(void);

void setup(void);


#endif	/* COMMON_H */

