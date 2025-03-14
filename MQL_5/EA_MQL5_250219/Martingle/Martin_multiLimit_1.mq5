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
int distance_point      = 50; 
int start_distance      = 50;

double start_price_buy  = 0;
double start_price_sell = 0;

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
   PositionInfo pi_1        = getPositionInfo(magic_no,symb);
   LimitStopOrdersInfo li_1 = getLimitStopOrdersInfo(magic_no, symb);
   
   int count_pi_1 = pi_1.count;
   int count_li_1 = li_1.count_total;
   
   if(count_pi_1==0 && count_li_1==0)
   {
      ExecuteTrade();
   }
   
   bool close_condition = PositionCloseCondition();
   if(close_condition) Order_Close_All(magic_no, symb);
   
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
      Print("step  1 ");
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
}


// 交易管理
/*
void OnTick() {
   int direction = GetTradeDirection();
    
   int count=0;
   int total=PositionsTotal(); 
   
   double pt = 0;
   
   for(int i=total-1; i>=0; i--)
   {           
      ulong  position_ticket  = PositionGetTicket(i);                                      
      string position_symbol  = PositionGetString(POSITION_SYMBOL);            
      ulong  magic            = PositionGetInteger(POSITION_MAGIC);                                     
      string cmt              = PositionGetString(POSITION_COMMENT);
      double lots             = StringToDouble(DoubleToString(PositionGetDouble(POSITION_VOLUME),2));   
      ENUM_ORDER_TYPE  type   = PositionGetInteger(POSITION_TYPE);
      
      if(magic==magic_no)
      {
         count = count+1;
      }                          
   }  
   Close_Condition();
   if(count>12) return;
   ExecuteTrade(direction);
   
}
*/






 