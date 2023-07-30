#line 1 "D:/2.Study/Second Year/Others/Summer Training/Embeded/Tasks/Final Project/FinalProject.c"







int tens[] = {0x00 , 0x10 , 0x20 , 0x30 , 0x40 , 0x50 , 0x60 , 0x70 , 0x80 , 0x90};
int count , south = 1 , automatic , delay;
void interrupt()
{
 if(INTF_bit)
 {
 INTF_bit = 0;
 count = -1;
 }
}
void WestFlasher()
{
  portb  = 0b00101000;
 if(count)
 delay_ms(400);
  portb  = 0b00100000;
}
void SouthFlasher()
{
  portb  = 0b01000100;
 if(count)
 delay_ms(400);
  portb  = 0b00000100;
}
void main()
{
 adcon1 = 7;
 trisa = trisb = trisc = trisd = 0;
 trisa.B4 = trisb.B0 = 1;
 GIE_bit = 1;
 INTE_bit = 1;
 INTEDG_bit = 1;
 NOT_RBPU_bit = 0;
  portb  =  portc  =  portd  = 0;
 if( portb.B0 )
 goto Manual;
 else
 goto Automatic;
 Automatic:
 if(south)
 {
  portb  = 0b10000100;
  porta  = 0b01111;
 for(count = 15 ; count >= 0 ; count --)
 {
  portd  = tens[count / 10] + count % 10;
 if(count - 3 > 0)
 {
  portc  = tens[(count-3) / 10] + (count-3) % 10;
 for(delay = 0 ; delay<1000 && ! portb.B0  ; delay ++)
 delay_ms(1);
 }
 else
 {
  portc  = count;
 SouthFlasher();
 if(count)
 for(delay = 0 ; delay<600 && ! portb.B0  ; delay ++)
 delay_ms(1);
 }
 }
 }
 else
 {
  portb  = 0b00110000;
  porta  = 0b01111;
 for(count = 23 ; count >= 0 ; count --)
 {
  portc  = tens[count / 10] + count % 10;
 if(count - 3 > 0)
 {
  portd  = tens[(count-3) / 10] + (count-3) % 10;
 for(delay = 0 ; delay<1000 && ! portb.B0  ; delay ++)
 delay_ms(1);
 }
 else
 {
  portd  = count;
 WestFlasher();
 if(count)
 for(delay = 0 ; delay<600 && ! portb.B0  ; delay ++)
 delay_ms(1);
 }
 }
 }
 if( portb.B0 )
 goto Manual;
 else
 {
 south = !south;
 goto Automatic;
 }

 Manual:
  portd  =  portc  =  porta  = 0;
 if(south)
 {
  portb  = 0b10000100;
 if(porta.B4)
 {
 while(porta.B4);
  porta  = 0b01100;
 for(count = 3 ; count >= 0 ; count --)
 {
  portc  = count;
 SouthFlasher();
 if(count)
 delay_ms( 600 );
 }
 south = !south;
 }
 }
 else
 {
  portb  = 0b00110000;
 if(porta.B4)
 {
 while(porta.B4);
  porta  = 0b00011;
 for(count = 3 ; count >= 0 ; count --)
 {
  portd  = count;
 westFlasher();
 if(count)
 delay_ms( 600 );
 }
 south = !south;
 }
 }
 if( portb.B0 )
 goto Manual;
 else
 goto Automatic;
}
