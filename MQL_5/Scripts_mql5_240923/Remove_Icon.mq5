//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
void OnStart()
  {
   // 获取当前图表上的对象总数
   int total_objects = ObjectsTotal(0);
   
   // 遍历所有对象
   for(int i = 0; i<total_objects; i++)
     {
      // 获取对象的名称
      string obj_name = ObjectName(0,i,0,-1);
      
      //Print(i,"-----",obj_name,"   total_objects: ",total_objects);
      
      
      if(obj_name==OBJ_ARROW_UP){
         Print("obj_name---------------------------  : ",obj_name);
      }
      
     }
     
     
     
  }
//+------------------------------------------------------------------+
