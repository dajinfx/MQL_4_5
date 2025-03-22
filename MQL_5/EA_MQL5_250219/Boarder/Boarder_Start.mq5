//+------------------------------------------------------------------+
//|                                                Boarder_Start.mq5 |
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
#include "BoardSet.mqh"

input int magic_no = 12;

int OnInit()
{
   
   return(INIT_SUCCEEDED);
}

void OnDeinit(const int reason)
{

   EventKillTimer();   
   DeleteObject();
}

input int x_r_v = 120;
input int y_r_v = 80;


void OnTick()
{
   Board_Edite_1(magic_no, x_r_v,  y_r_v);
}

void DeleteObject()
{
   int n=2;
   int obj_total=ObjectsTotal(0,0,-1); 
   PrintFormat("Total %d objects",obj_total); 
   
   for(int i=obj_total-1;i>=0;i--) 
   { 
      string name=ObjectName(0,i,-1,-1); 
      PrintFormat("object %d: %s",i,name); 
      ObjectDelete(0,name); 
   } 
}