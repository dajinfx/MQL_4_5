//+------------------------------------------------------------------+
//|                                          Martin_multiLimit_1.mq5 |
//|                                  Copyright 2025, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2025, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
#property strict
#include <Trade\Trade.mqh>
#include <Files\FileTxt.mqh>
#include <CommonMethod.mqh>

double baseLots         = 0.01;
string symb             = "";
double od_tp_p          = 0;
double od_sl_p          = 0;
string od_cmt           = "捕捉窄区";
double closeCondition   = 5;
int magic_no            = 13;
   
int multiloop           = 10;
int distance_point      = 100; 
int start_distance      = 50;

double start_price_buy  = 0;
double start_price_sell = 0;
PositionInfo pi_1;
LimitStopOrdersInfo st_1;

int running = 1;

int OnInit()
{
   symb = Symbol();
   return(INIT_SUCCEEDED);
}

void OnDeinit(const int reason)
{
   
}

void OnTick()
{
   pi_1 = getPositionInfo(magic_no,symb);
   st_1 = getLimitStopOrdersInfo(magic_no,symb);
   
   int count_pi_1 = pi_1.count;
   int count_st_1_buy = st_1.count_stop_buy;
   int count_st_1_sell = st_1.count_stop_sell;
   
   Print("count_pi_1:   ", count_pi_1,"  count_st_1: ",count_st_1_sell);
   
   if(count_pi_1==0 && count_st_1_buy==0 && count_st_1_sell==0)
   {
      if(running==1)
      {
         ExecuteTrade();
      }
   }
   
   bool close_condition = PositionCloseCondition();
   if(close_condition) Order_Close_All(magic_no, symb);
   
   Print("Tick end -------------------------------------------------");
}

// 计算交易信号  在这里汇集所有的指标信号
int Od_Signal(string currency1, double multLots)
{
   int signal = 0;
   
   //在此的函数中得到的是各个指标中获取的信号值，均线，macd 或者其他指标中得到值在这里聚合
   //int signal_mavalue = signal_mavalue( currency1, currency2, multLots);
   //int signal_cci = signal_cci( currency1, currency2, multLots);
   //signal_atrvalue( currency1, currency2, multLots);
   
   //if(signal_cci) signal=signal_cci;
   
   return signal;
}



bool PositionCloseCondition()
{
   double profit_total = POSITION_Profit(magic_no);
   
   //Print("profit_total: ",profit_total,"  closeCondition: ",closeCondition);
   if( profit_total > closeCondition ) return true;
   
   return false;
}

void PositionMatinExcute()
{

   double ask = SymbolInfoDouble(symb,SYMBOL_ASK);
   double bid = SymbolInfoDouble(symb,SYMBOL_BID);
   
   double openPrice_buy  = 0;
   double openPrice_sell = 0;
   
   double topPrice_buy   = pi_1.highestBuyPrice;
   double lowPrice_sell  = pi_1.lowestSellPrice;
   
   
   if(topPrice_buy==0) 
   
   
   if(ask + distance_point * Point()> topPrice_buy)
   {
      int od_result_buy = Od_Send(symb, ORDER_TYPE_BUY_STOP, baseLots, openPrice_buy,od_sl_p,od_tp_p,od_cmt,magic_no);
   }
   else
   if(bid - distance_point * Point()<lowPrice_sell)
   {
      int od_result_buy = Od_Send(symb, ORDER_TYPE_BUY_STOP, baseLots, openPrice_buy,od_sl_p,od_tp_p,od_cmt,magic_no);
   }
   

}

// 交易执行
void ExecuteTrade() {

   double ask = SymbolInfoDouble(symb,SYMBOL_ASK);
   double bid = SymbolInfoDouble(symb,SYMBOL_BID);
   
   double openPrice_buy  = 0;
   double openPrice_sell = 0;
   
   for(int i =0; i<multiloop; i++)
   {
      Print("step  i ",i,"   multiloop: ",multiloop);
      if(openPrice_buy==0)
      {
         openPrice_buy = ask+start_distance*Point();
         if(start_price_buy>0)
            openPrice_buy = start_price_buy;
      } 
      else
      {
         openPrice_buy = openPrice_buy + distance_point*Point();
      }

      int od_result_buy = Od_Send(symb, ORDER_TYPE_BUY_STOP, baseLots, openPrice_buy,od_sl_p,od_tp_p,od_cmt,magic_no);
      

      //----------------------------------------------
      
      if(openPrice_sell ==0)
      {
         openPrice_sell = bid-start_distance*Point();
         if(start_price_sell>0)
            openPrice_sell = start_price_sell;
      }
      else
      {
         openPrice_sell = openPrice_sell - distance_point*Point();
      }
      
      int od_result_sell = Od_Send(symb, ORDER_TYPE_SELL_STOP, baseLots, openPrice_sell,od_sl_p,od_tp_p,od_cmt,magic_no);
     
   }
   
}


void Order_Close_All(ulong magic_num, string symbol)
{
   Position_Close(magic_num, symbol);
   Order_Delete(magic_num, symbol);  
   running = 0;
}








 