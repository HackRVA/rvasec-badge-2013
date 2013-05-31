#include "common.h"
#include <p18cxxx.h>
extern unsigned char inputMode, do_callback;

extern unsigned char AddrByte;
extern unsigned char ToggByte;
extern unsigned char DataByte;
extern volatile unsigned char *unIRbits;
extern short *freq;

extern unsigned char irPayload_type, irPayload_data;

extern void (*ir_callback)(unsigned char type, unsigned char data);
extern unsigned char timer1Value;
extern unsigned char timer1Counts;

#pragma code
void irCB_gSpecialReq()
{
    ToggByte = (0b00100000 & data_gSpecial_peerCountReq) >> 5;
    AddrByte = (0b00011111 & data_gSpecial_peerCountReq);

    DataByte = type_game_special << 2;

    //put the top two bits of the data at the 2 LSBs
    DataByte |= (0b11000000 & data_gSpecial_peerCountReq)>>6;

    SendRC5();
}

void irCB_gSpecialResp(unsigned char data)
{
    ToggByte = (0b00100000 & data) >> 5;
    AddrByte = (0b00011111 & data);

    DataByte = type_game_special_resp << 2;

    //put the top two bits of the data at the 2 LSBs
    DataByte |= (0b11000000 & data)>>6;

    SendRC5();
}

void irCB_pingResp( unsigned char data)
{
    ToggByte = (0b00100000 & data) >> 5;
    AddrByte = (0b00011111 & data);

    DataByte = type_ping_resp << 2;

    //put the top two bits of the data at the 2 LSBs
    DataByte |= (0b11000000 & data)>>6;

    SendRC5();
}

void irCB_pingReq(unsigned char data)
{
    ToggByte = (0b00100000 & 0x77) >> 5;
    AddrByte = (0b00011111 & 0x77);

    DataByte = type_ping_req << 2;

    //put the top two bits of the data at the 2 LSBs
    DataByte |= (0b11000000 & 0x77)>>6;

    SendRC5();
}

void irCB_send(unsigned char type, unsigned char data)
{
    ToggByte = (0b00100000 & data) >> 5;
    AddrByte = (0b00011111 & data);

    DataByte = type << 2;

    //put the top two bits of the data at the 2 LSBs
    DataByte |= (0b11000000 & data)>>6;

    SendRC5();
}

void irCB_GoLFood(unsigned char amount)
{
    ToggByte = (0b00100000 & amount) >> 5;
    AddrByte = (0b00011111 & amount);

    DataByte = type_GoL_L_food << 2;

    //put the top two bits of the data at the 2 LSBs
    DataByte |= (0b11000000 & amount)>>6;

    SendRC5();
}

void irCB_GoLAttack(unsigned char amount)
{
    ToggByte = (0b00100000 & amount) >> 5;
    AddrByte = (0b00011111 & amount);

    DataByte = type_GoL_L_attack << 2;

    //put the top two bits of the data at the 2 LSBs
    DataByte |= (0b11000000 & amount)>>6;

    SendRC5();
}

void irCB_GoLTrade(unsigned char amount)
{
    ToggByte = (0b00100000 & amount) >> 5;
    AddrByte = (0b00011111 & amount);

    DataByte = type_GoL_L_hpTrade << 2;

    //put the top two bits of the data at the 2 LSBs
    DataByte |= (0b11000000 & amount)>>6;

    SendRC5();
}

void irCB_GoLMutate()
{
    ToggByte = (0b00100000 & data_gSpecial_virus) >> 5;
    AddrByte = (0b00011111 & data_gSpecial_virus);

    DataByte = type_game_special << 2;

    //put the top two bits of the data at the 2 LSBs
    DataByte |= (0b11000000 & data_gSpecial_virus)>>6;

    SendRC5();
}

void irCB_GoLRally(unsigned char amount)
{
    ToggByte = (0b00100000 & amount) >> 5;
    AddrByte = (0b00011111 & amount);

    DataByte = type_GoL_Z_rally << 2;

    //put the top two bits of the data at the 2 LSBs
    DataByte |= (0b11000000 & amount)>>6;

    SendRC5();
}

void irCB_GoL_Z_Attack(unsigned char amount)
{
    ToggByte = (0b00100000 & amount) >> 5;
    AddrByte = (0b00011111 & amount);

    DataByte = type_GoL_Z_attack << 2;

    //put the top two bits of the data at the 2 LSBs
    DataByte |= (0b11000000 & amount)>>6;

    SendRC5();
}