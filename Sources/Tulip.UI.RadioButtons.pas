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
{  The Original Code is Tulip.UI.RadioButtons.pas.                             }
{                                                                              }
{  The Initial Developer of the Original Code is Marcos Gomes.                 }
{  Portions created by Marcos Gomes are Copyright (C) 2012, Marcos Gomes.      }
{  All Rights Reserved.                                                        }
{                                                                              }
{******************************************************************************}
{                                                                              }
{  Tulip.UI.RadioButtons.pas                            Modified: 05-Out-2012  }
{  --------------------------------------------------------------------------  }
{                                                                              }
{               Base Implementations for RadioButton Controls                  }
{                                                                              }
{                                Version 1.02                                  }
{                                                                              }
{******************************************************************************}

unit Tulip.UI.RadioButtons;

interface

uses
  System.SysUtils, System.Classes,
  // Asphyre Units
  AbstractCanvas, AsphyreFonts, AsphyreImages, AsphyreTypes, Vectors2,
  // Tulip UI Units
  Tulip.UI.Types, Tulip.UI.Classes, Tulip.UI.Controls, Tulip.UI.Helpers,
  Tulip.UI.Utils;

type
{$REGION 'TCustomARadioButton'}
  TCustomARadioButton = class(TWControl)
  private
    FAntialiased: Boolean;
    FBorder: TBorder;
    FBox: TCkBox;
    FCaption: String;
    FChecked: Boolean;
    FColor: TFillColor;
    FFocusRect: TFocusRect;
    FFont: TFormatedFont;
    FImage: TImage;
    FMargin: Word;
    FReadOnly: Boolean;
    FTransparent: Boolean;

    procedure SetAntialiased(Value: Boolean);
    procedure SetBorder(Value: TBorder);
    procedure SetBox(Value: TCkBox);
    procedure SetCaption(Value: String);
    procedure SetChecked(Value: Boolean);
    procedure SetColor(Value: TFillColor);
    procedure SetFocusRect(Value: TFocusRect);
    procedure SetFont(Value: TFormatedFont);
    procedure SetImage(Value: TImage);
    procedure SetMargin(Value: Word);
    procedure SetReadOnly(Value: Boolean);
    procedure SetTransparent(Value: Boolean);
  protected
    procedure AssignTo(Dest: TPersistent); override;
    procedure Paint; override;

    procedure SetHeight(Value: Integer); override;
    procedure SetWidth(Value: Integer); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure DblClick; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;

    property Antialiased: Boolean read FAntialiased write SetAntialiased;
    property Border: TBorder read FBorder write SetBorder;
    property Box: TCkBox read FBox write SetBox;
    property Caption: String read FCaption write SetCaption;
    property Checked: Boolean read FChecked write SetChecked;
    property Color: TFillColor read FColor write SetColor;
    property FocusRect: TFocusRect read FFocusRect write SetFocusRect;
    property Font: TFormatedFont read FFont write SetFont;
    property Image: TImage read FImage write SetImage;
    property Margin: Word read FMargin write SetMargin;
    property ReadOnly: Boolean read FReadOnly write SetReadOnly;
    property Transparent: Boolean read FTransparent write SetTransparent;
  end;
{$ENDREGION}

implementation

{$REGION 'TCustomARadioButton'}
{ TCustomARadioButton }

procedure TCustomARadioButton.AssignTo(Dest: TPersistent);
begin
  ControlState := ControlState + [csReadingState];

  inherited AssignTo(Dest);

  if Dest is TCustomARadioButton then
    with TCustomARadioButton(Dest) do
    begin
      Antialiased := Self.Antialiased;
      Border := Self.Border;
      Box := Self.Box;
      Caption := Self.Caption;
      Checked := Self.Checked;
      Color := Self.Color;
      FocusRect := Self.FocusRect;
      Font := Self.Font;
      Image := Self.Image;
      Margin := Self.Margin;
      ReadOnly := Self.ReadOnly;
      Transparent := Self.Transparent;
    end;

  ControlState := ControlState - [csReadingState];
end;

constructor TCustomARadioButton.Create(AOwner: TComponent);
var
  I, Num: Integer;
  Control: TComponent;
begin
  ControlState := ControlState + [csCreating];

  inherited Create(AOwner);

  if (AOwner <> nil) and (AOwner <> Self) and (AOwner is TWControl) then
  begin
    // Auto generate name
    Num := 1;
    begin
      while AOwner.FindComponent('RadioButton' + IntToStr(Num)) <> nil do
        Inc(Num);
      Name := 'RadioButton' + IntToStr(Num);
    end;
  end;

  // Fields
  FAntialiased := True;
  FBorder := TBorder.Create;
  FBorder.Color := $B0FFFFFF;
  FBorder.Size := 0;
  FBox := TCkBox.Create;
  FCaption := Name;

  FChecked := True;
  // check parent for other radiobuttons
  if (AOwner <> nil) and (AOwner <> Self) and (AOwner is TWControl) then
  begin
    for I := 0 to AOwner.ComponentCount - 1 do
    begin
      Control := AOwner.Components[I];

      if (Control <> Self) and (Control is TCustomARadioButton) then
      begin
        if ((Control as TCustomARadioButton).Checked = True) then
        begin
          FChecked := False;
          Break;
        end;
      end;
    end;
  end;

  FColor := TFillColor.Create($FF4090F0, $FF4090F0, $FF4090F0, $FF4090F0);
  FFocusRect := fDark;
  FFont := TFormatedFont.Create;
  FFont.HorizontalAlign := aLeft;
  FImage := TImage.Create;
  FMargin := 2;
  FReadOnly := False;
  FTransparent := True;

  // Properties
  Self.Left := 0;
  Self.Top := 0;
  Self.Width := 120;
  Self.Height := 24;
  Self.TabStop := True;
  Self.Visible := True;

  ControlState := ControlState - [csCreating];
end;

procedure TCustomARadioButton.DblClick;
begin
  if not(FReadOnly) then
  begin
    Self.Checked := True;
  end;

  inherited DblClick;
end;

destructor TCustomARadioButton.Destroy;
var
  I: Integer;
  C: TComponent;
begin
  if (FChecked = True) and (Owner <> nil) and (Owner <> Self) then
  begin
    for I := Owner.ComponentCount - 1 downto 0 do
    begin
      C := Owner.Components[I];

      if (C <> Self) and (C is TCustomARadioButton) then
      begin
        (C as TCustomARadioButton).Checked := True;
        Break;
      end;
    end;
  end;

  FBorder.Free;
  FBox.Free;
  FColor.Free;
  FFont.Free;
  FImage.Free;

  inherited;
end;

procedure TCustomARadioButton.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if not(FReadOnly) then
  begin
    if (Key = $20) then
    begin
      Self.Checked := True;
    end;
  end;

  inherited KeyDown(Key, Shift);
end;

procedure TCustomARadioButton.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Self.SetFocus;

  inherited MouseDown(Button, Shift, X, Y);
end;

procedure TCustomARadioButton.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  L, T, H, W: Integer;
begin
  T := Self.ClientTop + FBorder.Size + FMargin;
  H := Self.Height - (FBorder.Size * 2) - (FMargin * 2);
  T := T + (H div 2 - FBox.Size div 2);

  L := Self.ClientLeft + FBorder.Size + FMargin;
  W := Self.ClientLeft + FBorder.Size + FMargin + FBox.Size;
  H := T + FBox.Size;

  if not(FReadOnly) then
  begin
    if (X >= L) and (X < W) and (Y >= T) and (Y < H) then
    begin
      Self.Checked := True;
    end;
  end;

  inherited MouseUp(Button, Shift, X, Y);
end;

procedure TCustomARadioButton.Paint;
var
  X, Y: Integer;
  AFont: TAsphyreFont;
  AImage: TAsphyreImage;
  bTop, bBottom: TConstraintSize;
  L, T, H, W: Integer;
begin
  // Set initial values
  X := ClientLeft;
  Y := ClientTop;

  ControlManager.Canvas.Antialias := FAntialiased;

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

  // Draw DisplayText
  AFont := ControlManager.Fonts.Font[FFont.Name];
  if (AFont <> nil) and (FCaption <> '') then
  begin
    AFont.TextRectEx(Point2(X + Border.Size + Box.Size + (Margin * 3),
      Y + Border.Size + Margin + 1), Point2(Width - Box.Size - (Border.Size * 2)
      - (Margin * 4), Height - (Border.Size * 2) - (Margin * 2)), FCaption,
      cColor2(FFont.Color), 1.0, FFont.HorizontalAlign, FFont.VerticalAlign,
      FFont.ParagraphLine);
  end;

  // Draw box
  // Draw box Background
  T := Y + Border.Size + Margin;
  H := Height - (Border.Size * 2) - (Margin * 2);
  T := T + (H div 2 - FBox.Size div 2);

  L := X + Border.Size + Margin;
  W := X + Border.Size + Margin + FBox.Size;
  H := T + FBox.Size;

  if FChecked then
    AImage := ControlManager.Images.Image[FBox.CheckedImage.Image]
  else
    AImage := ControlManager.Images.Image[FBox.Image.Image];

  if AImage <> nil then
  begin
    if FChecked then
      ControlManager.Canvas.UseImagePx(AImage, pRect4(FBox.CheckedImage.Rect))
    else
      ControlManager.Canvas.UseImagePx(AImage, pRect4(FBox.Image.Rect));

    ControlManager.Canvas.TexMap(pRect4(Rect(L, T, W, H)), cAlpha4(FColor),
      beNormal);
  end
  else
  begin
    ControlManager.Canvas.FillRect(Rect(L, T, W, H), cColor4(FBox.Color),
      beNormal);
    // draw check
    if FChecked then
    begin
      ControlManager.Canvas.FillRect(Rect(L + (FBox.Size div 4),
        T + (FBox.Size div 4), W - (FBox.Size div 4), H - (FBox.Size div 4)),
        cColor4(FBox.CheckedColor), beNormal);
    end;
  end;

  // Draw box Border
  if FBox.Border.Size > 0 then
  begin
    bTop := 0;
    bBottom := 0;

    if eTop in FBox.Border.Edges then
    begin
      ControlManager.Canvas.FillRect(Rect(L, T, W, T + FBox.Border.Size),
        FBox.Border.Color, beNormal);
      bTop := FBox.Border.Size;
    end;

    if eBottom in FBox.Border.Edges then
    begin
      ControlManager.Canvas.FillRect(Rect(L, H - FBox.Border.Size, W, H),
        FBox.Border.Color, beNormal);
      bBottom := FBox.Border.Size;
    end;

    if eLeft in FBox.Border.Edges then
      ControlManager.Canvas.FillRect(Rect(L, T + bTop, L + FBox.Border.Size,
        H - bBottom), FBox.Border.Color, beNormal);

    if eRight in FBox.Border.Edges then
      ControlManager.Canvas.FillRect(Rect(W - FBox.Border.Size, T + bTop, W,
        H - bBottom), FBox.Border.Color, beNormal);
  end;

  // Draw box Focus rect
  if (ControlManager.ActiveControl = Self) and (Self.FocusRect = fLight) then
  begin
    ControlManager.Canvas.FrameRect(Rect(L - 1, T - 1, W + 1, H + 1),
      cColor4($40FFFFFF), beNormal);
  end;
  if (ControlManager.ActiveControl = Self) and (Self.FocusRect = fDark) then
  begin
    ControlManager.Canvas.FrameRect(Rect(L - 1, T - 1, W + 1, H + 1),
      cColor4($30000000), beNormal);
  end;

end;

procedure TCustomARadioButton.SetAntialiased(Value: Boolean);
begin
  FAntialiased := Value;
end;

procedure TCustomARadioButton.SetBorder(Value: TBorder);
begin
  if Value <> nil then
    FBorder.Assign(Value);
end;

procedure TCustomARadioButton.SetBox(Value: TCkBox);
begin
  if Value <> nil then
    FBox.Assign(Value);
end;

procedure TCustomARadioButton.SetCaption(Value: String);
begin
  FCaption := Value;
end;

procedure TCustomARadioButton.SetChecked(Value: Boolean);
var
  I: Integer;
  C: TComponent;
begin
  if (Value = True) and (Owner <> nil) and (Owner <> Self) then
  begin
    for I := Owner.ComponentCount - 1 downto 0 do
    begin
      C := Owner.Components[I];

      if (C <> Self) and (C is TCustomARadioButton) then
      begin
        if (C as TCustomARadioButton).Checked = True then
          (C as TCustomARadioButton).Checked := False;
      end;
    end;
  end;

  FChecked := Value;
end;

procedure TCustomARadioButton.SetColor(Value: TFillColor);
begin
  if Value <> nil then
    FColor.Assign(Value);
end;

procedure TCustomARadioButton.SetFocusRect(Value: TFocusRect);
begin
  FFocusRect := Value;
end;

procedure TCustomARadioButton.SetFont(Value: TFormatedFont);
begin
  if Value <> nil then
    FFont.Assign(Value);
end;

procedure TCustomARadioButton.SetHeight(Value: Integer);
var
  MinH: Integer;
begin
  MinH := FBorder.Size * 2 + FMargin * 2 + FBox.Size;

  if Value < MinH then
    Value := MinH;

  inherited SetHeight(Value);
end;

procedure TCustomARadioButton.SetImage(Value: TImage);
begin
  if Value <> nil then
    FImage.Assign(Value);
end;

procedure TCustomARadioButton.SetMargin(Value: Word);
begin
  FMargin := Value;

  SetHeight(Self.Height);
  SetWidth(Self.Width);
end;

procedure TCustomARadioButton.SetReadOnly(Value: Boolean);
begin
  FReadOnly := Value;
end;

procedure TCustomARadioButton.SetTransparent(Value: Boolean);
begin
  FTransparent := Value;
end;

procedure TCustomARadioButton.SetWidth(Value: Integer);
var
  MinW: Integer;
begin
  MinW := FBorder.Size * 2 + FMargin * 2 + FBox.Size;

  if Value < MinW then
    Value := MinW;

  inherited SetWidth(Value);
end;
{$ENDREGION}

end.
