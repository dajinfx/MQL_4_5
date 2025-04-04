//+------------------------------------------------------------------+
//|                                                      DrawLine.mq5 |
//|                        Copyright 2023, MetaQuotes Software Corp. |
//|                                             https://www.metaquotes.net/ |
//+------------------------------------------------------------------+
#property copyright "Copyright 2023, MetaQuotes Software Corp."
#property link      "https://www.metaquotes.net/"
#property version   "1.00"
#property script_show_inputs

input string LineName = "UpCross";  // 线的名称
input color  LineColor = clrYellow;             // 线的颜色
input int    LineWidth = 1;                 // 线宽
input ENUM_LINE_STYLE LineStyle = STYLE_SOLID; // 线型
input int point  = 1000;

//+------------------------------------------------------------------+
//| 脚本程序开始函数                                               |
//+------------------------------------------------------------------+
void OnStart()
{
   // 获取当前价格(使用买入价)
   double price = SymbolInfoDouble(_Symbol, SYMBOL_BID);
   
   // 创建水平线
   ObjectCreate(0, LineName, OBJ_HLINE, 0, 0, price+point*Point());
   
   // 设置线属性
   ObjectSetInteger(0, LineName, OBJPROP_COLOR, LineColor);
   ObjectSetInteger(0, LineName, OBJPROP_WIDTH, LineWidth);
   ObjectSetInteger(0, LineName, OBJPROP_STYLE, LineStyle);
   ObjectSetInteger(0, LineName, OBJPROP_SELECTABLE, true);  // 使线可选中
   ObjectSetInteger(0, LineName, OBJPROP_SELECTED, true);    // 自动选中新创建的线
   
   // 将线移动到图表最前面
   ObjectSetInteger(0, LineName, OBJPROP_ZORDER, 0);
   
   // 更新图表
   ChartRedraw();
   
   // 显示信息
   Print("在价格 ", DoubleToString(price, _Digits), " 创建水平线");
}