//+------------------------------------------------------------------+
//|                                                    DidiIndex.mq5 |
//|                                                Rudinei Felipetto |
//+------------------------------------------------------------------+
#property copyright "Rudinei Felipetto"
#property version   "2.00"
#property indicator_separate_window
#property indicator_buffers 3
#property indicator_plots   3
//--- plot Fast Line
#property indicator_label1  "Fast Line"
#property indicator_type1   DRAW_LINE
#property indicator_color1  clrLime
#property indicator_style1  STYLE_SOLID
#property indicator_width1  1
//--- plot Mean Line
#property indicator_label2  "Mean Line"
#property indicator_type2   DRAW_LINE
#property indicator_color2  clrWhite
#property indicator_style2  STYLE_SOLID
#property indicator_width2  1
//--- plot Slow Line
#property indicator_label3  "Slow Line"
#property indicator_type3   DRAW_LINE
#property indicator_color3  clrYellow
#property indicator_style3  STYLE_SOLID
#property indicator_width3  1
//--- input parameters
      ENUM_TIMEFRAMES    Timeframe    = PERIOD_CURRENT; // Timeframe
input ENUM_MA_METHOD     Method       = MODE_SMA;       // Smoothing Method
input ENUM_APPLIED_PRICE AppliedPrice = PRICE_CLOSE;    // Price Values
input int                MAShift      =0;               // Shift
input int                FastPeriod   =3;               // Fast MA Period
input int                MeanPeriod   =8;               // Mean MA Period
input int                SlowPeriod   =20;              // Slow MA Period
input int                lookback     =512;             // Maximum lookback period

//--- indicator buffers
double SlowBuffer[];
double MeanBuffer[];
double FastBuffer[];
//--- indicator handlers
int short_handle;
int average_handle;
int long_handle;

#include <AZ-INVEST/CustomBarConfig.mqh>
#include <IncOnRingBuffer\CMAOnRingBuffer.mqh>

CMAOnRingBuffer maFast;
CMAOnRingBuffer maMean;
CMAOnRingBuffer maSlow;

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {
   int max_period;
//--- indicator buffers mapping
   SetIndexBuffer(0,FastBuffer,INDICATOR_DATA);
   SetIndexBuffer(1,MeanBuffer,INDICATOR_DATA);
   SetIndexBuffer(2,SlowBuffer,INDICATOR_DATA);

   ArraySetAsSeries(FastBuffer,true);
   ArraySetAsSeries(MeanBuffer,true);
   ArraySetAsSeries(SlowBuffer,true);

   if(Digits()==0) IndicatorSetInteger(INDICATOR_DIGITS,6);
   else IndicatorSetInteger(INDICATOR_DIGITS,Digits());

   ArrayInitialize(FastBuffer,EMPTY_VALUE);
   ArrayInitialize(MeanBuffer,EMPTY_VALUE);
   ArrayInitialize(SlowBuffer,EMPTY_VALUE);

   max_period=(MathMax(FastPeriod,MathMax(MeanPeriod,SlowPeriod)));

   PlotIndexSetInteger(0,PLOT_DRAW_BEGIN,max_period);
   PlotIndexSetInteger(1,PLOT_DRAW_BEGIN,max_period);
   PlotIndexSetInteger(2,PLOT_DRAW_BEGIN,max_period);

//   short_handle   = iMA(Symbol(), Timeframe, FastPeriod, Shift, Method, AppliedPrice);
//   average_handle = iMA(Symbol(), Timeframe, MeanPeriod, Shift, Method, AppliedPrice);
//   long_handle    = iMA(Symbol(), Timeframe, SlowPeriod, Shift, Method, AppliedPrice);
//
//   if(short_handle==INVALID_HANDLE || average_handle==INVALID_HANDLE || long_handle==INVALID_HANDLE)
//     {
//      Print("Error starting handles!");
//      return(INIT_FAILED);
//     }

   if(!maFast.Init(FastPeriod, Method, lookback))
   {
      PrintFormat("Failed to create fast MA on ring buffer");
      return(INIT_FAILED);
   }
   
   if(!maMean.Init(MeanPeriod, Method, lookback))
   {
      PrintFormat("Failed to create mean MA on ring buffer");
      return(INIT_FAILED);
   }

   if(!maSlow.Init(SlowPeriod, Method, lookback))
   {
      PrintFormat("Failed to create slow MA on ring buffer");
      return(INIT_FAILED);
   }

   customChartIndicator.SetUseAppliedPriceFlag(AppliedPrice);

   IndicatorSetString(INDICATOR_SHORTNAME,"DidiIndex("+IntegerToString(FastPeriod)+", "+IntegerToString(MeanPeriod)+", "+IntegerToString(SlowPeriod)+")");
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Custom indicator deinitialization function                       |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
//   IndicatorRelease(short_handle);
//   IndicatorRelease(average_handle);
//   IndicatorRelease(long_handle);
//---
  }
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int  OnCalculate(
   const int        rates_total,       // size of input time series
   const int        prev_calculated,   // number of handled bars at the previous call
   const datetime&  time[],            // Time array
   const double&    open[],            // Open array
   const double&    high[],            // High array
   const double&    low[],             // Low array
   const double&    close[],           // Close array
   const long&      tick_volume[],     // Tick Volume array
   const long&      volume[],          // Real Volume array
   const int&       spread[]           // Spread array
)  {
//---
   int limit, index;
   
   //
   // Process data through custom chart indicator
   //
   
   if(!customChartIndicator.OnCalculate(rates_total,prev_calculated,time,close))
      return(0);
      
   if(!customChartIndicator.BufferSynchronizationCheck(close))
      return(0);
      
   int _prev_calculated = customChartIndicator.GetPrevCalculated();      
   int _rates_total = ArraySize(customChartIndicator.Price);
   
   //
   
   limit=_rates_total-_prev_calculated;
   if(_prev_calculated==0) limit-=(MathMax(FastPeriod,MathMax(MeanPeriod,SlowPeriod)));

   maFast.MainOnArray(_rates_total, _prev_calculated, customChartIndicator.Price);
   maMean.MainOnArray(_rates_total, _prev_calculated, customChartIndicator.Price);
   maSlow.MainOnArray(_rates_total, _prev_calculated, customChartIndicator.Price);
   
   for(int i=limit; i>=0; i--)
   {
      //CalculateDidiIndex(i);
      
      index = i+MAShift;
      
      if(maMean[index] == 0)
         return(0);
      
      FastBuffer[i] = maFast[index]/maMean[index];
      MeanBuffer[i] = 1;
      SlowBuffer[i] = maSlow[index]/maMean[index];
         
   }
//---
   return(rates_total);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
/*
void CalculateDidiIndex(const int shift=0)
  {
//---
   double fast[1],mean[1],slow[1];

   if(CopyBuffer(short_handle, 0, shift, 1, fast)<=0) return;
   if(CopyBuffer(average_handle, 0, shift, 1, mean)<=0) return;
   if(CopyBuffer(long_handle, 0, shift, 1, slow)<=0) return;

   FastBuffer[shift] = fast[0]/mean[0];
   MeanBuffer[shift] = 1;
   SlowBuffer[shift] = slow[0]/mean[0];
//---
  }
*/  
//+------------------------------------------------------------------+
