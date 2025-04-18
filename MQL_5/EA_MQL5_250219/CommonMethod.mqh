//+------------------------------------------------------------------+
//|                                                 CommonMethod.mqh |
//|                                  Copyright 2025, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2025, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#include <Trade\Trade.mqh>
//+------------------------------------------------------------------+
//| defines                                                          |
//+------------------------------------------------------------------+
struct PositionInfo
{
   double lowestPrice;
   double highestPrice;
   ulong  lowestTicket;
   ulong  hihgestTicket;
   
   double lowestBuyPrice;
   double highestBuyPrice;
   ulong  lowestBuyTicket;
   ulong  hihgestBuyTicket;
   
   double lowestSellPrice;
   double highestSellPrice;
   ulong  lowestSellTicket;
   ulong  hihgestSellTicket;
   
   int count;
   int count_buy;
   int count_sell;
   
   double totalProfit;
   double buyProfit;
   double sellProfit;
};

struct LimitStopOrdersInfo
{
   int count_limit_buy  ;
   int count_limit_sell ;
   int count_stop_buy   ;
   int count_stop_sell  ;
   int count_total;
   
   double limit_lowestBuyPrice; 
   double limit_highestBuyPrice;
   ulong  limit_lowestBuyTicket;
   ulong  limit_hihgestBuyTicket;
   
   double limit_lowestSellPrice;
   double limit_highestSellPrice;
   ulong  limit_lowestSellTicket;
   ulong  limit_hihgestSellTicket;
   
   double stop_lowestBuyPrice;
   double stop_highestBuyPrice;
   ulong  stop_lowestBuyTicket;
   ulong  stop_hihgestBuyTicket;
   
   double stop_lowestSellPrice;
   double stop_highestSellPrice;
   ulong  stop_lowestSellTicket;
   ulong  stop_hihgestSellTicket; 
};

LimitStopOrdersInfo getLimitStopOrdersInfo(int od_mg, string symbol)
{
   int count_limit_buy  = 0;
   int count_limit_sell = 0;
   int count_stop_buy   = 0;
   int count_stop_sell  = 0;
   int count_total      = 0;
   int total=OrdersTotal(); 
   
   double limit_lowestBuyPrice = 0;
   double limit_highestBuyPrice = 0;
   ulong  limit_lowestBuyTicket = 0;
   ulong  limit_highestBuyTicket = 0;
   
   double limit_lowestSellPrice = 0;
   double limit_highestSellPrice = 0;
   ulong  limit_lowestSellTicket = 0;
   ulong  limit_highestSellTicket = 0;
   
   double stop_lowestBuyPrice = 0;
   double stop_highestBuyPrice = 0;
   ulong  stop_lowestBuyTicket = 0;
   ulong  stop_highestBuyTicket = 0;
   
   double stop_lowestSellPrice = 0;
   double stop_highestSellPrice = 0;
   ulong  stop_lowestSellTicket = 0;
   ulong  stop_highestSellTicket = 0;

   LimitStopOrdersInfo li;

   for(int i=total-1; i>=0; i--)
   {           
      ulong  order_ticket   = OrderGetTicket(i);                                      
      string order_symbol   = OrderGetString(ORDER_SYMBOL); 
      double order_op_price = OrderGetDouble(ORDER_PRICE_OPEN);                         
      ulong  magic             = OrderGetInteger(ORDER_MAGIC);                                  
      double lots              = OrderGetDouble(ORDER_VOLUME_CURRENT);    
      string cmt               = OrderGetString(ORDER_COMMENT);
      
      if(magic !=od_mg)continue;
      if(symbol != "" && order_symbol!=symbol)continue;                        
      
      ENUM_ORDER_TYPE type = (ENUM_ORDER_TYPE)OrderGetInteger(ORDER_TYPE);   
      
      if(magic == od_mg){
         if(type == ORDER_TYPE_BUY_LIMIT)
         {
            if(limit_lowestBuyPrice == 0 || limit_lowestBuyPrice > order_op_price) 
            {
               limit_lowestBuyPrice  = order_op_price;
               limit_lowestBuyTicket = order_ticket;
            }
            if(limit_highestBuyPrice == 0 || limit_highestBuyPrice < order_op_price) 
            {
               limit_highestBuyPrice  = order_op_price;
               limit_highestBuyTicket = order_ticket;
            }   
            count_limit_buy +=1;
            count_total +=1;
         }
         
         if(type == ORDER_TYPE_SELL_LIMIT)
         {
            if(limit_lowestSellPrice == 0 || limit_lowestSellPrice > order_op_price) 
            {
               limit_lowestSellPrice   = order_op_price;
               limit_lowestSellTicket  = order_ticket;
            }
            if(limit_highestSellPrice == 0 || limit_highestSellPrice < order_op_price) 
            {
               limit_highestSellPrice  = order_op_price;
               limit_highestSellTicket = order_ticket;
            }   
            count_limit_sell +=1;
            count_total +=1;
         }
         
         if(type == ORDER_TYPE_BUY_STOP)
         {
            if(stop_lowestBuyPrice == 0 || stop_lowestBuyPrice > order_op_price) 
            {
               stop_lowestBuyPrice   = order_op_price;
               stop_lowestBuyTicket  = order_ticket;
            }
            if(stop_highestBuyPrice == 0 || stop_highestBuyPrice < order_op_price) 
            {
               stop_highestBuyPrice  = order_op_price;
               stop_highestBuyTicket = order_ticket;
            }  
            count_stop_buy +=1;
            count_total +=1;
         } 
         
         if(type == ORDER_TYPE_SELL_STOP)
         {
            if(stop_lowestSellPrice == 0 || stop_lowestSellPrice > order_op_price) 
            {
               stop_lowestSellPrice   = order_op_price;
               stop_lowestSellTicket  = order_ticket;
            }
            if(stop_highestSellPrice == 0 || stop_highestSellPrice < order_op_price) 
            {
               stop_highestSellPrice  = order_op_price;
               stop_highestSellTicket = order_ticket;
            }   
            count_stop_sell +=1;
            count_total +=1;
         }                 
      }                           
   } 
   
   li.count_limit_buy  = count_limit_buy;
   li.count_limit_sell = count_limit_sell;
   li.count_stop_buy   = count_stop_buy;
   li.count_stop_sell  = count_stop_sell;

   li.limit_lowestBuyPrice = limit_lowestBuyPrice;
   li.limit_highestBuyPrice = limit_highestBuyPrice;
   li.limit_lowestBuyTicket = limit_lowestBuyTicket;
   li.limit_hihgestBuyTicket = limit_highestBuyTicket;
   
   li.limit_lowestSellPrice = limit_lowestSellPrice;
   li.limit_highestSellPrice = limit_highestSellPrice;
   li.limit_lowestSellTicket = limit_lowestSellTicket;
   li.limit_hihgestSellTicket = limit_highestSellTicket;
   
   li.stop_lowestBuyPrice = stop_lowestBuyPrice;
   li.stop_highestBuyPrice = stop_highestBuyPrice;
   li.stop_lowestBuyTicket = stop_lowestBuyTicket;
   li.stop_hihgestBuyTicket = stop_highestBuyTicket;
   
   li.stop_lowestSellPrice = stop_lowestSellPrice;
   li.stop_highestSellPrice = stop_highestSellPrice;
   li.stop_lowestSellTicket = stop_lowestSellTicket;
   li.stop_hihgestSellTicket = stop_highestSellTicket;
   li.count_total = count_total;
   
   return li;
}


PositionInfo getPositionInfo(int od_mg, string symbol)
{
   int count = 0;
   int count_buy  = 0;
   int count_sell = 0;
   int total=PositionsTotal(); 
   
   double lowestPrice = 0;
   double highestPrice = 0;
   ulong  lowestTicket = 0;
   ulong  hihgestTicket = 0;

   double lowestBuyPrice = 0;
   double highestBuyPrice = 0;
   ulong  lowestBuyTicket = 0;
   ulong  hihgestBuyTicket = 0;
   
   double lowestSellPrice = 0;
   double highestSellPrice = 0;
   ulong  lowestSellTicket = 0;
   ulong  hihgestSellTicket = 0;
      
   double totalProfit = 0;
   double buyProfit   = 0;
   double sellProfit  = 0;
   
   PositionInfo pi;

   for(int i=total-1; i>=0; i--)
   {           
      ulong  position_ticket   = PositionGetTicket(i);                                      
      string position_symbol   = PositionGetString(POSITION_SYMBOL); 
      double position_op_price = PositionGetDouble(POSITION_PRICE_OPEN);                         
      ulong  magic             = PositionGetInteger(POSITION_MAGIC);                                  
      double lots              = PositionGetDouble(POSITION_VOLUME);    
      string cmt               = PositionGetString(POSITION_COMMENT);    
      double position_profit   = PositionGetDouble(POSITION_PROFIT);                         
      
      ENUM_POSITION_TYPE type = (ENUM_POSITION_TYPE)PositionGetInteger(POSITION_TYPE);  
      if(magic !=od_mg)continue;
      if(symbol != "" && position_symbol != symbol)continue; 
      
      if(magic == od_mg){
         if((symbol != "" && position_symbol== symbol)||(symbol==""))
         {
            totalProfit = totalProfit+position_profit;
         }
         
         if(lowestPrice == 0 || lowestPrice > position_op_price) 
         {
            lowestPrice = position_op_price;
            lowestTicket = position_ticket;
         }
         if(highestPrice == 0 || highestPrice < position_op_price) 
         {
            highestPrice = position_op_price;
            hihgestTicket = position_ticket;
         }
         count +=1; 
         
         if(type == POSITION_TYPE_BUY)
         {
            if(lowestBuyPrice == 0 || lowestBuyPrice > position_op_price) 
            {
               lowestBuyPrice  = position_op_price;
               lowestBuyTicket = position_ticket;
            }
            if(highestBuyPrice == 0 || highestBuyPrice < position_op_price) 
            {
               highestBuyPrice  = position_op_price;
               hihgestBuyTicket = position_ticket;
            } 
            
            buyProfit = buyProfit + PositionGetDouble(POSITION_PROFIT);
            count_buy +=1;  
         }
         
         if(type == POSITION_TYPE_SELL)
         {
            if(lowestSellPrice == 0 || lowestSellPrice > position_op_price) 
            {
               lowestSellPrice  = position_op_price;
               lowestSellTicket = position_ticket;
            }
            if(highestSellPrice == 0 || highestSellPrice < position_op_price) 
            {
               highestSellPrice  = position_op_price;
               hihgestSellTicket = position_ticket;
            }  
            sellProfit = sellProfit + PositionGetDouble(POSITION_PROFIT);
            count_sell +=1; 
         }
      }                           
   } 
   
   pi.lowestPrice       = lowestPrice;
   pi.lowestTicket      = lowestTicket;
   pi.highestPrice      = highestPrice;
   pi.hihgestTicket     = hihgestTicket;
   pi.lowestBuyPrice    = lowestBuyPrice;
   pi.lowestBuyTicket   = lowestBuyTicket;
   pi.highestBuyPrice   = highestBuyPrice;
   pi.hihgestSellTicket = hihgestSellTicket;
   pi.count = count;
   pi.count_buy = count_buy;
   pi.count_sell = count_sell;
   pi.totalProfit = totalProfit;
   pi.buyProfit = buyProfit;
   pi.sellProfit = sellProfit;
   
   return pi;
}

int POSITION_Count(int od_mg)
{
   int count=0;
   int total=PositionsTotal(); 

   for(int i=total-1; i>=0; i--)
   {           
      ulong  position_ticket  = PositionGetTicket(i);                                      
      string position_symbol  = PositionGetString(POSITION_SYMBOL);                        
      ulong  magic            = PositionGetInteger(POSITION_MAGIC);                                  
      double lots             = PositionGetDouble(POSITION_VOLUME);    
      string cmt              = PositionGetString(POSITION_COMMENT);                             
      
      ENUM_POSITION_TYPE type = (ENUM_POSITION_TYPE)PositionGetInteger(POSITION_TYPE);   
      
      if(magic == od_mg){
         count++;
      }                           
   } 
   return count;
}

int POSITION_Count(int od_mg, int od_ty, string symbol)
{
   int count=0;
   int total=PositionsTotal(); 

   for(int i=total-1; i>=0; i--)
   {           
      ulong  position_ticket  = PositionGetTicket(i);                                      
      string position_symbol  = PositionGetString(POSITION_SYMBOL);                        
      ulong  magic            = PositionGetInteger(POSITION_MAGIC);    
      string cmt              = PositionGetString(POSITION_COMMENT);   
      long    type = PositionGetInteger(POSITION_TYPE);   
      
      if(magic == od_mg && type==od_ty && position_symbol==symbol){
         count++;
      }                           
   } 
   return count;
}

double POSITION_Profit(int od_mg)
{
   int count=0;
   int total=PositionsTotal(); 
   
   double pt = 0;
   
   for(int i=total-1; i>=0; i--)
   {           
      ulong  position_ticket  = PositionGetTicket(i);                                      
      string position_symbol  = PositionGetString(POSITION_SYMBOL);            
      ulong  magic            = PositionGetInteger(POSITION_MAGIC);                                     
      string cmt              = PositionGetString(POSITION_COMMENT);
      double profit           = StringToDouble(DoubleToString(PositionGetDouble(POSITION_PROFIT),2)); 
      
      if(magic == od_mg){
         pt=StringToDouble(DoubleToString((pt+profit),2));
      }                           
   }   
   
   return pt;
}

void Position_Close(ulong magic_num, string symbol)
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
      long   type             = PositionGetInteger(POSITION_TYPE);
      
      if( magic== magic_num  && position_symbol == symbol)
      {
         Print("position_ticket: ",position_ticket);
         if (!trade.PositionClose(position_ticket)) 
         {
             Print("平仓失败: ", position_ticket, " 错误代码: ", GetLastError());
         }
      }
   } 
}   

void Order_Delete(ulong magic_num,string symbol)
{
   int count=0;
   int total=OrdersTotal(); 
   
   double pt = 0;
   CTrade trade;
   for(int i=total-1; i>=0; i--)
   {           
      ulong  Order_ticket  = OrderGetTicket(i);                                      
      string Order_symbol  = OrderGetString(ORDER_SYMBOL);            
      ulong  magic         = OrderGetInteger(ORDER_MAGIC);                                    
      string cmt           = OrderGetString(ORDER_COMMENT);
      double lots          = StringToDouble(DoubleToString(OrderGetDouble(ORDER_VOLUME_CURRENT),2));   
      long   type          = OrderGetInteger(ORDER_TYPE);
      
      if(magic != magic_num || Order_symbol!=symbol) return;
      
      if (!trade.OrderDelete(Order_ticket)) 
      {
         Print("position_ticket: ",Order_ticket,"   position_symbol: ",Order_symbol,"type",type);
         Print("平仓失败: ", Order_ticket, " 错误代码: ", GetLastError());
      }
   }   
}



bool Od_Send(string symbol, ENUM_ORDER_TYPE od_ty , double od_lots, double open_pri, double sl_p,double tp_p,string cmt,int m_n) { 
   // 
   bool od_send = false; 
   
   MqlTradeRequest request;
   MqlTradeResult result;
   ZeroMemory(request);
   ZeroMemory(result);
  
   if(od_ty==ORDER_TYPE_BUY || od_ty==ORDER_TYPE_SELL){ 
      request.action   =TRADE_ACTION_DEAL;}
   if(od_ty==ORDER_TYPE_BUY_STOP || od_ty==ORDER_TYPE_SELL_STOP || od_ty==ORDER_TYPE_BUY_LIMIT || od_ty==ORDER_TYPE_SELL_LIMIT )   { 
      request.action   =TRADE_ACTION_PENDING;} 
   
   double sl=0, tp=0;
   
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
   
   
   if(symbol == "EURJPY")
   {
      Print("symb: ",symbol,"   sl: ",sl,"   tp:  ",tp);
      Print("symb: ",symbol,"   sl_p*Point(): ",sl_p*Point(),"   tp_p*Point():  ",tp_p*Point(), "  sl_p: ",sl_p,"   tp_p: ",tp_p);
   }
   
   
   request.type      = od_ty ;  
   request.symbol    = symbol;                        
   request.volume    = od_lots;                      
   request.price     = open_pri; 
   request.deviation = 5;                            
   request.tp        = tp;
   request.sl        = sl;
   request.comment   = cmt;
   request.magic     = m_n;
   request.type_filling = ORDER_FILLING_IOC;
   od_send=OrderSend(request,result); 
   
   if(!od_send)
   {
      Print(" GetLastError(): ",GetLastError());   
   }
   else
   {
      Print("Trade success!  Symbol:  "+symbol+"  od_ty: ",od_ty);
      Print(request.type_filling); 
   }
      
   
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
         Print(" GetLastError(): "+IntegerToString(GetLastError())+"  i: ",IntegerToString(i));   
      }else
      {
          Print("Trade success!  Symbol:  "+symbol+"  od_ty: ",od_ty);
         Print(request.type_filling);   
         break;
      }
   }        
   
   
   return od_send;
} 

string Double_Str(double num,int digit){
   string str_num;
   string num_c = DoubleToString(NormalizeDouble(num,digit));
   
   int st_f=StringFind(num_c,".");
   if(st_f<0)
      str_num = DoubleToString(num);
   else
      str_num = StringSubstr(num_c,0,StringFind(num_c,".")+1)+StringSubstr(num_c,StringFind(num_c,".")+1,digit); 
   return str_num;
}

void Dis_p_change(double profit_dis, double loss_dis, double &profit_dis_raw, double &loss_dis_raw){
   
   if(Symbol() == "GOLD" || Symbol() == "XAUUSD")
   {
      profit_dis_raw = profit_dis * 10;
      loss_dis_raw   = loss_dis * 10;
   }else
   {
      profit_dis_raw = profit_dis;
      loss_dis_raw   = loss_dis;
   }
}


