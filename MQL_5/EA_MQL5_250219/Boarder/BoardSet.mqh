//+------------------------------------------------------------------+
//|                                                     BoardSet.mqh |
//|                        Copyright 2016, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2016, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property strict
#include <CommonMethod.mqh>

//20170606
void Board_Edite_1(int magic_no_1, int x_r_v, int y_r_v)
{
   int    board_width  = 190;
   int    board_heiht  = 255;
   
   int    x_r_1        = x_r_v ? x_r_v : 120;             // 左侧X轴位置
   int    y_r_1        = y_r_v ? y_r_v : 80;              // 左侧Y轴位置
   
   int    chart_ID     = 0;               // chart's ID
   int    sub_window   = 0;               // subwindow index

   string font_name    = "黑体";
   int    font_size    = 9;
   int    line_size    = 9;

   int    x_1          = x_r_1+8;
   int    y_1          = y_r_1+20;
   int    y_jianju     = 17;
   color  color_Code1  = C'207, 207, 207';
   
   PositionInfo pi_1   = getPositionInfo(magic_no_1,"");
   
   //---------------------------------------------------------- Account No
   string content_1    = " 账  号:";
   string content_1_v  = AccountInfoInteger(ACCOUNT_LOGIN);
   int    x_1_1        = x_1+90;
   //---------------------------------------------------------- Margic
   string content_2    = " Margic:";
   string content_2_v  = magic_no_1;
   int    x_2_1        = x_1+90;
   //---------------------------------------------------------- Balance 
   string content_3    = " 余  额:";
   string content_3_v  = Double_Str(AccountInfoDouble(ACCOUNT_BALANCE),2);  
   int    x_3_1        = x_2_1;    
   //---------------------------------------------------------- Equity
   string content_4    = " 净  值:";
   string content_4_v  = Double_Str(AccountInfoDouble(ACCOUNT_EQUITY),2);
   int    x_4_1        = x_2_1;   
   //---------------------------------------------------------- Take Profit
   string content_5    = " 盈  亏:";
   double take_profit  = pi_1.totalProfit;
   string content_5_v  = Double_Str(take_profit,2);
   int    x_5_1        = x_2_1;
   
   //---------------------------------------------------------- Take Profit   
   
   
   
   /*
   string content_5    = " 点  数:";
   double profit_point = (Od_Profit_Point(OP_BUY)/10+Od_Profit_Point(OP_SELL)/10);
   string content_5_v  = Double_Str(profit_point,2);
   int    x_5_1        = x_2_1;
   
   */
   color  color_Code4  = C'207, 207, 207';
   if(StringToDouble(content_4_v)>0)color_Code4="0, 255, 0";
   if(StringToDouble(content_4_v)<0)color_Code4="255, 48, 48"; 
   color  color_Code5  = C'207, 207, 207';
   if(StringToDouble(content_5_v)>0)color_Code5="0, 255, 0";
   if(StringToDouble(content_5_v)<0)color_Code5="255, 48, 48"; 
   /*
   //---------------------------------------------------------- Buy Lots
   string content_6    = " Buy 手数:";
   string content_6_v  = Od_Count(OP_BUY)+" / "+Double_Str(Od_Lots(OP_BUY),2);
   int    x_6_1        = x_2_1;
   color  color_Code6  = C'191, 239, 255';
   //---------------------------------------------------------- Sell Lots
   string content_7    = " Buy 盈亏:";
   double buy_profit   = NormalizeDouble(Od_Profit(OP_BUY),2);
   string content_7_v  = Double_Str(buy_profit,2);
   int    x_7_1        = x_2_1;
   //---------------------------------------------------------- Sell Lots
   
   string content_8    = " Buy 点数:";
   double buy_profit_p = Od_Profit_Point(OP_BUY)/10;
   string content_8_v  = Double_Str(buy_profit_p,2);
   int    x_8_1        = x_2_1;
   
   color  color_Code7  = C'191, 239, 255';
   color  color_Code8  = C'191, 239, 255';
   
   color  color_Code7_v  = C'207, 207, 207';
   if(StringToDouble(content_7_v)>0)color_Code7_v="0, 255, 0";
   if(StringToDouble(content_7_v)<0)color_Code7_v="255, 48, 48"; 
   color  color_Code8_v  = C'207, 207, 207';
   if(StringToDouble(content_8_v)>0)color_Code8_v="0, 255, 0";
   if(StringToDouble(content_8_v)<0)color_Code8_v="255, 48, 48"; 
   */
   //---------------------------------------------------------- Buy Lots
   /*
   string content_9   = " Sell 手数:";
   string content_9_v = Od_Count(OP_SELL)+" / "+Double_Str(Od_Lots(OP_SELL),2);
   int    x_9_1       = x_2_1;
   color  color_Code9 = C'255, 130, 71';  
   //---------------------------------------------------------- Sell Profit
   string content_10    = " Sell 盈亏:";
   double sell_profit   = NormalizeDouble(Od_Profit(OP_SELL),2);
   string content_10_v  = Double_Str(sell_profit,2);
   int    x_10_1        = x_2_1;
   //---------------------------------------------------------- Sell Profit
   string content_11    = " Sell 点数:";
   double sell_profit_p = Od_Profit_Point(OP_SELL)/10;
   string content_11_v  = Double_Str(sell_profit_p,2);
   int    x_11_1        = x_2_1;
   
   color  color_Code10  = C'255, 130, 71';
   color  color_Code11  = C'255, 130, 71';
   color  color_Code10_v= C'207, 207, 207';
   color  color_Code11_v= C'207, 207, 207';
   if(StringToDouble(content_10_v)>0)color_Code10_v=C'0, 255, 0';
   if(StringToDouble(content_10_v)<0)color_Code10_v=C'255, 48, 48';
   if(StringToDouble(content_11_v)>0)color_Code11_v=C'0, 255, 0';
   if(StringToDouble(content_11_v)<0)color_Code11_v=C'255, 48, 48';
   */
   
   string            recName="bs_c_panel_1";
   int               recWidth =board_width;
   int               recHeight=board_heiht;
   
   color             recBackColor=C'54  ,54  ,54 ';                  // Background color 
   ENUM_BORDER_TYPE  recBorder=BORDER_FLAT;                          // Border type 
   ENUM_BASE_CORNER  recCorner=CORNER_LEFT_UPPER;                    // Chart corner for anchoring 
   color             recBorderColor=C'54  ,54  ,54 ';                // Flat border color (Flat) 
   ENUM_LINE_STYLE   recStyle=STYLE_SOLID;                           // Flat border style (Flat) 
   int               recLineWidth=0;                                 // Flat border width (Flat) 
   bool              recBack=false;                                  // Background object 
   bool              recSelection=false;                             // Highlight to move 
   bool              recHidden=false;                                // Hidden in the object list 
   long              recZOrder=0;                                    // Priority for mouse click 
   
   CreateBoard(chart_ID,recName,0,x_r_1,y_r_1,recWidth,recHeight,recBackColor,recBorder,recCorner,recBorderColor,recStyle,recLineWidth,recBack,recSelection,recHidden,recZOrder);
   
   CreateLabel("AccountNo",       content_1,  font_size,font_name,color_Code1,  x_1,  y_1,y_jianju,CORNER_LEFT_UPPER,0);
   CreateLabel("AccountValue",    content_1_v,font_size,font_name,color_Code1,  x_1_1,y_1,y_jianju,CORNER_LEFT_UPPER,0);
   
   CreateBoard(chart_ID,"line_1",0,x_1+4,y_1+25,160,3,clrWhite,BORDER_SUNKEN,CORNER_LEFT_UPPER,clrBlack,STYLE_DOT,0,false,false,false,0);
   CreateLabel("Margic",          content_2,  font_size,font_name,color_Code1,  x_1,  y_1,y_jianju,CORNER_LEFT_UPPER,2);
   CreateLabel("MargicValue",     content_2_v,font_size,font_name,color_Code1,  x_2_1,y_1,y_jianju,CORNER_LEFT_UPPER,2);   
   
   CreateBoard(chart_ID,"line_2",0,x_1+4,y_1+55,160,3,clrWhite,BORDER_SUNKEN,CORNER_LEFT_UPPER,clrBlack,STYLE_DOT,0,false,false,false,0);
   CreateLabel("Balance",         content_3,  font_size,font_name,color_Code1,  x_1,  y_1,y_jianju,CORNER_LEFT_UPPER,4);
   CreateLabel("BalanceValue",    content_3_v,font_size,font_name,color_Code1,  x_3_1,y_1,y_jianju,CORNER_LEFT_UPPER,4); 
   
   
   CreateLabel("Equity",          content_4,  font_size,font_name,color_Code1,  x_1,  y_1,y_jianju,CORNER_LEFT_UPPER,5);
   CreateLabel("EquityValue",     content_4_v,font_size,font_name,color_Code4,  x_4_1,y_1,y_jianju,CORNER_LEFT_UPPER,5);
   
   CreateBoard(chart_ID,"line_3",0,x_1+4,y_1+105,160,3,clrWhite,BORDER_SUNKEN,CORNER_LEFT_UPPER,clrBlack,STYLE_DOT,0,false,false,false,0);
   CreateLabel("TakeProfit",      content_5,  font_size,font_name,color_Code1,  x_1,  y_1,y_jianju,CORNER_LEFT_UPPER,7);
   CreateLabel("TakeProfitValue", content_5_v,font_size,font_name,color_Code4,  x_5_1,y_1,y_jianju,CORNER_LEFT_UPPER,7);
   
   //CreateBoard(chart_ID,"line_3",0,x_1+4,y_1+110,160,3,clrWhite,BORDER_SUNKEN,CORNER_LEFT_UPPER,clrBlack,STYLE_DOT,0,false,false,false,0);
   //CreateLabel("BuyLots",          content_6,  font_size,font_name,color_Code6,  x_1,  y_1,y_jianju,CORNER_LEFT_UPPER,8);
   //CreateLabel("BuyLotsValue",     content_6_v,font_size,font_name,color_Code6,  x_6_1,y_1,y_jianju,CORNER_LEFT_UPPER,8);
   
   //CreateLabel("BuyProfit",        content_7,  font_size,font_name,color_Code7,  x_1,  y_1,y_jianju,CORNER_LEFT_UPPER,9);
   //CreateLabel("BuyProfitValue",   content_7_v,font_size,font_name,color_Code7_v,x_7_1,y_1,y_jianju,CORNER_LEFT_UPPER,9);
   //CreateLabel("BuyProfit_p",      content_8,  font_size,font_name,color_Code8,  x_1,  y_1,y_jianju,CORNER_LEFT_UPPER,10);
   //CreateLabel("BuyProfit_p_Value",content_8_v,font_size,font_name,color_Code8_v,x_8_1,y_1,y_jianju,CORNER_LEFT_UPPER,10);
   
   //CreateBoard(chart_ID,"line_4",0,x_1+4,y_1+170,160,3,clrWhite,BORDER_SUNKEN,CORNER_LEFT_UPPER,clrBlack,STYLE_DOT,0,false,false,false,0);
   
   //CreateLabel("SellLots",         content_9,  font_size,font_name,color_Code9,  x_1,  y_1,y_jianju,CORNER_LEFT_UPPER,12);
   //CreateLabel("SellLotsValue",    content_9_v,font_size,font_name,color_Code9,  x_9_1,y_1,y_jianju,CORNER_LEFT_UPPER,12);
   
   //CreateLabel("SellProfit",       content_10,  font_size,font_name,color_Code10,  x_1,  y_1,y_jianju,CORNER_LEFT_UPPER,13);
   //CreateLabel("SellProfitValue",  content_10_v,font_size,font_name,color_Code10_v,x_10_1,y_1,y_jianju,CORNER_LEFT_UPPER,13);
   //CreateLabel("SellProfit_p",     content_11,  font_size,font_name,color_Code11,  x_1,  y_1,y_jianju,CORNER_LEFT_UPPER,14);
   //CreateLabel("SellProfit_p_Value",content_11_v,font_size,font_name,color_Code11_v,x_11_1,y_1,y_jianju,CORNER_LEFT_UPPER,14);
    
}
/*
void Board_Edite_2()
{ 
   int               chart_ID     = 0;                     
   int               sub_window   = 0;                     
   int               x1           = 130;
   int               y1           = 20;
   int               y_jianju     = 13;   
   
   //----------------------------------------------------------    Board style
   string            recName      = "bs_c_panel_2";
   int               recWidth     = 100;
   int               recHeight    = 510;
   int               x_r_1        = x1;
   int               y_r_1        = y1;
   
   color             recBackColor=C'54  ,54  ,54 ';                // Background color 
   ENUM_BORDER_TYPE  recBorder=BORDER_FLAT;                        // Border type 
   ENUM_BASE_CORNER  recCorner=CORNER_RIGHT_UPPER;                 // Chart corner for anchoring 
   color             recBorderColor=C'54  ,54  ,54 ';              // Flat border color (Flat) 
   ENUM_LINE_STYLE   recStyle=STYLE_SOLID;                         // Flat border style (Flat) 
   int               recLineWidth=0;                               // Flat border width (Flat) 
   bool              recBack=false;                                // Background object 
   bool              recSelection=false;                           // Highlight to move 
   bool              recHidden=false;                              // Hidden in the object list 
   long              recZOrder=0;                                  // Priority for mouse click 
   ENUM_BASE_CORNER  t_corner     = CORNER_RIGHT_LOWER;            // chart corner for anchoring
   ENUM_ALIGN_MODE   align        = ALIGN_LEFT;
   bool              read_only    = false;   
   color             t_clr        = clrBlack;                      // text color
   color             t_back_clr   = C'236,233,216';                // background color
   color             t_border_clr = clrNONE;                       // border color
   
   //---------------------------------------------------------     Button style

   string            b_name_1     = "bt_do_once";                  // button name
   string            b_text_1     = "运行一次";                    // text
   int               x_b_1        = x_r_1-10;                      // X coordinate
   int               y_b_1        = y_r_1+25 ;                     // Y coordinate

   string            b_name_2     = "bt_stop_run";                 // button name
   string            b_text_2     = "停止运行";                    // text
   int               x_b_2        = x_b_1;                         // X coordinate
   int               y_b_2        = y_b_1+35 ;                     // Y coordinate

   string            b_name_3     = "bt_close_all";                // button name
   string            b_text_3     = "Close All";                   // text
   int               x_b_3        = x_b_1;                         // X coordinate
   int               y_b_3        = y_b_2+35 ;                     // Y coordinate
   
   string            b_name_4     = "bt_stop_fanpan";              // button name
   string            b_text_4     = "停止翻盘";                    // text
   int               x_b_4        = x_b_1;                         // X coordinate
   int               y_b_4        = y_b_3+35 ;                     // Y coordinate

   string            b_name_5     = "bt_close_buy";                // button name
   string            b_text_5     = "多单平仓";                    // text
   int               x_b_5        = x_b_1;                         // X coordinate
   int               y_b_5        = y_b_4+35 ;                     // Y coordinate

   string            b_name_6     = "bt_close_sell";               // button name
   string            b_text_6     = "空单平仓";                    // text
   int               x_b_6        = x_b_1;                         // X coordinate
   int               y_b_6        = y_b_5+35 ;                     // Y coordinate     
   
   string            b_name_7     = "bt_delete";                   // button name
   string            b_text_7     = "删除挂单";                    // text
   int               x_b_7        = x_b_1;                         // X coordinate
   int               y_b_7        = y_b_6+35 ;                     // Y coordinate
   
   string            b_name_8     = "bt_up_buy";                   // button name
   string            b_text_8     = "向上多单";                    // text
   int               x_b_8        = x_b_1;                         // X coordinate
   int               y_b_8        = y_b_7+35 ;                     // Y coordinate
   
   string            b_name_9     = "bt_down_buy";                 // button name
   string            b_text_9     = "向下多单";                    // text
   int               x_b_9        = x_b_1;                         // X coordinate
   int               y_b_9        = y_b_8+35 ;                     // Y coordinate
   
   string            b_name_10    = "bt_up_sell";                   // button name
   string            b_text_10    = "向上空单";                    // text
   int               x_b_10       = x_b_1;                         // X coordinate
   int               y_b_10       = y_b_9+35 ;                     // Y coordinate
   
   string            b_name_11    = "bt_down_sell";                 // button name
   string            b_text_11    = "向下空单";                    // text
   int               x_b_11       = x_b_1;                         // X coordinate
   int               y_b_11       = y_b_10+35 ;                    // Y coordinate
   
   string            b_name_12    = "bt_only_buy";                   // button name
   string            b_text_12    = "只多";                    // text
   int               x_b_12       = x_b_1;                         // X coordinate
   int               y_b_12       = y_b_11+35 ;                     // Y coordinate
   
   string            b_name_13    = "bt_only_sell";                 // button name
   string            b_text_13    = "只空";                    // text
   int               x_b_13       = x_b_1;                         // X coordinate
   int               y_b_13       = y_b_12+35 ;                    // Y coordinate

   int               b_width      = 80;                            // button width
   int               b_height     = 30;                            // button height
   ENUM_BASE_CORNER  b_corner     = CORNER_RIGHT_UPPER;            // chart corner for anchoring
   string            b_font       = "Arial";                       // font
   int               b_font_size  = 10;                            // font size
   color             b_clr        = clrBlack;                      // text color
   color             b_back_clr   = C'236,233,216';                // background color
   color             border_clr   = clrNONE;                       // border color
   bool              b_state      = false;                         // pressed/released
   long              z_order      = 0 ;                            // priority for mouse click
   
   bool              back         = false;                         // in the background
   bool              selection    = false;                         // highlight to move
   bool              hidden       = true;                          // hidden in the object list
      
   //---------------------------------------------------------     Set
   
   CreateBoard( chart_ID,recName,0,x_r_1,y_r_1,recWidth,recHeight,recBackColor,recBorder,recCorner,recBorderColor,recStyle,recLineWidth,recBack,recSelection,recHidden,recZOrder);

   CreateButton(chart_ID,b_name_1,sub_window,x_b_1,y_b_1,b_width,b_height,b_corner,b_text_1,b_font,b_font_size,b_clr,b_back_clr,border_clr,b_state,back,selection,hidden,z_order);
   CreateButton(chart_ID,b_name_2,sub_window,x_b_2,y_b_2,b_width,b_height,b_corner,b_text_2,b_font,b_font_size,b_clr,b_back_clr,border_clr,b_state,back,selection,hidden,z_order);
   CreateButton(chart_ID,b_name_3,sub_window,x_b_3,y_b_3,b_width,b_height,b_corner,b_text_3,b_font,b_font_size,b_clr,b_back_clr,border_clr,b_state,back,selection,hidden,z_order);
   CreateButton(chart_ID,b_name_4,sub_window,x_b_4,y_b_4,b_width,b_height,b_corner,b_text_4,b_font,b_font_size,b_clr,b_back_clr,border_clr,b_state,back,selection,hidden,z_order);
   CreateButton(chart_ID,b_name_5,sub_window,x_b_5,y_b_5,b_width,b_height,b_corner,b_text_5,b_font,b_font_size,b_clr,b_back_clr,border_clr,b_state,back,selection,hidden,z_order);
   CreateButton(chart_ID,b_name_6,sub_window,x_b_6,y_b_6,b_width,b_height,b_corner,b_text_6,b_font,b_font_size,b_clr,b_back_clr,border_clr,b_state,back,selection,hidden,z_order);
   CreateButton(chart_ID,b_name_7,sub_window,x_b_7,y_b_7,b_width,b_height,b_corner,b_text_7,b_font,b_font_size,b_clr,b_back_clr,border_clr,b_state,back,selection,hidden,z_order);
   
   CreateButton(chart_ID,b_name_8,sub_window,x_b_8,y_b_8,b_width,b_height,b_corner,b_text_8,b_font,b_font_size,b_clr,b_back_clr,border_clr,b_state,back,selection,hidden,z_order);
   CreateButton(chart_ID,b_name_9,sub_window,x_b_9,y_b_9,b_width,b_height,b_corner,b_text_9,b_font,b_font_size,b_clr,b_back_clr,border_clr,b_state,back,selection,hidden,z_order);
   CreateButton(chart_ID,b_name_10,sub_window,x_b_10,y_b_10,b_width,b_height,b_corner,b_text_10,b_font,b_font_size,b_clr,b_back_clr,border_clr,b_state,back,selection,hidden,z_order);
   CreateButton(chart_ID,b_name_11,sub_window,x_b_11,y_b_11,b_width,b_height,b_corner,b_text_11,b_font,b_font_size,b_clr,b_back_clr,border_clr,b_state,back,selection,hidden,z_order);
   
   CreateButton(chart_ID,b_name_12,sub_window,x_b_12,y_b_12,b_width,b_height,b_corner,b_text_12,b_font,b_font_size,b_clr,b_back_clr,border_clr,b_state,back,selection,hidden,z_order);
   CreateButton(chart_ID,b_name_13,sub_window,x_b_13,y_b_13,b_width,b_height,b_corner,b_text_13,b_font,b_font_size,b_clr,b_back_clr,border_clr,b_state,back,selection,hidden,z_order);
    
}
*/
/*
void Board_Edite_2()
{ 
   int               chart_ID     = 0;                     
   int               sub_window   = 0;                     
   int               x1           = 130;
   int               y1           = 15;
   int               y_jianju     = 13;   
   
   //----------------------------------------------------------    Board style
   string            recName      = "bs_c_panel_2";
   int               recWidth     = 100;
   int               recHeight    = 200;
   int               x_r_1        = x1;
   int               y_r_1        = y1;
   
   color             recBackColor=C'54  ,54  ,54 ';                // Background color 
   ENUM_BORDER_TYPE  recBorder=BORDER_FLAT;                        // Border type 
   ENUM_BASE_CORNER  recCorner=CORNER_RIGHT_UPPER;                 // Chart corner for anchoring 
   color             recBorderColor=C'54  ,54  ,54 ';              // Flat border color (Flat) 
   ENUM_LINE_STYLE   recStyle=STYLE_SOLID;                         // Flat border style (Flat) 
   int               recLineWidth=0;                               // Flat border width (Flat) 
   bool              recBack=false;                                // Background object 
   bool              recSelection=false;                           // Highlight to move 
   bool              recHidden=false;                              // Hidden in the object list 
   long              recZOrder=0;                                  // Priority for mouse click 
   ENUM_BASE_CORNER  t_corner     = CORNER_RIGHT_LOWER;            // chart corner for anchoring
   ENUM_ALIGN_MODE   align        = ALIGN_LEFT;
   bool              read_only    = false;   
   color             t_clr        = clrBlack;                      // text color
   color             t_back_clr   = C'236,233,216';                // background color
   color             t_border_clr = clrNONE;                       // border color
   
   //---------------------------------------------------------     Button style

   string            b_name_1     = "bt_do_once";                  // button name
   string            b_text_1     = "运行一次";                    // text
   int               x_b_1        = x_r_1-10;                      // X coordinate
   int               y_b_1        = y_r_1+25 ;                     // Y coordinate

   string            b_name_2     = "bt_stop_run";                 // button name
   string            b_text_2     = "停止运行";                    // text
   int               x_b_2        = x_b_1;                         // X coordinate
   int               y_b_2        = y_b_1+35 ;                     // Y coordinate

   string            b_name_3     = "bt_close_all";                // button name
   string            b_text_3     = "Close All";                   // text
   int               x_b_3        = x_b_1;                         // X coordinate
   int               y_b_3        = y_b_2+35 ;                     // Y coordinate
   
   string            b_name_4     = "bt_stop_fanpan";              // button name
   string            b_text_4     = "停止翻盘";                    // text
   int               x_b_4        = x_b_1;                         // X coordinate
   int               y_b_4        = y_b_3+35 ;                     // Y coordinate

   int               b_width      = 80;                            // button width
   int               b_height     = 30;                            // button height
   ENUM_BASE_CORNER  b_corner     = CORNER_RIGHT_UPPER;            // chart corner for anchoring
   string            b_font       = "Arial";                       // font
   int               b_font_size  = 10;                            // font size
   color             b_clr        = clrBlack;                      // text color
   color             b_back_clr   = C'236,233,216';                // background color
   color             border_clr   = clrNONE;                       // border color
   bool              b_state      = false;                         // pressed/released
   long              z_order      = 0 ;                            // priority for mouse click
   
   bool              back         = false;                         // in the background
   bool              selection    = false;                         // highlight to move
   bool              hidden       = true;                          // hidden in the object list
      
   //---------------------------------------------------------     Set
   
   CreateBoard( chart_ID,recName,0,x_r_1,y_r_1,recWidth,recHeight,recBackColor,recBorder,recCorner,recBorderColor,recStyle,recLineWidth,recBack,recSelection,recHidden,recZOrder);

   CreateButton(chart_ID,b_name_1,sub_window,x_b_1,y_b_1,b_width,b_height,b_corner,b_text_1,b_font,b_font_size,b_clr,b_back_clr,border_clr,b_state,back,selection,hidden,z_order);
   CreateButton(chart_ID,b_name_2,sub_window,x_b_2,y_b_2,b_width,b_height,b_corner,b_text_2,b_font,b_font_size,b_clr,b_back_clr,border_clr,b_state,back,selection,hidden,z_order);
   CreateButton(chart_ID,b_name_3,sub_window,x_b_3,y_b_3,b_width,b_height,b_corner,b_text_3,b_font,b_font_size,b_clr,b_back_clr,border_clr,b_state,back,selection,hidden,z_order);
   CreateButton(chart_ID,b_name_4,sub_window,x_b_4,y_b_4,b_width,b_height,b_corner,b_text_4,b_font,b_font_size,b_clr,b_back_clr,border_clr,b_state,back,selection,hidden,z_order);

}
*/

void CreateLabel(string l_name,string l_text,int l_fontsize,int l_fontname,color l_color,int x_size,int y_size,int y_jianju,ENUM_BASE_CORNER l_corner,int xy_size_code) 
{
   y_size=y_size+(y_jianju*xy_size_code);

   ObjectCreate(0,l_name,OBJ_LABEL,0,0,0);
   ObjectSetString(0,l_name,OBJPROP_TEXT,l_text);
   ObjectSetString(0,l_name,OBJPROP_FONT,l_fontname);
   ObjectSetInteger(0,l_name,OBJPROP_FONTSIZE,l_fontsize);
   ObjectSetInteger(0,l_name,OBJPROP_COLOR,l_color);
   ObjectSetInteger(0,l_name,OBJPROP_CORNER,l_corner);
   ObjectSetInteger(0,l_name,OBJPROP_XDISTANCE,x_size);
   ObjectSetInteger(0,l_name,OBJPROP_YDISTANCE,y_size);
   ObjectSetInteger(0,l_name,OBJPROP_SELECTED,false); 
   ObjectSetInteger(0,l_name,OBJPROP_SELECTABLE,false); 
}


void CreateEdit(int chart_ID, string name, int sub_window, int x, int y, int width, int height, ENUM_BASE_CORNER corner,string text,  
                 string font, int font_size, ENUM_ALIGN_MODE align, bool read_only,color clr,color back_clr, color border_clr, bool back, bool selection, bool hidden, int z_order)
{
   ObjectCreate(chart_ID,name,OBJ_EDIT,sub_window,0,0);
   ObjectSetString(chart_ID,name,OBJPROP_TEXT,text);
   ObjectSetString(chart_ID,name,OBJPROP_FONT,font);
   ObjectSetInteger(chart_ID,name,OBJPROP_XDISTANCE,x);
   ObjectSetInteger(chart_ID,name,OBJPROP_YDISTANCE,y);
   ObjectSetInteger(chart_ID,name,OBJPROP_XSIZE,width);
   ObjectSetInteger(chart_ID,name,OBJPROP_YSIZE,height);
   ObjectSetInteger(chart_ID,name,OBJPROP_CORNER,corner);
   ObjectSetInteger(chart_ID,name,OBJPROP_FONTSIZE,font_size);
   ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr);
   ObjectSetInteger(chart_ID,name,OBJPROP_BGCOLOR,back_clr);
   ObjectSetInteger(chart_ID,name,OBJPROP_BORDER_COLOR,border_clr);
   ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back);
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection);
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection);
   ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden);
   ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order);
}

void CreateButton(int chart_ID, string name, int sub_window, int x, int y, int width, int height, ENUM_BASE_CORNER corner,string text,  
                 string font, int font_size, color clr,color back_clr, color border_clr, bool state, bool back, bool selection, bool hidden, int z_order)
{
   ObjectCreate(chart_ID,name,OBJ_BUTTON,sub_window,0,0);
   ObjectSetString(chart_ID,name,OBJPROP_TEXT,text);
   ObjectSetString(chart_ID,name,OBJPROP_FONT,font);
   ObjectSetInteger(chart_ID,name,OBJPROP_XDISTANCE,x);
   ObjectSetInteger(chart_ID,name,OBJPROP_YDISTANCE,y);
   ObjectSetInteger(chart_ID,name,OBJPROP_XSIZE,width);
   ObjectSetInteger(chart_ID,name,OBJPROP_YSIZE,height);
   ObjectSetInteger(chart_ID,name,OBJPROP_CORNER,corner);
   ObjectSetInteger(chart_ID,name,OBJPROP_FONTSIZE,font_size);
   ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr);
   ObjectSetInteger(chart_ID,name,OBJPROP_BGCOLOR,back_clr);
   ObjectSetInteger(chart_ID,name,OBJPROP_BORDER_COLOR,border_clr);
   ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back);
   ObjectSetInteger(chart_ID,name,OBJPROP_STATE,state);
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection);
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection);
   ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden);
   ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order);
}

void CreateBoard(int chart_ID, string name, int sub_window, int x, int y, int width, int height,   
                 color back_clr, ENUM_BORDER_TYPE border,ENUM_BASE_CORNER corner,color clr,ENUM_LINE_STYLE  style,int line_width,bool back, bool selection, bool hidden, int z_order)
{
   ObjectCreate(chart_ID,name,OBJ_RECTANGLE_LABEL,sub_window,0,0);
   ObjectSetInteger(chart_ID,name,OBJPROP_XDISTANCE,x); 
   ObjectSetInteger(chart_ID,name,OBJPROP_YDISTANCE,y);  
   ObjectSetInteger(chart_ID,name,OBJPROP_XSIZE,width); 
   ObjectSetInteger(chart_ID,name,OBJPROP_YSIZE,height); 
   ObjectSetInteger(chart_ID,name,OBJPROP_BGCOLOR,back_clr); 
   ObjectSetInteger(chart_ID,name,OBJPROP_BORDER_TYPE,border); 
   ObjectSetInteger(chart_ID,name,OBJPROP_CORNER,corner); 
   ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr); 
   ObjectSetInteger(chart_ID,name,OBJPROP_STYLE,style);
   ObjectSetInteger(chart_ID,name,OBJPROP_WIDTH,line_width); 
   ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back); 
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection); 
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection); 
   ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden);  
   ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order); 
   ObjectSetInteger(chart_ID,name,OBJPROP_BACK,false); 
}

