//+------------------------------------------------------------------+
//|                                                 CommonMethod.mqh |
//|                                  Copyright 2025, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2025, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#include <Trade\Trade.mqh>

string test_return(string para1){
   string test_return = para1;
   return (test_return);
}

struct PositionInfo
{
   double lowPrice;
   ulong ticket;
};


void Low_Position_Price(ENUM_ORDER_TYPE orderType,int magic,string comment,double  &lowPrice, ulong &od_tic){
   lowPrice=0;
   od_tic=0;
   int    total=PositionsTotal();
   
   //Print("total:  ",total);
   CTrade trade;
   for(int i=total-1; i>=0; i--)
   {           
   
      ulong  position_ticket  = PositionGetTicket(i);                                      
      string position_symbol  = PositionGetString(POSITION_SYMBOL);            
      ulong  od_magic         = PositionGetInteger(POSITION_MAGIC);                                     
      string od_cmt           = PositionGetString(POSITION_COMMENT);
      double lots             = StringToDouble(DoubleToString(PositionGetDouble(POSITION_VOLUME),2));   
      ENUM_ORDER_TYPE  type   = PositionGetInteger(POSITION_TYPE);
      double od_pri           = PositionGetDouble(POSITION_PRICE_OPEN);
      
      if(type==orderType && od_magic == magic && od_cmt==comment){
         //Print("type: ",type,"    od_pri: ",od_pri);
         if(lowPrice==0){ lowPrice=od_pri; od_tic=position_ticket; continue;}
         if(od_pri<lowPrice){
           lowPrice=od_pri;
           od_tic=position_ticket;
         }
      }
   }
}


void  Low_Order_Price(ENUM_ORDER_TYPE orderType,int magic,string comment, double  &lowPrice, ulong &od_tic){
   lowPrice=0;
   od_tic=0;
   int    total=OrdersTotal();
   
   //Print("total:  ",total);
   CTrade trade;
   for(int i=total-1; i>=0; i--)
   {    
      ulong  order_ticket     = OrderGetTicket(i);                                      
      string order_symbol     = OrderGetString(ORDER_SYMBOL);            
      ulong  order_magic      = OrderGetInteger(ORDER_MAGIC);                                     
      string orderd_cmt       = OrderGetString(ORDER_COMMENT);
      double order_lots       = StringToDouble(DoubleToString(OrderGetDouble(ORDER_VOLUME_CURRENT),2));   
      ENUM_ORDER_TYPE  type   = OrderGetInteger(ORDER_TYPE);
      double od_pri           = OrderGetDouble(ORDER_PRICE_OPEN);
      
      if(type==orderType && order_magic == magic && orderd_cmt==comment){
         Print("type: ",type,"    od_pri: ",od_pri);
         if(lowPrice==0){ lowPrice=od_pri; od_tic=order_ticket; continue;}
         if(od_pri<lowPrice){
           lowPrice=od_pri;
           od_tic=order_ticket;
         }
      }
   }
}