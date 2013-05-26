/* 
 * File:   common.h
 * Author: morgan
 *
 * Created on May 11, 2013, 5:29 PM
 */

#ifndef COMMON_H
#define	COMMON_H

///////////////////////
//---IR Prtocol Defs---
///////////////////////



//types
#define type_ping_req 0x00
#define type_ping_resp 0x01
#define type_id_Request 0x02
#define type_id_response 0x03
#define type_game_special 0x04
#define type_game_special_resp 0x05

#define type_GoL_L_food 0x07
#define type_GoL_L_attack 0x08
#define type_GoL_L_hpTrade 0x09

#define type_GoL_Z_attack 0x0A
#define type_GoL_Z_rally 0x0B

//specific data for types
#define data_gSpecial_cylonHello 0x01
#define data_gSpecial_peerCountReq 0x02
#define data_gSpecial_virus 0x03

//special LED sequences for the led_ev
typedef enum LED_mode {startup, 
                        cylon,
                        sectionWin,
                        stageWin,
                        sonar};

//events that can occur
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

//game stages
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

#endif	/* COMMON_H */

