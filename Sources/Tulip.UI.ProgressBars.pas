{******************************************************************************}
{                                                                              }
{                        Tulip - User Interface Library                        }
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
{  The Original Code is Tulip.UI.ProgressBars.pas.                             }
{                                                                              }
{  The Initial Developer of the Original Code is Marcos Gomes.                 }
{  Portions created by Marcos Gomes are Copyright (C) 2012, Marcos Gomes.      }
{  All Rights Reserved.                                                        }
{                                                                              }
{******************************************************************************}
{                                                                              }
{  Tulip.UI.ProgressBars.pas                            Modified: 05-Out-2012  }
{  --------------------------------------------------------------------------  }
{                                                                              }
{                 Base Implementations for ProgressBar Controls                }
{                                                                              }
{                                Version 1.02                                  }
{                                                                              }
{******************************************************************************}

unit Tulip.UI.ProgressBars;

interface

uses
  System.SysUtils, System.Types, System.Classes,
  // PXL Units
  PXL.Canvas,
  PXL.Images,
  PXL.Fonts,
  PXL.Types,
  // Tulip UI Units
  Tulip.UI.Classes, Tulip.UI.Types, Tulip.UI.Utils, Tulip.UI.Controls,
  Tulip.UI.Forms, Tulip.UI.Helpers;

type
{$REGION 'TCustomAProgressBar'}
  TCustomAProgressBar = class(TAControl)
  private
    FAntialiased: Boolean;
    FBorder: TBorder;
    FCanMoveHandle: Boolean;
    FCaption: String;
    FColor: TFillColor;
    FDisplay: TProgressDisplay;
    FFont: TFormatedFont;
    FImage: TImage;
    FMargin: Word;
    FMax: Cardinal;
    FMin: Cardinal;
    FPosition: Cardinal;
    FProgressColor: TFillColor;
    FTransparent: Boolean;
    procedure SetAntialiased(Value: Boolean);
    procedure SetBorder(Value: TBorder);
    procedure SetCanMoveHandle(Value: Boolean);
    procedure SetCaption(Value: String);
    procedure SetColor(Color: TFillColor);
    procedure SetDisplay(Value: TProgressDisplay);
    procedure SetFont(Value: TFormatedFont);
    procedure SetImage(Value: TImage);
    procedure SetMargin(Value: Word);
    procedure SetMax(Value: Cardinal);
    procedure SetMin(Value: Cardinal);
    procedure SetPosition(Value: Cardinal);
    procedure SetProgressColor(Value: TFillColor);
    procedure SetTransparent(Value: Boolean);
  protected
    procedure AssignTo(Dest: TPersistent); override;
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function GetPercentage: Cardinal;

    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;

    property Antialiased: Boolean read FAntialiased write SetAntialiased;
    property Border: TBorder read FBorder write SetBorder;
    property CanMoveHandle: Boolean read FCanMoveHandle write SetCanMoveHandle;
    property Caption: String read FCaption write SetCaption;
    property Color: TFillColor read FColor write SetColor;
    property Display: TProgressDisplay read FDisplay write SetDisplay;
    property Font: TFormatedFont read FFont write SetFont;
    property Image: TImage read FImage write SetImage;
    property Margin: Word read FMargin write SetMargin;
    property Max: Cardinal read FMax write SetMax;
    property Min: Cardinal read FMin write SetMin;
    property Position: Cardinal read FPosition write SetPosition;
    property ProgressColor: TFillColor read FProgressColor
      write SetProgressColor;
    property Transparent: Boolean read FTransparent write SetTransparent;
  end;
{$ENDREGION}

implementation

var
  XOffSet, YOffSet: Integer;

{$REGION 'TCustomAProgressBar'}
  { TCustomAProgressBar }

procedure TCustomAProgressBar.AssignTo(Dest: TPersistent);
begin
  ControlState := ControlState + [csReadingState];

  inherited AssignTo(Dest);

  if Dest is TCustomAProgressBar then
    with TCustomAProgressBar(Dest) do
    begin
      Antialiased := Self.Antialiased;
      Border := Self.Border;
      CanMoveHandle := Self.CanMoveHandle;
      Caption := Self.Caption;
      Color := Self.Color;
      Display := Self.Display;
      Font := Self.Font;
      Image := Self.Image;
      Margin := Self.Margin;
      Max := Self.Max;
      Min := Self.Min;
      Position := Self.Position;
      ProgressColor := Self.ProgressColor;
      Transparent := Self.Transparent;
    end;

  ControlState := ControlState - [csReadingState];
end;

constructor TCustomAProgressBar.Create(AOwner: TComponent);
var
  Num: Integer;
begin
  ControlState := ControlState + [csCreating];

  inherited Create(AOwner);

  if (AOwner <> nil) and (AOwner <> Self) and (AOwner is TWControl) then
  begin
    // Auto generate name
    Num := 1;
    while AOwner.FindComponent('ProgressBar' + IntToStr(Num)) <> nil do
      Inc(Num);
    Name := 'ProgressBar' + IntToStr(Num);
  end;

  // Set Fields
  FAntialiased := True;
  FBorder := TBorder.Create;
  FBorder.Color := $B0FFFFFF;
  FBorder.Size := 1;
  FCanMoveHandle := True;
  FCaption := '';
  FColor := TFillColor.Create($FF4090F0, $FF4090F0, $FF6EAAF4, $FF6EAAF4);
  FDisplay := pdPercentage;
  FFont := TFormatedFont.Create;
  FFont.Color.SetColor($B0FFFFFF, $B0FFFFFF);
  FImage := TImage.Create;
  FMargin := 1;
  FMax := 100;
  FMin := 0;
  FPosition := 0;
  FProgressColor := TFillColor.Create($FFA6CAF0, $FFA6CAF0, $FF4090F0,
    $FF4090F0);
  FTransparent := False;

  // Set Properties
  Self.Left := 0;
  Self.Top := 0;
  Self.Height := 24;
  Self.Width := 120;

  ControlState := ControlState - [csCreating];
end;

destructor TCustomAProgressBar.Destroy;
begin
  FBorder.Free;
  FColor.Free;
  FFont.Free;
  FImage.Free;
  FProgressColor.Free;

  inherited;
end;

function TCustomAProgressBar.GetPercentage: Cardinal;
begin
  Result := Round((FPosition / FMax) * 100);
end;

procedure TCustomAProgressBar.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  // Start move the form Handle
  if (FCanMoveHandle) and (Handle is TCustomAForm) then
  begin
    if (Button = mbLeft) and (TCustomAForm(Handle).CanMove) then
    begin
      XOffSet := X - TCustomAForm(Handle).Left;
      YOffSet := Y - TCustomAForm(Handle).Top;
      TCustomAForm(Handle).IsMoving := True;
    end;
  end;

  inherited MouseDown(Button, Shift, X, Y);
end;

procedure TCustomAProgressBar.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  // Move the form Handle
  if (FCanMoveHandle) and (Handle is TCustomAForm) then
  begin
    if TCustomAForm(Handle).IsMoving = True then
    begin
      TCustomAForm(Handle).Left := X - XOffSet;
      TCustomAForm(Handle).Top := Y - YOffSet;
    end;
  end;

  inherited MouseMove(Shift, X, Y);
end;

procedure TCustomAProgressBar.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  // Stop move the form Handle
  if (FCanMoveHandle) and (Handle is TCustomAForm) then
  begin
    if (Button = mbLeft) and (TCustomAForm(Handle).IsMoving) then
      TCustomAForm(Handle).IsMoving := False;
  end;

  inherited MouseUp(Button, Shift, X, Y);
end;

procedure TCustomAProgressBar.Paint;
var
  X, Y: Integer;
  AFont: TBitmapFont;
  AImage: TAtlasImage;
  bTop, bBottom: TConstraintSize;
  L, W: Integer;
  AText: String;
begin
  // Set initial values
  X := ClientLeft;
  Y := ClientTop;

  if FAntialiased then
    Include(ControlManager.Canvas.Attributes, Antialias)
  else
    Exclude(ControlManager.Canvas.Attributes, Antialias);

  // Draw Background
  if not FTransparent then
  begin
    AImage := ControlManager.Images.Image[FImage.Image];
    if AImage <> nil then
    begin
      ControlManager.Canvas.UseImagePx(AImage, FloatRect4(FImage.Rect));
      ControlManager.Canvas.TexQuad(FloatRect4(Rect(X, Y, X + Width, Y + Height)),
        cAlpha4(FColor), Normal);
    end
    else
    begin
      ControlManager.Canvas.FillRect(Rect(X, Y, X + Width, Y + Height),
        cColor4(FColor), Normal);
    end;
  end;

  // Draw Border
  if Border.Size > 0 then
  begin
    bTop := 0;
    bBottom := 0;

    if eTop in Border.Edges then
    begin
      ControlManager.Canvas.FillRect(Rect(X, Y, X + Width, Y + Border.Size),
        Border.Color, Normal);
      bTop := Border.Size;
    end;

    if eBottom in Border.Edges then
    begin
      ControlManager.Canvas.FillRect(Rect(X, Y + Height - Border.Size,
        X + Width, Y + Height), Border.Color, Normal);
      bBottom := Border.Size;
    end;

    if eLeft in Border.Edges then
      ControlManager.Canvas.FillRect(Rect(X, Y + bTop, X + Border.Size,
        Y + Height - bBottom), Border.Color, Normal);

    if eRight in Border.Edges then
      ControlManager.Canvas.FillRect(Rect(X + Width - Border.Size, Y + bTop,
        X + Width, Y + Height - bBottom), Border.Color, Normal);
  end;

  // Draw progress
  L := X + FBorder.Size + FMargin;
  W := Self.Width - FBorder.Size - FMargin;

  if Round(W * (FPosition * (1 / (FMax)))) > 0 then
  begin
    ControlManager.Canvas.FillRect(Rect(L, Y + FBorder.Size + FMargin,
      X + Round(W * (FPosition / FMax)), Y + Self.Height - FBorder.Size -
      FMargin), cColor4(FProgressColor), Normal);
  end;

  case FDisplay of
    pdNone:
      AText := '';
    pdValue:
      AText := Format('%d', [FPosition]);
    pdPercentage:
      AText := Format('%d%%', [GetPercentage]);
    pdCustom:
      AText := FCaption;
  end;

  // Draw DisplayText
  AFont := ControlManager.Fonts.Font[FFont.Name];
  if (AFont <> nil) and (AText <> '') then
  begin
    AFont.TextRectEx(Point2(X + Border.Size + Margin, Y + Border.Size + Margin +
      1), Point2(Width - (Border.Size * 2) - (Margin * 2),
      Height - (Border.Size * 2) - (Margin * 2)), AText, cColor2(FFont.Color),
      1.0, FFont.HorizontalAlign, FFont.VerticalAlign, FFont.ParagraphLine);
  end;
end;

procedure TCustomAProgressBar.SetAntialiased(Value: Boolean);
begin
  FAntialiased := Value;
end;

procedure TCustomAProgressBar.SetBorder(Value: TBorder);
begin
  if Value <> nil then
    FBorder.Assign(Value);
end;

procedure TCustomAProgressBar.SetCanMoveHandle(Value: Boolean);
begin
  FCanMoveHandle := Value
end;

procedure TCustomAProgressBar.SetCaption(Value: String);
begin
  FCaption := Value;
end;

procedure TCustomAProgressBar.SetColor(Color: TFillColor);
begin
  if Color <> nil then
    FColor.Assign(Color);
end;

procedure TCustomAProgressBar.SetDisplay(Value: TProgressDisplay);
begin
  FDisplay := Value;
end;

procedure TCustomAProgressBar.SetFont(Value: TFormatedFont);
begin
  if Value <> nil then
    FFont.Assign(Value);
end;

procedure TCustomAProgressBar.SetImage(Value: TImage);
begin
  if Value <> nil then
    FImage.Assign(Value);
end;

procedure TCustomAProgressBar.SetMargin(Value: Word);
begin
  FMargin := Value;
end;

procedure TCustomAProgressBar.SetMax(Value: Cardinal);
begin
  FMax := Value;

  if FMax < FMin then
    FMax := FMin;

  if FPosition > FMax then
    FPosition := FMax;
end;

procedure TCustomAProgressBar.SetMin(Value: Cardinal);
begin
  FMin := Value;

  if FMin > FMax then
    FMin := FMax;

  if FPosition < FMin then
    FPosition := FMin;
end;

procedure TCustomAProgressBar.SetPosition(Value: Cardinal);
begin
  FPosition := Value;

  if Value < FMin then
    FPosition := FMin;

  if Value > FMax then
    FPosition := FMax;
end;

procedure TCustomAProgressBar.SetProgressColor(Value: TFillColor);
begin
  if Value <> nil then
    FProgressColor.Assign(Value);
end;

procedure TCustomAProgressBar.SetTransparent(Value: Boolean);
begin
  FTransparent := Value;
end;
{$ENDREGION}

end.
