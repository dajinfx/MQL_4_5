//+------------------------------------------------------------------+
//|                                                Close_Buy_All.mq5 |
//|                                  Copyright 2024, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2024, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
#include <Trade\Trade.mqh>

void OnStart()
  {
      ENUM_ORDER_TYPE od_ty = ORDER_TYPE_SELL;
      Order_Close(od_ty);
  }
//+------------------------------------------------------------------+


//
void Order_Close(ENUM_ORDER_TYPE od_ty)
{
   int count=0;
   int total=PositionsTotal(); 
   
   double pt = 0;
   
   for(int i=total-1; i>=0; i=i-1)
   {           
      ulong  position_ticket  = PositionGetTicket(i);                                      
      string position_symbol  = PositionGetString(POSITION_SYMBOL);            
      ulong  magic            = PositionGetInteger(POSITION_MAGIC);                                     
      string cmt              = PositionGetString(POSITION_COMMENT);
      double lots             = StringToDouble(DoubleToString(PositionGetDouble(POSITION_VOLUME),2));   
      ENUM_ORDER_TYPE  type   = PositionGetInteger(POSITION_TYPE);
      
      if(od_ty==type)
      {
         CTrade cEATrade;
         cEATrade.PositionClose(position_ticket,lots);
      }                          
   }   
}

//
bool Od_Modify(string symb, int ticket, ENUM_ORDER_TYPE od_ty, double open_pri, double sl,double tp) { 
               
   MqlTradeRequest request;
   MqlTradeResult  result;
     
   request.action    =  TRADE_ACTION_SLTP;                           
   request.position  =  ticket;                            
   request.symbol    =  symb;        
   request.sl        =  sl;  
 
   bool od_send      =  OrderSend(request,result); 
   
   return od_send;
}  