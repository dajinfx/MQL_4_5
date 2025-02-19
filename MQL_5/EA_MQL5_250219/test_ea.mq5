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
#include <CommonMethod.mqh>

int OnInit()
  {
   return(INIT_SUCCEEDED);
  }

void OnDeinit(const int reason)
  {

   
  }

void OnTick()
{
   string f = "hello world!";
   string t_str = test_return(f);
   //Print(t_str);
   
   double low_pri; 
   ulong  ticket;
   Low_Position_Price(ORDER_TYPE_BUY, 101,"Scripts_mql5_buy", low_pri, ticket);
   
   Print("low_pri: ",low_pri, "  ticket: ",ticket);
   
}

string result(string para1="12", string para2="hello")
{
   string p1 = para1;
   string pw = para2;
   
   return pw;
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
   
   request.type      = od_ty ;  
   request.symbol    = symb;                        
   request.volume    = od_lots;                      
   request.price     = open_pri; 
   request.deviation = 5;                            
   request.tp        = tp;
   request.sl        = sl;
   request.comment   = cmt;
   request.magic     = m_n;
   
   request.type_filling = ORDER_FILLING_IOC;
   
   bool od_send=OrderSend(request,result); 
   if(!od_send)
   {
      Print(" GetLastError(): "+GetLastError());   
   }
   
   return od_send;
} 
