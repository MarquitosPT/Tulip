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
{  The Original Code is Tulip.UI.TrackBars.pas.                                }
{                                                                              }
{  The Initial Developer of the Original Code is Marcos Gomes.                 }
{  Portions created by Marcos Gomes are Copyright (C) 2012, Marcos Gomes.      }
{  All Rights Reserved.                                                        }
{                                                                              }
{******************************************************************************}
{                                                                              }
{  Tulip.UI.TrackBars.pas                               Modified: 05-Out-2012  }
{  --------------------------------------------------------------------------  }
{                                                                              }
{                 Base Implementations for TrackBar Controls                   }
{                                                                              }
{                                Version 1.02                                  }
{                                                                              }
{******************************************************************************}

unit Tulip.UI.TrackBars;

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
{$REGION 'TCustomATrackBar'}
  TCustomATrackBar = class(TWControl)
  private
    FAntialiased: Boolean;
    FBorder: TBorder;
    FButton: TBtBox;
    FColor: TFillColor;
    FFocusRect: TFocusRect;
    FImage: TImage;
    FIncrement: Integer;
    FMargin: Word;
    FMax: Integer;
    FMin: Integer;
    FPosition: Integer;
    FTransparent: Boolean;

    procedure SetAntialiased(Value: Boolean);
    procedure SetBorder(Value: TBorder);
    procedure SetButton(Value: TBtBox);
    procedure SetColor(Value: TFillColor);
    procedure SetFocusRect(Value: TFocusRect);
    procedure SetImage(Value: TImage);
    procedure SetIncrement(Value: Integer);
    procedure SetMargin(Value: Word);
    procedure SetMax(Value: Integer);
    procedure SetMin(Value: Integer);
    procedure SetPosition(Value: Integer);
    procedure SetTransparent(Value: Boolean);
  protected
    procedure AssignTo(Dest: TPersistent); override;
    procedure Paint; override;

    procedure SetHeight(Value: Integer); override;
    procedure SetWidth(Value: Integer); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function GetPercentage: Integer;

    procedure KeyDown(var Key: Word; Shift: TShiftState); override;

    procedure MouseLeave; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;

    function MouseWheelDown(Shift: TShiftState; MousePos: TPoint)
      : Boolean; override;
    function MouseWheelUp(Shift: TShiftState; MousePos: TPoint)
      : Boolean; override;

    property Antialiased: Boolean read FAntialiased write SetAntialiased;
    property Border: TBorder read FBorder write SetBorder;
    property Button: TBtBox read FButton write SetButton;
    property Color: TFillColor read FColor write SetColor;
    property FocusRect: TFocusRect read FFocusRect write SetFocusRect;
    property Image: TImage read FImage write SetImage;
    property Increment: Integer read FIncrement write SetIncrement;
    property Margin: Word read FMargin write SetMargin;
    property Max: Integer read FMax write SetMax;
    property Min: Integer read FMin write SetMin;
    property Position: Integer read FPosition write SetPosition;
    property Transparent: Boolean read FTransparent write SetTransparent;
  end;
{$ENDREGION}

implementation

{$REGION 'TCustomATrackBar'}
{ TCustomATrackBar }

procedure TCustomATrackBar.AssignTo(Dest: TPersistent);
begin
  ControlState := ControlState + [csReadingState];

  inherited AssignTo(Dest);

  if Dest is TCustomATrackBar then
    with TCustomATrackBar(Dest) do
    begin
      Antialiased := Self.Antialiased;
      Border := Self.Border;
      Button := Self.Button;
      Color := Self.Color;
      FocusRect := Self.FocusRect;
      Image := Self.Image;
      Increment := Self.Increment;
      Margin := Self.Margin;
      Max := Self.Max;
      Min := Self.Min;
      Position := Self.Position;
      Transparent := Self.Transparent;
    end;

  ControlState := ControlState - [csReadingState];
end;

constructor TCustomATrackBar.Create(AOwner: TComponent);
var
  Num: Integer;
begin
  ControlState := ControlState + [csCreating];

  inherited Create(AOwner);

  if (AOwner <> nil) and (AOwner <> Self) and (AOwner is TWControl) then
  begin
    // Auto generate name
    Num := 1;
    while AOwner.FindComponent('TrackBar' + IntToStr(Num)) <> nil do
      Inc(Num);
    Name := 'TrackBar' + IntToStr(Num);
  end;

  // Set Fields
  FAntialiased := True;
  FBorder := TBorder.Create;
  FBorder.Color := $B0FFFFFF;
  FBorder.Size := 1;
  FButton := TBtBox.Create;
  FColor := TFillColor.Create($FF4090F0, $FF4090F0, $FF6EAAF4, $FF6EAAF4);
  FFocusRect := fDark;
  FImage := TImage.Create;
  FIncrement := 10;
  FMargin := 1;
  FMax := 100;
  FMin := 0;
  FPosition := 0;
  FTransparent := False;

  // Set Properties
  Self.Left := 0;
  Self.Top := 0;
  Self.Height := 16;
  Self.Width := 120;
  Self.TabStop := True;

  ControlState := ControlState - [csCreating];
end;

destructor TCustomATrackBar.Destroy;
begin
  FBorder.Free;
  FButton.Free;
  FColor.Free;
  FImage.Free;

  inherited;
end;

function TCustomATrackBar.GetPercentage: Integer;
begin
  Result := Round((FPosition / FMax) * 100);
end;

procedure TCustomATrackBar.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if Key = 39 then // right
  begin
    Self.Position := FPosition + FIncrement;
  end;

  if Key = 37 then // left
  begin
    Self.Position := FPosition - FIncrement;
  end;

  if Key = 36 then // home
  begin
    Self.Position := FMin;
  end;

  if Key = 35 then // end
  begin
    Self.Position := FMax;
  end;

  inherited KeyDown(Key, Shift);
end;

procedure TCustomATrackBar.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  L, T, H, W, Pos, BtL, BtW: Integer;
begin
  L := ClientLeft + FBorder.Size + FMargin + (FButton.Width div 2);
  W := Self.Width - FBorder.Size * 2 - FMargin * 2 - FButton.Width;
  T := ClientTop + Round((Self.Height / 2) - (FButton.Height / 2));
  H := T + FButton.Height;

  Pos := L + Round((FPosition / FMax) * W);
  BtL := Pos - (FButton.Width div 2);
  BtW := Pos + (FButton.Width div 2);

  if PtInRect(Rect(BtL, T, BtW, H), Point(X, Y)) then
  begin
    FButton.ControlState := FButton.ControlState + [csClicked];
  end;

  Self.SetFocus;

  inherited MouseDown(Button, Shift, X, Y);
end;

procedure TCustomATrackBar.MouseLeave;
begin
  FButton.ControlState := FButton.ControlState - [csMouseHover];

  inherited;
end;

procedure TCustomATrackBar.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  L, T, H, W, Pos, BtL, BtW: Integer;
  VPos: Integer;
begin
  L := ClientLeft + FBorder.Size + FMargin + (FButton.Width div 2);
  W := Self.Width - FBorder.Size * 2 - FMargin * 2 - FButton.Width;
  T := ClientTop + Round((Self.Height / 2) - (FButton.Height / 2));
  H := T + FButton.Height;

  if csClicked in FButton.ControlState then
  begin
    VPos := X - L;
    Self.Position := Round((VPos / W) * FMax);
  end;

  Pos := L + Round((FPosition / FMax) * W);
  BtL := Pos - (FButton.Width div 2);
  BtW := Pos + (FButton.Width div 2);

  if PtInRect(Rect(BtL, T, BtW, H), Point(X, Y)) then
  begin
    FButton.ControlState := FButton.ControlState + [csMouseHover];
  end
  else
  begin
    FButton.ControlState := FButton.ControlState - [csMouseHover];
  end;

  inherited MouseMove(Shift, X, Y);
end;

procedure TCustomATrackBar.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  L, T, H, W, Pos, BtL, BtW: Integer;
begin
  L := ClientLeft + FBorder.Size + FMargin + (FButton.Width div 2);
  W := Self.Width - FBorder.Size * 2 - FMargin * 2 - FButton.Width;
  T := ClientTop + Round((Self.Height / 2) - (FButton.Height / 2));
  H := T + FButton.Height;

  Pos := L + Round((FPosition / (FMax - FMin)) * W);
  BtL := Pos - (FButton.Width div 2);
  BtW := Pos + (FButton.Width div 2);

  if not(PtInRect(Rect(BtL, T, BtW, H), Point(X, Y))) and
    not(csClicked in FButton.ControlState) then
  begin
    if (X <= L + (W div 8)) then // 0
    begin
      FPosition := FMin;
    end;
    if (X > L + (W div 8)) and (X <= L + (W div 8) + (W div 4)) then // 1/4
    begin
      FPosition := FMax div 4;
    end;
    if (X > L + (W div 8) + (W div 4)) and (X <= L + (W div 8) + (W div 4) * 2)
    then // 1/2
    begin
      FPosition := FMax div 2;
    end;
    if (X > L + (W div 8) + (W div 4) * 2) and
      (X <= L + (W div 8) + (W div 4) * 3) then // 3/4
    begin
      FPosition := (FMax div 4) * 3;
    end;
    if (X > L + (W div 8) + (W div 4) * 3) then // 1
    begin
      FPosition := FMax;
    end;
  end;

  FButton.ControlState := FButton.ControlState - [csClicked];

  inherited MouseUp(Button, Shift, X, Y);
end;

function TCustomATrackBar.MouseWheelDown(Shift: TShiftState;
  MousePos: TPoint): Boolean;
begin
  Self.Position := FPosition + FIncrement;

  Result := True;
end;

function TCustomATrackBar.MouseWheelUp(Shift: TShiftState;
  MousePos: TPoint): Boolean;
begin
  Self.Position := FPosition - FIncrement;

  Result := True;
end;

procedure TCustomATrackBar.Paint;
var
  X, Y: Integer;
  AImage: TAtlasImage;
  bTop, bBottom: TConstraintSize;
  L, T, H, W, Pos, BtL, BtW: Integer;
  BtBorderColor: TAColor;
  BtColor: TFillColor;
  BtImage: TImage;
begin
  // Set initial values
  X := ClientLeft;
  Y := ClientTop;

//  if FAntialiased then
//    Include(ControlManager.Canvas.Attributes, Antialias)
//  else
//    Exclude(ControlManager.Canvas.Attributes, Antialias);

  // Draw Background
  if not FTransparent then
  begin
    AImage := ControlManager.Images.Image[FImage.Image];
    if AImage <> nil then
    begin
      ControlManager.Canvas.UseImagePx(AImage, FloatRect4(FImage.Rect));
      ControlManager.Canvas.TexQuad(FloatRect4(Rect(X, Y, X + Width, Y + Height)),
        cAlpha4(FColor), TBlendingEffect.Normal);
    end
    else
    begin
      ControlManager.Canvas.FillRect(FloatRectBDS(X, Y, X + Width, Y + Height),
        cColor4(FColor), TBlendingEffect.Normal);
    end;
  end;

  // Draw Border
  if Border.Size > 0 then
  begin
    bTop := 0;
    bBottom := 0;

    if eTop in Border.Edges then
    begin
      ControlManager.Canvas.FillRect(FloatRectBDS(X, Y, X + Width, Y + Border.Size),
        Border.Color, TBlendingEffect.Normal);
      bTop := Border.Size;
    end;

    if eBottom in Border.Edges then
    begin
      ControlManager.Canvas.FillRect(FloatRectBDS(X, Y + Height - Border.Size,
        X + Width, Y + Height), Border.Color, TBlendingEffect.Normal);
      bBottom := Border.Size;
    end;

    if eLeft in Border.Edges then
      ControlManager.Canvas.FillRect(FloatRectBDS(X, Y + bTop, X + Border.Size,
        Y + Height - bBottom), Border.Color, TBlendingEffect.Normal);

    if eRight in Border.Edges then
      ControlManager.Canvas.FillRect(FloatRectBDS(X + Width - Border.Size, Y + bTop,
        X + Width, Y + Height - bBottom), Border.Color, TBlendingEffect.Normal);
  end;

  // Draw Focus rect
  if (ControlManager.ActiveControl = Self) and (Self.FocusRect = fLight) then
  begin
    ControlManager.Canvas.FrameRect(FloatRectBDS(X - 1, Y - 1, X + Width + 1,
      Y + Height + 1), IntColor4($40FFFFFF), TBlendingEffect.Normal);
  end;
  if (ControlManager.ActiveControl = Self) and (Self.FocusRect = fDark) then
  begin
    ControlManager.Canvas.FrameRect(FloatRectBDS(X - 1, Y - 1, X + Width + 1,
      Y + Height + 1), IntColor4($30000000), TBlendingEffect.Normal);
  end;

  // Draw button
  L := X + FBorder.Size + FMargin + (FButton.Width div 2);
  W := Self.Width - FBorder.Size * 2 - FMargin * 2 - FButton.Width;
  // T := Y + FBorder.Size + FMargin;
  T := Y + Round((Self.Height / 2) - (FButton.Height / 2));
  // H := Y + Self.Height - FBorder.Size - FMargin;
  H := T + FButton.Height;

  Pos := L + Round((FPosition / (FMax)) * W);
  BtL := Pos - (FButton.Width div 2);
  BtW := Pos + (FButton.Width div 2);

  if csClicked in FButton.ControlState then // mouse pressed
  begin
    BtColor := FButton.ColorPressed;
    BtImage := FButton.ImagePressed;
    BtBorderColor := FButton.Border.ColorPressed;
  end
  else if csMouseHover in FButton.ControlState then // MouseHover
  begin
    BtColor := FButton.ColorHover;
    BtImage := FButton.ImageHover;
    BtBorderColor := FButton.Border.ColorHover;
  end
  else // normal
  begin
    BtColor := FButton.Color;
    BtImage := FButton.Image;
    BtBorderColor := FButton.Border.Color;
  end;

  // Draw button background
  AImage := ControlManager.Images.Image[BtImage.Image];
  if AImage <> nil then
  begin
    ControlManager.Canvas.UseImagePx(AImage, FloatRect4(BtImage.Rect));
    ControlManager.Canvas.TexQuad(FloatRect4(Rect(BtL, T, BtW, H)), cAlpha4(BtColor),
      TBlendingEffect.Normal);
  end
  else
  begin
    // Draw shadow scroll area
    ControlManager.Canvas.FillRect(FloatRectBDS(L, T + (FButton.Height div 2) - 1,
      L + W, H - (FButton.Height div 2) + 1), IntColor4($20000000), TBlendingEffect.Normal);

    ControlManager.Canvas.FillRect(FloatRectBDS(BtL, T, BtW, H), cColor4(BtColor),
      TBlendingEffect.Normal);
  end;

  // Draw Button Border
  if FButton.Border.Size > 0 then
  begin
    bTop := 0;
    bBottom := 0;

    if eTop in FButton.Border.Edges then
    begin
      ControlManager.Canvas.FillRect(FloatRectBDS(BtL, T, BtW, T + FButton.Border.Size),
        BtBorderColor, TBlendingEffect.Normal);
      bTop := FButton.Border.Size;
    end;

    if eBottom in FButton.Border.Edges then
    begin
      ControlManager.Canvas.FillRect(FloatRectBDS(BtL, H - FButton.Border.Size, BtW, H),
        BtBorderColor, TBlendingEffect.Normal);
      bBottom := FButton.Border.Size;
    end;

    if eLeft in FButton.Border.Edges then
      ControlManager.Canvas.FillRect(FloatRectBDS(BtL, T + bTop,
        BtL + FButton.Border.Size, H - bBottom), BtBorderColor, TBlendingEffect.Normal);

    if eRight in FButton.Border.Edges then
      ControlManager.Canvas.FillRect(FloatRectBDS(BtW - FButton.Border.Size, T + bTop,
        BtW, H - bBottom), BtBorderColor, TBlendingEffect.Normal);
  end;

end;

procedure TCustomATrackBar.SetAntialiased(Value: Boolean);
begin
  FAntialiased := Value;
end;

procedure TCustomATrackBar.SetBorder(Value: TBorder);
begin
  if Value <> nil then
    FBorder.Assign(Value);
end;

procedure TCustomATrackBar.SetButton(Value: TBtBox);
begin
  if Value <> nil then
    FButton.Assign(Value);
end;

procedure TCustomATrackBar.SetColor(Value: TFillColor);
begin
  if Value <> nil then
    FColor.Assign(Value);
end;

procedure TCustomATrackBar.SetFocusRect(Value: TFocusRect);
begin
  FFocusRect := Value;
end;

procedure TCustomATrackBar.SetHeight(Value: Integer);
var
  MinH: Integer;
begin
  MinH := FBorder.Size * 2 + FMargin * 2 + FButton.Height;

  if Value < MinH then
    Value := MinH;

  inherited SetHeight(Value);
end;

procedure TCustomATrackBar.SetImage(Value: TImage);
begin
  if Value <> nil then
    FImage.Assign(Value);
end;

procedure TCustomATrackBar.SetIncrement(Value: Integer);
begin
  FIncrement := Value;

  if FIncrement > FMax then
    FIncrement := FMax;

  if FIncrement <= 0 then
    FIncrement := 1;
end;

procedure TCustomATrackBar.SetMargin(Value: Word);
begin
  FMargin := Value;

  SetHeight(Self.Height);
  SetWidth(Self.Width);
end;

procedure TCustomATrackBar.SetMax(Value: Integer);
begin
  FMax := Value;

  if FMax < FMin then
    FMax := FMin;

  if FPosition > FMax then
    FPosition := FMax;
end;

procedure TCustomATrackBar.SetMin(Value: Integer);
begin
  FMin := Value;

  if FMin > FMax then
    FMin := FMax;

  if FMin < 0 then
    FMin := 0;

  if FPosition < FMin then
    FPosition := FMin;
end;

procedure TCustomATrackBar.SetPosition(Value: Integer);
begin
  FPosition := Value;

  if FPosition > FMax then
    FPosition := FMax;

  if FPosition < FMin then
    FPosition := FMin;
end;

procedure TCustomATrackBar.SetTransparent(Value: Boolean);
begin
  FTransparent := Value;
end;

procedure TCustomATrackBar.SetWidth(Value: Integer);
var
  MinW: Integer;
begin
  MinW := FBorder.Size * 2 + FMargin * 2 + FButton.Width;

  if Value < MinW then
    Value := MinW;

  inherited SetWidth(Value);
end;
{$ENDREGION}

end.
