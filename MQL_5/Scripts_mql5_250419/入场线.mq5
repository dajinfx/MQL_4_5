//+------------------------------------------------------------------+
//|                                                          入场线.mq4 |
//|                        Copyright 2017, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2017, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
void OnStart()
{
   string hname  = "line_entry_"+TimeToString(TimeCurrent())+":"+TimeToString(TimeCurrent());
   double price  = SymbolInfoDouble(Symbol(),SYMBOL_ASK);
   color  lcolor = clrRed;
   int    width  = 1;
   ENUM_LINE_STYLE style = STYLE_SOLID;
   
   HLineCreate(0,hname,0,price,lcolor,style,width, false,true,true,0);
}

bool HLineCreate(long chart_ID, string name, int sub_window,double price,color clr,ENUM_LINE_STYLE style,int width, bool back,bool selection,bool hidden,long z_order)         
{ 
   if(!ObjectCreate(chart_ID,name,OBJ_HLINE,sub_window,0,price)) 
     { 
      Print(__FUNCTION__, 
            ": failed to create a horizontal line! Error code = ",GetLastError()); 
      return(false); 
     } 
         
   ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr); 
   ObjectSetInteger(chart_ID,name,OBJPROP_STYLE,style); 
   ObjectSetInteger(chart_ID,name,OBJPROP_WIDTH,width);  
   ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back); 
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection); 
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection); 
   ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden); 
   ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order); 
   return(true); 
}

