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
      ENUM_ORDER_TYPE od_ty = ORDER_TYPE_BUY;
      Order_Delete(ORDER_TYPE_BUY);
      
      int order_count = CountPendingOrders();
  }
//+------------------------------------------------------------------+


//
void Order_Delete(ENUM_ORDER_TYPE od_ty)
{
   Print("test2");
   int count=0;
   int total=OrdersTotal(); 
   
   Print("total: ",total);
   double pt = 0;
   CTrade trade;
   for(int i=total-1; i>=0; i--)
   {           
      ulong  Order_ticket  = OrderGetTicket(i);                                      
      string Order_symbol  = OrderGetString(ORDER_SYMBOL);            
      ulong  magic            = OrderGetInteger(ORDER_MAGIC);                                     
      string cmt              = OrderGetString(ORDER_COMMENT);
      double lots             = StringToDouble(DoubleToString(OrderGetDouble(ORDER_VOLUME_CURRENT),2));   
      ulong  type   = OrderGetInteger(ORDER_TYPE);
      
      Print("Order_ticket: ",Order_ticket);
      if (!trade.OrderDelete(Order_ticket)) 
      {
         Print("position_ticket: ",Order_ticket,"   position_symbol: ",Order_symbol,"type",type);
         Print("平仓失败: ", Order_ticket, " 错误代码: ", GetLastError());
      }
   }   
}


int CountPendingOrders()
{
    int count = 0;
    
    for(int i = 0; i < OrdersTotal(); i++)  
    {
        ulong ticket = OrderGetTicket(i);  
        if(ticket > 0 && OrderSelect(ticket))  
        {
            ENUM_ORDER_TYPE orderType = (ENUM_ORDER_TYPE)OrderGetInteger(ORDER_TYPE);
            
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