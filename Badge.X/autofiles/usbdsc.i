#line 1 "usbdsc.c"
#line 1 "usbdsc.c"

#line 32 "usbdsc.c"
 


#line 72 "usbdsc.c"

#line 162 "usbdsc.c"
 


#line 170 "usbdsc.c"
 

 



 
#pragma romdata

 
rom USB_DEV_DSC device_dsc=
{
    sizeof(USB_DEV_DSC),    
    DSC_DEV,                
    0x0200,                 
    CDC_DEVICE,             
    0x00,                   
    0x00,                   
    EP0_BUFF_SIZE,          
    0x04D8,                 
    0x000A,                 
    0x0001,                 
    0x01,                   
    0x02,                   
    0x00,                   
    0x01                    
};

 
CFG01=
{
     
    sizeof(USB_CFG_DSC),    
    DSC_CFG,                
    sizeof(cfg01),          
    2,                      
    1,                      
    0,                      
    _DEFAULT | _SELF,	    
    50,                     

     
    sizeof(USB_INTF_DSC),   
    DSC_INTF,               
    0,                      
    0,                      
    1,                      
    COMM_INTF,              
    ABSTRACT_CONTROL_MODEL, 
    V25TER,                 
    0,                      

     
    sizeof(USB_CDC_HEADER_FN_DSC),CS_INTERFACE,DSC_FN_HEADER,0x0110,
    sizeof(USB_CDC_ACM_FN_DSC),CS_INTERFACE,DSC_FN_ACM,0x02,
    sizeof(USB_CDC_UNION_FN_DSC),CS_INTERFACE,DSC_FN_UNION,CDC_COMM_INTF_ID,CDC_DATA_INTF_ID,
    sizeof(USB_CDC_CALL_MGT_FN_DSC),CS_INTERFACE,DSC_FN_CALL_MGT,0x00,CDC_DATA_INTF_ID,

     
    sizeof(USB_EP_DSC),DSC_EP,_EP02_IN,_INT,CDC_INT_EP_SIZE,0x02,

     
    sizeof(USB_INTF_DSC),   
    DSC_INTF,               
    1,                      
    0,                      
    2,                      
    DATA_INTF,              
    0,                      
    NO_PROTOCOL,            
    0,                      

     
    sizeof(USB_EP_DSC),DSC_EP,_EP03_OUT,_BULK,CDC_BULK_OUT_EP_SIZE,0x00,
    sizeof(USB_EP_DSC),DSC_EP,_EP03_IN,_BULK,CDC_BULK_IN_EP_SIZE,0x00
};

rom struct{byte bLength;byte bDscType;word string[1];}sd000={
sizeof(sd000),DSC_STR,0x0409};

rom struct{byte bLength;byte bDscType;word string[25];}sd001={
sizeof(sd001),DSC_STR,
'M','i','c','r','o','c','h','i','p',' ',
'T','e','c','h','n','o','l','o','g','y',' ','I','n','c','.'};

rom struct{byte bLength;byte bDscType;word string[25];}sd002={
sizeof(sd002),DSC_STR,
'C','D','C',' ','R','S','-','2','3','2',' ',
'E','m','u','l','a','t','i','o','n',' ','D','e','m','o'};


rom const unsigned char *rom USB_CD_Ptr[]=
{
    (rom const unsigned char *rom)&cfg01,
    (rom const unsigned char *rom)&cfg01
};
rom const unsigned char *rom USB_SD_Ptr[]=
{
    (rom const unsigned char *rom)&sd000,
    (rom const unsigned char *rom)&sd001,
    (rom const unsigned char *rom)&sd002
};

rom pFunc ClassReqHandler[1]=
{
    &USBCheckCDCRequest
};

#pragma code

 
