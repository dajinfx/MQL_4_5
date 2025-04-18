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
void OnStart()
  {
      Print("test0");
      ENUM_ORDER_TYPE od_ty = ORDER_TYPE_BUY;
      Order_Close(ORDER_TYPE_BUY);
      Print("test1");
      
      int order_count = CountPendingOrders();
      Print("order_count",order_count);
  }
//+------------------------------------------------------------------+


//
void Order_Close(ENUM_ORDER_TYPE od_ty)
{
   Print("test2");
   int count=0;
   int total=PositionsTotal(); 
   
   Print("total: ",total);
   double pt = 0;
   CTrade trade;
   for(int i=total-1; i>=0; i--)
   {           
      ulong  position_ticket  = PositionGetTicket(i);                                      
      string position_symbol  = PositionGetString(POSITION_SYMBOL);            
      ulong  magic            = PositionGetInteger(POSITION_MAGIC);                                     
      string cmt              = PositionGetString(POSITION_COMMENT);
      double lots             = StringToDouble(DoubleToString(PositionGetDouble(POSITION_VOLUME),2));   
      ENUM_ORDER_TYPE  type   = PositionGetInteger(POSITION_TYPE);
      
      Print("position_ticket: ",position_ticket);
      if (!trade.PositionClose(position_ticket)) 
      {
          Print("平仓失败: ", position_ticket, " 错误代码: ", GetLastError());
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

int CountPendingOrders()
{
    int count = 0;
    
    for(int i = 0; i < OrdersTotal(); i++)  // 遍历所有挂单
    {
        ulong ticket = OrderGetTicket(i);  // 获取挂单的 Ticket
        if(ticket > 0 && OrderSelect(ticket))  // 选择该挂单
        {
            ENUM_ORDER_TYPE orderType = (ENUM_ORDER_TYPE)OrderGetInteger(ORDER_TYPE);
            
            // 统计所有挂单
            if(orderType == ORDER_TYPE_BUY_LIMIT  ||
               orderType == ORDER_TYPE_BUY_STOP   ||
               orderType == ORDER_TYPE_SELL_LIMIT ||
               orderType == ORDER_TYPE_SELL_STOP)
            {
                count++;
            }
        }
    }
    
    return count;
}  