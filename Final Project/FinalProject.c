#define   wait600     600
#define   wait1000    1000
#define   manual      portb.B0
#define   SEG_E       porta
#define   leds        portb
#define   south_seg   portc
#define   west_Seg    portd
int tens[] = {0x00 , 0x10 , 0x20 , 0x30 , 0x40 , 0x50 , 0x60 , 0x70 , 0x80 , 0x90};
int count , south = 1 , automatic , delay;                                      //MailBox
void interrupt()
{
    if(INTF_bit)
    {
      INTF_bit = 0;                                                             //Acknowledge
      count = -1;                                                               //Exit the loop
    }
}
void WestFlasher()
{
      leds = 0b00101000;                                                        //Prepare west street to stop
      if(count)
          delay_ms(400);
      leds = 0b00100000;                                                        //Flashing
}
void SouthFlasher()
{
     leds = 0b01000100;                                                         //Prepare south street to stop
     if(count)
         delay_ms(400);
     leds = 0b00000100;                                                         //Flashing
}
void main()
{
    adcon1 = 7;
    trisa = trisb = trisc = trisd = 0;
    trisa.B4 = trisb.B0 = 1;
    GIE_bit = 1;
    INTE_bit = 1;
    INTEDG_bit = 1;                                                             //Rising Edge
    NOT_RBPU_bit = 0;
    leds = south_seg = west_Seg = 0;
    if(manual)
        goto Manual;
    else
        goto Automatic;
    Automatic:
        if(south)
        {
            leds = 0b10000100;                                                  //Run south street(Green)
            SEG_E = 0b01111;
            for(count = 15 ; count >= 0 ; count --)
            {
               west_Seg = tens[count / 10] + count % 10;                        //Red LED counter(West)
               if(count - 3 > 0)
               {
                 south_seg = tens[(count-3) / 10] + (count-3) % 10;             //Green LED counter(South)
                 for(delay = 0 ; delay<1000 && !manual ; delay ++)
                     delay_ms(1);
               }
               else
               {
                 south_seg = count;                                             //Yellow LED counter(South)
                 SouthFlasher();                                                //Flashing with delay 400ms
                 if(count)
                     for(delay = 0 ; delay<600 && !manual ; delay ++)
                         delay_ms(1);                                           //delay 600ms
               }
            }
        }
        else
        {
            leds = 0b00110000;                                                  //Run west street(Green)
            SEG_E = 0b01111;
            for(count = 23 ; count >= 0 ; count --)
            {
               south_seg = tens[count / 10] + count % 10;                       //Red LED counter(South)
               if(count - 3 > 0)
               {
                 west_Seg = tens[(count-3) / 10] + (count-3) % 10;              //Green LED counter(west)
                 for(delay = 0 ; delay<1000 && !manual ; delay ++)
                     delay_ms(1);
               }
               else
               {
                 west_Seg = count;                                              //Yellow LED counter(west)
                 WestFlasher();                                                 //Flashing with delay 400ms
                 if(count)
                     for(delay = 0 ; delay<600 && !manual ; delay ++)
                         delay_ms(1);                                           //delay 600ms
               }
            }
        }
        if(manual)
            goto Manual;
        else
        {
            south = !south;                                                     //Exchanging pathes
            goto Automatic;
        }

    Manual:
        west_Seg = south_seg = SEG_E = 0;
        if(south)
        {
            leds = 0b10000100;                                                  //Run south street
            if(porta.B4)
            {
                while(porta.B4);
                SEG_E = 0b01100;                                                //Enable South street segments
                for(count = 3 ; count >= 0 ; count --)
                {
                     south_seg = count;                                         //Yellow LED counter(South)
                     SouthFlasher();
                     if(count)
                       delay_ms(wait600);
                }
                south = !south;
            }
        }
        else
        {
            leds = 0b00110000;                                                  //Run west street
            if(porta.B4)
            {
                while(porta.B4);
                SEG_E = 0b00011;                                                //Enable west street segments
                for(count = 3 ; count >= 0 ; count --)
                {
                     west_Seg = count;                                          //Yellow LED counter(west)
                     westFlasher();
                     if(count)
                       delay_ms(wait600);
                }
                south = !south;
             }
        }
        if(manual)
            goto Manual;
        else
            goto Automatic;
}