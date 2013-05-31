	include "P18F2455.INC"

    UDATA_ACS

EEbyte		res 1		; byte
EEaddr		res 1		; addr

    global EEbyte
    global EEaddr       ; address starts at 0->255

    global EEstore              ; so linker will see it
    global EEfetch              ; so linker will see it



    CODE

EEstore
        movf    EEaddr, W
        movwf   EEADR, A
        movf    EEbyte, W
        movwf   EEDATA, A
        bcf     EECON1, EEPGD, A
        bcf     EECON1, CFGS, A
        bcf     PIR2, EEIF, A
        bsf     EECON1, WREN, A
        bcf     INTCON, GIE, A
        movlw   h'55'
        movwf   EECON2, A
        movlw   h'aa'
        movwf   EECON2, A
        bsf     EECON1, WR, A
        bsf     INTCON, GIE, A
ECSTORE2
        btfss   PIR2, EEIF, A
        bra     ECSTORE2
        bcf     EECON1, WREN, A
        bcf     PIR2, EEIF, A

        return


EEfetch
        movf    EEaddr, W
        movwf   EEADR, A
        bcf     EECON1, EEPGD, A
        bcf     EECON1, CFGS, A
        bsf     EECON1, RD, A
        movf    EEDATA, W
        movwf   EEbyte

        return


	end
