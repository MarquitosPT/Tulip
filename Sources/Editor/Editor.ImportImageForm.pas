{******************************************************************************}
{                                                                              }
{                    Tulip - Graphical User Interface Editor                   }
{                                                                              }
{             Copyright(c) 2012 Marcos Gomes. All rights Reserved.             }
{                                                                              }
{  --------------------------------------------------------------------------  }
{                                                                              }
{  This product is based on Asphyre Sphinx (c) 2000 - 2012  Yuriy Kotsarenko.  }
{       All rights reserved. Official web site: http://www.afterwarp.net       }
{                                                                              }
{******************************************************************************}
{                                                                              }
{  Important Notice:                                                           }
{                                                                              }
{  If you modify/use this code or one of its parts either in original or       }
{  modified form, you must comply with Mozilla Public License Version 2.0,     }
{  including section 3, "Responsibilities". Failure to do so will result in    }
{  the license breach, which will be resolved in the court. Remember that      }
{  violating author's rights either accidentally or intentionally is           }
{  considered a serious crime in many countries. Thank you!                    }
{                                                                              }
{  !! Please *read* Mozilla Public License 2.0 document located at:            }
{  http://www.mozilla.org/MPL/                                                 }
{                                                                              }
{  --------------------------------------------------------------------------  }
{                                                                              }
{  The contents of this file are subject to the Mozilla Public License         }
{  Version 2.0 (the "License"); you may not use this file except in            }
{  compliance with the License. You may obtain a copy of the License at        }
{  http://www.mozilla.org/MPL/                                                 }
{                                                                              }
{  Software distributed under the License is distributed on an "AS IS"         }
{  basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the     }
{  License for the specific language governing rights and limitations          }
{  under the License.                                                          }
{                                                                              }
{  The Original Code is Editor.ImportImageForm.pas.                            }
{                                                                              }
{  The Initial Developer of the Original Code is Marcos Gomes.                 }
{  Portions created by Marcos Gomes are Copyright (C) 2012, Marcos Gomes.      }
{  All Rights Reserved.                                                        }
{                                                                              }
{******************************************************************************}
{                                                                              }
{  Editor.ImportImageForm.pas                           Modified: 05-Out-2012  }
{  --------------------------------------------------------------------------  }
{                                                                              }
{                     Implementation of ImportImageForm                        }
{                                                                              }
{                                Version 1.02                                  }
{                                                                              }
{******************************************************************************}

unit Editor.ImportImageForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls,
  // Asphyre Units
  AsphyreFormatInfo, ImagePixelFx, Vectors2px, AsphyreArchives, StreamUtils,
  SystemSurfaces, AsphyreTypes, AsphyreConv, AsphyreBitmaps, AsphyreBMP,
  AsphyreJPG, AsphyrePNG,
  // Tulip UI Units
  Tulip.UI.Helpers;

type
  TPxFm = packed record
    Format: TAsphyrePixelFormat;
    PatternWidth: Longint;
    PatternHeight: Longint;
    VisibleWidth: Longint;
    VisibleHeight: Longint;
    PatternCount: Longint;
    TextureWidth: Longint;
    TextureHeight: Longint;
    TextureCount: Longint;
  end;

  TImportImageForm = class(TForm)
    GroupBox1: TGroupBox;
    txtFileName: TEdit;
    bOpenFile: TButton;
    Label1: TLabel;
    GroupSize: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    txtTextureWidth: TEdit;
    txtTextureHeight: TEdit;
    txtPatternWidth: TEdit;
    txtPatternHeight: TEdit;
    UpDownTextureWidth: TUpDown;
    UpDownTextureHeight: TUpDown;
    GroupAlpha: TGroupBox;
    rbFromSource: TRadioButton;
    rbFromMask: TRadioButton;
    Label2: TLabel;
    Label7: TLabel;
    GroupKey: TGroupBox;
    txtKeyName: TEdit;
    GroupPixel: TGroupBox;
    cbPixelFormat: TComboBox;
    bCancel: TButton;
    bImport: TButton;
    UpDownPatternWidth: TUpDown;
    UpDownPatternHeight: TUpDown;
    OpenDialog1: TOpenDialog;
    ToleranceRange: TTrackBar;
    ColorDialog1: TColorDialog;
    MaskColor: TPanel;
    StatusBar1: TStatusBar;
    procedure bOpenFileClick(Sender: TObject);
    procedure MaskColorClick(Sender: TObject);
    procedure rbFromMaskClick(Sender: TObject);
    procedure rbFromSourceClick(Sender: TObject);
    procedure bImportClick(Sender: TObject);
    procedure UpDownTextureWidthChangingEx(Sender: TObject;
      var AllowChange: Boolean; NewValue: SmallInt;
      Direction: TUpDownDirection);
    procedure UpDownTextureHeightChangingEx(Sender: TObject;
      var AllowChange: Boolean; NewValue: SmallInt;
      Direction: TUpDownDirection);
    procedure cbPixelFormatChange(Sender: TObject);
    procedure txtPatternWidthChange(Sender: TObject);
    procedure txtPatternHeightChange(Sender: TObject);
    procedure txtTextureWidthChange(Sender: TObject);
    procedure txtTextureHeightChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FMaskAlpha: Boolean;
    FImage: TSystemSurface;
    FPixelFormat: TPxFm;
    FIsFileOpen: Boolean;
    FIsDimValid: Boolean;

    function OpenFile(FileName: String): Boolean;
    function SaveToStream(out AStream: TMemoryStream): Boolean;
    function ValidateDimensions(Sender: TObject): Boolean;

    procedure CreatePixelFormatList;
    procedure ProcessDimentions;
  public
    { Public declarations }
  end;

var
  ImportImageForm: TImportImageForm;

implementation

uses
  Editor.MainForm;

{$R *.dfm}

procedure TImportImageForm.bImportClick(Sender: TObject);
var
  Stream: TMemoryStream;
  BoolResult: Boolean;
  IntegerResult: Integer;
begin
  IntegerResult := -1;

  if EditorManager.ControlManager.Root.Images.IndexOf(txtKeyName.Text) <> -1
  then
  begin
    ShowMessage('Your project already contains the key "' +
      txtKeyName.Text + '".');
    ModalResult := mrNone;
    Exit;
  end;

  Stream := TMemoryStream.Create;

  BoolResult := Self.SaveToStream(Stream);

  if BoolResult then
  begin
    IntegerResult := EditorManager.ControlManager.Images.InsertFromStream
      (txtKeyName.Text, Stream);

    if IntegerResult <> -1 then
    begin
      EditorManager.ControlManager.Root.Images.Add(txtKeyName.Text);
    end;
  end;

  Stream.Free;

  if (BoolResult) and (IntegerResult <> -1) then
  begin
    ModalResult := mrOk;
  end
  else
  begin
    ModalResult := mrAbort;
  end;
end;

procedure TImportImageForm.bOpenFileClick(Sender: TObject);
var
  TempStr: String;
begin
  if OpenDialog1.Execute then
  begin
    if OpenFile(OpenDialog1.FileName) then
    begin
      txtFileName.Text := OpenDialog1.FileName;
      TempStr := ExtractFileName(OpenDialog1.FileName);
      Delete(TempStr, pos('.', TempStr), Length(TempStr));
      txtKeyName.Text := TempStr;

      FIsFileOpen := True;
      FIsDimValid := True;
      // GroupSize.Enabled := True;
      GroupAlpha.Enabled := True;
      GroupKey.Enabled := True;
      GroupPixel.Enabled := True;
      bImport.Enabled := True;
    end
    else
    begin
      ShowMessage('Failed loading source bitmap!');
    end;
  end;
end;

procedure TImportImageForm.cbPixelFormatChange(Sender: TObject);
begin
  FPixelFormat.Format := StrToFormat(cbPixelFormat.Items.Strings
    [cbPixelFormat.ItemIndex]);
end;

procedure TImportImageForm.CreatePixelFormatList;
var
  I: Integer;
begin
  cbPixelFormat.Items.Clear;

  for I := 1 to Ord(High(TAsphyrePixelFormat)) do
  begin
    cbPixelFormat.Items.Add(FormatToStr(TAsphyrePixelFormat(I)));
  end;

  cbPixelFormat.ItemIndex := 1;
  FPixelFormat.Format := StrToFormat(cbPixelFormat.Items.Strings
    [cbPixelFormat.ItemIndex]);
end;

procedure TImportImageForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if FImage <> nil then
    FImage.Free;
end;

procedure TImportImageForm.FormShow(Sender: TObject);
begin
  FMaskAlpha := False;
  FIsFileOpen := False;
  FIsDimValid := False;

  txtFileName.Text := '';
  GroupSize.Enabled := False;
  GroupAlpha.Enabled := False;
  GroupKey.Enabled := False;
  GroupPixel.Enabled := False;
  bImport.Enabled := False;

  CreatePixelFormatList;

  UpDownPatternWidth.Min := 1;
  UpDownPatternWidth.Max := High(Integer);

  UpDownPatternHeight.Min := 1;
  UpDownPatternHeight.Max := High(Integer);

  UpDownTextureWidth.Min := 16;
  UpDownTextureWidth.Max := High(Integer);

  UpDownTextureHeight.Min := 16;
  UpDownTextureHeight.Max := High(Integer);

  FImage := TSystemSurface.Create;
end;

procedure TImportImageForm.MaskColorClick(Sender: TObject);
begin
  ColorDialog1.Color := MaskColor.Color;

  if ColorDialog1.Execute then
  begin
    MaskColor.Color := ColorDialog1.Color;
  end;
end;

function TImportImageForm.OpenFile(FileName: String): Boolean;
var
  pc, pw, ph, tw, th, tc: Integer;
  // twc, thc: integer;
begin
  Result := BitmapManager.LoadFromFile(FileName, FImage);

  if (Result = True) then
  begin
    // tw := 16;
    // th := 16;
    // tc := 1;

    pw := FImage.Width;
    ph := FImage.Height;
    pc := 1;

    tw := FImage.Width;
    th := FImage.Height;
    tc := 1;

    // if (pw > ph) and (pw mod ph = 0) then
    // begin
    // pc := (pw  div ph);
    // pw := pw div pc;
    // end;
    //
    // while pw > tw do
    // begin
    // tw := tw * 2;
    // end;
    //
    // while ph > th do
    // begin
    // th := th * 2;
    // end;
    //
    // twc := (tw div pw);
    // thc := (th div ph);
    //
    // while ((twc * thc * tc) < pc) do
    // begin
    //
    // // optimize to 512x512 if possible adding new texture
    // if (twc * thc * tc < pc)
    // and (tw = 512) and (th = 512)
    // and (pw <= 512) and (ph <= 512) then
    // begin
    // tc := tc + 1;
    // continue;
    // end;
    //
    // // optimize to 1024x1012 if possible adding new texture
    // if (twc * thc * tc < pc)
    // and (tw = 1024) and (th = 1024)
    // and (pw <= 1024) and (ph <= 1024) then
    // begin
    // tc := tc + 1;
    // continue;
    // end;
    //
    // // optimize to 2048x2048 if possible adding new texture
    // if (twc * thc * tc < pc)
    // and (tw = 2048) and (th = 2048)
    // and (pw <= 2048) and (ph <= 2048) then
    // begin
    // tc := tc + 1;
    // continue;
    // end;
    //
    // // optimize to 4096x4096 if possible adding new texture
    // if (twc * thc * tc < pc)
    // and (tw = 4096) and (th = 4096)
    // and (pw <= 4096) and (ph <= 4096) then
    // begin
    // tc := tc + 1;
    // continue;
    // end;
    //
    // tw := tw * 2;
    // twc := (tw div pw);
    //
    // if (twc * thc * tc < pc) then
    // begin
    // th := th * 2;
    // thc := (th div ph);
    // end;
    //
    // end;

    FPixelFormat.PatternWidth := pw;
    FPixelFormat.PatternHeight := ph;
    FPixelFormat.PatternCount := pc;
    FPixelFormat.TextureWidth := tw;
    FPixelFormat.TextureHeight := th;
    FPixelFormat.TextureCount := tc;
    FPixelFormat.VisibleWidth := pw;
    FPixelFormat.VisibleHeight := ph;

    UpDownPatternWidth.Position := pw;
    UpDownPatternHeight.Position := ph;

    UpDownTextureWidth.Position := tw;
    UpDownTextureHeight.Position := th;

    // StatusBar1.Panels[0].Text :=
    // 'Patterns: ' + inttostr(pc) +
    // ' [' + inttostr(pw) + 'x' + inttostr(ph) + ']' +
    // ' - Textures: ' + inttostr(tc) +
    // ' [' + inttostr(tw) + 'x' + inttostr(th) + ']';
    StatusBar1.Panels[1].Text := 'Image size: ' + inttostr(FImage.Width) + ' x '
      + inttostr(FImage.Height) + '';
  end;
end;

procedure TImportImageForm.ProcessDimentions;
var
  pc, pw, ph, tw, th, tc: Integer;
  twc, thc: Integer;
begin
  tw := StrToInt(txtTextureWidth.Text);
  th := StrToInt(txtTextureHeight.Text);
  pw := StrToInt(txtPatternWidth.Text);
  ph := StrToInt(txtPatternHeight.Text);

  pc := (FImage.Width div pw) * (FImage.Height div ph);
  tc := 1;

  twc := (tw div pw);
  thc := (th div ph);

  while ((twc * thc * tc) < pc) do
  begin
    tc := tc + 1;
  end;

  FPixelFormat.PatternWidth := pw;
  FPixelFormat.PatternHeight := ph;
  FPixelFormat.PatternCount := pc;
  FPixelFormat.TextureWidth := tw;
  FPixelFormat.TextureHeight := th;
  FPixelFormat.TextureCount := tc;
  FPixelFormat.VisibleWidth := pw;
  FPixelFormat.VisibleHeight := ph;

  StatusBar1.Panels[0].Text := 'Patterns: ' + inttostr(pc) + ' [' + inttostr(pw)
    + 'x' + inttostr(ph) + ']' + ' - Textures: ' + inttostr(tc) + ' [' +
    inttostr(tw) + 'x' + inttostr(th) + ']';
end;

procedure TImportImageForm.rbFromMaskClick(Sender: TObject);
begin
  FMaskAlpha := True;
  MaskColor.Enabled := rbFromMask.Checked;
  ToleranceRange.Enabled := rbFromMask.Checked;
end;

procedure TImportImageForm.rbFromSourceClick(Sender: TObject);
begin
  FMaskAlpha := False;
  MaskColor.Enabled := rbFromMask.Checked;
  ToleranceRange.Enabled := rbFromMask.Checked;
end;

function TImportImageForm.SaveToStream(out AStream: TMemoryStream): Boolean;
var
  Dest: TSystemSurface;

  AuxMem: Pointer;
  AuxSize: Integer;
  Index: Integer;
  Tolerance: Integer;
begin
  Dest := TSystemSurface.Create();

  Tolerance := Trunc((ToleranceRange.Position * 57.73502692) / 100);

  TileBitmap(Dest, FImage, Point2px(FPixelFormat.TextureWidth,
    FPixelFormat.TextureHeight), Point2px(FPixelFormat.PatternWidth,
    FPixelFormat.PatternHeight), Point2px(FPixelFormat.PatternWidth,
    FPixelFormat.PatternHeight), FMaskAlpha, MaskColor.Color, Tolerance);

  // --> Format
  StreamPutByte(AStream, Byte(FPixelFormat.Format));
  // --> Pattern Size
  StreamPutWord(AStream, FPixelFormat.PatternWidth);
  StreamPutWord(AStream, FPixelFormat.PatternHeight);
  // --> Pattern Count
  StreamPutLongInt(AStream, FPixelFormat.PatternCount);
  // --> Visible Size
  StreamPutWord(AStream, FPixelFormat.VisibleWidth);
  StreamPutWord(AStream, FPixelFormat.VisibleHeight);
  // --> Texture Size
  StreamPutWord(AStream, FPixelFormat.TextureWidth);
  StreamPutWord(AStream, FPixelFormat.TextureHeight);
  // --> Texture Count
  StreamPutWord(AStream, FPixelFormat.TextureCount);

  // Allocate auxiliary memory for pixel conversion.
  AuxSize := (FPixelFormat.TextureWidth * AsphyrePixelFormatBits
    [FPixelFormat.Format]) div 8;
  AuxMem := AllocMem(AuxSize);

  // Convert pixel data and write it to the stream.
  try
    for Index := 0 to Dest.Height - 1 do
    begin
      Pixel32toXArray(Dest.ScanLine[Index], AuxMem, FPixelFormat.Format,
        FPixelFormat.TextureWidth);
      AStream.WriteBuffer(AuxMem^, AuxSize);
    end;
  except
    FreeMem(AuxMem);
    Dest.Free;

    Result := False;
    Exit;
  end;

  // Release auxiliary memory.
  FreeMem(AuxMem);
  Dest.Free;

  // position to the beginning of our stream
  AStream.Seek(0, soFromBeginning);

  Result := True;
end;

procedure TImportImageForm.txtPatternHeightChange(Sender: TObject);
begin
  if FIsFileOpen then
    bImport.Enabled := ValidateDimensions(Sender);
end;

procedure TImportImageForm.txtPatternWidthChange(Sender: TObject);
begin
  if FIsFileOpen then
    bImport.Enabled := ValidateDimensions(Sender);
end;

procedure TImportImageForm.txtTextureHeightChange(Sender: TObject);
begin
  if FIsFileOpen then
    bImport.Enabled := ValidateDimensions(Sender);
end;

procedure TImportImageForm.txtTextureWidthChange(Sender: TObject);
begin
  if FIsFileOpen then
    bImport.Enabled := ValidateDimensions(Sender);
end;

procedure TImportImageForm.UpDownTextureHeightChangingEx(Sender: TObject;
  var AllowChange: Boolean; NewValue: SmallInt; Direction: TUpDownDirection);
// var
// i: Integer;
begin
  // i := NewValue mod 16;
  //
  // if direction = updUp then
  // NewValue := NewValue + i;
  //
  // if direction = updDown then
  // NewValue := NewValue - i;

end;

procedure TImportImageForm.UpDownTextureWidthChangingEx(Sender: TObject;
  var AllowChange: Boolean; NewValue: SmallInt; Direction: TUpDownDirection);
// var
// i: Integer;
begin
  // i := NewValue mod 16;
  //
  // if direction = updUp then
  // NewValue := NewValue + i;
  //
  // if direction = updDown then
  // NewValue := NewValue - i;
end;

function TImportImageForm.ValidateDimensions(Sender: TObject): Boolean;
var
  pw, ph, tw, th: Integer;
begin
  FIsDimValid := False;

  try
    pw := StrToInt(txtPatternWidth.Text);
    ph := StrToInt(txtPatternHeight.Text);
    tw := StrToInt(txtTextureWidth.Text);
    th := StrToInt(txtTextureHeight.Text);
  except
    StatusBar1.Panels[0].Text := 'Introduced value is invalid.';

    Result := False;
    Exit;
  end;

  if (th < ph) then
  begin
    StatusBar1.Panels[0].Text := 'Can''t use this definitions.';

    Result := False;
    Exit;
  end;

  if (tw < pw) then
  begin
    StatusBar1.Panels[0].Text := 'Can''t use this definitions.';

    Result := False;
    Exit;
  end;

  if (FImage.Width mod pw <> 0) then
  begin
    StatusBar1.Panels[0].Text := 'Can''t use this definitions.';

    Result := False;
    Exit;
  end;

  if (FImage.Height mod ph <> 0) then
  begin
    StatusBar1.Panels[0].Text := 'Can''t use this definitions.';

    Result := False;
    Exit;
  end;

  ProcessDimentions;

  FIsDimValid := True;
  Result := True;
end;

end.
