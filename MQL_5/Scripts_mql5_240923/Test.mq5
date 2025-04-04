//+------------------------------------------------------------------+
//|                                                         Test.mq5 |
//|                                  Copyright 2025, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2025, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
#include <CommonMethod.mqh>
#include <Trade\Trade.mqh>


double Lots=0.01;
string symbol_type;
double deal_point;
int magic_no = 101;
double profit_dis_p = 500;
double loss_dis_p = 200;

void OnStart()
{
   
   PositionInfo pi = getPositionInfo(magic_no);
   LimitStopOrdersInfo lsi = getLimitStopOrdersInfo(magic_no);
   
   Print("pi.count: ",pi.count);
   Print("lsi.count_limit_buy: ",lsi.count_limit_buy);
   
   Print("lsi.count_limit_sell: ",lsi.count_limit_sell);
   /**/
   
   string symbol = Symbol();
   ENUM_TIMEFRAMES timeframe = PERIOD_H1;
   int maPeriod = 10;
   ENUM_MA_METHOD maMethod = MODE_SMMA;
   ENUM_APPLIED_PRICE appliedPrice = PRICE_CLOSE;
   int shift = 1;
   
   Print("symbol: ",symbol,"  timeframe: ",timeframe, "  maPeriod: ",maPeriod,"   maMethod: ",maMethod,"  appliedPrice: ",appliedPrice,"   shift: ",shift);
   int handle = iMA(symbol, timeframe, maPeriod, 0, maMethod, appliedPrice);
   if (handle == INVALID_HANDLE)
   {
      Print("Error creating iMA handle for ", symbol);
   }
   
   double buffer[3]; // 取最近3根K线数据
   if (CopyBuffer(handle, 0, shift, 3, buffer) <= 0)
   {
      Print("Error copying buffer for ", symbol);
   }
   
   rint("handle: ",handle);
   
   
}
   

//+------------------------------------------------------------------+
