//+------------------------------------------------------------------+
//|                                                          ATP.mq5 |
//|                        Copyright 2018, MetaQuotes Software Corp. |
//|                                                 https://mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2018, MetaQuotes Software Corp."
#property link      "https://mql5.com"
#property version   "1.00"
#property indicator_separate_window
#property indicator_buffers 3
#property indicator_plots   3
//--- plot ATP
#property indicator_label1  "ATP"
#property indicator_type1   DRAW_LINE
#property indicator_color1  clrDodgerBlue
#property indicator_style1  STYLE_SOLID
#property indicator_width1  1
//--- plot UP
#property indicator_label2  "Up"
#property indicator_type2   DRAW_LINE
#property indicator_color2  clrLimeGreen
#property indicator_style2  STYLE_SOLID
#property indicator_width2  1
//--- plot DN
#property indicator_label3  "Down"
#property indicator_type3   DRAW_LINE
#property indicator_color3  clrRed
#property indicator_style3  STYLE_SOLID
#property indicator_width3  1
//--- enums
enum ENUM_INPUT_YES_NO
  {
   INPUT_YES   =  1, // Yes
   INPUT_NO    =  0  // No
  };
//--- input parameters
input uint              InpPeriodUP =  14;         // Period Up
input uint              InpPeriodDN =  10;         // Period Down
input uint              InpPeriod   =  24;         // Period
input ENUM_INPUT_YES_NO InpShowUpDn =  INPUT_NO;   // Show lines Up and Down
//--- indicator buffers
double         BufferATP[];
double         BufferUP[];
double         BufferDN[];
//--- global variables
int            period_up;
int            period_dn;
int            period;

//

#include <AZ-INVEST/CustomBarConfig.mqh>

//

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- setting global variables
   period=int(InpPeriod<1 ? 1 : InpPeriod);
   period_up=int(InpPeriodUP<1 ? 1 : InpPeriodUP);
   period_dn=int(InpPeriodDN<1 ? 1 : InpPeriodDN);
//--- indicator buffers mapping
   SetIndexBuffer(0,BufferATP,INDICATOR_DATA);
   SetIndexBuffer(1,BufferUP,INDICATOR_DATA);
   SetIndexBuffer(2,BufferDN,INDICATOR_DATA);
//--- settings indicators parameters
   IndicatorSetInteger(INDICATOR_DIGITS,Digits());
   IndicatorSetString(INDICATOR_SHORTNAME,"Asymmetric Trend Pressure("+(string)period+")");
//--- setting buffer arrays as timeseries
   ArraySetAsSeries(BufferATP,true);
   ArraySetAsSeries(BufferDN,true);
   ArraySetAsSeries(BufferUP,true);
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
  {
//--- Проверка на минимальное количество баров для расчёта
   if(rates_total<period) return 0;
//--- Проверка и расчёт количества просчитываемых баров
   int limit=rates_total-prev_calculated;
   if(limit>1)
     {
      limit=rates_total-period-1;
      ArrayInitialize(BufferATP,EMPTY_VALUE);
      ArrayInitialize(BufferDN,EMPTY_VALUE);
      ArrayInitialize(BufferUP,EMPTY_VALUE);
     }
     
   //
   // Process data through custom chart indicator
   //
   
   if(!customChartIndicator.OnCalculate(rates_total,prev_calculated,time,close))
      return(0);
      
   if(!customChartIndicator.BufferSynchronizationCheck(close))
      return(0);
   
   //
   // Make the following modifications in the code below:
   //
   // customChartIndicator.GetPrevCalculated() should be used instead of prev_calculated
   //
   // customChartIndicator.Open[] should be used instead of open[]
   // customChartIndicator.Low[] should be used instead of low[]
   // customChartIndicator.High[] should be used instead of high[]
   // customChartIndicator.Close[] should be used instead of close[]
   //
   // customChartIndicator.IsNewBar (true/false) informs you if a bar completed
   //
   // customChartIndicator.Time[] shold be used instead of Time[] for checking the bar time.
   // (!) customChartIndicator.SetGetTimeFlag() must be called in OnInit() for customChartIndicator.Time[] to be used
   //
   // customChartIndicator.Tick_volume[] should be used instead of TickVolume[]
   // customChartIndicator.Real_volume[] should be used instead of Volume[]
   // (!) customChartIndicator.SetGetVolumesFlag() must be called in OnInit() for Tick_volume[] & Real_volume[] to be used
   //
   // customChartIndicator.Price[] should be used instead of Price[]
   // (!) customChartIndicator.SetUseAppliedPriceFlag(ENUM_APPLIED_PRICE _applied_price) must be called in OnInit() for customChartIndicator.Price[] to be used
   //
   
   int _prev_calculated = customChartIndicator.GetPrevCalculated();
   
   //
   //
   //      
     
//--- Установка индексации массивов как таймсерий
   ArraySetAsSeries(customChartIndicator.Open,true);
   ArraySetAsSeries(customChartIndicator.Close,true);
//--- Расчёт индикатора
   for(int i=limit; i>=0; i--)
     {
      double summ_up=0,summ_dn=0;
      int n=0,count_up=0,count_dn=0;
      while(n<period)
        {
         if(customChartIndicator.Close[i+n]>customChartIndicator.Open[i+n] && count_up<period_up)
           {
            count_up++;
            summ_up+=customChartIndicator.Close[i+n]-customChartIndicator.Open[i+n];
           }
         else if(customChartIndicator.Close[i+n]<customChartIndicator.Open[i+n] && count_dn<period_dn)
           {
            count_dn++;
            summ_dn+=customChartIndicator.Open[i+n]-customChartIndicator.Close[i+n];
           }
         n++;
        }
      if(InpShowUpDn)
        {
         BufferUP[i]=summ_up/period_up;
         BufferDN[i]=summ_dn/period_dn;
        }
      else
         BufferUP[i]=BufferDN[i]=EMPTY_VALUE;
      BufferATP[i]=summ_up/period_up-summ_dn/period_dn;
     }
//--- return value of prev_calculated for next call
   return(rates_total);
  }
//+------------------------------------------------------------------+
