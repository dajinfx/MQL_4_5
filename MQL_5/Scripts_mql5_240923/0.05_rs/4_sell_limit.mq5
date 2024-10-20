//+------------------------------------------------------------------+
//|                                                   1_selllimit.mq5 |
//|                                  Copyright 2024, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2024, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
double Lots=0.05;
string symbol_type;
double deal_point;
int magic_no = 101;
double profit_dis_p = 500;
double loss_dis_p = 200;
double points_above_market = 200; // Distance in points above current price for Sell Limit

void OnStart()
{
   double bid = SymbolInfoDouble(Symbol(), SYMBOL_BID);
   double selllimit_price = NormalizeDouble(bid + points_above_market * Point(), Digits());
   bool od_result = Od_Send(Symbol(), ORDER_TYPE_SELL_LIMIT, Lots, selllimit_price, loss_dis_p, profit_dis_p, "Scripts_mql5_selllimit", magic_no);
}

bool Od_Send(string symb, ENUM_ORDER_TYPE od_ty, double od_lots, double open_pri, double sl_p, double tp_p, string cmt, int m_n) { 
               
   MqlTradeRequest request;
   MqlTradeResult  result;
   
   request.action = TRADE_ACTION_PENDING;
   
   double sl, tp;
   
   sl = NormalizeDouble(open_pri + sl_p * Point(), Digits());
   tp = NormalizeDouble(open_pri - tp_p * Point(), Digits());
   
   if(sl_p == 0 || DoubleToString(sl_p) == "") sl = 0;
   if(tp_p == 0 || DoubleToString(tp_p) == "") tp = 0;
   
   request.type = od_ty;  
   request.symbol = symb;                        
   request.volume = od_lots;                      
   request.price = open_pri; 
   request.deviation = 5;                            
   request.tp = tp;
   request.sl = sl;
   request.comment = cmt;
   request.magic = m_n;
   
   request.type_filling = ORDER_FILLING_IOC;
   
   bool od_send = OrderSend(request, result); 
   if(!od_send)
   {
      Print("OrderSend error: ", GetLastError());   
   }
   else
   {
      Print("Sell Limit order placed successfully");
   }
   
   return od_send;
} 