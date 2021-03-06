#property copyright "Copyright 2011-2021, Level Up Software"

static bool IS_TESTING = (bool)MQLInfoInteger(MQL_TESTER);

enum ENUM_BOOL
{
#ifdef P_RENKO_BR
   BFalse = 0,                // Não 
   BTrue = 1,                 // Sim 
#else
   BFalse = 0,                // No 
   BTrue = 1,                 // Yes 
#endif
};

enum ENUM_MA_METHOD_EXT
{
#ifdef P_RENKO_BR
   _MODE_SMA = 0,             // Simples 
   _MODE_EMA,                 // Exponencial 
   _MODE_SMMA,                // Suavizada 
   _MODE_LWMA,                // Ponderada
   _VWAP_TICKVOL = 997,       // VWMA (tick volume)
   _VWAP_REALVOL = 998,       // VWMA (real volume)
   _LINEAR_REGRESSION = 999,  // Linear regression
#else
   _MODE_SMA = 0,             // Simple
   _MODE_EMA,                 // Exponential
   _MODE_SMMA,                // Smoothed
   _MODE_LWMA,                // Linear-weighted
   _VWAP_TICKVOL = 997,       // Volume-weighted (tick volume)
   _VWAP_REALVOL = 998,       // Volume-weighted (real volume)
   _LINEAR_REGRESSION = 999,  // Linear regression
#endif
};

enum ENUM_CHANNEL_TYPE
{
#ifdef AMP_VERSION

   _None = 0,                 // No
   _Keltner_Channel = 4,      // Yes

#else

   #ifdef P_RENKO_BR
      _None = 0,                 // Nenhum
      _Donchian_Channel = 1,     // Canais de Donchian
      _Bollinger_Bands = 2,      // Bandas de Bollinger
      _SuperTrend = 3,           // Super Trend
      _Keltner_Channel = 4,      // Canais de Keltner
   #else   
      _None = 0,                 // None
      _Donchian_Channel = 1,     // Donchian Channel
      _Bollinger_Bands = 2,      // Bollinger Bands
      _SuperTrend = 3,           // Super Trend
      _Keltner_Channel = 4,      // Keltner Channel
   #endif

#endif // AMP_VERSION   
};

enum ENUM_TICK_PRICE_TYPE
{
   tickBid,                   // Bid price
   tickAsk,                   // Ask price
   tickLast,                  // Last price
};

enum ENUM_PIVOT_POINTS
{
#ifdef P_RENKO_BR
   ppNone = 0,                // Nenhum
   ppPrevHLC,                 // HLC Dia Anterior
   ppClassic,                 // Clássico
   ppClassicPrevHLC,          // Clássico + HLC Dia Anterior
   ppFibo,                    // Fibonacci
   ppFiboPrevHLC,             // Fibonacci + HLC Dia Anterior
#else
   ppNone = 0,                // None
   ppPrevHLC,                 // Previous day HLC
   ppClassic,                 // Classic
   ppClassicPrevHLC,          // Classic + Prev HLC
   ppFibo,                    // Fibonacci
   ppFiboPrevHLC,             // Fibonacci + Prev HLC
#endif
};

enum ENUM_PIVOT_TYPE
{
#ifdef P_RENKO_BR
   ppCalcNone = 0,             // Nenhum
   ppHLC3 = 1,                 // (H+L+C) / 3
   ppOHLC4 = 2,                // (O+H+L+C) / 4
#else
   ppCalcNone = 0,             // None
   ppHLC3 = 1,                 // (H+L+C) / 3
   ppOHLC4 = 2,                // (O+H+L+C) / 4
#endif
};

enum ENUM_BAR_SIZE_CALC_MODE
{
   BAR_SIZE_ABSOLUTE_TICKS = 0,  // Ticks
   BAR_SIZE_ABSOLUTE_PIPS,       // Pips
   BAR_SIZE_ABSOLUTE_POINTS,     // Points
   BAR_SIZE_ATR_PERCENT,         // ATR %
   BAR_SIZE_PERCENT,             // %
};

enum ENUM_ALERT_TYPE 
{
   ALERT_NEW_BAR_BULL = 0,
   ALERT_NEW_BAR_BEAR,
   ALERT_MA_CROSS_BULL,
   ALERT_MA_CROSS_BEAR,
};

enum ENUM_MA_LINE_TYPE
{   
#ifdef P_RENKO_BR
   MA_NONE = DRAW_NONE,       // Não Mostrar
   MA_LINE = DRAW_LINE,       // Linha   
   MA_DOTS = DRAW_ARROW,      // Pontilhado
#else
   MA_NONE = DRAW_NONE,       // Don't show
   MA_LINE = DRAW_LINE,       // Line   
   MA_DOTS = DRAW_ARROW,      // Dots
#endif 
};

enum ENUM_CHART_INFO
{
   CHART_INFO_NONE = 0,       // None   
};

enum ENUM_VOLUME_CHART_CALCULATION
{
   VOLUME_CHART_USE_VOLUME,   // Volume chart
   VOLUME_CHART_USE_TICKS,    // Tick chart
};

enum ENUM_ALERT_WHEN
{
#ifdef P_RENKO_BR
   ALERT_WHEN_None = 0,       // Nenhum
   ALERT_WHEN_NewBar,         // Nova barra
   ALERT_WHEN_Reversal,       // Barra de reversão
   ALERT_WHEN_NewBullishReversal, // Barra de reversão de alta
   ALERT_WHEN_NewBearishReversal, // Barra de reversão de baixa
   ALERT_WHEN_MaCross,        // Cruzamento Médias MA1 e MA2
   ALERT_WHEN_NewBarReversal, // Nova barra & Barra de Reversão
   ALERT_WHEN_NewBarMaCross,  // Nova barra & Cruzamento Médias
   ALERT_WHEN_ReversalMaCross,// Barra de Reversão & Cruzamento Médias
   ALERT_WHEN_All,            // Nova Barra & Barra de Reversão & Cruzamento Médias
#else
   ALERT_WHEN_None = 0,       // None
   ALERT_WHEN_NewBar,         // New bar
   ALERT_WHEN_Reversal,       // Reversal bar
   ALERT_WHEN_NewBullishReversal, // Bullish reversal bar
   ALERT_WHEN_NewBearishReversal, // Bearish reversal bar
   ALERT_WHEN_MaCross,        // MA1 & MA2 crossover
   ALERT_WHEN_NewBarReversal, // New bar & Reversal bar
   ALERT_WHEN_NewBarMaCross,  // New bar & MA cross
   ALERT_WHEN_ReversalMaCross,// Reversal bar & MA cross
   ALERT_WHEN_All,            // New bar & reversal bar & MA cross
#endif
};

enum ENUM_ALERT_NOTIFY_TYPE
{
#ifdef P_RENKO_BR
   ALERT_NOTIFY_TYPE_None = 0,   // Nenhum
   ALERT_NOTIFY_TYPE_Msg,        // Mostrar com box de alerta
   ALERT_NOTIFY_TYPE_Sound,      // Tocar som
   ALERT_NOTIFY_TYPE_Push,       // Enviar Notificação Push
   ALERT_NOTIFY_TYPE_MsgSound,   // Mostrar alerta & Tocar som
   ALERT_NOTIFY_TYPE_SoundPush,  // Tocar som & Enviar notificação push
   ALERT_NOTIFY_TYPE_MsgPush,    // Mostrar alerta & Enviar notificação push
   ALERT_NOTIFY_TYPE_All,        // Mostrar alerta & Tocar som & Enviar notificação push
#else
   ALERT_NOTIFY_TYPE_None = 0,   // None
   ALERT_NOTIFY_TYPE_Msg,        // Show in alert box
   ALERT_NOTIFY_TYPE_Sound,      // Play sound
   ALERT_NOTIFY_TYPE_Push,       // Send push notification
   ALERT_NOTIFY_TYPE_MsgSound,   // Show alert & Sound
   ALERT_NOTIFY_TYPE_SoundPush,  // Play sound & Push notify
   ALERT_NOTIFY_TYPE_MsgPush,    // Show alert & Push notify
   ALERT_NOTIFY_TYPE_All,        // Alert & Sound & Push notify
#endif
};

//
//  Settigns used by CustomBarProcessor class for alert & info purposes
//

struct ALERT_INFO_SETTINGS
{
   string            TradingSessionTime;
   color             OffMarketColor;
   
   double            TopBottomPaddingPercentage;
   ENUM_PIVOT_POINTS showPivots;
   ENUM_PIVOT_TYPE   pivotPointCalculationType; 
   color             Rcolor;
   color             Pcolor;
   color             Scolor;
   color             PDHColor;
   color             PDLColor;
   color             PDCColor;   
   ENUM_BOOL         showNextBarLevels;
   color             HighThresholdIndicatorColor;
   color             LowThresholdIndicatorColor;
   ENUM_BOOL         showCurrentBarOpenTime;
   color             InfoTextColor;
   
   ENUM_BOOL         NewBarAlert;
   ENUM_BOOL         ReversalBarAlert;
   ENUM_BOOL         BullishReversalAlert;
   ENUM_BOOL         BearishReversalAlert;
   ENUM_BOOL         MaCrossAlert;
   ENUM_BOOL         UseAlertWindow;
   ENUM_BOOL         UseSound; 
   ENUM_BOOL         UsePushNotifications;
   string            SoundFileBull;
   string            SoundFileBear;
   
   ENUM_BOOL         DisplayAsBarChart;
};

//
// Settgins used for custom symbol chart
// 

struct CUSTOM_SYMBOL_SETTINGS
{
   string            CustomChartName;
   string            ApplyTemplate;
   bool              ForBacktesting;
   bool              ForceFasterRefresh;
};

//
// Settings used for on chart indicators
//

struct CHART_INDICATOR_SETTINGS
{
   //ENUM_BOOL            MA1on; 
   ENUM_MA_LINE_TYPE    MA1lineType;
   int                  MA1period;
   ENUM_MA_METHOD_EXT   MA1method;
   ENUM_APPLIED_PRICE   MA1applyTo;
   int                  MA1shift;
   ENUM_BOOL            MA1priceLabel;
   
   //ENUM_BOOL            MA2on; 
   ENUM_MA_LINE_TYPE    MA2lineType;
   int                  MA2period;
   ENUM_MA_METHOD_EXT   MA2method;
   ENUM_APPLIED_PRICE   MA2applyTo;
   int                  MA2shift;
   ENUM_BOOL            MA2priceLabel;
   
   //ENUM_BOOL            MA3on; 
   ENUM_MA_LINE_TYPE    MA3lineType;
   int                  MA3period;
   ENUM_MA_METHOD_EXT   MA3method;
   ENUM_APPLIED_PRICE   MA3applyTo;
   int                  MA3shift;
   ENUM_BOOL            MA3priceLabel;

   //ENUM_BOOL            MA4on; 
   ENUM_MA_LINE_TYPE    MA4lineType;   
   int                  MA4period;
   ENUM_MA_METHOD_EXT   MA4method;
   ENUM_APPLIED_PRICE   MA4applyTo;
   int                  MA4shift;
   ENUM_BOOL            MA4priceLabel;            
   
   ENUM_CHANNEL_TYPE    ShowChannel;      
   ENUM_APPLIED_PRICE   ChannelAppliedPrice;
   int                  ChannelPeriod;
   int                  ChannelAtrPeriod;
   double               ChannelMultiplier;
   double               ChannelBandsDeviations;
   ENUM_BOOL            ChannelPriceLabel;
   ENUM_BOOL            ChannelMidPriceLabel;
   
   ENUM_BOOL            UsedInEA;
   ENUM_BOOL            ShiftObj;
};

#ifdef P_RENKO_BOT
   #define P_RENKO_BR
#endif

#ifdef P_RENKO_BR
enum ENUM_CHART_SIZE
{
   _1R = 1, //1R (Renko)
   _2R, //2R (Renko)
   _3R, //3R (Renko)
   _4R, //4R (Renko)
   _5R, //5R (Renko)
   _6R, //6R (Renko)
   _7R, //7R (Renko)
   _8R, //8R (Renko)
   _9R, //9R (Renko)
   _10R, //10R (Renko)
   _11R, //11R (Renko)
   _12R, //12R (Renko)
   _13R, //13R (Renko)
   _14R, //14R (Renko)
   _15R, //15R (Renko)
   _16R, //16R (Renko)
   _17R, //17R (Renko)
   _18R, //18R (Renko)
   _19R, //19R (Renko)
   _20R, //20R (Renko)
   _21R, //21R (Renko)
   _22R, //22R (Renko)
   _23R, //23R (Renko)
   _24R, //24R (Renko)
   _25R, //25R (Renko)
   _26R, //26R (Renko)
   _27R, //27R (Renko)
   _28R, //28R (Renko)
   _29R, //29R (Renko)
   _30R, //30R (Renko)
   _31R, //31R (Renko)
   _32R, //32R (Renko)
   _33R, //33R (Renko)
   _34R, //34R (Renko)
   _35R, //35R (Renko)
   _36R, //36R (Renko)
   _37R, //37R (Renko)
   _38R, //38R (Renko)
   _39R, //39R (Renko)
   _40R, //40R (Renko)
   _41R, //41R (Renko)
   _42R, //42R (Renko)
   _43R, //43R (Renko)
   _44R, //44R (Renko)
   _45R, //45R (Renko)
   _46R, //46R (Renko)
   _47R, //47R (Renko)
   _48R, //48R (Renko)
   _49R, //49R (Renko)
   _50R, //50R (Renko)
   _1P, //1P (Preço)
   _2P, //2P (Preço)
   _3P, //3P (Preço)
   _4P, //4P (Preço)
   _5P, //5P (Preço)
   _6P, //6P (Preço)
   _7P, //7P (Preço)
   _8P, //8P (Preço)
   _9P, //9P (Preço)
   _10P, //10P (Preço)
   _11P, //11P (Preço)
   _12P, //12P (Preço)
   _13P, //13P (Preço)
   _14P, //14P (Preço)
   _15P, //15P (Preço)
   _16P, //16P (Preço)
   _17P, //17P (Preço)
   _18P, //18P (Preço)
   _19P, //19P (Preço)
   _20P, //20P (Preço)
   _21P, //21P (Preço)
   _22P, //22P (Preço)
   _23P, //23P (Preço)
   _24P, //24P (Preço)
   _25P, //25P (Preço)
   _26P, //26P (Preço)
   _27P, //27P (Preço)
   _28P, //28P (Preço)
   _29P, //29P (Preço)
   _30P, //30P (Preço)
   _31P, //31P (Preço)
   _32P, //32P (Preço)
   _33P, //33P (Preço)
   _34P, //34P (Preço)
   _35P, //35P (Preço)
   _36P, //36P (Preço)
   _37P, //37P (Preço)
   _38P, //38P (Preço)
   _39P, //39P (Preço)
   _40P, //40P (Preço)
   _41P, //41P (Preço)
   _42P, //42P (Preço)
   _43P, //43P (Preço)
   _44P, //44P (Preço)
   _45P, //45P (Preço)
   _46P, //46P (Preço)
   _47P, //47P (Preço)
   _48P, //48P (Preço)
   _49P, //49P (Preço)
   _50P, //50P (Preço)
};
#endif

#ifdef P_RENKO_BOT
   #undef P_RENKO_BR
#endif

enum ENUM_CUSTOM_BAR_TYPE
{
   cbtCustom = 0,          // No
   cbtRenko,               // Renko
   cbtMedianRenko,         // Median Renko
   cbtPointO,              // PointO
   cbtTurboRenko075,       // Turbo Renko
   cbtHybridRenko075,      // Hybrid Renko   
};

enum ENUM_INTERVAL
{
   INTERVAL_SECONDS = 0,      // Seconds
   INTERVAL_MINUTES = 1,     // Minutes
   INTERVAL_HOURS = 2,     // Hours
   INTERVAL_DAYS = 3,     // Days
   INTERVAL_WEEKS = 4,   // Weeks
   INTERVAL_MONTHS = 5, // Months
};

const long _INTERVAL_MULT[6] = {1,60,3600,86400,604800,2592000};
const string _INTERVALS[6] = {"sec","min","hrs","day","week","month"};