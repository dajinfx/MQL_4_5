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
#include <CommonMethod.mqh>

double Lots=0.02;
string symbol_type;
double deal_point;
int magic_no = 101;
double profit_dis_p = 500;
double loss_dis_p = 200;
double points_above_market = 200; // Distance in points above current price for Sell Limit

void OnStart()
{
   double profit_dis = profit_dis_p;
   double loss_dis   = loss_dis_p;
   Dis_p_change(profit_dis = profit_dis_p, loss_dis = loss_dis_p, profit_dis_p, loss_dis_p);
   
   double bid = SymbolInfoDouble(Symbol(), SYMBOL_BID);
   double selllimit_price = NormalizeDouble(bid + points_above_market * Point(), Digits());
   
   bool od_result = false;
   
   while(!od_result){
      od_result = Od_Send(Symbol(), ORDER_TYPE_SELL_LIMIT, Lots, selllimit_price, loss_dis_p, profit_dis_p, "Scripts_mql5_selllimit", magic_no);
      if(od_result)break;
   }
}
 