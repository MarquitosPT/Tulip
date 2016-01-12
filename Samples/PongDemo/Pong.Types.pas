unit Pong.Types;

interface

//---------------------------------------------------------------------------
uses
 PXL.Devices,
 PXL.Canvas,
 PXL.Images,
 PXL.Fonts,
 PXL.Archives,
 PXL.SwapChains,
 PXL.Timing,
 PXL.Types,
 PXL.ImageFormats,
 PXL.Providers;

type
  TGameState = (gsMenu, gsPaused, gsPlaying);

//---------------------------------------------------------------------------
var
 DisplaySize: TPoint2px;

//---------------------------------------------------------------------------
 ImageFormatManager: TImageFormatManager;
 ImageFormatHandler: TCustomImageFormatHandler;

 DeviceProvider: TGraphicsDeviceProvider;

 GameDevice : TCustomSwapChainDevice = nil;
 GameCanvas : TCustomCanvas = nil;
 GameImages : TAtlasImages = nil;
 GameFonts  : TBitmapFonts  = nil;
 GameState  : TGameState = gsMenu;
 Timer : TMultimediaTimer = nil;

 MediaFile  : TArchive = nil;

 fontTahoma: Integer = -1;
 fontTahomab: Integer = -1;

implementation

end.
