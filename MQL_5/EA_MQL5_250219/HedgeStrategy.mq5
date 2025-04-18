//+------------------------------------------------------------------+
//|                                                      test_ea.mq5 |
//|                                  Copyright 2025, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2025, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| 15 分钟对冲策略：EURUSD + GBPUSD vs USDCHF                      |
//+------------------------------------------------------------------+
#property strict
#include <Trade\Trade.mqh>

// 交易品种
string symbols[] = {"EURUSD", "USDCHF", "GBPUSD"};
double lot_size_1 = 0.02;       // 交易手数
double lot_size_2 = 0.1;       // 交易手数
int ma_period = 10;          // 移动平均周期
int atr_period = 14;         // ATR 计算周期
int rsi_period = 14;         // RSI 计算周期
double loss_dis_p = 0;  // 止损倍数
double profit_dis_p = 0;  // 止盈倍数
string comment = "Hedge-1";
int magic_no = 100;
string profit_close = 5;


// 获取移动平均值
double GetMA(string symbol, ENUM_TIMEFRAMES tf, int period) {
    int ma_handle = iMA(symbol, tf, period, 0, MODE_SMA, PRICE_CLOSE);
    double ma_value[];
    if (CopyBuffer(ma_handle, 0, 0, 1, ma_value) <= 0) {
        Print("无法获取 MA 值: ", symbol);
        return 0;
    }
    return ma_value[0];
}

// 获取 ATR 值
double GetATR(string symbol, ENUM_TIMEFRAMES tf, int period) {
    int atr_handle = iATR(symbol, tf, period);
    double atr_value[];
    if (CopyBuffer(atr_handle, 0, 0, 1, atr_value) <= 0) {
        Print("无法获取 ATR 值: ", symbol);
        return 0;
    }
    return atr_value[0];
}

// 获取 RSI 值
double GetRSI(string symbol, ENUM_TIMEFRAMES tf, int period) {
    int rsi_handle = iRSI(symbol, tf, period, PRICE_CLOSE);
    double rsi_value[];
    if (CopyBuffer(rsi_handle, 0, 0, 1, rsi_value) <= 0) {
        Print("无法获取 RSI 值: ", symbol);
        return 50;  // 默认返回中性 RSI 值
    }
    return rsi_value[0];
}

// 确定交易方向（1=多头，-1=空头，0=无交易）
int GetTradeDirection() {
    double ma_eur = GetMA("EURUSD", PERIOD_M15, ma_period);
    double ma_gbp = GetMA("GBPUSD", PERIOD_M15, ma_period);
    double ma_chf = GetMA("USDCHF", PERIOD_M15, ma_period);

    double price_eur = SymbolInfoDouble("EURUSD", SYMBOL_BID);
    double price_gbp = SymbolInfoDouble("GBPUSD", SYMBOL_BID);
    double price_chf = SymbolInfoDouble("USDCHF", SYMBOL_BID);

    // 确保 USDCHF 反向
    bool eur_gbp_up = (price_eur > ma_eur) && (price_gbp > ma_gbp);
    bool usdchf_down = (price_chf < ma_chf);
    bool eur_gbp_down = (price_eur < ma_eur) && (price_gbp < ma_gbp);
    bool usdchf_up = (price_chf > ma_chf);

    if (eur_gbp_up && usdchf_down) return 1;  // 多头信号
    if (eur_gbp_down && usdchf_up) return -1; // 空头信号
    return 0;  // 无交易信号
}

// 计算 TP 和 SL
double GetPriceLevel(string symbol, double price, double atr, double multiplier, bool is_buy) {
    double point = SymbolInfoDouble(symbol, SYMBOL_POINT);
    double level = atr * multiplier * (is_buy ? 1 : -1);
    return price + level;
}
double atr_multiplier_sl = 1.5;  // 止损倍数
double atr_multiplier_tp = 3.0;  // 止盈倍数
// 交易执行


// 交易执行
void ExecuteTrade(int direction) {
   Print("direction: ",direction);
   if (direction == 0) return;

   for (int i = 0; i < ArraySize(symbols); i++) {
      string sym = symbols[i];
      Print("symbol:  ",sym);
      
      bool od_result = false;
      
      
      if (direction == 1) {  // 做多 EURUSD & GBPUSD, 做空 USDCHF
         Print("方向 1"); 
         if(sym == "EURUSD" || sym == "GBPUSD")
         {
              double ask=SymbolInfoDouble(sym,SYMBOL_ASK);
              Print("sym: ",sym, "   ask: ",ask); 
              
              
              while(!od_result){
                  double ask=SymbolInfoDouble(sym,SYMBOL_ASK);
                  Print("sym: ",sym, "   ask: ",ask);
                  od_result = Od_Send(sym,ORDER_TYPE_BUY, lot_size_1, ask,loss_dis_p,profit_dis_p,comment,magic_no);
              }   
         }
         else
         if(sym == "USDCHF")
         {     
               double bid=SymbolInfoDouble(sym,SYMBOL_BID);
               Print("sym: ",sym, "   bid: ",bid);
               
               while(!od_result){
                  double bid=SymbolInfoDouble(sym,SYMBOL_BID);
                  Print("sym: ",sym, "   bid: ",bid);
                  od_result = Od_Send(sym, ORDER_TYPE_SELL, lot_size_2, bid,loss_dis_p,profit_dis_p,comment,magic_no);
               }
          }
                    
      } 
      else 
      { 
         Print("方向 2");
         // 反向
         if(sym == "EURUSD" || sym == "GBPUSD")
         {
              while(!od_result){
                  double bid=SymbolInfoDouble(sym,SYMBOL_BID);
                  Print("sym: ",sym, "   bid: ",bid);
                  od_result = Od_Send(sym,ORDER_TYPE_SELL, lot_size_1, bid,loss_dis_p,profit_dis_p,comment,magic_no);
              }
         }
         else
         if(sym == "USDCHF")
         {
               while(!od_result){
                  double ask=SymbolInfoDouble(sym,SYMBOL_ASK);
                  Print("sym: ",sym, "   ask: ",ask);
                  od_result = Od_Send(sym, ORDER_TYPE_BUY, lot_size_2, ask,loss_dis_p,profit_dis_p,comment,magic_no);
               }
          }
          
      }
   }
}

void Close_Condition()
{
   double total_profit = 0;
   int count=0;
   int total=PositionsTotal(); 
   
   double pt = 0;
   CTrade trade;
   for(int i=total-1; i>=0; i--)
   {           
      ulong  position_ticket  = PositionGetTicket(i);                                      
      string position_symbol  = PositionGetString(POSITION_SYMBOL);            
      ulong  magic            = PositionGetInteger(POSITION_MAGIC);                                     
      string cmt              = PositionGetString(POSITION_COMMENT);
      double lots             = StringToDouble(DoubleToString(PositionGetDouble(POSITION_VOLUME),2));   
      double profit           = PositionGetDouble(POSITION_PROFIT);
      ENUM_ORDER_TYPE  type   = PositionGetInteger(POSITION_TYPE);
      
      if(magic_no==magic)
      {
         total_profit = total_profit + profit;
      }
   } 
   Print("total_profit: ",total_profit,"  profit_close: ",profit_close);
   if(total_profit > profit_close)
   {
      Order_Close_All(magic_no, comment);
   }
}

bool Od_Send(string symb, ENUM_ORDER_TYPE od_ty , double od_lots, double open_pri, double sl_p,double tp_p,string cmt,int m_n) { 
   // 交易请求
   bool od_send = false; 
   
   MqlTradeRequest request;
   MqlTradeResult result;
   ZeroMemory(request);
   ZeroMemory(result);
   
   
   if(od_ty==ORDER_TYPE_BUY || od_ty==ORDER_TYPE_SELL){ 
      request.action   =TRADE_ACTION_DEAL;}
   if(od_ty==ORDER_TYPE_BUY_STOP || od_ty==ORDER_TYPE_SELL_STOP || od_ty==ORDER_TYPE_BUY_LIMIT || od_ty==ORDER_TYPE_SELL_LIMIT )   { 
      request.action   =TRADE_ACTION_PENDING;} 
   
   double sl, tp;
   
   if(od_ty==ORDER_TYPE_BUY  || od_ty==ORDER_TYPE_BUY_STOP  || od_ty==ORDER_TYPE_BUY_LIMIT)
   {
      sl  = NormalizeDouble(open_pri-sl_p*Point(),5); 
      tp  = NormalizeDouble(open_pri+tp_p*Point(),5);
   }else
   if(od_ty==ORDER_TYPE_SELL || od_ty==ORDER_TYPE_SELL_STOP || od_ty==ORDER_TYPE_SELL_LIMIT)
   {
      sl  = NormalizeDouble(open_pri+sl_p*Point(),5); 
      tp  = NormalizeDouble(open_pri-tp_p*Point(),5);
   }
   if(sl_p==0 || DoubleToString(sl_p)=="")sl=0;
   if(tp_p==0 || DoubleToString(tp_p)=="")tp=0;
   
   
   request.type      = od_ty ;  
   request.symbol    = symb;                        
   request.volume    = od_lots;                      
   request.price     = open_pri; 
   request.deviation = 5;                            
   request.tp        = tp;
   request.sl        = sl;
   request.comment   = cmt;
   request.magic     = m_n;
   
   for(int i=0;i<4;i++){
      
      if(i==0)
      {
         request.type_filling = ORDER_FILLING_BOC;
      }
      if(i==1)
      {
         request.type_filling = ORDER_FILLING_FOK;
      }
      if(i==2)
      {
         request.type_filling = ORDER_FILLING_IOC;
      }
      if(i==3)
      {
         request.type_filling = ORDER_FILLING_RETURN;
      }
      
      od_send=OrderSend(request,result); 
      if(!od_send)
      {
         //Print(" GetLastError(): "+GetLastError()+"  i: ",i);   
      }else
      {
         Print(request.type_filling);   
         break;
      }
   }          
   
   return od_send;
} 

void Order_Close_All(string magic_no, string comment)
{
   int count=0;
   int total=PositionsTotal(); 
   
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
      
      if( magic== magic_no  && cmt == comment)
      {
         Print("position_ticket: ",position_ticket);
         if (!trade.PositionClose(position_ticket)) 
         {
             Print("平仓失败: ", position_ticket, " 错误代码: ", GetLastError());
         }
      }
   }   
}


// 交易管理
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
