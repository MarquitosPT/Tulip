{******************************************************************************}
{                                                                              }
{                        Tulip - User Interface Library                        }
{                                                                              }
{         Copyright(c) 2012 - 2013 Marcos Gomes. All rights Reserved.          }
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
{  The Original Code is Tulip.UI.ListBoxes.pas.                                }
{                                                                              }
{  The Initial Developer of the Original Code is Marcos Gomes.                 }
{  Portions created by Marcos Gomes are Copyright (C) 2012, Marcos Gomes.      }
{  All Rights Reserved.                                                        }
{                                                                              }
{******************************************************************************}
{                                                                              }
{  Tulip.UI.ListBoxes.pas                               Modified: 23-Mar-2013  }
{  --------------------------------------------------------------------------  }
{                                                                              }
{                  Base Implementations for ListBox Controls                   }
{                                                                              }
{                                Version 1.03                                  }
{                                                                              }
{******************************************************************************}

unit Tulip.UI.ListBoxes;

interface

uses
  Winapi.Windows, System.SysUtils, System.Types, System.Classes, System.Math,
  // Aspryre units
  AsphyreTypes, AbstractCanvas, AsphyreFonts, AsphyreImages, AsphyreUtils,
  Vectors2,
  // Tulip UI Units
  Tulip.UI.Classes, Tulip.UI.Types, Tulip.UI.Utils, Tulip.UI.Controls,
  Tulip.UI.Forms, Tulip.UI.Helpers;

type
{$REGION 'TCustomAListBox'}
  TCustomAListBox = class(TWControl)
  private
    FAntialiased: Boolean;
    FBorder: TBorder;
    FColor: TFillColor;
    FDownButton: TBtBox;
    FFocusRect: TFocusRect;
    FFont: TEditFont;
    FImage: TImage;
    FIndex: Integer;
    FLineHeight: Integer;
    FMargin: Word;
    FScrollButton: TBtBox;
    FStrings: TAStringList;
    FTransparent: Boolean;
    FUpButton: TBtBox;

    FVirtualPos: Integer;

    function GetVirtualHeight: Integer;
    function GetVirtualWidth: Integer;

    procedure SetAntialiased(Value: Boolean);
    procedure SetBorder(Value: TBorder);
    procedure SetColor(Value: TFillColor);
    procedure SetDownButton(Value: TBtBox);
    procedure SetFocusRect(Value: TFocusRect);
    procedure SetFont(Value: TEditFont);
    procedure SetImage(Value: TImage);
    procedure SetIndex(Value: Integer);
    procedure SetLineHeight(Value: Integer);
    procedure SetMargin(Value: Word);
    procedure SetScrollButton(Value: TBtBox);
    procedure SetStrings(Value: TAStringList);
    procedure SetTransparent(Value: Boolean);
    procedure SetUpButton(Value: TBtBox);
  protected
    procedure AssignTo(Dest: TPersistent); override;
    procedure Paint; override;
    procedure PaintScrollBar;

    procedure SetHeight(Value: Integer); override;
    procedure SetWidth(Value: Integer); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

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
    property Color: TFillColor read FColor write SetColor;
    property DownButton: TBtBox read FDownButton write SetDownButton;
    property FocusRect: TFocusRect read FFocusRect write SetFocusRect;
    property Font: TEditFont read FFont write SetFont;
    property Image: TImage read FImage write SetImage;
    property ItemIndex: Integer read FIndex write SetIndex;
    property LineHeight: Integer read FLineHeight write SetLineHeight;
    property Lines: TAStringList read FStrings write SetStrings;
    property Margin: Word read FMargin write SetMargin;
    property ScrollButton: TBtBox read FScrollButton write SetScrollButton;
    property Transparent: Boolean read FTransparent write SetTransparent;
    property UpButton: TBtBox read FUpButton write SetUpButton;
  end;
{$ENDREGION}

implementation

{$REGION 'TCustomAListBox'}
{ TCustomAListBox }

procedure TCustomAListBox.AssignTo(Dest: TPersistent);
begin
  ControlState := ControlState + [csReadingState];

  inherited AssignTo(Dest);

  if Dest is TCustomAListBox then
    with TCustomAListBox(Dest) do
    begin
      Antialiased := Self.Antialiased;
      Border := Self.Border;
      Color := Self.Color;
      DownButton := Self.DownButton;
      FocusRect := Self.FocusRect;
      Font := Self.Font;
      Image := Self.Image;
      ItemIndex := Self.ItemIndex;
      LineHeight := Self.LineHeight;
      Lines := Self.Lines;
      Margin := Self.Margin;
      ScrollButton := Self.ScrollButton;
      Transparent := Self.Transparent;
      UpButton := Self.UpButton;
    end;

  ControlState := ControlState - [csReadingState];
end;

constructor TCustomAListBox.Create(AOwner: TComponent);
var
  Num: Integer;
begin
  ControlState := ControlState + [csCreating];

  inherited Create(AOwner);

  if (AOwner <> nil) and (AOwner <> Self) and (AOwner is TWControl) then
  begin
    // Auto generate name
    Num := 1;
    while AOwner.FindComponent('ListBox' + IntToStr(Num)) <> nil do
      Inc(Num);
    Name := 'ListBox' + IntToStr(Num);
  end;

  // Set Fields
  FAntialiased := True;
  FBorder := TBorder.Create;
  FBorder.Color := $B0FFFFFF;
  FBorder.Size := 1;
  FColor := TFillColor.Create($FF4090F0, $FF4090F0, $FF6EAAF4, $FF6EAAF4);
  FDownButton := TBtBox.Create;
  FDownButton.Height := 16;
  FDownButton.Width := 16;
  FFocusRect := fDark;
  FFont := TEditFont.Create;
  FImage := TImage.Create;
  FIndex := -1;
  LineHeight := 16;
  FMargin := 1;
  FScrollButton := TBtBox.Create;
  FScrollButton.Height := 16;
  FScrollButton.Width := 16;
  FStrings := TAStringList.Create;
  FTransparent := False;
  FUpButton := TBtBox.Create;
  FUpButton.Height := 16;
  FUpButton.Width := 16;
  FVirtualPos := 0;

  // Set Properties
  Self.Left := 0;
  Self.Top := 0;
  Self.Height := 120;
  Self.Width := 120;
  Self.TabStop := True;

  ControlState := ControlState - [csCreating];
end;

destructor TCustomAListBox.Destroy;
begin
  FBorder.Free;
  FColor.Free;
  FDownButton.Free;
  FFont.Free;
  FImage.Free;
  FScrollButton.Free;
  FStrings.Free;
  FUpButton.Free;

  inherited;
end;

function TCustomAListBox.GetVirtualHeight: Integer;
begin
  Result := FLineHeight * FStrings.Count;
end;

function TCustomAListBox.GetVirtualWidth: Integer;
begin
  Result := Self.Width - (FBorder.Size * 2) - (FMargin * 2) -
    Max(Max(FUpButton.Width, FDownButton.Width), FScrollButton.Width);
end;

procedure TCustomAListBox.KeyDown(var Key: Word; Shift: TShiftState);
var
  H: Integer;
  dLines: Integer;
begin
  H := Self.Height - FMargin * 2 - FBorder.Size * 2;
  dLines := H div FLineHeight;

  if Key = VK_UP then
  begin
    if (FStrings.Count > 0) and (FIndex > 0) then
    begin
      Self.ItemIndex := FIndex - 1;

      if (Abs(FVirtualPos) > FIndex * FLineHeight) then
      begin
        FVirtualPos := -(FIndex * FLineHeight);
      end;
    end;
  end;

  // Page_Up pressed
  if Key = VK_PRIOR then
  begin
    if (FStrings.Count > 0) and (FIndex > 0) then
    begin
      Self.ItemIndex := FIndex - dLines;

      if (Abs(FVirtualPos) > FIndex * FLineHeight) then
      begin
        FVirtualPos := -(FIndex * FLineHeight);
      end;
    end;
  end;

  if Key = VK_HOME then
  begin
    if (FStrings.Count > 0) and (FIndex > 0) then
    begin
      Self.ItemIndex := 0;

      if (Abs(FVirtualPos) > FIndex * FLineHeight) then
      begin
        FVirtualPos := -(FIndex * FLineHeight);
      end;
    end;
  end;

  if Key = VK_DOWN then
  begin
    if (FStrings.Count > 0) and (FIndex < FStrings.Count - 1) then
    begin
      Self.ItemIndex := FIndex + 1;

      if ((FIndex + 1) * FLineHeight) > (dLines * FLineHeight - FVirtualPos)
      then
      begin
        FVirtualPos := -(((FIndex + 1) * FLineHeight) - (dLines * FLineHeight));
      end;
    end;
  end;

  // Page_Down pressed
  if Key = VK_NEXT then
  begin
    if (FStrings.Count > 0) and (FIndex < FStrings.Count - 1) then
    begin
      Self.ItemIndex := FIndex + dLines;

      if ((FIndex + 1) * FLineHeight) > (dLines * FLineHeight - FVirtualPos)
      then
      begin
        FVirtualPos := -(((FIndex + 1) * FLineHeight) - (dLines * FLineHeight));
      end;
    end;
  end;

  if Key = VK_END then
  begin
    if (FStrings.Count > 0) and (FIndex < FStrings.Count - 1) then
    begin
      Self.ItemIndex := FStrings.Count - 1;

      if ((FIndex + 1) * FLineHeight) > (dLines * FLineHeight - FVirtualPos)
      then
      begin
        FVirtualPos := -(((FIndex + 1) * FLineHeight) - (dLines * FLineHeight));
      end;
    end;
  end;

  inherited KeyDown(Key, Shift);
end;

procedure TCustomAListBox.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  L, T, H, W: Integer;
  upBtL, upBtT, upBtH, upBtW: Integer;
  dnBtL, dnBtT, dnBtH, dnBtW: Integer;
  srBtL, srBtT, srBtH, srBtW: Integer;
  dLines, VPos: Integer;
begin
  // check if user clicked on client list area
  L := Self.ClientLeft + FMargin + FBorder.Size;
  T := Self.ClientTop + FMargin + FBorder.Size;
  W := Self.ClientLeft + FMargin + FBorder.Size + GetVirtualWidth;
  H := Self.ClientTop + Self.Height - FMargin - FBorder.Size;

  if PtInRect(Rect(L, T, W, H), Point(X, Y)) then
  begin
    VPos := (Y - T) - FVirtualPos;
    Self.ItemIndex := VPos div FLineHeight;
  end;

  // Check if user clicked on scroll area
  L := Self.ClientLeft + FMargin + FBorder.Size + GetVirtualWidth;
  // W := Self.ClientLeft + Self.Width - FMargin - FBorder.Size;

  // Test UpButton
  upBtL := L;
  upBtT := T;
  upBtW := L + FUpButton.Width;
  upBtH := T + FUpButton.Height;

  if PtInRect(Rect(upBtL, upBtT, upBtW, upBtH), Point(X, Y)) then
  begin
    FUpButton.ControlState := FUpButton.ControlState + [csClicked];
  end;

  // Test Down Button
  dnBtL := L;
  dnBtT := H - FDownButton.Height;
  dnBtW := L + FDownButton.Width;
  dnBtH := H;

  if PtInRect(Rect(dnBtL, dnBtT, dnBtW, dnBtH), Point(X, Y)) then
  begin
    FDownButton.ControlState := FDownButton.ControlState + [csClicked];
  end;

  // Test Scroll Button
  dLines := (H - T) div FLineHeight;

  T := T + FUpButton.Height;
  H := H - FDownButton.Height;

  srBtL := L;
  srBtT := T + Round(Abs(FVirtualPos) /
    (GetVirtualHeight - (FLineHeight * dLines)) *
    (H - T - FScrollButton.Height));
  srBtW := L + FScrollButton.Width;
  srBtH := srBtT + FScrollButton.Height;

  if PtInRect(Rect(srBtL, srBtT, srBtW, srBtH), Point(X, Y)) then
  begin
    FScrollButton.ControlState := FScrollButton.ControlState + [csClicked];
  end;

  inherited MouseDown(Button, Shift, X, Y);
end;

procedure TCustomAListBox.MouseLeave;
begin
  FUpButton.ControlState := FUpButton.ControlState - [csMouseHover];
  FDownButton.ControlState := FDownButton.ControlState - [csMouseHover];
  FScrollButton.ControlState := FScrollButton.ControlState - [csMouseHover];

  inherited MouseLeave;
end;

procedure TCustomAListBox.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  L, T, H: Integer;
  upBtL, upBtT, upBtH, upBtW: Integer;
  dnBtL, dnBtT, dnBtH, dnBtW: Integer;
  srBtL, srBtT, srBtH, srBtW: Integer;
  dLines, VPos: Integer;
begin
  L := Self.ClientLeft + FMargin + FBorder.Size + GetVirtualWidth;
  T := Self.ClientTop + FMargin + FBorder.Size;
  // W := Self.ClientLeft + Self.Width - FMargin - FBorder.Size;
  H := Self.ClientTop + Self.Height - FMargin - FBorder.Size;

  // Test UpButton
  upBtL := L;
  upBtT := T;
  upBtW := L + FUpButton.Width;
  upBtH := T + FUpButton.Height;

  if PtInRect(Rect(upBtL, upBtT, upBtW, upBtH), Point(X, Y)) then
  begin
    FUpButton.ControlState := FUpButton.ControlState + [csMouseHover];
  end
  else
    FUpButton.ControlState := FUpButton.ControlState - [csMouseHover];

  // Test Down Button
  dnBtL := L;
  dnBtT := H - FDownButton.Height;
  dnBtW := L + FDownButton.Width;
  dnBtH := H;

  if PtInRect(Rect(dnBtL, dnBtT, dnBtW, dnBtH), Point(X, Y)) then
  begin
    FDownButton.ControlState := FDownButton.ControlState + [csMouseHover];
  end
  else
    FDownButton.ControlState := FDownButton.ControlState - [csMouseHover];

  // Test Scroll Button
  dLines := (H - T) div FLineHeight;

  T := T + FUpButton.Height;
  H := H - FDownButton.Height;

  if csClicked in FScrollButton.ControlState then
  begin
    if GetVirtualHeight - (FLineHeight * dLines) > 0 then
    begin
      VPos := Round((Y - (T + FScrollButton.Height div 2)) /
        (H - T - FScrollButton.Height) *
        (GetVirtualHeight - (FLineHeight * dLines)));

      FVirtualPos := -VPos;

      if FVirtualPos > 0 then
        FVirtualPos := 0;

      if (GetVirtualHeight - (FLineHeight * dLines)) < Abs(FVirtualPos) then
        FVirtualPos := -(GetVirtualHeight - (FLineHeight * dLines));
    end;
  end;

  srBtL := L;
  srBtT := T + Round(Abs(FVirtualPos) /
    (GetVirtualHeight - (FLineHeight * dLines)) *
    (H - T - FScrollButton.Height));
  srBtW := L + FScrollButton.Width;
  srBtH := srBtT + FScrollButton.Height;

  if PtInRect(Rect(srBtL, srBtT, srBtW, srBtH), Point(X, Y)) then
  begin
    FScrollButton.ControlState := FScrollButton.ControlState + [csMouseHover];
  end
  else
    FScrollButton.ControlState := FScrollButton.ControlState - [csMouseHover];

  inherited MouseMove(Shift, X, Y);
end;

procedure TCustomAListBox.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  H: Integer;
  dLines: Integer;
begin
  H := Self.Height - FMargin * 2 - FBorder.Size * 2;
  dLines := H div FLineHeight;

  // Button Up released
  if csClicked in FUpButton.ControlState then
  begin
    if (FVirtualPos < 0) then
    begin
      FVirtualPos := FVirtualPos + FLineHeight;

      if FVirtualPos > 0 then
        FVirtualPos := 0;
    end;

    FUpButton.ControlState := FUpButton.ControlState - [csClicked];
  end;

  // Button Down Released
  if csClicked in FDownButton.ControlState then
  begin
    if (GetVirtualHeight - (FLineHeight * dLines) + FVirtualPos > 0) then
    begin
      FVirtualPos := FVirtualPos - FLineHeight;

      if (GetVirtualHeight - (FLineHeight * dLines)) < Abs(FVirtualPos) then
        FVirtualPos := -(GetVirtualHeight - (FLineHeight * dLines));
    end;

    FDownButton.ControlState := FDownButton.ControlState - [csClicked];
  end;

  // Scroll Button released always
  FScrollButton.ControlState := FScrollButton.ControlState - [csClicked];

  inherited MouseUp(Button, Shift, X, Y);
end;

function TCustomAListBox.MouseWheelDown(Shift: TShiftState;
  MousePos: TPoint): Boolean;
var
  H: Integer;
begin
  H := Self.Height - FMargin * 2 - FBorder.Size * 2;

  if (FVirtualPos + GetVirtualHeight >= H) then
  begin
    FVirtualPos := FVirtualPos - FLineHeight;
  end;

  Result := True;
end;

function TCustomAListBox.MouseWheelUp(Shift: TShiftState;
  MousePos: TPoint): Boolean;
begin
  if (FVirtualPos < 0) then
  begin
    FVirtualPos := FVirtualPos + FLineHeight;

    if FVirtualPos > 0 then
      FVirtualPos := 0;
  end;

  Result := True;
end;

procedure TCustomAListBox.Paint;
var
  I, X, Y: Integer;
  ARect: TRect;
  AImage: TAsphyreImage;
  AFont: TAsphyreFont;
  bTop, bBottom: TConstraintSize;
  L, T, H, W: Integer;
begin
  // Set initial values
  X := ClientLeft;
  Y := ClientTop;

  ControlManager.Canvas.Antialias := FAntialiased;

  // Get size Canvas
  ARect := ControlManager.Canvas.ClipRect;

  // Draw Background
  if not FTransparent then
  begin
    AImage := ControlManager.Images.Image[FImage.Image];
    if AImage <> nil then
    begin
      ControlManager.Canvas.UseImagePx(AImage, pRect4(FImage.Rect));
      ControlManager.Canvas.TexMap(pRect4(Rect(X, Y, X + Width, Y + Height)),
        cAlpha4(FColor), beNormal);
    end
    else
    begin
      ControlManager.Canvas.FillRect(Rect(X, Y, X + Width, Y + Height),
        cColor4(FColor), beNormal);
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
        Border.Color, beNormal);
      bTop := Border.Size;
    end;

    if eBottom in Border.Edges then
    begin
      ControlManager.Canvas.FillRect(Rect(X, Y + Height - Border.Size,
        X + Width, Y + Height), Border.Color, beNormal);
      bBottom := Border.Size;
    end;

    if eLeft in Border.Edges then
      ControlManager.Canvas.FillRect(Rect(X, Y + bTop, X + Border.Size,
        Y + Height - bBottom), Border.Color, beNormal);

    if eRight in Border.Edges then
      ControlManager.Canvas.FillRect(Rect(X + Width - Border.Size, Y + bTop,
        X + Width, Y + Height - bBottom), Border.Color, beNormal);
  end;

  // Draw Focus rect
  if (ControlManager.ActiveControl = Self) and (Self.FocusRect = fLight) then
  begin
    ControlManager.Canvas.FrameRect(Rect(X - 1, Y - 1, X + Width + 1,
      Y + Height + 1), cColor4($40FFFFFF), beNormal);
  end;
  if (ControlManager.ActiveControl = Self) and (Self.FocusRect = fDark) then
  begin
    ControlManager.Canvas.FrameRect(Rect(X - 1, Y - 1, X + Width + 1,
      Y + Height + 1), cColor4($30000000), beNormal);
  end;

  PaintScrollBar;

  // Set Rect Canvas
  L := X + FBorder.Size + FMargin;
  T := Y + FBorder.Size + FMargin;
  W := L + GetVirtualWidth;
  H := T + Self.Height - FBorder.Size * 2 - FMargin * 2;

  ControlManager.Canvas.ClipRect := ShortRect(Rect(L, T, W, H), ARect);

  // test
  // ControlManager.Canvas.FillRect(Rect(L, T,W, H), $FFFFFFFF, beNormal);

  if GetVirtualHeight <= (Self.Height - (FBorder.Size * 2) - (FMargin * 2)) then
    FVirtualPos := 0;

  T := T + FVirtualPos;

  // Draw Text
  // Draw DisplayText
  AFont := ControlManager.Fonts.Font[FFont.Name];
  if (AFont <> nil) and (FStrings.Count > 0) then
  begin
    for I := 0 to FStrings.Count - 1 do
    begin
      // Draw selected rect
      if I = FIndex then
      begin
        ControlManager.Canvas.FillRect(Rect(L, T + (LineHeight * I), W,
          T + (LineHeight * (I + 1))), cColor4(FFont.SelectionColor), beNormal);
        AFont.TextOut(Point2(L, T + (LineHeight * I)), FStrings.Items[I],
          cColor2($B0FFFFFF), 1.0);
      end
      else
      begin
        AFont.TextOut(Point2(L, T + (LineHeight * I)), FStrings.Items[I],
          cColor2(FFont.Color), 1.0);
      end;
    end;
  end;

  // Set Rect Canvas
  ControlManager.Canvas.ClipRect := ARect;
end;

procedure TCustomAListBox.PaintScrollBar;
var
  X, Y: Integer;
  AImage: TAsphyreImage;
  bTop, bBottom: TConstraintSize;
  L, T, H, W: Integer;

  upBtColor: TFillColor;
  upBtImage: TImage;
  upBtBorderColor: TAColor;
  upBtL, upBtT, upBtH, upBtW: Integer;

  dnBtColor: TFillColor;
  dnBtImage: TImage;
  dnBtBorderColor: TAColor;
  dnBtL, dnBtT, dnBtH, dnBtW: Integer;

  srBtColor: TFillColor;
  srBtImage: TImage;
  srBtBorderColor: TAColor;
  srBtL, srBtT, srBtH, srBtW: Integer;

  dLines: Integer;
begin
  // Set initial values
  X := ClientLeft;
  Y := ClientTop;

  L := X + FMargin + FBorder.Size + GetVirtualWidth;
  T := Y + FMargin + FBorder.Size;
  W := X + Width - FMargin - FBorder.Size;
  H := Y + Height - FMargin - FBorder.Size;

  // Draw background shadow
  AImage := ControlManager.Images.Image[FImage.Image];
  if AImage = nil then
  begin
    ControlManager.Canvas.FillRect(Rect(L, T, W, H), cColor4($20000000),
      beNormal);
  end;

  // Draw UpButton
  if csClicked in FUpButton.ControlState then
  begin
    upBtColor := FUpButton.ColorPressed;
    upBtImage := FUpButton.ImagePressed;
    upBtBorderColor := FUpButton.Border.ColorPressed;
  end
  else if csMouseHover in FUpButton.ControlState then
  begin
    upBtColor := FUpButton.ColorHover;
    upBtImage := FUpButton.ImageHover;
    upBtBorderColor := FUpButton.Border.ColorHover;
  end
  else
  begin
    upBtColor := FUpButton.Color;
    upBtImage := FUpButton.Image;
    upBtBorderColor := FUpButton.Border.Color;
  end;

  upBtL := L;
  upBtT := T;
  upBtW := L + FUpButton.Width;
  upBtH := T + FUpButton.Height;

  AImage := ControlManager.Images.Image[upBtImage.Image];
  if AImage <> nil then
  begin
    ControlManager.Canvas.UseImagePx(AImage, pRect4(upBtImage.Rect));
    ControlManager.Canvas.TexMap(pRect4(Rect(upBtL, upBtT, upBtW, upBtH)),
      cAlpha4(upBtColor), beNormal);
  end
  else
  begin
    ControlManager.Canvas.FillRect(Rect(upBtL, upBtT, upBtW, upBtH),
      cColor4(upBtColor), beNormal);

    ControlManager.Canvas.FillTri(Point2(upBtL + (FUpButton.Width / 2),
      upBtT + (FUpButton.Border.Size + (FUpButton.Height / 8)) - 1),
      Point2(upBtL + (FUpButton.Border.Size + (FUpButton.Width / 8)),
      upBtH - (FUpButton.Border.Size + (FUpButton.Height / 8)) - 1),
      Point2(upBtW - (FUpButton.Border.Size + (FUpButton.Width / 8)),
      upBtH - (FUpButton.Border.Size + (FUpButton.Height / 8)) - 1), $20000000,
      $20000000, $20000000, beNormal);
  end;

  // Draw UpButton Border
  if FUpButton.Border.Size > 0 then
  begin
    bTop := 0;
    bBottom := 0;

    if eTop in FUpButton.Border.Edges then
    begin
      ControlManager.Canvas.FillRect(Rect(upBtL, upBtT, upBtW,
        upBtT + FUpButton.Border.Size), upBtBorderColor, beNormal);
      bTop := FUpButton.Border.Size;
    end;

    if eBottom in FUpButton.Border.Edges then
    begin
      ControlManager.Canvas.FillRect(Rect(upBtL, upBtH - FUpButton.Border.Size,
        upBtW, upBtH), upBtBorderColor, beNormal);
      bBottom := FUpButton.Border.Size;
    end;

    if eLeft in FUpButton.Border.Edges then
      ControlManager.Canvas.FillRect(Rect(upBtL, upBtT + bTop,
        upBtL + FUpButton.Border.Size, upBtH - bBottom), upBtBorderColor,
        beNormal);

    if eRight in FUpButton.Border.Edges then
      ControlManager.Canvas.FillRect(Rect(upBtW - FUpButton.Border.Size,
        upBtT + bTop, upBtW, upBtH - bBottom), upBtBorderColor, beNormal);
  end;

  // Draw DownButton
  if csClicked in FDownButton.ControlState then
  begin
    dnBtColor := FDownButton.ColorPressed;
    dnBtImage := FDownButton.ImagePressed;
    dnBtBorderColor := FDownButton.Border.ColorPressed;
  end
  else if csMouseHover in FDownButton.ControlState then
  begin
    dnBtColor := FDownButton.ColorHover;
    dnBtImage := FDownButton.ImageHover;
    dnBtBorderColor := FDownButton.Border.ColorHover;
  end
  else
  begin
    dnBtColor := FDownButton.Color;
    dnBtImage := FDownButton.Image;
    dnBtBorderColor := FDownButton.Border.Color;
  end;

  dnBtL := L;
  dnBtT := H - FDownButton.Height;
  dnBtW := L + FDownButton.Width;
  dnBtH := H;

  AImage := ControlManager.Images.Image[dnBtImage.Image];
  if AImage <> nil then
  begin
    ControlManager.Canvas.UseImagePx(AImage, pRect4(dnBtImage.Rect));
    ControlManager.Canvas.TexMap(pRect4(Rect(dnBtL, dnBtT, dnBtW, dnBtH)),
      cAlpha4(dnBtColor), beNormal);
  end
  else
  begin
    ControlManager.Canvas.FillRect(Rect(dnBtL, dnBtT, dnBtW, dnBtH),
      cColor4(dnBtColor), beNormal);
    ControlManager.Canvas.FillTri
      (Point2(dnBtL + (FDownButton.Border.Size + (FDownButton.Width / 8)),
      dnBtT + (FDownButton.Border.Size + (FDownButton.Height / 8)) + 1),
      Point2(dnBtW - (FDownButton.Border.Size + (FDownButton.Width / 8)),
      dnBtT + (FDownButton.Border.Size + (FDownButton.Height / 8)) + 1),
      Point2(dnBtL + (FDownButton.Width / 2),
      dnBtH - (FDownButton.Border.Size + (FDownButton.Height / 8)) + 1),
      $20000000, $20000000, $20000000, beNormal);
  end;

  // Draw DownButton Border
  if FDownButton.Border.Size > 0 then
  begin
    bTop := 0;
    bBottom := 0;

    if eTop in FDownButton.Border.Edges then
    begin
      ControlManager.Canvas.FillRect(Rect(dnBtL, dnBtT, dnBtW,
        dnBtT + FDownButton.Border.Size), dnBtBorderColor, beNormal);
      bTop := FDownButton.Border.Size;
    end;

    if eBottom in FDownButton.Border.Edges then
    begin
      ControlManager.Canvas.FillRect
        (Rect(dnBtL, dnBtH - FDownButton.Border.Size, dnBtW, dnBtH),
        dnBtBorderColor, beNormal);
      bBottom := FDownButton.Border.Size;
    end;

    if eLeft in FDownButton.Border.Edges then
      ControlManager.Canvas.FillRect(Rect(dnBtL, dnBtT + bTop,
        dnBtL + FDownButton.Border.Size, dnBtH - bBottom), dnBtBorderColor,
        beNormal);

    if eRight in FDownButton.Border.Edges then
      ControlManager.Canvas.FillRect(Rect(dnBtW - FDownButton.Border.Size,
        dnBtT + bTop, dnBtW, dnBtH - bBottom), dnBtBorderColor, beNormal);
  end;

  // Draw ScrollButton
  if csClicked in FScrollButton.ControlState then
  begin
    srBtColor := FScrollButton.ColorPressed;
    srBtImage := FScrollButton.ImagePressed;
    srBtBorderColor := FScrollButton.Border.ColorPressed;
  end
  else if csMouseHover in FScrollButton.ControlState then
  begin
    srBtColor := FScrollButton.ColorHover;
    srBtImage := FScrollButton.ImageHover;
    srBtBorderColor := FScrollButton.Border.ColorHover;
  end
  else
  begin
    srBtColor := FScrollButton.Color;
    srBtImage := FScrollButton.Image;
    srBtBorderColor := FScrollButton.Border.Color;
  end;

  dLines := (H - T) div FLineHeight;

  T := T + FUpButton.Height;
  H := H - FDownButton.Height;

  srBtL := L;
  srBtT := T + Round(Abs(FVirtualPos) /
    (GetVirtualHeight - (FLineHeight * dLines)) *
    (H - T - FScrollButton.Height));
  srBtW := L + FScrollButton.Width;
  srBtH := srBtT + FScrollButton.Height;

  AImage := ControlManager.Images.Image[srBtImage.Image];
  if AImage <> nil then
  begin
    ControlManager.Canvas.UseImagePx(AImage, pRect4(srBtImage.Rect));
    ControlManager.Canvas.TexMap(pRect4(Rect(srBtL, srBtT, srBtW, srBtH)),
      cAlpha4(srBtColor), beNormal);
  end
  else
  begin
    ControlManager.Canvas.FillRect(Rect(srBtL, srBtT, srBtW, srBtH),
      cColor4(srBtColor), beNormal);
  end;

  // Draw ScrollButton Border
  if FScrollButton.Border.Size > 0 then
  begin
    bTop := 0;
    bBottom := 0;

    if eTop in FScrollButton.Border.Edges then
    begin
      ControlManager.Canvas.FillRect(Rect(srBtL, srBtT, srBtW,
        srBtT + FScrollButton.Border.Size), srBtBorderColor, beNormal);
      bTop := FScrollButton.Border.Size;
    end;

    if eBottom in FScrollButton.Border.Edges then
    begin
      ControlManager.Canvas.FillRect
        (Rect(srBtL, srBtH - FScrollButton.Border.Size, srBtW, srBtH),
        srBtBorderColor, beNormal);
      bBottom := FScrollButton.Border.Size;
    end;

    if eLeft in FScrollButton.Border.Edges then
      ControlManager.Canvas.FillRect(Rect(srBtL, srBtT + bTop,
        srBtL + FScrollButton.Border.Size, srBtH - bBottom), srBtBorderColor,
        beNormal);

    if eRight in FScrollButton.Border.Edges then
      ControlManager.Canvas.FillRect(Rect(srBtW - FScrollButton.Border.Size,
        srBtT + bTop, srBtW, srBtH - bBottom), srBtBorderColor, beNormal);
  end;

end;

procedure TCustomAListBox.SetAntialiased(Value: Boolean);
begin
  FAntialiased := Value;
end;

procedure TCustomAListBox.SetBorder(Value: TBorder);
begin
  if Value <> nil then
    FBorder.Assign(Value);
end;

procedure TCustomAListBox.SetColor(Value: TFillColor);
begin
  if Value <> nil then
    FColor.Assign(Value);
end;

procedure TCustomAListBox.SetDownButton(Value: TBtBox);
begin
  if Value <> nil then
    FDownButton.Assign(Value);
end;

procedure TCustomAListBox.SetFocusRect(Value: TFocusRect);
begin
  FFocusRect := Value;
end;

procedure TCustomAListBox.SetFont(Value: TEditFont);
begin
  if Value <> nil then
    FFont.Assign(Value);
end;

procedure TCustomAListBox.SetHeight(Value: Integer);
var
  MinH: Integer;
begin
  MinH := FUpButton.Height + FDownButton.Height + FScrollButton.Height + FMargin
    * 2 + FBorder.Size * 2;

  if (Value < MinH) then
    Value := MinH;

  inherited SetHeight(Value);
end;

procedure TCustomAListBox.SetImage(Value: TImage);
begin
  if Value <> nil then
    FImage.Assign(Value);
end;

procedure TCustomAListBox.SetIndex(Value: Integer);
begin
  FIndex := Value;

  if FIndex >= FStrings.Count then
    FIndex := FStrings.Count - 1;
end;

procedure TCustomAListBox.SetLineHeight(Value: Integer);
begin
  FLineHeight := Value;

  if FLineHeight < 0 then
    FLineHeight := 1;
end;

procedure TCustomAListBox.SetMargin(Value: Word);
begin
  FMargin := Value;

  SetHeight(Self.Height);
  SetWidth(Self.Width);
end;

procedure TCustomAListBox.SetScrollButton(Value: TBtBox);
begin
  if Value <> nil then
    FScrollButton.Assign(Value);
end;

procedure TCustomAListBox.SetStrings(Value: TAStringList);
begin
  if Value <> nil then
    FStrings.Assign(Value);
end;

procedure TCustomAListBox.SetTransparent(Value: Boolean);
begin
  FTransparent := Value;
end;

procedure TCustomAListBox.SetUpButton(Value: TBtBox);
begin
  if Value <> nil then
    FUpButton.Assign(Value);
end;

procedure TCustomAListBox.SetWidth(Value: Integer);
var
  MinW: Integer;
begin
  MinW := (FBorder.Size * 2) + (FMargin * 2) +
    Max(Max(FUpButton.Width, FDownButton.Width), FScrollButton.Width);

  if Value < MinW then
    Value := MinW;

  inherited SetWidth(Value);
end;
{$ENDREGION}

end.
