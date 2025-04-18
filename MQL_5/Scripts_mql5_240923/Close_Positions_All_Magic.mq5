//+------------------------------------------------------------------+
//|                                                Close_Buy_All.mq5 |
//|                                  Copyright 2024, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2024, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
#include <Trade\Trade.mqh>
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+

input int cmagic = 101;

void OnStart()
  {
      Print("test0");
      Order_Close();
  }
//+------------------------------------------------------------------+


//
void Order_Close()
{
   int count=0;
   int total=PositionsTotal(); 
   
   double pt = 0;
   CTrade trade;
   for(int i=total-1; i>=0; i--)
   {           
      ulong  position_ticket  = PositionGetTicket(i);                                      
      string position_symbol  = PositionGetString(POSITION_SYMBOL);            
      ulong  magic            = PositionGetInteger(POSITION_MAGIC);                                     
      string cmt              = PositionGetString(POSITION_COMMENT);
      double lots             = StringToDouble(DoubleToString(PositionGetDouble(POSITION_VOLUME),2));   
      ulong  type             = PositionGetInteger(POSITION_TYPE);
      
      if(magic == cmagic)
      {
         if (!trade.PositionClose(position_ticket)) 
         {
             Print("平仓失败: ", position_ticket, " 错误代码: ", GetLastError());
         }
      }
      

   }   
}
