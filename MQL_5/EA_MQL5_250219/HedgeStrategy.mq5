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

// 交易品种
string symbols[] = {"EURUSD", "USDCHF", "GBPUSD"};
double lot_size = 0.1;       // 交易手数
int ma_period = 10;          // 移动平均周期
int atr_period = 14;         // ATR 计算周期
int rsi_period = 14;         // RSI 计算周期
double loss_dis_p = 200;  // 止损倍数
double profit_dis_p = 300;  // 止盈倍数
string comment = "Hedge-1";
int magic_no = 100;



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

// 交易执行
void ExecuteTrade(int direction) {
   if (direction == 0) return;

   Print("test123");
   for (int i = 0; i < ArraySize(symbols); i++) {
      string sym = symbols[i];
      Print("symbol:  ",sym);
      
      bool od_result = false;
      
      
      if (direction == 1) {  // 做多 EURUSD & GBPUSD, 做空 USDCHF
           
         if(sym == "EURUSD" || sym == "GBPUSD")
         {
              double ask=SymbolInfoDouble(sym,SYMBOL_ASK);
              Print("sym: ",sym, "   ask: ",ask); 
              
              
              while(!od_result){
                  double ask=SymbolInfoDouble(sym,SYMBOL_ASK);
                  Print("sym: ",sym, "   ask: ",ask);
                  od_result = Od_Send(sym,ORDER_TYPE_BUY, lot_size, ask,loss_dis_p,profit_dis_p,comment,magic_no);
              }   
         }
         else
         if(sym == "USDCHF")
         {     
               double bid=SymbolInfoDouble(sym,SYMBOL_BID);
               Print("sym: ",sym, "   bid: ",bid);
               /*
               while(!od_result){
                  double bid=SymbolInfoDouble(sym,SYMBOL_BID);
                  Print("sym: ",sym, "   bid: ",bid);
                  od_result = Od_Send(sym, ORDER_TYPE_SELL, lot_size, bid,loss_dis_p,profit_dis_p,comment,magic_no);
               }
               */
          }
                    
      } 
      else 
      {  
         /*// 反向
         if(sym == "EURUSD" || sym == "GBPUSD")
         {
              while(!od_result){
                  double bid=SymbolInfoDouble(sym,SYMBOL_BID);
                  Print("sym: ",sym, "   bid: ",bid);
                  od_result = Od_Send(sym,ORDER_TYPE_SELL, lot_size, bid,loss_dis_p,profit_dis_p,comment,magic_no);
              }
         }
         else
         if(sym == "USDCHF")
         {
               while(!od_result){
                  double ask=SymbolInfoDouble(sym,SYMBOL_ASK);
                  Print("sym: ",sym, "   ask: ",ask);
                  od_result = Od_Send(sym, ORDER_TYPE_BUY, lot_size, ask,loss_dis_p,profit_dis_p,comment,magic_no);
               }
          }
          */
      }
   }
}






bool Od_Send(string symb, ENUM_ORDER_TYPE od_ty , double od_lots, double open_pri, double sl_p,double tp_p,string cmt,int m_n) { 
               
   MqlTradeRequest request;
   MqlTradeResult  result;
   
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
   
   Print("symb: ",symb, "    od_ty: ", od_ty, "   open_pri: ",open_pri, "  sl: ",sl, "  tp: ",tp);
   
   request.type      = od_ty ;  
   request.symbol    = symb;                        
   request.volume    = od_lots;                      
   request.price     = open_pri; 
   request.deviation = 5;                            
   request.tp        = tp;
   request.sl        = sl;
   request.comment   = cmt;
   request.magic     = m_n;
   
   bool od_send  = false;
   
   od_send=OrderSend(request,result);
   
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
         Print(" GetLastError(): "+GetLastError()+"  i: ",i);   
      }else
      {
         Print(request.type_filling);   
         break;
      }
   }
   return od_send;
} 

// 交易管理
void OnTick() {
    int direction = GetTradeDirection();
    Print("test123  fuck you! ");
    ExecuteTrade(direction);
    
}
