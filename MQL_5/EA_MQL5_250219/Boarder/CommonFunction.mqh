//+------------------------------------------------------------------+
//|                                               CommonFunction.mqh |
//|                        Copyright 2016, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

/*
   ------ 版本：17051601 -----
*/

#property copyright "Copyright 2016, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property strict


int Get_LowProfit_ticket(int orderType, int magic, string cmt){
   double topPrice  = 0;
   int    oTotal    = OrdersTotal();
   int    od_tic    = 0;
   double lowProfit = 0;
   
   for(int i=0; i<oTotal; i++){
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)){
         double od_pri   = OrderOpenPrice();
         int    od_ticet = OrderTicket();
         int    od_ty    = OrderType();
         int    od_magic = OrderMagicNumber();
         string od_cmt   = OrderComment();
         double od_pt    = OrderProfit();
         
         if(orderType==od_ty && od_cmt==cmt && od_magic==magic){
            if(lowProfit==0) 
            { 
               lowProfit=od_pt;
               od_tic=od_ticet;
               continue;
            }else
            if(od_pt<lowProfit)
            {
               lowProfit=od_pt;
               od_tic=od_ticet;
            }
         }
      }
   }
   return od_tic;
}

double Get_LowProfit(int orderType, int magic, string cmt){
   double topPrice  = 0;
   int    oTotal    = OrdersTotal();
   int    od_tic    = 0;
   double lowProfit = 0;
   
   for(int i=0; i<oTotal; i++){
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)){
         double od_pri   = OrderOpenPrice();
         int    od_ticet = OrderTicket();
         int    od_ty    = OrderType();
         int    od_magic = OrderMagicNumber();
         string od_cmt   = OrderComment();
         double od_pt    = OrderProfit();
         
         if(orderType==od_ty && od_cmt==cmt && od_magic==magic){
            if(lowProfit==0) 
            { 
               lowProfit=od_pt;
               continue;
            }else
            if(od_pt<lowProfit)
            {
               lowProfit=od_pt;
            }
         }
      }
   }
   
   return lowProfit;
}


double Get_TopPrice(int orderType){
   double topPrice=0;
   int    oTotal=OrdersTotal();
   int    od_tic=0;
   
   for(int i=0; i<oTotal; i++){
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)){
         double od_pri = OrderOpenPrice();
         int    od_ticet = OrderTicket();
         int    od_ty    = OrderType();
   
         if(orderType==od_ty){
            if(topPrice==0) { topPrice=od_pri;continue;}
            if(od_pri>topPrice){
              topPrice=od_pri;
              od_tic = od_ticet;
            }
         }
      }
   }
   return topPrice;
}

double Get_TopPrice(int orderType,int magic,string comment){
   double topPrice=0;
   int    oTotal=OrdersTotal();
   int    od_tic=0;
   
   for(int i=0; i<oTotal; i++){
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)){
         double od_pri = OrderOpenPrice();
         int    od_ticet = OrderTicket();
         int    od_ty    = OrderType();
         int    od_magic = OrderMagicNumber();
         string od_cmt   = OrderComment();
   
         if(orderType==od_ty && od_magic==magic && od_cmt==comment){
            if(topPrice==0) { topPrice=od_pri;continue;}
            if(od_pri>topPrice){
              topPrice=od_pri;
              od_tic = od_ticet;
            }
         }
      }
   }
   return topPrice;
}

double Get_TopPrice(int orderType, int magic){
   double topPrice=0;
   int    oTotal=OrdersTotal();
   int    od_tic=0;
   
   for(int i=0; i<oTotal; i++){
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)){
         double od_pri = OrderOpenPrice();
         int    od_ticet = OrderTicket();
         int    od_ty    = OrderType();
         int    od_magic = OrderMagicNumber();
         if(orderType==od_ty && od_magic==magic){
            if(topPrice==0) { topPrice=od_pri;continue;}
            if(od_pri>topPrice){
              topPrice=od_pri;
              od_tic = od_ticet;
            }
         }
      }
   }
   return topPrice;
}

double Get_LowPrice(int orderType){
   double lowPrice=0;
   int    oTotal=OrdersTotal();
   int    od_tic=0;
   
   for(int i=0; i<oTotal; i++){
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)){
         double od_pri = OrderOpenPrice();
         int    od_ticet = OrderTicket();
         int    od_ty    = OrderType();
         
         if(orderType==od_ty){
            if(lowPrice==0){ lowPrice=od_pri; continue;}
            if(od_pri<lowPrice){
              lowPrice=od_pri;
              od_tic=od_ticet;
            }
         }
      }
   }
   return lowPrice;
}

double Get_LowPrice(int orderType,int magic){
   double lowPrice=0;
   int    oTotal=OrdersTotal();
   int    od_tic=0;
   
   
   for(int i=0; i<oTotal; i++){
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)){
         double od_pri = OrderOpenPrice();
         int    od_ticet = OrderTicket();
         int    od_ty    = OrderType();
         int    od_magic = OrderMagicNumber();
         
         if(orderType==od_ty && od_magic == magic){
            if(lowPrice==0){ lowPrice=od_pri; continue;}
            if(od_pri<lowPrice){
              lowPrice=od_pri;
              od_tic=od_ticet;
            }
         }
      }
   }
   return lowPrice;
}

double Get_LowPrice(int orderType,int magic,string comment){
   double lowPrice=0;
   int    oTotal=OrdersTotal();
   int    od_tic=0;
   
   
   for(int i=0; i<oTotal; i++){
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)){
         double od_pri = OrderOpenPrice();
         int    od_ticet = OrderTicket();
         int    od_ty    = OrderType();
         int    od_magic = OrderMagicNumber();
         string od_cmt   = OrderComment();
         
         if(orderType==od_ty && od_magic == magic && od_cmt==comment){
            if(lowPrice==0){ lowPrice=od_pri; continue;}
            if(od_pri<lowPrice){
              lowPrice=od_pri;
              od_tic=od_ticet;
            }
         }
      }
   }
   return lowPrice;
}

double Od_Profit(int od_t){
   double pt=0;
   for(int i=0; i<OrdersTotal(); i++)
   {
      if((OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==true) && (OrderSymbol()==Symbol())){if(OrderType()==od_t) pt+=OrderProfit();}
   }
   return pt;
}

double Od_Profit_magic(int magic){
   double pt=0;
   
   for(int i=0; i<OrdersTotal(); i++)
   {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==true){
         int    od_magic = OrderMagicNumber();
         string od_symb  = OrderSymbol();
         int    od_ty    = OrderType();
         
         if(od_symb==Symbol() && od_magic==magic){
               pt+=OrderProfit();
         }
      }
   }
   return pt;
}

double Od_Profit(int magic, string comment){
   double pt=0;
   
   for(int i=0; i<OrdersTotal(); i++)
   {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==true){
         int    od_magic = OrderMagicNumber();
         string od_symb  = OrderSymbol();
         int    od_ty    = OrderType();
         string od_cmt   = OrderComment();
         
         if(od_symb==Symbol() && od_magic==magic && od_cmt==comment){
               pt+=OrderProfit();
         }
      }
   }
   return pt;
}

double Od_Profit(int type,int magic){
   double pt=0;
   
   for(int i=0; i<OrdersTotal(); i++)
   {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==true){
         int    od_magic = OrderMagicNumber();
         string od_symb  = OrderSymbol();
         int    od_ty    = OrderType();
         
         if(od_symb==Symbol() && od_ty==type  && od_magic==magic){
               pt+=OrderProfit();
         }
      }
   }
   return pt;
}

double Od_Profit_Point(int type){
   int pt_point=0;
   for(int i=0; i<OrdersTotal(); i++)
   {
      if((OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==true) && (OrderSymbol()==Symbol())){
         double od_penpri = OrderOpenPrice();
         int    od_ty     = OrderType();
         if(od_ty==type){ 
            if(type == OP_BUY){
               pt_point+=(Bid-od_penpri)/Point;
            }else
            if(type == OP_SELL){
               pt_point+=(od_penpri-Ask)/Point;
            }
         }
      }
   }
   return pt_point;
}

double Od_Profit_Point(int type,int magic){
   int pt_point=0;
   
   for(int i=0; i<OrdersTotal(); i++)
   {
      if((OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==true)){
         int od_magic     = OrderMagicNumber();
         double od_penpri = OrderOpenPrice();
         string od_symb   = OrderSymbol();
         int    od_ty     = OrderType();
         if(od_ty==type && od_magic==magic && od_symb==Symbol()){ 
            if(type == OP_BUY){
               pt_point+=(Bid-od_penpri)/Point;
            }else
            if(type == OP_SELL){
               pt_point+=(od_penpri-Ask)/Point;
            }
         }
      }
   }
   return pt_point;
}

double Od_Lots(int type){
   double Lots=0;
   for(int i=0; i<OrdersTotal(); i++)
   {
      if((OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==true) && (OrderSymbol()==Symbol())){if(OrderType()==type) Lots+=OrderLots();}
   }
   return Lots;
}

double Od_Lots(int type,int magic){
   double Lots  = 0;
   
   for(int i=0; i<OrdersTotal(); i++)
   {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==true){
         int    od_magic  = OrderMagicNumber();
         string od_symb   = OrderSymbol();
         int    od_ty     = OrderType();
         
         if(od_ty==type && od_magic==magic && od_symb==Symbol()){ 
            Lots+=OrderLots();
         }
      }
   }
   return Lots;
}

double Od_Count(int od_t){
   int count=0;
   for(int i=0; i<OrdersTotal(); i++)
   {
      if((OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==true) && (OrderSymbol()==Symbol())){if(OrderType()==od_t) count++;}
   }
   return count;
}

double Od_Count(int type,int magic){
   int count=0;
   int od_magic = OrderMagicNumber();
   
   for(int i=0; i<OrdersTotal(); i++)
   {
      if((OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==true)){
         int od_magic     = OrderMagicNumber();
         string od_symb   = OrderSymbol();
         int    od_ty     = OrderType();
         if(od_ty==type && od_magic==magic && od_symb==Symbol()){ 
            count++;
         }
      }
   }
   return count;
}

double Od_Count(int type,int magic,string comment){
   int count=0;
   
   for(int i=0; i<OrdersTotal(); i++)
   {
      if((OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==true)){
         int od_magic     = OrderMagicNumber();
         string od_symb   = OrderSymbol();
         int    od_ty     = OrderType();
         string od_cmt    = OrderComment();
         int od_tic       = OrderTicket();
         double od_lots   = OrderLots();
         
         if(od_ty==type && od_magic==magic && od_symb==Symbol() && od_cmt==comment){ 
            count++;
            
            
         }
      }
   }
   
   
   return count;
}

double T_Profit(int od_t){
   double pt=0;
   int   od_total=OrdersTotal();
   for(int i=0; i<od_total; i++)
   {
      if((OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==true))
      {
         if(OrderType()==od_t) pt+=OrderProfit();
      }
   }
   return pt;
}

double T_Profit(int type,int magic){
   double pt=0;
   int od_magic = OrderMagicNumber();
   int   od_total=OrdersTotal();
   
   for(int i=0; i<od_total; i++)
   {
      if((OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==true))
      {
         int od_magic     = OrderMagicNumber();
         string od_symb   = OrderSymbol();
         int    od_ty     = OrderType();
         if(od_ty==type && od_magic==magic && od_symb==Symbol()){ 
            pt+=OrderProfit();
         }
      }
   }
   return pt;
}

double T_Profit(int type,int magic,string comment){
   double pt=0;
   int od_magic = OrderMagicNumber();
   int   od_total=OrdersTotal();
   
   for(int i=0; i<od_total; i++)
   {
      if((OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==true))
      {
         int od_magic     = OrderMagicNumber();
         string od_symb   = OrderSymbol();
         int    od_ty     = OrderType();
         string od_cmt    = OrderComment();
         if(od_ty==type && od_magic==magic && od_symb==Symbol() && od_cmt==comment){ 
            pt+=OrderProfit();
         }
      }
   }
   return pt;
}

void Close_Order(int od_type){
   int n=2;
   int od_total = OrdersTotal();
   while(n){
      for(int i; i<od_total; i++){
         if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==true){
            string od_symb = OrderSymbol();
            int od_ty      = OrderType(); 
            int od_tic     = OrderTicket();
            double od_lots = OrderLots();
            
            if( od_ty==od_type ){
               OrderClose(od_tic,od_lots,OrderClosePrice(),3,Red); 
            }
         }
      }
      int count = 0;
      for(int j; j<od_total; j++){
         if(OrderSelect(j,SELECT_BY_POS,MODE_TRADES)==true){
            string od_symb = OrderSymbol();
            int od_ty      = OrderType(); 
            
            if( od_ty==od_type ){
               count++;
            }
         }         
      }
      n=count;
      if(count==0)break;
   } 
}

void Close_OrderByTicket(int od_ticket){
   int n=2;
   int od_total = OrdersTotal();
   
   for(int i; i<od_total; i++){
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==true){
         string od_symb = OrderSymbol();
         int od_ty      = OrderType(); 
         int od_tic     = OrderTicket();
         double od_lots = OrderLots();
        
         OrderClose(od_tic,od_lots,OrderClosePrice(),3,Red); 
      }
   }
}

void Close_Order(int od_type,int magic){
   int n=2;
   int od_total = OrdersTotal();
   while(n){
      for(int i; i<od_total; i++){
         if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==true){
            string od_symb = OrderSymbol();
            int od_ty      = OrderType(); 
            int od_tic     = OrderTicket();
            double od_lots = OrderLots();
            int od_magic   = OrderMagicNumber();
            
            if( od_ty==od_type && od_magic==magic){
               OrderClose(od_tic,od_lots,OrderClosePrice(),3,Red); 
            }
         }
      }
      int count = 0;
      for(int j; j<od_total; j++){
         if(OrderSelect(j,SELECT_BY_POS,MODE_TRADES)==true){
            string od_symb = OrderSymbol();
            int od_ty      = OrderType(); 
            int od_magic   = OrderMagicNumber();
            
            if( od_ty==od_type && od_magic==magic ){
               count++;
            }
         }         
      }
      n=count;
      if(count==0)break;
   } 
}

void Close_Order_Type(int od_type,int magic,string comment,double lots){
   int n=2;
   int od_total = OrdersTotal();
   while(n){
      for(int i; i<od_total; i++){
         if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==true){
            string od_symb = OrderSymbol();
            int od_ty      = OrderType(); 
            int od_tic     = OrderTicket();
            double od_lots = OrderLots();
            int od_magic   = OrderMagicNumber();
            string od_cmt  = OrderComment();
            
            if( od_ty==od_type && od_magic==magic && od_cmt==comment){
               OrderClose(od_tic,od_lots,OrderClosePrice(),3,Red); 
            }
         }
      }
      int count = 0;
      for(int j; j<od_total; j++){
         if(OrderSelect(j,SELECT_BY_POS,MODE_TRADES)==true){
            string od_symb = OrderSymbol();
            int od_ty      = OrderType(); 
            int od_magic   = OrderMagicNumber();
            string od_cmt  = OrderComment();
            
            if( od_ty==od_type && od_magic==magic && od_cmt==comment ){
               count++;
            }
         }         
      }
      n=count;
      if(count==0)break;
   } 
}


void Close_Order_Type(int od_type,int magic,string comment){
   int n=2;
   int od_total = OrdersTotal();
   while(n){
      for(int i; i<od_total; i++){
         if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==true){
            string od_symb = OrderSymbol();
            int od_ty      = OrderType(); 
            int od_tic     = OrderTicket();
            double od_lots = OrderLots();
            int od_magic   = OrderMagicNumber();
            string od_cmt  = OrderComment();
            
            if( od_ty==od_type && od_magic==magic && od_cmt==comment){
               OrderClose(od_tic,od_lots,OrderClosePrice(),3,Red); 
            }
         }
      }
      int count = 0;
      for(int j; j<od_total; j++){
         if(OrderSelect(j,SELECT_BY_POS,MODE_TRADES)==true){
            string od_symb = OrderSymbol();
            int od_ty      = OrderType(); 
            int od_magic   = OrderMagicNumber();
            string od_cmt  = OrderComment();
            
            if( od_ty==od_type && od_magic==magic && od_cmt==comment ){
               count++;
            }
         }         
      }
      n=count;
      if(count==0)break;
   } 
}
void Close_Order_All(){
   int n=2;
   int od_total = OrdersTotal();
   while(n){
      for(int i; i<od_total; i++){
         if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==true){
            string od_symb = OrderSymbol();
            int od_ty      = OrderType(); 
            int od_tic     = OrderTicket();
            double od_lots = OrderLots();
            if(od_ty==OP_BUY || od_ty==OP_SELL)
            OrderClose(od_tic,od_lots,OrderClosePrice(),3,Red); 
         }
      }
      
      int count = 0;
      for(int i; i<od_total; i++){
         if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==true){
            string od_symb = OrderSymbol();
            int od_ty      = OrderType(); 
            if(od_ty==OP_BUY || od_ty==OP_SELL)
            count++;
         }         
      }
      n=count;
      if(count==0)break;
   } 
}

void Close_Order_All(int magic){
   int n=2;
   int od_total = OrdersTotal();
   while(n){
      for(int i; i<od_total; i++){
         if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==true){
            string od_symb = OrderSymbol();
            int od_ty      = OrderType(); 
            int od_tic     = OrderTicket();
            double od_lots = OrderLots();
            int od_magic   = OrderMagicNumber();
            if(od_ty==OP_BUY || od_ty==OP_SELL)
            OrderClose(od_tic,od_lots,OrderClosePrice(),3,Red); 
         }
      }
      
      int count = 0;
      for(int i; i<od_total; i++){
         if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==true){
            string od_symb = OrderSymbol();
            int od_ty      = OrderType(); 
            int od_magic   = OrderMagicNumber();
            if(od_ty==OP_BUY || od_ty==OP_SELL){if(od_magic==magic)count++;};
         }         
      }
      n=count;
      if(count==0)break;
   } 
}
void Close_Order_All(int magic,string comment){
   int n=2;
   int od_total = OrdersTotal();
   while(n){
      for(int i; i<od_total; i++){
         if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==true){
            string od_symb = OrderSymbol();
            int od_ty      = OrderType(); 
            int od_tic     = OrderTicket();
            double od_lots = OrderLots();
            int od_magic   = OrderMagicNumber();
            string od_cmt  = OrderComment();
            if((od_ty==OP_BUY || od_ty==OP_SELL) && od_cmt==comment)
            OrderClose(od_tic,od_lots,OrderClosePrice(),3,Red); 
         }
      }
      
      int count = 0;
      for(int i; i<od_total; i++){
         if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==true){
            string od_symb = OrderSymbol();
            int od_ty      = OrderType(); 
            int od_magic   = OrderMagicNumber();
            string od_cmt  = OrderComment();
            if(od_ty==OP_BUY || od_ty==OP_SELL )
            {
               if(od_magic==magic &&  od_cmt==comment)
               count++;
            };
         }         
      }
      n=count;
      if(count==0)break;
   } 
}

void Delete_Order_All(){
   int n=2;
   int od_total = OrdersTotal();
   while(n){
      for(int i; i<od_total; i++){
         if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==true){
            int od_ty      = OrderType(); 
            int od_tic     = OrderTicket();
            
            if(od_ty==OP_BUYLIMIT || od_ty==OP_SELLLIMIT || od_ty==OP_BUYSTOP || od_ty==OP_SELLSTOP )
            OrderDelete(od_tic); 
         }
      }
      
      int count = 0;
      for(int i; i<od_total; i++){
         if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==true){
            int od_ty      = OrderType(); 
            if(od_ty==OP_BUYLIMIT || od_ty==OP_SELLLIMIT || od_ty==OP_BUYSTOP || od_ty==OP_SELLSTOP ){count++;};
         }         
      }
      n=count;
      if(count==0)break;
   } 
}

void Delete_Order_All(int magic){
   int n=2;
   int od_total = OrdersTotal();
   while(n){
      for(int i; i<od_total; i++){
         if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==true){
            string od_symb = OrderSymbol();
            int od_ty      = OrderType(); 
            int od_tic     = OrderTicket();
            double od_lots = OrderLots();
            int od_magic   = OrderMagicNumber();
            if(od_ty==OP_BUYLIMIT || od_ty==OP_SELLLIMIT || od_ty==OP_BUYSTOP || od_ty==OP_SELLSTOP )
            OrderDelete(od_tic); 
         }
      }
      
      int count = 0;
      for(int i; i<od_total; i++){
         if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==true){
            string od_symb = OrderSymbol();
            int od_ty      = OrderType(); 
            int od_magic   = OrderMagicNumber();
            if(od_ty==OP_BUYLIMIT || od_ty==OP_SELLLIMIT || od_ty==OP_BUYSTOP || od_ty==OP_SELLSTOP ){if(od_magic==magic)count++;};
         }         
      }
      n=count;
      if(count==0)break;
   } 
}

void Delete_Order_All(int type, int magic){
   int n=2;
   int od_total = OrdersTotal();
   while(n){
      for(int i; i<od_total; i++){
         if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==true){
            int od_ty      = OrderType(); 
            int od_tic     = OrderTicket();
            
            if(od_ty==type)
            {
               if(od_ty==OP_BUYLIMIT || od_ty==OP_SELLLIMIT || od_ty==OP_BUYSTOP || od_ty==OP_SELLSTOP )
               OrderDelete(od_tic);
            }
         }
      }
      
      int count = 0;
      for(int i; i<od_total; i++){
         if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==true){
            int od_ty      = OrderType(); 
            if(od_ty==type)
            {
               if(od_ty==OP_BUYLIMIT || od_ty==OP_SELLLIMIT || od_ty==OP_BUYSTOP || od_ty==OP_SELLSTOP ){count++;};
            }
         }         
      }
      n=count;
      if(count==0)break;
   } 
}

string Double_Str(double num,int digit){
   string str_num;
   string num_c = DoubleToString(NormalizeDouble(num,digit));
   
   int st_f=StringFind(num_c,".");
   if(st_f<0)
      str_num = num;
   else
      str_num = StringSubstr(num_c,0,StringFind(num_c,".")+1)+StringSubstr(num_c,StringFind(num_c,".")+1,digit); 
   return str_num;
}

int Od_Send(string symbol,int od_ty,double lots,double pri,double sl_p,double tp_p,string cmt,int m_n)
{  
   double sl, tp;
   if(od_ty==OP_BUY || od_ty==OP_BUYSTOP || od_ty==OP_BUYLIMIT)
   {
      sl  = NormalizeDouble(pri-sl_p*Point,Digits); 
      tp  = NormalizeDouble(pri+tp_p*Point,Digits);
   }else
   if(od_ty==OP_SELL || od_ty==OP_SELLSTOP || od_ty==OP_SELLLIMIT)
   {
      sl  = NormalizeDouble(pri+sl_p*Point,Digits); 
      tp  = NormalizeDouble(pri-tp_p*Point,Digits);
   }
   if(sl_p==0 || DoubleToString(sl_p)=="")sl=0;
   if(tp_p==0 || DoubleToString(tp_p)=="")tp=0;
   
   int ticket=OrderSend(symbol,od_ty,lots,NormalizeDouble(pri, Digits),3,sl,tp,cmt,m_n,0,Red); 
   return ticket;
}

void DeleteObjectDrawLine(string drawname)
{
   int n=2;
   int obj_total=ObjectsTotal(); 
   PrintFormat("Total %d objects",obj_total); 
   
   for(int i=obj_total-1;i>=0;i--) 
   { 
      string name=ObjectName(i); 
      int sf = StringFind(name,drawname,0);
      if(sf>-1){
         PrintFormat("object %d: %s",i,name); 
         ObjectDelete(name);
      } 
   } 
}