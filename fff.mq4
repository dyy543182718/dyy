
//extern double StopLossPoint = 600;//定义止损点数
//#property script_show_inputs
extern double DecreaseFactor = 2;//定义设置初始最大可滑点数
extern double 倍数=2.25;
extern double BeginningBalancesPercentage = 0.06;
int start()
{
 double gao=iHigh(NULL,PERIOD_D1,1);
 double di=iLow(NULL,PERIOD_D1,1);
 double sl=(gao-di)/Point;
   PercentageTrading_OP_BUY(sl);//调用下方自定义函数变量
   return(0);
}

//+------------------------------------------------------------------+

double PercentageTrading(double zijin,double sll)// 按余额的百分比，计算下单手数 的 自定义函数
{

   return (AccountBalance()*zijin /sll);
}

//+------------------------------------------------------------------+

//定义即将开仓的交易，需要 占用 期初余额的百分比 是多少

//+------------------------------------------------------------------+

void PercentageTrading_OP_BUY(double sl)// 将 “按余额百分之多少 开 多单 ”下单代码 封装成自定义函数，start模块调用
{

   int ticket;
   double ProfitPoint = sl *倍数;//定义止盈点数为StopLossPoint（止损点数）的 倍数，即1：该数字为盈亏比，也就是赔率
   double Lots = PercentageTrading(BeginningBalancesPercentage,sl);//下单手数为当前激活脚本时，按账户余额的N计算最大亏损Y，除以止损点数后下单，详见最后面自定义函数
   Lots = NormalizeDouble(Lots,2);//保留下单Lots手数的后两位小数点，即下单至“0.01”位，若平台不允许操作0.01手报错，来这里调整
 


      ticket = OrderSend(Symbol(), OP_BUY,Lots,Ask,0,Ask - sl * Point,Ask + ProfitPoint * Point, "开多单", 0, 0, DeepPink);
      if(ticket<0)
        { 
         Print("失败原因=",GetLastError());
        }

   

   
}

