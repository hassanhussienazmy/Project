
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;FinalProject.c,10 :: 		void interrupt()
;FinalProject.c,12 :: 		if(INTF_bit)
	BTFSS      INTF_bit+0, BitPos(INTF_bit+0)
	GOTO       L_interrupt0
;FinalProject.c,14 :: 		INTF_bit = 0;                                                             //Acknowledge
	BCF        INTF_bit+0, BitPos(INTF_bit+0)
;FinalProject.c,15 :: 		count = -1;                                                               //Exit the loop
	MOVLW      255
	MOVWF      _count+0
	MOVLW      255
	MOVWF      _count+1
;FinalProject.c,16 :: 		}
L_interrupt0:
;FinalProject.c,17 :: 		}
L_end_interrupt:
L__interrupt72:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_WestFlasher:

;FinalProject.c,18 :: 		void WestFlasher()
;FinalProject.c,20 :: 		leds = 0b00101000;                                                        //Prepare west street to stop
	MOVLW      40
	MOVWF      PORTB+0
;FinalProject.c,21 :: 		if(count)
	MOVF       _count+0, 0
	IORWF      _count+1, 0
	BTFSC      STATUS+0, 2
	GOTO       L_WestFlasher1
;FinalProject.c,22 :: 		delay_ms(400);
	MOVLW      5
	MOVWF      R11+0
	MOVLW      15
	MOVWF      R12+0
	MOVLW      241
	MOVWF      R13+0
L_WestFlasher2:
	DECFSZ     R13+0, 1
	GOTO       L_WestFlasher2
	DECFSZ     R12+0, 1
	GOTO       L_WestFlasher2
	DECFSZ     R11+0, 1
	GOTO       L_WestFlasher2
L_WestFlasher1:
;FinalProject.c,23 :: 		leds = 0b00100000;                                                        //Flashing
	MOVLW      32
	MOVWF      PORTB+0
;FinalProject.c,24 :: 		}
L_end_WestFlasher:
	RETURN
; end of _WestFlasher

_SouthFlasher:

;FinalProject.c,25 :: 		void SouthFlasher()
;FinalProject.c,27 :: 		leds = 0b01000100;                                                         //Prepare south street to stop
	MOVLW      68
	MOVWF      PORTB+0
;FinalProject.c,28 :: 		if(count)
	MOVF       _count+0, 0
	IORWF      _count+1, 0
	BTFSC      STATUS+0, 2
	GOTO       L_SouthFlasher3
;FinalProject.c,29 :: 		delay_ms(400);
	MOVLW      5
	MOVWF      R11+0
	MOVLW      15
	MOVWF      R12+0
	MOVLW      241
	MOVWF      R13+0
L_SouthFlasher4:
	DECFSZ     R13+0, 1
	GOTO       L_SouthFlasher4
	DECFSZ     R12+0, 1
	GOTO       L_SouthFlasher4
	DECFSZ     R11+0, 1
	GOTO       L_SouthFlasher4
L_SouthFlasher3:
;FinalProject.c,30 :: 		leds = 0b00000100;                                                         //Flashing
	MOVLW      4
	MOVWF      PORTB+0
;FinalProject.c,31 :: 		}
L_end_SouthFlasher:
	RETURN
; end of _SouthFlasher

_main:

;FinalProject.c,32 :: 		void main()
;FinalProject.c,34 :: 		adcon1 = 7;
	MOVLW      7
	MOVWF      ADCON1+0
;FinalProject.c,35 :: 		trisa = trisb = trisc = trisd = 0;
	CLRF       TRISD+0
	MOVF       TRISD+0, 0
	MOVWF      TRISC+0
	MOVF       TRISC+0, 0
	MOVWF      TRISB+0
	MOVF       TRISB+0, 0
	MOVWF      TRISA+0
;FinalProject.c,36 :: 		trisa.B4 = trisb.B0 = 1;
	BSF        TRISB+0, 0
	BTFSC      TRISB+0, 0
	GOTO       L__main76
	BCF        TRISA+0, 4
	GOTO       L__main77
L__main76:
	BSF        TRISA+0, 4
L__main77:
;FinalProject.c,37 :: 		GIE_bit = 1;
	BSF        GIE_bit+0, BitPos(GIE_bit+0)
;FinalProject.c,38 :: 		INTE_bit = 1;
	BSF        INTE_bit+0, BitPos(INTE_bit+0)
;FinalProject.c,39 :: 		INTEDG_bit = 1;                                                             //Rising Edge
	BSF        INTEDG_bit+0, BitPos(INTEDG_bit+0)
;FinalProject.c,40 :: 		NOT_RBPU_bit = 0;
	BCF        NOT_RBPU_bit+0, BitPos(NOT_RBPU_bit+0)
;FinalProject.c,41 :: 		leds = south_seg = west_Seg = 0;
	CLRF       PORTD+0
	MOVF       PORTD+0, 0
	MOVWF      PORTC+0
	MOVF       PORTC+0, 0
	MOVWF      PORTB+0
;FinalProject.c,42 :: 		if(manual)
	BTFSS      PORTB+0, 0
	GOTO       L_main5
;FinalProject.c,43 :: 		goto Manual;
	GOTO       ___main_Manual
L_main5:
;FinalProject.c,46 :: 		Automatic:
___main_Automatic:
;FinalProject.c,47 :: 		if(south)
	MOVF       _south+0, 0
	IORWF      _south+1, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main7
;FinalProject.c,49 :: 		leds = 0b10000100;                                                  //Run south street(Green)
	MOVLW      132
	MOVWF      PORTB+0
;FinalProject.c,50 :: 		SEG_E = 0b01111;
	MOVLW      15
	MOVWF      PORTA+0
;FinalProject.c,51 :: 		for(count = 15 ; count >= 0 ; count --)
	MOVLW      15
	MOVWF      _count+0
	MOVLW      0
	MOVWF      _count+1
L_main8:
	MOVLW      128
	XORWF      _count+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main78
	MOVLW      0
	SUBWF      _count+0, 0
L__main78:
	BTFSS      STATUS+0, 0
	GOTO       L_main9
;FinalProject.c,53 :: 		west_Seg = tens[count / 10] + count % 10;                        //Red LED counter(West)
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _count+0, 0
	MOVWF      R0+0
	MOVF       _count+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	MOVWF      R2+0
	MOVF       R0+1, 0
	MOVWF      R2+1
	RLF        R2+0, 1
	RLF        R2+1, 1
	BCF        R2+0, 0
	MOVF       R2+0, 0
	ADDLW      _tens+0
	MOVWF      FSR
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _count+0, 0
	MOVWF      R0+0
	MOVF       _count+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	ADDWF      INDF+0, 0
	MOVWF      PORTD+0
;FinalProject.c,54 :: 		if(count - 3 > 0)
	MOVLW      3
	SUBWF      _count+0, 0
	MOVWF      R1+0
	MOVLW      0
	BTFSS      STATUS+0, 0
	ADDLW      1
	SUBWF      _count+1, 0
	MOVWF      R1+1
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      R1+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main79
	MOVF       R1+0, 0
	SUBLW      0
L__main79:
	BTFSC      STATUS+0, 0
	GOTO       L_main11
;FinalProject.c,56 :: 		south_seg = tens[(count-3) / 10] + (count-3) % 10;             //Green LED counter(South)
	MOVLW      3
	SUBWF      _count+0, 0
	MOVWF      FLOC__main+0
	MOVLW      0
	BTFSS      STATUS+0, 0
	ADDLW      1
	SUBWF      _count+1, 0
	MOVWF      FLOC__main+1
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       FLOC__main+0, 0
	MOVWF      R0+0
	MOVF       FLOC__main+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	MOVWF      R2+0
	MOVF       R0+1, 0
	MOVWF      R2+1
	RLF        R2+0, 1
	RLF        R2+1, 1
	BCF        R2+0, 0
	MOVF       R2+0, 0
	ADDLW      _tens+0
	MOVWF      FSR
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       FLOC__main+0, 0
	MOVWF      R0+0
	MOVF       FLOC__main+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	ADDWF      INDF+0, 0
	MOVWF      PORTC+0
;FinalProject.c,57 :: 		for(delay = 0 ; delay<1000 && !manual ; delay ++)
	CLRF       _delay+0
	CLRF       _delay+1
L_main12:
	MOVLW      128
	XORWF      _delay+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      3
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main80
	MOVLW      232
	SUBWF      _delay+0, 0
L__main80:
	BTFSC      STATUS+0, 0
	GOTO       L_main13
	BTFSC      PORTB+0, 0
	GOTO       L_main13
L__main70:
;FinalProject.c,58 :: 		delay_ms(1);
	MOVLW      3
	MOVWF      R12+0
	MOVLW      151
	MOVWF      R13+0
L_main17:
	DECFSZ     R13+0, 1
	GOTO       L_main17
	DECFSZ     R12+0, 1
	GOTO       L_main17
	NOP
	NOP
;FinalProject.c,57 :: 		for(delay = 0 ; delay<1000 && !manual ; delay ++)
	INCF       _delay+0, 1
	BTFSC      STATUS+0, 2
	INCF       _delay+1, 1
;FinalProject.c,58 :: 		delay_ms(1);
	GOTO       L_main12
L_main13:
;FinalProject.c,59 :: 		}
	GOTO       L_main18
L_main11:
;FinalProject.c,62 :: 		south_seg = count;                                             //Yellow LED counter(South)
	MOVF       _count+0, 0
	MOVWF      PORTC+0
;FinalProject.c,63 :: 		SouthFlasher();                                                //Flashing with delay 400ms
	CALL       _SouthFlasher+0
;FinalProject.c,64 :: 		if(count)
	MOVF       _count+0, 0
	IORWF      _count+1, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main19
;FinalProject.c,65 :: 		for(delay = 0 ; delay<600 && !manual ; delay ++)
	CLRF       _delay+0
	CLRF       _delay+1
L_main20:
	MOVLW      128
	XORWF      _delay+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      2
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main81
	MOVLW      88
	SUBWF      _delay+0, 0
L__main81:
	BTFSC      STATUS+0, 0
	GOTO       L_main21
	BTFSC      PORTB+0, 0
	GOTO       L_main21
L__main69:
;FinalProject.c,66 :: 		delay_ms(1);                                           //delay 600ms
	MOVLW      3
	MOVWF      R12+0
	MOVLW      151
	MOVWF      R13+0
L_main25:
	DECFSZ     R13+0, 1
	GOTO       L_main25
	DECFSZ     R12+0, 1
	GOTO       L_main25
	NOP
	NOP
;FinalProject.c,65 :: 		for(delay = 0 ; delay<600 && !manual ; delay ++)
	INCF       _delay+0, 1
	BTFSC      STATUS+0, 2
	INCF       _delay+1, 1
;FinalProject.c,66 :: 		delay_ms(1);                                           //delay 600ms
	GOTO       L_main20
L_main21:
L_main19:
;FinalProject.c,67 :: 		}
L_main18:
;FinalProject.c,51 :: 		for(count = 15 ; count >= 0 ; count --)
	MOVLW      1
	SUBWF      _count+0, 1
	BTFSS      STATUS+0, 0
	DECF       _count+1, 1
;FinalProject.c,68 :: 		}
	GOTO       L_main8
L_main9:
;FinalProject.c,69 :: 		}
	GOTO       L_main26
L_main7:
;FinalProject.c,72 :: 		leds = 0b00110000;                                                  //Run west street(Green)
	MOVLW      48
	MOVWF      PORTB+0
;FinalProject.c,73 :: 		SEG_E = 0b01111;
	MOVLW      15
	MOVWF      PORTA+0
;FinalProject.c,74 :: 		for(count = 23 ; count >= 0 ; count --)
	MOVLW      23
	MOVWF      _count+0
	MOVLW      0
	MOVWF      _count+1
L_main27:
	MOVLW      128
	XORWF      _count+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main82
	MOVLW      0
	SUBWF      _count+0, 0
L__main82:
	BTFSS      STATUS+0, 0
	GOTO       L_main28
;FinalProject.c,76 :: 		south_seg = tens[count / 10] + count % 10;                       //Red LED counter(South)
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _count+0, 0
	MOVWF      R0+0
	MOVF       _count+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	MOVWF      R2+0
	MOVF       R0+1, 0
	MOVWF      R2+1
	RLF        R2+0, 1
	RLF        R2+1, 1
	BCF        R2+0, 0
	MOVF       R2+0, 0
	ADDLW      _tens+0
	MOVWF      FSR
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _count+0, 0
	MOVWF      R0+0
	MOVF       _count+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	ADDWF      INDF+0, 0
	MOVWF      PORTC+0
;FinalProject.c,77 :: 		if(count - 3 > 0)
	MOVLW      3
	SUBWF      _count+0, 0
	MOVWF      R1+0
	MOVLW      0
	BTFSS      STATUS+0, 0
	ADDLW      1
	SUBWF      _count+1, 0
	MOVWF      R1+1
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      R1+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main83
	MOVF       R1+0, 0
	SUBLW      0
L__main83:
	BTFSC      STATUS+0, 0
	GOTO       L_main30
;FinalProject.c,79 :: 		west_Seg = tens[(count-3) / 10] + (count-3) % 10;              //Green LED counter(west)
	MOVLW      3
	SUBWF      _count+0, 0
	MOVWF      FLOC__main+0
	MOVLW      0
	BTFSS      STATUS+0, 0
	ADDLW      1
	SUBWF      _count+1, 0
	MOVWF      FLOC__main+1
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       FLOC__main+0, 0
	MOVWF      R0+0
	MOVF       FLOC__main+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	MOVWF      R2+0
	MOVF       R0+1, 0
	MOVWF      R2+1
	RLF        R2+0, 1
	RLF        R2+1, 1
	BCF        R2+0, 0
	MOVF       R2+0, 0
	ADDLW      _tens+0
	MOVWF      FSR
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       FLOC__main+0, 0
	MOVWF      R0+0
	MOVF       FLOC__main+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	ADDWF      INDF+0, 0
	MOVWF      PORTD+0
;FinalProject.c,80 :: 		for(delay = 0 ; delay<1000 && !manual ; delay ++)
	CLRF       _delay+0
	CLRF       _delay+1
L_main31:
	MOVLW      128
	XORWF      _delay+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      3
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main84
	MOVLW      232
	SUBWF      _delay+0, 0
L__main84:
	BTFSC      STATUS+0, 0
	GOTO       L_main32
	BTFSC      PORTB+0, 0
	GOTO       L_main32
L__main68:
;FinalProject.c,81 :: 		delay_ms(1);
	MOVLW      3
	MOVWF      R12+0
	MOVLW      151
	MOVWF      R13+0
L_main36:
	DECFSZ     R13+0, 1
	GOTO       L_main36
	DECFSZ     R12+0, 1
	GOTO       L_main36
	NOP
	NOP
;FinalProject.c,80 :: 		for(delay = 0 ; delay<1000 && !manual ; delay ++)
	INCF       _delay+0, 1
	BTFSC      STATUS+0, 2
	INCF       _delay+1, 1
;FinalProject.c,81 :: 		delay_ms(1);
	GOTO       L_main31
L_main32:
;FinalProject.c,82 :: 		}
	GOTO       L_main37
L_main30:
;FinalProject.c,85 :: 		west_Seg = count;                                              //Yellow LED counter(west)
	MOVF       _count+0, 0
	MOVWF      PORTD+0
;FinalProject.c,86 :: 		WestFlasher();                                                 //Flashing with delay 400ms
	CALL       _WestFlasher+0
;FinalProject.c,87 :: 		if(count)
	MOVF       _count+0, 0
	IORWF      _count+1, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main38
;FinalProject.c,88 :: 		for(delay = 0 ; delay<600 && !manual ; delay ++)
	CLRF       _delay+0
	CLRF       _delay+1
L_main39:
	MOVLW      128
	XORWF      _delay+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      2
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main85
	MOVLW      88
	SUBWF      _delay+0, 0
L__main85:
	BTFSC      STATUS+0, 0
	GOTO       L_main40
	BTFSC      PORTB+0, 0
	GOTO       L_main40
L__main67:
;FinalProject.c,89 :: 		delay_ms(1);                                           //delay 600ms
	MOVLW      3
	MOVWF      R12+0
	MOVLW      151
	MOVWF      R13+0
L_main44:
	DECFSZ     R13+0, 1
	GOTO       L_main44
	DECFSZ     R12+0, 1
	GOTO       L_main44
	NOP
	NOP
;FinalProject.c,88 :: 		for(delay = 0 ; delay<600 && !manual ; delay ++)
	INCF       _delay+0, 1
	BTFSC      STATUS+0, 2
	INCF       _delay+1, 1
;FinalProject.c,89 :: 		delay_ms(1);                                           //delay 600ms
	GOTO       L_main39
L_main40:
L_main38:
;FinalProject.c,90 :: 		}
L_main37:
;FinalProject.c,74 :: 		for(count = 23 ; count >= 0 ; count --)
	MOVLW      1
	SUBWF      _count+0, 1
	BTFSS      STATUS+0, 0
	DECF       _count+1, 1
;FinalProject.c,91 :: 		}
	GOTO       L_main27
L_main28:
;FinalProject.c,92 :: 		}
L_main26:
;FinalProject.c,93 :: 		if(manual)
	BTFSS      PORTB+0, 0
	GOTO       L_main45
;FinalProject.c,94 :: 		goto Manual;
	GOTO       ___main_Manual
L_main45:
;FinalProject.c,97 :: 		south = !south;                                                     //Exchanging pathes
	MOVF       _south+0, 0
	IORWF      _south+1, 0
	MOVLW      1
	BTFSS      STATUS+0, 2
	MOVLW      0
	MOVWF      _south+0
	MOVWF      _south+1
	MOVLW      0
	MOVWF      _south+1
;FinalProject.c,98 :: 		goto Automatic;
	GOTO       ___main_Automatic
;FinalProject.c,101 :: 		Manual:
___main_Manual:
;FinalProject.c,102 :: 		west_Seg = south_seg = SEG_E = 0;
	CLRF       PORTA+0
	MOVF       PORTA+0, 0
	MOVWF      PORTC+0
	MOVF       PORTC+0, 0
	MOVWF      PORTD+0
;FinalProject.c,103 :: 		if(south)
	MOVF       _south+0, 0
	IORWF      _south+1, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main47
;FinalProject.c,105 :: 		leds = 0b10000100;                                                  //Run south street
	MOVLW      132
	MOVWF      PORTB+0
;FinalProject.c,106 :: 		if(porta.B4)
	BTFSS      PORTA+0, 4
	GOTO       L_main48
;FinalProject.c,108 :: 		while(porta.B4);
L_main49:
	BTFSS      PORTA+0, 4
	GOTO       L_main50
	GOTO       L_main49
L_main50:
;FinalProject.c,109 :: 		SEG_E = 0b01100;                                                //Enable South street segments
	MOVLW      12
	MOVWF      PORTA+0
;FinalProject.c,110 :: 		for(count = 3 ; count >= 0 ; count --)
	MOVLW      3
	MOVWF      _count+0
	MOVLW      0
	MOVWF      _count+1
L_main51:
	MOVLW      128
	XORWF      _count+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main86
	MOVLW      0
	SUBWF      _count+0, 0
L__main86:
	BTFSS      STATUS+0, 0
	GOTO       L_main52
;FinalProject.c,112 :: 		south_seg = count;                                         //Yellow LED counter(South)
	MOVF       _count+0, 0
	MOVWF      PORTC+0
;FinalProject.c,113 :: 		SouthFlasher();
	CALL       _SouthFlasher+0
;FinalProject.c,114 :: 		if(count)
	MOVF       _count+0, 0
	IORWF      _count+1, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main54
;FinalProject.c,115 :: 		delay_ms(wait600);
	MOVLW      7
	MOVWF      R11+0
	MOVLW      23
	MOVWF      R12+0
	MOVLW      106
	MOVWF      R13+0
L_main55:
	DECFSZ     R13+0, 1
	GOTO       L_main55
	DECFSZ     R12+0, 1
	GOTO       L_main55
	DECFSZ     R11+0, 1
	GOTO       L_main55
	NOP
L_main54:
;FinalProject.c,110 :: 		for(count = 3 ; count >= 0 ; count --)
	MOVLW      1
	SUBWF      _count+0, 1
	BTFSS      STATUS+0, 0
	DECF       _count+1, 1
;FinalProject.c,116 :: 		}
	GOTO       L_main51
L_main52:
;FinalProject.c,117 :: 		south = !south;
	MOVF       _south+0, 0
	IORWF      _south+1, 0
	MOVLW      1
	BTFSS      STATUS+0, 2
	MOVLW      0
	MOVWF      _south+0
	MOVWF      _south+1
	MOVLW      0
	MOVWF      _south+1
;FinalProject.c,118 :: 		}
L_main48:
;FinalProject.c,119 :: 		}
	GOTO       L_main56
L_main47:
;FinalProject.c,122 :: 		leds = 0b00110000;                                                  //Run west street
	MOVLW      48
	MOVWF      PORTB+0
;FinalProject.c,123 :: 		if(porta.B4)
	BTFSS      PORTA+0, 4
	GOTO       L_main57
;FinalProject.c,125 :: 		while(porta.B4);
L_main58:
	BTFSS      PORTA+0, 4
	GOTO       L_main59
	GOTO       L_main58
L_main59:
;FinalProject.c,126 :: 		SEG_E = 0b00011;                                                //Enable west street segments
	MOVLW      3
	MOVWF      PORTA+0
;FinalProject.c,127 :: 		for(count = 3 ; count >= 0 ; count --)
	MOVLW      3
	MOVWF      _count+0
	MOVLW      0
	MOVWF      _count+1
L_main60:
	MOVLW      128
	XORWF      _count+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main87
	MOVLW      0
	SUBWF      _count+0, 0
L__main87:
	BTFSS      STATUS+0, 0
	GOTO       L_main61
;FinalProject.c,129 :: 		west_Seg = count;                                          //Yellow LED counter(west)
	MOVF       _count+0, 0
	MOVWF      PORTD+0
;FinalProject.c,130 :: 		westFlasher();
	CALL       _WestFlasher+0
;FinalProject.c,131 :: 		if(count)
	MOVF       _count+0, 0
	IORWF      _count+1, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main63
;FinalProject.c,132 :: 		delay_ms(wait600);
	MOVLW      7
	MOVWF      R11+0
	MOVLW      23
	MOVWF      R12+0
	MOVLW      106
	MOVWF      R13+0
L_main64:
	DECFSZ     R13+0, 1
	GOTO       L_main64
	DECFSZ     R12+0, 1
	GOTO       L_main64
	DECFSZ     R11+0, 1
	GOTO       L_main64
	NOP
L_main63:
;FinalProject.c,127 :: 		for(count = 3 ; count >= 0 ; count --)
	MOVLW      1
	SUBWF      _count+0, 1
	BTFSS      STATUS+0, 0
	DECF       _count+1, 1
;FinalProject.c,133 :: 		}
	GOTO       L_main60
L_main61:
;FinalProject.c,134 :: 		south = !south;
	MOVF       _south+0, 0
	IORWF      _south+1, 0
	MOVLW      1
	BTFSS      STATUS+0, 2
	MOVLW      0
	MOVWF      _south+0
	MOVWF      _south+1
	MOVLW      0
	MOVWF      _south+1
;FinalProject.c,135 :: 		}
L_main57:
;FinalProject.c,136 :: 		}
L_main56:
;FinalProject.c,137 :: 		if(manual)
	BTFSS      PORTB+0, 0
	GOTO       L_main65
;FinalProject.c,138 :: 		goto Manual;
	GOTO       ___main_Manual
L_main65:
;FinalProject.c,140 :: 		goto Automatic;
	GOTO       ___main_Automatic
;FinalProject.c,141 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
