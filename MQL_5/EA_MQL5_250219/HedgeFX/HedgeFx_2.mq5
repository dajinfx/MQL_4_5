//+------------------------------------------------------------------+
//|                                                    HedgeFx_1.mq5 |
//|                                  Copyright 2025, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2025, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
#include <Trade\Trade.mqh>
#include <Files\FileTxt.mqh>
#include <CommonMethod.mqh>

struct CurrencyPair
{
   string currency1; 
   string currency2; 
   float  multLots; 
};
CurrencyPair groups[];

string symbol_type;
double deal_point;
input double baseLots = 0.01;
input int magic_no = 12;
input double od_tp_p = 0;
input double od_sl_p = 0;
input string od_cmt  = "对冲策略";
input double closeCondition = 6;

int groupsSignal[3] = {1, 1, 1};  //作用是为了可以手动设置初始值信号 ， 1 表示currency1 直接做多，-1 表示currency1 直接做空， 0 表示根据singanl 交易 

ENUM_TIMEFRAMES timeframe = PERIOD_H1;

int OnInit()
{
   ArrayResize(groups, 3);
   
   //  >2
   groups[0].currency1  = "AUDJPY";
   groups[0].currency2  = "NZDJPY";
   groups[0].multLots   = 1;   // 1 正相关, -1表示负相关
   
   groups[1].currency1  = "SGDJPY";
   groups[1].currency2  = "USDJPY";
   groups[1].multLots   = 1;   // 1 正相关, -1表示负相关
   
   groups[2].currency1  = "CHFJPY";
   groups[2].currency2  = "EURJPY";
   groups[2].multLots   = 1;   // 1 正相关, -1表示负相关
   

   return(INIT_SUCCEEDED);
}
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
{
   ResizePair();
   for (int i = 0; i < ArraySize(groups); i++)
   {
      Print("currency1: ", groups[i].currency1, " currency2: ", groups[i].currency2);
   }
}


void OnTick()
{
   // ResizePair();
   // Output each currency pair
   for (int i = 0; i < ArraySize(groups); i++)
   {
      string Symbol_1 = groups[i].currency1;
      PositionInfo pi_1 = getPositionInfo(magic_no,Symbol_1);
   
      string Symbol_2 = groups[i].currency2;
      PositionInfo pi_2 = getPositionInfo(magic_no,Symbol_2);
      
      int nenueal_signalcounts =  0;
      for(int i = 0; i < ArraySize(groups); i++)
      {
         if(groupsSignal[i]!=0)
         {nenueal_signalcounts++;}
      }
      
      int signal = 0;
      
      if(nenueal_signalcounts>0)
      {
         //groupsSignal 作用是为了可以手动设置初始值信号
         if( groupsSignal[i] != 0 )
         {
            Print("groupsSignal: ",groupsSignal[i]);
            signal = groupsSignal[i];
         }        
      }
      else
      {
         signal = Od_Signal(groups[i].currency1, groups[i].currency2, groups[i].multLots);
      }

      
      
      Print("signal: ",signal,"   groups[i].currency1: ",groups[i].currency1);
      if( signal)
      {
         int pi_1_count = pi_1.count;
         int pi_2_count = pi_2.count;
         
         Print("pi_1_count: ",pi_1_count," pi_2_count: ",pi_2_count);
         if(pi_1_count==0 && pi_2_count==0)
         {
            Order_Set(groups[i].currency1, groups[i].currency2, groups[i].multLots,signal);
         }
         
      }
   }
   
   bool PositionCloseCondition = PositionCloseCondition();
   if(PositionCloseCondition)
   {
      PositionCloseAll();
   }

}


void ResizePair()
{
   int currentSize = ArraySize(groups);
   ArrayResize(groups, currentSize + 1);
   groups[currentSize].currency1 = "NZDUSD";
   groups[currentSize].currency2 = "CADUSD";
   groups[currentSize].multLots = 0;
}

// 计算交易信号  在这里汇集所有的指标信号
int Od_Signal(string currency1, string currency2, double multLots)
{
   int signal = 0;
   
   //在此的函数中得到的是各个指标中获取的信号值，均线，macd 或者其他指标中得到值在这里聚合
   int signal_mavalue = signal_mavalue( currency1, currency2, multLots);
   int signal_cci = signal_cci( currency1, currency2, multLots);
   //signal_atrvalue( currency1, currency2, multLots);
   
   if(signal_cci) signal=signal_cci;
   
   return signal;
}

int signal_cci(string currency1, string currency2, double multLots)
{
   int CCI_Period = 14;
   int appliedPrice = PRICE_TYPICAL;
   int signal = 0;
   int yuzhi = 100;

   // currency1 的 CCI 值
   int cciHandle1 = iCCI(currency1, timeframe, CCI_Period, appliedPrice);
   if (cciHandle1 == INVALID_HANDLE)
   {
      Print("Failed to create CCI for ", currency1);
      return 0;
   }
   double cciValues1[];
   if (CopyBuffer(cciHandle1, 0, 0, 5, cciValues1) != 5)
   {
      Print("Failed to get CCI data for ", currency1);
      IndicatorRelease(cciHandle1);
      return 0;
   }
   IndicatorRelease(cciHandle1);
   double cciCurrent1 = cciValues1[3];  //离现在的bar最近的
   double cciPrevious1 = cciValues1[1]; //最远的
   
   
   bool overbought1 = ( cciCurrent1 > yuzhi); //超买，卖信号
   bool oversold1 = (cciCurrent1 < -yuzhi);   //超卖，买信号
 
   // currency2 的 CCI 值
   int cciHandle2 = iCCI(currency2, timeframe, CCI_Period, appliedPrice);
   if (cciHandle2 == INVALID_HANDLE)
   {
      Print("Failed to create CCI for ", currency2);
      return 0;
   }
   double cciValues2[];
   if (CopyBuffer(cciHandle2, 0, 0, 5, cciValues2) != 5)
   {
      Print("Failed to get CCI data for ", currency2);
      IndicatorRelease(cciHandle2);
      return 0;
   }
   IndicatorRelease(cciHandle2);
   double cciCurrent2 = cciValues2[3];
   double cciPrevious2 = cciValues2[1];
   bool overbought2 = (cciPrevious2 < yuzhi );
   bool oversold2 = (cciPrevious2 > -yuzhi );

   // 信号逻辑  >0 正相关 反方向，<0 负相关 同方向
   if (multLots > 0)
   {
      if (overbought1) signal = -1;  // currency1 空单， currency2 多单
      else if (oversold1) signal = 1;  // currency1 多单，currency2 空单
   }
   else
   {
      if (overbought1 ) signal = -1;  // currency1 空单，currency2 空单
      else if (oversold1) signal = 1;  // currency1 多单，currency2 多单
   }
   
   return signal;
}


double signal_atrvalue(string symbol_1, string symbol_2, int multLots)
{
   int signal = 0;        // 交易信号
   double atrMultiplier = 2.0; 
   double atr1 = GetATR(symbol_1, timeframe, 14) * atrMultiplier;
   double atr2 = GetATR(symbol_2, timeframe, 14) * atrMultiplier;
   
   Print("symbol_1: ",symbol_1,"   atr1:  ",atr1);
   Print("symbol_2: ",symbol_2,"   atr2:  ",atr2);
   return signal;
}


//获得均线的信号值
int signal_mavalue(string currency1, string currency2, double multLots)
{
   int shortPeriod = 10;  // 短周期均线
   int longPeriod = 30;   // 长周期均线
   int signal = 0;        // 交易信号

   ENUM_MA_METHOD maMethod = MODE_LWMA;
   ENUM_APPLIED_PRICE appliedPrice = PRICE_CLOSE;

   
   // 获取 currency1 的均线值
   double maShort1 =  NormalizeDouble(GetMAValue(currency1, timeframe, shortPeriod, maMethod, appliedPrice, 1), 5);
   double maLong1  =  NormalizeDouble(GetMAValue(currency1, timeframe, longPeriod, maMethod, appliedPrice, 1), 5);
   
   double prevMaShort1 =  NormalizeDouble(GetMAValue(currency1, timeframe, shortPeriod, maMethod, appliedPrice, 2), 5);
   double prevMaLong1  =  NormalizeDouble(GetMAValue(currency1, timeframe, longPeriod, maMethod, appliedPrice, 2), 5);
   
   /*
   if(currency1=="GBPUSD")
      Print("currency1： ",currency1,"   maShort1: ",maShort1,"  maLong1: ",DoubleToString(maLong1,5),"  prevMaShort1: ",prevMaShort1,"  prevMaLong1: ",prevMaLong1);
   */

   // 获取 currency2 的均线值
   double maShort2 = GetMAValue(currency2, timeframe, shortPeriod, maMethod, appliedPrice, 1);
   double maLong2  = GetMAValue(currency2, timeframe, longPeriod, maMethod, appliedPrice, 1);
   double prevMaShort2 = GetMAValue(currency2, timeframe, shortPeriod, maMethod, appliedPrice, 2);
   double prevMaLong2  = GetMAValue(currency2, timeframe, longPeriod, maMethod, appliedPrice, 2);

   // 判断金叉与死叉
   bool crossUp1  = (prevMaShort1 < prevMaLong1) && (maShort1 > maLong1); // currency1 金叉
   bool crossDown1 = (prevMaShort1 > prevMaLong1) && (maShort1 < maLong1); // currency1 死叉

   bool crossUp2  = (prevMaShort2 < prevMaLong2) && (maShort2 > maLong2); // currency2 金叉
   bool crossDown2 = (prevMaShort2 > prevMaLong2) && (maShort2 < maLong2); // currency2 死叉

   if (multLots > 0)//正相关时， 反向做单
   {
      if (crossUp1 && crossDown2) signal = 1; // currency1 多单，currency2 空单
      else if (crossDown1 && crossUp2) signal = -1; // currency1 空单，currency2 多单
   }
   else
   {
      if (crossUp1 && crossUp2) signal = 1; // currency1 多单，currency2 多单
      else if (crossDown1 && crossDown2) signal = -1; // currency1 空单，currency2 空单
   }
   
   return signal;
}


void Order_Set(string symbol_1, string symbol_2, double multLots , int signal)
{
   double od_lots = 0;
   bool Od_Result_1 = false;
   bool Od_Result_2 = false;
   
   if(signal == 1 )//symbol 1  buy,   symbol 2 sell，  symbol 1 低买高卖
   {
      if(multLots>0) //正相关品种
      {
         Print("1 !!!");
         od_lots = baseLots * multLots; 
         double ask1=SymbolInfoDouble(symbol_1,SYMBOL_ASK); 
         double ask2=SymbolInfoDouble(symbol_2,SYMBOL_BID);
         
         Od_Result_1 = Od_Send(symbol_1,ORDER_TYPE_BUY,  baseLots, ask1,od_sl_p,od_tp_p,od_cmt,magic_no); //symbol 1  buy,   symbol 2 sell
         Od_Result_2 = Od_Send(symbol_2,ORDER_TYPE_SELL, baseLots, ask2,od_sl_p,od_tp_p,od_cmt,magic_no); //symbol 1  sell,   symbol 2 buy   *方向相反
      } 
      else  //负相关品种
      {
         Print("2 !!!");
         od_lots = baseLots * multLots * (-1);
         
         double ask1=SymbolInfoDouble(symbol_1,SYMBOL_ASK); 
         double ask2=SymbolInfoDouble(symbol_2,SYMBOL_ASK);
         
         Od_Result_1 = Od_Send(symbol_1,ORDER_TYPE_BUY, baseLots, ask1,od_sl_p,od_tp_p,od_cmt,magic_no); 
         Od_Result_2 = Od_Send(symbol_2,ORDER_TYPE_BUY, baseLots, ask2,od_sl_p,od_tp_p,od_cmt,magic_no);
      }
      
   }
   else
   if(signal == -1 )//symbol 1  sell,   symbol 2 buy，  symbol 1 高卖低买
   {
      if(multLots>0)
      {
         Print("3 !!!");
         od_lots = baseLots * multLots; 
         double ask1=SymbolInfoDouble(symbol_1,SYMBOL_BID); 
         double ask2=SymbolInfoDouble(symbol_2,SYMBOL_ASK);
         
         Od_Result_1 = Od_Send(symbol_1,ORDER_TYPE_SELL, baseLots, ask1,od_sl_p,od_tp_p,od_cmt,magic_no); 
         Od_Result_2 = Od_Send(symbol_2,ORDER_TYPE_BUY , baseLots, ask2,od_sl_p,od_tp_p,od_cmt,magic_no); 

      }
      else
      {
         Print("4 !!!");
         od_lots = baseLots * multLots * (-1);
         
         double ask1=SymbolInfoDouble(symbol_1,SYMBOL_BID); 
         double ask2=SymbolInfoDouble(symbol_2,SYMBOL_BID);
         
         Od_Result_1 = Od_Send(symbol_1,ORDER_TYPE_SELL,  baseLots, ask1,od_sl_p,od_tp_p,od_cmt,magic_no); 
         Od_Result_2 = Od_Send(symbol_2,ORDER_TYPE_SELL , baseLots, ask2,od_sl_p,od_tp_p,od_cmt,magic_no); 
      }
   }
}


// 获取均线值
double GetMAValue(string symbol, ENUM_TIMEFRAMES tf, int maPeriod, ENUM_MA_METHOD maMethod, ENUM_APPLIED_PRICE appliedPrice, int shift)
{
   //Print("symbol: ",symbol,"  timeframe: ",timeframe, "  maPeriod: ",maPeriod,"   maMethod: ",maMethod,"  appliedPrice: ",appliedPrice,"   shift: ",shift);
   int handle = iMA(symbol, tf, maPeriod, 0, maMethod, appliedPrice);
   
   //Print("handle: ",handle);
   if (handle == INVALID_HANDLE)
   {
      Print("Error creating iMA handle for ", symbol);
      return 0.0;
   }
   
   double buffer[3]; // 取最近3根K线数据
   if (CopyBuffer(handle, 0, shift, 3, buffer) <= 0)
   {
      Print("Error copying buffer for ", symbol);
      return 0.0;
   }
   return buffer[1]; // 返回当前K线的均线值
}


double GetATR(string symbol,ENUM_TIMEFRAMES tf, int period)
{
   int handle = iATR(symbol, tf, period);
   if (handle == INVALID_HANDLE) return 0.0;
   double buffer[];
   if (CopyBuffer(handle, 0, 0, 1, buffer) > 0)
      return buffer[0];
   return 0.0;
}

bool PositionCloseCondition()
{
   double profit_total = POSITION_Profit(magic_no);
   
   //Print("profit_total: ",profit_total,"  closeCondition: ",closeCondition);
   if( profit_total > closeCondition ) return true;
   
   return false;
}

void PositionCloseAll()
{
   int count=0;
   int total=PositionsTotal(); 
   
   //Print("total: ",total);
   double pt = 0;
   CTrade trade;
   for(int i=total-1; i>=0; i--)
   {           
      ulong  position_ticket  = PositionGetTicket(i);                                      
      string position_symbol  = PositionGetString(POSITION_SYMBOL);            
      ulong  magic            = PositionGetInteger(POSITION_MAGIC);                                     
      string cmt              = PositionGetString(POSITION_COMMENT);
      double lots             = StringToDouble(DoubleToString(PositionGetDouble(POSITION_VOLUME),2));  
      long   type             = PositionGetInteger(POSITION_TYPE);
      
      if( magic == magic_no )
      {
         if (!trade.PositionClose(position_ticket)) 
         {
             Print("平仓失败: ", position_ticket, " 错误代码: ", GetLastError());
         }
      }
   }  
}