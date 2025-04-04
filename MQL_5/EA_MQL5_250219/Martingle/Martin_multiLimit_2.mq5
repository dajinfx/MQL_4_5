//+------------------------------------------------------------------+
//|                                          Martin_multiLimit_1.mq5 |
//|                                  Copyright 2025, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2025, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
//+------------------------------------------------------------------+
//| Expert initialization function       
//Martin_multiLimit_1 基础上，添加触发，当价格穿越上下预制的横线时，进行触发                      |
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

input bool trigger_Line = 1;
input string LineUpName = "UpCross";
input string LineDownName  = "DownCross" 

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
         int signal = Od_Signal(Symbol(), baseLots);
         
         if(signal)
         {
            ExecuteTrade();
         }
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
   
   int crossSignal = CheckCrossLines();
   if(crossSignal) signal=crossSignal;
   
   return signal;
}

int CheckCrossLines()
{
    // 检查是否存在两条线
    bool upLineExists = ObjectFind(0, "crossUp") >= 0;
    bool downLineExists = ObjectFind(0, "crossDown") >= 0;
    
    if(!upLineExists && !downLineExists)
    {
        Print("未找到crossUp或crossDown线");
        return 0;
    }
    
    // 获取当前价格
    double currentAsk = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
    double currentBid = SymbolInfoDouble(_Symbol, SYMBOL_BID);
    
    // 获取前一根K线的收盘价
    double prevClose = iClose(_Symbol, _Period, 1);
    
    // 检查crossUp线穿越
    if(upLineExists)
    {
        double crossUpPrice = ObjectGetDouble(0, "crossUp", OBJPROP_PRICE);
        
        // 上根K线收盘价在crossUp之下且当前价格在crossUp之上
        if(prevClose < crossUpPrice && currentAsk > crossUpPrice)
        {
            Print("ASK价格向上穿越crossUp线");
            return 1;
        }
    }
    
    // 检查crossDown线穿越
    if(downLineExists)
    {
        double crossDownPrice = ObjectGetDouble(0, "crossDown", OBJPROP_PRICE);
        
        // 上根K线收盘价在crossDown之上且当前价格在crossDown之下
        if(prevClose > crossDownPrice && currentBid < crossDownPrice)
        {
            Print("BID价格向下穿越crossDown线");
            return 1;
        }
    }
    
    return 0;
}

bool PositionCloseCondition()
{
   double profit_total = POSITION_Profit(magic_no);
   
   //Print("profit_total: ",profit_total,"  closeCondition: ",closeCondition);
   if( profit_total > closeCondition ) return true;
   
   return false;
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








 