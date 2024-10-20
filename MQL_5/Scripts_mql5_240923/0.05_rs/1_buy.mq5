//+------------------------------------------------------------------+
//|                                                        1_buy.mq5 |
//|                                  Copyright 2024, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2024, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+


double Lots=0.05;
string symbol_type;
double deal_point;
int magic_no = 101;
double profit_dis_p = 500;
double loss_dis_p = 200;

void OnStart()
{
   double ask1=SymbolInfoDouble(Symbol(),SYMBOL_ASK);
   bool od_result = Od_Send(Symbol(),ORDER_TYPE_BUY, Lots, ask1,loss_dis_p,profit_dis_p,"Scripts_mql5_buy",magic_no);
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
