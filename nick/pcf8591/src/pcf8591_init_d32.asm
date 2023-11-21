;-------------------------------------------------------------------------------
; pcf8591_init_d32 - a function to configure the pcf8591 device as 3 differential
; alalog inputs A0, A1, A2 with a common A3 input. Three outputs Chnl 0, Chnl 1, 
; and Chnl 2,  with Channel 2 being active and DAC value from
; pcf8591_def.inc include file. Assumes the pcf8591 8 Bit A/D D/A is I2C
; connected to the PIO and I2C Expansion Boards for the 1802/Mini Computer.
;
; Copyright 2023 Milton 'Nick' DeNicholas
;
; This is an extension of Copyrighted work by Gaston Williams
; please see https://github.com/fourstix/Elfos-I2C-Libraries for more info
;
; Based on the the Elf-I2C library
; Written by Tony Hefner
; Copyright 2023 by Tony Hefner
; Please see github.com/arhefner/Elfos-I2C for more info
;
; PIO and I2C Expansion Boards for the 1802/Mini Computer hardware
; Copyright 2022 by Tony Hefner 
; Please see github.com/arhefner/1802-Mini-PIO for more info
;
;-------------------------------------------------------------------------------

#include ../../include/ops.inc
#include ../../include/bios.inc
#include ../../include/kernel.inc
#include ../../include/sysconfig.inc
#include ../../include/i2c_lib.inc
#include ../../include/pcf8591_def.inc

;-------------------------------------------------------------------------------
; This routine initializes the device as 3 differential analog inputs A0, A1, A2
; with a common A3 input. Three outputs Chnl 0, Chnl 1, and Chnl 2,  with 
; Channel 2 being active. Pcf8591 device address and DAC value are
; defined in the pcf8591_def.inc file above.
;
; Example:
;           call    pcf8591_init_d32   ; initialize device to:
;                                      ; Channel 2 active, 3 differential inputs, 
;                                      ; DAC = pcf8591_DAC, analog out enabled
;
; Returns: 
;     DF = 0 on success, DF = 1 if not found
;-------------------------------------------------------------------------------

            proc    pcf8591_init_d32   ; Differential inputs - A2 + A3 --> Chnl 2
            
            call    i2c_wrbuf          ; write to pcf8591 device, chnl 2 active
            db      I2C_ADDR , $02     ;    where 12c addr = I2C_ADDR for 2 bytes
            dw      pcf8591d32         ; 
            return
            
pcf8591d32: db    $00+AD_CHNL_2+AD_INP_3DIFF+AOUT_ENABLE  ; Control Byte:
            db    pcf8591_DAC          ; DAC value
            
            endp
            