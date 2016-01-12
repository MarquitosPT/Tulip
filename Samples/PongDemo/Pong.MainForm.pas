unit Pong.MainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  // Pong Units
  Pong.ControlManager, Pong.Types;

type
  TMainForm = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    FailureHandled: Boolean;
    GameTicks: Integer;

    procedure TimerEvent(const Sender: TObject);
    procedure ProcessEvent(const Sender: TObject);

    procedure ApplicationIdle(Sender: TObject; var Done: Boolean);
  public
    { Public declarations }
    procedure RenderWindow;
    procedure RenderScene;
  end;

var
  MainForm: TMainForm;
  ControlManager: TPongControlManager;

implementation

uses
  PXL.Archives,
  PXL.Providers,
  PXL.Providers.DX9,
  PXL.Devices,
  PXL.Devices.DX9,
  PXL.Canvas,
  PXL.Images,
  PXL.Fonts,
  PXL.SwapChains,
  PXL.Timing,
  PXL.Types,

  PXL.Classes,
  PXL.ImageFormats,
  PXL.ImageFormats.Auto,
  PXL.Providers.Auto,

  Tulip.UI.Helpers,
  Tulip.UI.Types,
  Tulip.UI;

{$R *.dfm}
{ TForm1 }

procedure TMainForm.ApplicationIdle(Sender: TObject; var Done: Boolean);
begin
  Timer.NotifyTick;
  Done := False;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  ReportMemoryLeaksOnShutdown := True;

  ImageFormatManager := TImageFormatManager.Create;
  ImageFormatHandler := CreateDefaultImageFormatHandler(ImageFormatManager);

  DeviceProvider := CreateDefaultProvider(ImageFormatManager);

  DeviceProvider := TDX9Provider.Create(ImageFormatManager);

  GameDevice := DeviceProvider.CreateDevice as TCustomSwapChainDevice;


  DisplaySize := Point2px(ClientWidth, ClientHeight);
  GameDevice.SwapChains.Add(Handle, DisplaySize);
  GameDevice.SwapChains.Items[0].VSync := True;

  if not GameDevice.Initialize then
  begin
    MessageDlg('Failed to initialize PXL Device.', mtError, [mbOk], 0);
    Application.Terminate;
    Exit;
  end;

  GameCanvas := DeviceProvider.CreateCanvas(GameDevice);
  if not GameCanvas.Initialize then
  begin
    MessageDlg('Failed to initialize PXL Canvas.', mtError, [mbOk], 0);
    Application.Terminate;
    Exit;
  end;

  GameImages := TAtlasImages.Create(GameDevice);

  GameFonts := TBitmapFonts.Create(GameDevice);
  GameFonts.Canvas := GameCanvas;

  MediaFile := TArchive.Create();
  MediaFile.OpenMode := TArchive.TOpenMode.ReadOnly;

  MediaFile.FileName := ExtractFilePath(ParamStr(0)) + 'media.asvf';

//  fontTahoma := GameFonts.InsertFromArchive('tahoma10',MediaFile);
//  fontTahomab := GameFonts.InsertFromArchive('tahoma10b',MediaFile);
//
//  if (FontTahoma = -1) or (fontTahomab = -1) then
//  begin
//    MessageDlg('Could not load Tahoma font.', mtError, [mbOk], 0);
//    Application.Terminate;
//    Exit;
//  end;

  //fontTahoma := GameFonts.Insert('media.asvf | tahoma10.xml', 'tahoma10.image');
  //GameFonts[fontTahoma].Kerning := 1;
  //fontTahomab := GameFonts.Insert('media.asvf | tahoma10b.xml', 'tahoma10b.image');

  // Create ControlManager and initialize it
  ControlManager := TPongControlManager.Create(Self, GameDevice, GameCanvas);
  ControlManager.Initialize;

  // Initialize and prepare the timer.
  Timer := TMultimediaTimer.Create;
  Timer.MaxFPS := 1000;
  Timer.OnTimer := TimerEvent;
  Timer.OnProcess := ProcessEvent;
  Timer.Enabled := True;

  Application.OnIdle := ApplicationIdle;

  // This variable tells that a connection failure to Asphyre device has been
  // already handled.
  FailureHandled := False;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  Timer.Enabled := False;

  // Release Control Engine.
  FreeAndNil(ControlManager);

  GameFonts.Free;
  GameImages.Free;
  GameCanvas.Free;
  GameDevice.Free;
  DeviceProvider.Free;
  ImageFormatHandler.Free;
  ImageFormatManager.Free;

  Timer.Enabled := False;
  Timer.OnTimer := nil;
  Timer.OnProcess := nil;
  Timer.Free;
end;

procedure TMainForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_ESCAPE) then
  begin
    if (GameState = gsPlaying) then
    begin
      GameState := gsPaused;

      ControlManager.AForm('Pause').Show(True);

      // Set focus on first button
      ControlManager.AButton('Pause','Continue').SetFocus;
    end;
  end;
end;

procedure TMainForm.FormResize(Sender: TObject);
begin
  DisplaySize := Point2px(ClientWidth, ClientHeight);

  if (GameDevice <> nil) and (Timer <> nil) and GameDevice.Initialized then
  begin
    GameDevice.Resize(0, DisplaySize);
    RenderWindow;
    Timer.Reset;
  end;
end;

procedure TMainForm.RenderScene;
var
  j, i: Integer;
begin

  if (GameState = gsPlaying) or (GameState = gsPaused) then
  begin
    // Draw gray background.
    for j := 0 to (DisplaySize.y div 10) do
      for i := 0 to (DisplaySize.x div 10) do
        GameCanvas.FillQuad(FloatRect4(i * 10, j * 10, 10, 10),
          IntColor4($FF585858, $FF505050, $FF484848, $FF404040));

//    GameFonts[fontTahomab].DrawText
//      (Point2(DisplaySize.x * 0.5 + Cos(GameTicks * 0.0073) * DisplaySize.x *
//      0.25, DisplaySize.y * 0.5 + Sin(GameTicks * 0.00312) * DisplaySize.y *
//      0.25), 'Pong Demo!', IntColor2($FFFFE887, $FFFF0000), 1.0);
  end;

  if (GameState = gsPlaying) then
  begin
    //GameFonts[fontTahoma].DrawText(Point2(4.0, 4.0), 'Press Escape to pause.',
      //IntColor2($FFFFE887, $FFFF0000), 1.0);
  end;

  if GameState = gsMenu then
  begin
    // Draw gray background.
    for j := 0 to (DisplaySize.y div 10) do
      for i := 0 to (DisplaySize.x div 10) do
        GameCanvas.FillQuad(FloatRect4(i * 10, j * 10, 10, 10),
          IntColor4($FF585858, $FF505050, $FF484848, $FF404040));
  end;

  // Render ControlManager
  ControlManager.Render;

//    // Show frame Rate
//  GameFonts[fontTahoma].TextOut(
//  Point2(4.0, 460.0),
//  'FPS: ' + IntToStr(Timer.FrameRate),
//  cColor2($FFFFE887, $FFFF0000), 1.0);
end;

procedure TMainForm.RenderWindow;
begin
  if GameDevice.BeginScene then
  try
    GameDevice.Clear([TClearType.Color], 0);

    RenderScene;

    Timer.Process;
  finally
    GameDevice.EndScene;
  end;
end;

procedure TMainForm.TimerEvent(const Sender: TObject);
begin
  RenderWindow;
end;

procedure TMainForm.ProcessEvent(const Sender: TObject);
begin
  if GameState = gsPlaying then
    Inc(GameTicks);
end;

end.
