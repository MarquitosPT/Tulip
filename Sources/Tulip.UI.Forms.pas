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
{  The Original Code is Tulip.UI.Forms.pas.                                    }
{                                                                              }
{  The Initial Developer of the Original Code is Marcos Gomes.                 }
{  Portions created by Marcos Gomes are Copyright (C) 2012, Marcos Gomes.      }
{  All Rights Reserved.                                                        }
{                                                                              }
{******************************************************************************}
{                                                                              }
{  Tulip.UI.Forms.pas                                   Modified: 23-Mar-2013  }
{  --------------------------------------------------------------------------  }
{                                                                              }
{                    Base Implementations for Form Controls                    }
{                                                                              }
{                                Version 1.03                                  }
{                                                                              }
{******************************************************************************}

unit Tulip.UI.Forms;

interface

uses
  System.SysUtils, System.Types, System.Classes,
  // Aspryre units
  AsphyreTypes, AbstractCanvas, AsphyreFonts, AsphyreImages, AsphyreUtils,
  Vectors2,
  // Tulip UI units
  Tulip.UI.Types, Tulip.UI.Classes, Tulip.UI.Controls, Tulip.UI.Utils,
  Tulip.UI.Helpers;

type
{$REGION 'TCustomAForm'}
  TCustomAForm = class(TWControl)
  private
    FAntialiased: Boolean;
    FBorder: TBorder;
    FBoundToScreen: Boolean;
    FCanMove: Boolean;
    FCaption: String;
    FColor: TFillColor;
    FFont: TFormatedFont;
    FImage: TImage;
    FIsMoving: Boolean;
    FMargin: Word;
    FModal: Boolean;
    FShadow: Boolean;
    FWordWrap: Boolean;

    procedure SetAntialiased(Value: Boolean);
    procedure SetBorder(Value: TBorder);
    procedure SetCaption(Value: String);
    procedure SetColor(Color: TFillColor);
    procedure SetImage(Value: TImage);
    procedure SetMargin(Value: Word);
    procedure SetCanMove(Value: Boolean);
    procedure SetShadow(Value: Boolean);
    procedure SetFont(Value: TFormatedFont);
    procedure SetWordWrap(Value: Boolean);
  protected
    procedure AssignTo(Dest: TPersistent); override;
    procedure Paint; override;

    procedure SetLeft(Value: Integer); override;
    procedure SetHeight(Value: Integer); override;
    procedure SetTop(Value: Integer); override;
    procedure SetWidth(Value: Integer); override;
  public
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function IsModal: Boolean;

    procedure Close;
    procedure Show(Modal: Boolean = False);

    property Antialiased: Boolean read FAntialiased write SetAntialiased;
    property Border: TBorder read FBorder write SetBorder;
    property BoundToScreen: Boolean read FBoundToScreen write FBoundToScreen;
    property Caption: String read FCaption write SetCaption;
    property CanMove: Boolean read FCanMove write SetCanMove;
    property Color: TFillColor read FColor write SetColor;
    property Font: TFormatedFont read FFont write SetFont;
    property Image: TImage read FImage write SetImage;
    property IsMoving: Boolean read FIsMoving write FIsMoving;
    property Margin: Word read FMargin write SetMargin;
    property Shadow: Boolean read FShadow write SetShadow;
    property WordWrap: Boolean read FWordWrap write SetWordWrap;
  end;
{$ENDREGION}

implementation

// ----------------------------------------------------------------------------

var
  XOffSet, YOffSet: Integer;

{$REGION 'TCustomAForm'}
  { TCustomAForm }

procedure TCustomAForm.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  if (Button = mbLeft) and (FCanMove) then
  begin
    XOffSet := X - Left;
    YOffSet := Y - Top;
    FIsMoving := True;
  end;

  inherited MouseDown(Button, Shift, X, Y);
end;

procedure TCustomAForm.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  if FIsMoving = True then
  begin
    Left := X - XOffSet;
    Top := Y - YOffSet;
  end;

  inherited MouseMove(Shift, X, Y);
end;

procedure TCustomAForm.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  if (Button = mbLeft) and (FIsMoving) then
    FIsMoving := False;

  inherited MouseUp(Button, Shift, X, Y);
end;

procedure TCustomAForm.AssignTo(Dest: TPersistent);
begin
  ControlState := ControlState + [csReadingState];

  inherited AssignTo(Dest);

  if Dest is TCustomAForm then
    with TCustomAForm(Dest) do
    begin
      Antialiased := Self.Antialiased;
      Border := Self.Border;
      BoundToScreen := Self.BoundToScreen;
      Caption := Self.Caption;
      Color := Self.Color;
      Font := Self.Font;
      Image := Self.Image;
      CanMove := Self.CanMove;
      Margin := Self.Margin;
      Shadow := Self.Shadow;
      WordWrap := Self.WordWrap;
    end;

  ControlState := ControlState - [csReadingState];
end;

procedure TCustomAForm.Close;
begin
  FModal := False;
  Visible := False;
end;

constructor TCustomAForm.Create(AOwner: TComponent);
var
  Num: Integer;
begin
  ControlState := ControlState + [csCreating];

  inherited Create(AOwner);

  if (AOwner <> nil) and (AOwner <> Self) and (AOwner is TWControl) then
  begin
    // Auto generate name
    Num := 1;
    while TWControl(AOwner).FindChildControl('Form' + IntToStr(Num),
      True) <> nil do
      Inc(Num);
    Name := 'Form' + IntToStr(Num);
  end;

  // fields
  FAntialiased := True;
  FBorder := TBorder.Create;
  FBorder.Color := $80000000;
  FBoundToScreen := False;
  FCanMove := True;
  FCaption := '';
  FColor := TFillColor.Create($FFA6CAF0, $FFA6CAF0, $FF4090F0, $FF4090F0);
  FFont := TFormatedFont.Create;
  FImage := TImage.Create;
  FIsMoving := False;
  FMargin := 3;
  FModal := False;
  FShadow := True;
  FWordWrap := True;

  // properties
  Left := 0;
  Top := 0;
  Width := 320;
  Height := 240;

  ControlState := ControlState - [csCreating];
end;

destructor TCustomAForm.Destroy;
begin
  FBorder.Free;
  FColor.Free;
  FFont.Free;
  FImage.Free;

  inherited Destroy;
end;

function TCustomAForm.IsModal: Boolean;
begin
  Result := FModal;
end;

procedure TCustomAForm.Paint;
var
  X, Y: Integer;
  AFont: TAsphyreFont;
  AImage: TAsphyreImage;
  bTop, bBottom: TConstraintSize;
  I: Integer;
  ARect: TRect;
  AHeight, AWidth: Integer;
  vLeft, vTop: Integer;
begin
  // Get size Canvas
  ARect := ControlManager.Canvas.ClipRect;

  // Set initial values
  X := ClientLeft;
  Y := ClientTop;

  ControlManager.Canvas.Antialias := FAntialiased;

  if FShadow then
  begin
    // Draw Shadow
    I := 12;
    while I > 5 do
    begin
      ControlManager.Canvas.FillRect(Rect(X - I, Y - I, X + Width + I,
        Y + Height + I), cAlpha4(1), beShadow);
      Dec(I, 2);
    end;

    I := 5;
    while I > 3 do
    begin
      ControlManager.Canvas.FillRect(Rect(X - I, Y - I, X + Width + I,
        Y + Height + I), cAlpha4(2), beShadow);
      Dec(I, 1);
    end;

    I := 3;
    while I > 0 do
    begin
      ControlManager.Canvas.FillRect(Rect(X - I, Y - I, X + Width + I,
        Y + Height + I), cAlpha4(4), beShadow);
      Dec(I, 1);
    end;
  end;

  // Draw Background
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
    if WordWrap then
    begin
      AFont.TextRectEx(Point2(X + Border.Size + Margin, Y + Border.Size +
        Margin + 1), Point2(Width - (Border.Size * 2) - (Margin * 2),
        Height - (Border.Size * 2) - (Margin * 2)), FCaption,
        cColor2(FFont.Color), 1.0, FFont.HorizontalAlign, FFont.VerticalAlign,
        FFont.ParagraphLine);
    end
    else
    begin
      // Set Bounds
      X := ClientLeft + Margin + Border.Size;
      Y := ClientTop + Margin + Border.Size;
      AWidth := Width - Margin * 2 - Border.Size * 2;
      AHeight := Height - Margin * 2 - Border.Size * 2;

      // Set Rect Canvas
      ControlManager.Canvas.ClipRect :=
        ShortRect(Rect(X - 1, Y, X + AWidth, Y + AHeight), ARect);

      case Self.FFont.VerticalAlign of
        aTop:
          vTop := Y;
        aMiddle:
          vTop := Y + (AHeight div 2) - (AFont.TexHeight(FCaption) div 2);
        aBottom:
          vTop := Y + AHeight - AFont.TexHeight(FCaption);
        else
          vTop := X;
      end;

      case FFont.HorizontalAlign of
        aLeft,
        aJustify:
          vLeft := X;
        aCenter:
          vLeft := X + (AWidth div 2) - Round(AFont.TextWidth(FCaption) / 2);
        aRight:
          vLeft := X + AWidth - Round(AFont.TextWidth(FCaption));
        else
          vLeft := X;
      end;

      AFont.TextOut(Point2(vLeft, vTop),FCaption, cColor2(FFont.Color), 1.0);

      // Restore Rect Canvas
      ControlManager.Canvas.ClipRect := ARect;
    end;
  end;

  inherited Paint;
end;

procedure TCustomAForm.SetAntialiased(Value: Boolean);
begin
  FAntialiased := Value;
end;

procedure TCustomAForm.SetBorder(Value: TBorder);
begin
  if Value <> nil then
    FBorder.Assign(Value);
end;

procedure TCustomAForm.SetCanMove(Value: Boolean);
begin
  FCanMove := Value;
end;

procedure TCustomAForm.SetCaption(Value: String);
begin
  FCaption := Value;
end;

procedure TCustomAForm.SetColor(Color: TFillColor);
begin
  if Color <> nil then
    FColor.Assign(Color);
end;

procedure TCustomAForm.SetHeight(Value: Integer);
begin
  if (FBoundToScreen) then
  begin
    if Value < 0 then
    begin
      Value := 0;
    end;

    if Top + Value > Parent.Height then
    begin
      Value := Parent.Height - Top;
    end;
  end;

  inherited SetHeight(Value);
end;

procedure TCustomAForm.SetFont(Value: TFormatedFont);
begin
  if Value <> nil then
    FFont.Assign(Value);
end;

procedure TCustomAForm.SetTop(Value: Integer);
begin
  if (FBoundToScreen) then
  begin
    if Value < 0 then
    begin
      Value := 0;
    end;

    if Value + Height > Parent.Height then
    begin
      Value := Parent.Height - Height;
    end;
  end;

  inherited SetTop(Value);
end;

procedure TCustomAForm.SetWidth(Value: Integer);
begin
  if (FBoundToScreen) then
  begin
    if Value < 0 then
    begin
      Value := 0;
    end;

    if Left + Value > Parent.Width then
    begin
      Value := Parent.Width - Left;
    end;
  end;

  inherited SetWidth(Value);
end;

procedure TCustomAForm.SetWordWrap(Value: Boolean);
begin
  FWordWrap := Value;
end;

procedure TCustomAForm.SetImage(Value: TImage);
begin
  if Value <> nil then
    FImage.Assign(Value);
end;

procedure TCustomAForm.SetLeft(Value: Integer);
begin
  if (FBoundToScreen) then
  begin
    if Value < 0 then
    begin
      Value := 0;
    end;

    if Value + Width > Parent.Width then
    begin
      Value := Parent.Width - Width;
    end;
  end;

  inherited SetLeft(Value);
end;

procedure TCustomAForm.SetMargin(Value: Word);
begin
  if FMargin <> Value then
    FMargin := Value;
end;

procedure TCustomAForm.SetShadow(Value: Boolean);
begin
  FShadow := Value;
end;

procedure TCustomAForm.Show(Modal: Boolean = False);
begin
  FModal := Modal;
  Visible := True;
  BringToFront;
  SetFocus;
  SelectFirst;
end;
{$ENDREGION}

end.
