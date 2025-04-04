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

input double baseLots = 0.01;
string symbol_type;
double deal_point;

double od_tp_p = 0;
double od_sl_p = 0;
string od_cmt  = "对冲策略_2";
double closeCondition = 5;

input int magic_no_1 = 12;
input int magic_no_2 = 22;

ENUM_TIMEFRAMES timeframe = PERIOD_H1;

int OnInit()
{
   ArrayResize(groups, 3);
   
   //  >2
   groups[0].currency1  = "AUDJPY";
   groups[0].currency2  = "NZDJPY";
   groups[0].multLots   = 1;
   
   groups[1].currency1  = "SGDJPY";
   groups[1].currency2  = "USDJPY";
   groups[1].multLots   = 1;
   
   groups[2].currency1  = "CHFJPY";
   groups[2].currency2  = "EURJPY";
   groups[2].multLots   = 1;

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
      PositionInfo pi_1 = getPositionInfo(magic_no_1,Symbol_1);
   
      string Symbol_2 = groups[i].currency2;
      PositionInfo pi_2 = getPositionInfo(magic_no_1,Symbol_2);
      
      int count_buy_1  = pi_1.count_buy;
      int count_sell_1 = pi_1.count_sell;
      
      int count_buy_2  = pi_2.count_buy;
      int count_sell_2 = pi_2.count_sell;
      
      PositionInfo pi_1_1 = getPositionInfo(magic_no_2,Symbol_1);
      PositionInfo pi_2_1 = getPositionInfo(magic_no_2,Symbol_2);
      
      int count_symbol_1 = pi_1_1.count;
      int count_symbol_2 = pi_2_1.count;
      
      
      double ask=SymbolInfoDouble(Symbol_1,SYMBOL_ASK); 
      double bid=SymbolInfoDouble(Symbol_2,SYMBOL_BID);
      
      
      if(count_symbol_1==0 && count_symbol_2==0)
      {
         if(count_buy_1>0 || count_sell_1>0) 
         {
            if(count_buy_1>0 || count_sell_1==0)
            {
               
               int Od_Result_1 = Od_Send(Symbol_1,ORDER_TYPE_SELL,  baseLots, bid,od_sl_p,od_tp_p,od_cmt,magic_no_2);
            }
            else
            if(count_buy_1==0 || count_sell_1>0)
            {
               int Od_Result_2 = Od_Send(Symbol_1,ORDER_TYPE_BUY,  baseLots, ask,od_sl_p,od_tp_p,od_cmt,magic_no_2);
            }
         }
         
         if(count_buy_2>0 || count_sell_2>0) 
         {
            if(count_buy_2>0 || count_sell_2==0)
            {
               
               int Od_Result_3 = Od_Send(Symbol_2,ORDER_TYPE_SELL,  baseLots, bid,od_sl_p,od_tp_p,od_cmt,magic_no_2);
            }
            else
            if(count_buy_2==0 || count_sell_2>0)
            {
               int Od_Result_4 = Od_Send(Symbol_2,ORDER_TYPE_BUY,  baseLots, ask,od_sl_p,od_tp_p,od_cmt,magic_no_2);
            }
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

bool PositionCloseCondition()
{
   double profit_total = POSITION_Profit(magic_no_2);
   
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
      
      if( magic == magic_no_2 )
      {
         if (!trade.PositionClose(position_ticket)) 
         {
             Print("平仓失败: ", position_ticket, " 错误代码: ", GetLastError());
         }
      }
   }  
}