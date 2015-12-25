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
{  The Original Code is Tulip.UI.Buttons.pas.                                  }
{                                                                              }
{  The Initial Developer of the Original Code is Marcos Gomes.                 }
{  Portions created by Marcos Gomes are Copyright (C) 2012, Marcos Gomes.      }
{  All Rights Reserved.                                                        }
{                                                                              }
{******************************************************************************}
{                                                                              }
{  Tulip.UI.Buttons.pas                                 Modified: 05-Out-2012  }
{  --------------------------------------------------------------------------  }
{                                                                              }
{                   Base Implementations for Button Controls                   }
{                                                                              }
{                                Version 1.02                                  }
{                                                                              }
{******************************************************************************}

unit Tulip.UI.Buttons;

interface

uses
  System.SysUtils, System.Types, System.Classes,
  // Asphyre Units
  AbstractCanvas, AsphyreFonts, AsphyreImages, AsphyreTypes, Vectors2,
  // Tulip UI Units
  Tulip.UI.Types, Tulip.UI.Classes, Tulip.UI.Controls, Tulip.UI.Helpers,
  Tulip.UI.Utils;

type
{$REGION 'TCustomAButton'}
  TCustomAButton = class(TWControl)
  private
    FAntialiased: Boolean;
    FBorder: TActiveBorder;
    FCaption: String;
    FColor: TFillColor;
    FColorHover: TFillColor;
    FColorPressed: TFillColor;
    FFocusRect: TFocusRect;
    FFont: TActiveFormatedFont;
    FImage: TImage;
    FImageHover: TImage;
    FImagePressed: TImage;
    FMargin: Word;
    FShadow: Boolean;
    FTransparent: Boolean;

    procedure SetAntialiased(Value: Boolean);
    procedure SetBorder(Value: TActiveBorder);
    procedure SetCaption(Value: String);
    procedure SetColor(Color: TFillColor);
    procedure SetColorHover(Color: TFillColor);
    procedure SetColorPressed(Color: TFillColor);
    procedure SetFocusRect(Value: TFocusRect);
    procedure SetFont(Value: TActiveFormatedFont);
    procedure SetImage(Value: TImage);
    procedure SetImageHover(Value: TImage);
    procedure SetImagePressed(Value: TImage);
    procedure SetMargin(Value: Word);
    procedure SetShadow(Value: Boolean);
    procedure SetTransparent(Value: Boolean);
  protected
    procedure AssignTo(Dest: TPersistent); override;
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    procedure MouseEnter; override;
    procedure MouseLeave; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;

    property Antialiased: Boolean read FAntialiased write SetAntialiased;
    property Border: TActiveBorder read FBorder write SetBorder;
    property Caption: String read FCaption write SetCaption;
    property Color: TFillColor read FColor write SetColor;
    property ColorHover: TFillColor read FColorHover write SetColorHover;
    property ColorPressed: TFillColor read FColorPressed write SetColorPressed;
    property FocusRect: TFocusRect read FFocusRect write SetFocusRect;
    property Font: TActiveFormatedFont read FFont write SetFont;
    property Image: TImage read FImage write SetImage;
    property ImageHover: TImage read FImageHover write SetImageHover;
    property ImagePressed: TImage read FImagePressed write SetImagePressed;
    property Margin: Word read FMargin write SetMargin;
    property Shadow: Boolean read FShadow write SetShadow;
    property Transparent: Boolean read FTransparent write SetTransparent;
  end;
{$ENDREGION}

implementation

{$REGION 'TCustomAButton'}
{ TCustomAButton }

procedure TCustomAButton.AssignTo(Dest: TPersistent);
begin
  ControlState := ControlState + [csReadingState];

  inherited AssignTo(Dest);

  if Dest is TCustomAButton then
    with TCustomAButton(Dest) do
    begin
      Antialiased := Self.Antialiased;
      Border := Self.Border;
      Caption := Self.Caption;
      Color := Self.Color;
      ColorHover := Self.ColorHover;
      ColorPressed := Self.ColorPressed;
      FocusRect := Self.FocusRect;
      Font := Self.Font;
      Image := Self.Image;
      ImageHover := Self.ImageHover;
      ImagePressed := Self.ImagePressed;
      Margin := Self.Margin;
      Shadow := Self.Shadow;
      Transparent := Self.Transparent;
    end;

  ControlState := ControlState - [csReadingState];
end;

constructor TCustomAButton.Create(AOwner: TComponent);
var
  Num: Integer;
begin
  ControlState := ControlState + [csCreating];

  inherited Create(AOwner);

  if (AOwner <> nil) and (AOwner <> Self) and (AOwner is TWControl) then
  begin
    // Auto generate name
    Num := 1;
    begin
      while (TWControl(AOwner).Handle.FindChildControl('Button' + IntToStr(Num),
        True) <> nil) do
        Inc(Num);
      Name := 'Button' + IntToStr(Num);
    end;
  end;

  // Fields
  FAntialiased := True;
  FBorder := TActiveBorder.Create;
  FBorder.Color := $B0FFFFFF;
  FBorder.ColorHover := $C0FFFFFF;
  FBorder.ColorPressed := $C0FFFFFF;
  FBorder.Size := 1;
  FCaption := Name;
  FColor := TFillColor.Create($FFA6CAF0, $FFA6CAF0, $FF4090F0, $FF4090F0);
  FColorHover := TFillColor.Create($FFB6DAF0, $FFB6DAF0, $FF409AF0, $FF409AF0);
  FColorPressed := TFillColor.Create($FF4090F0, $FF4090F0, $FFA6CAF0,
    $FFA6CAF0);
  FFocusRect := fDark;
  FFont := TActiveFormatedFont.Create;
  FFont.Name := 'tahoma10';
  FFont.ColorPressed.SetColor($FFFFD040, $FFFFFFFF);
  FImage := TImage.Create;
  FImageHover := TImage.Create;
  FImagePressed := TImage.Create;
  FMargin := 2;
  FShadow := True;
  FTransparent := False;

  // Properties
  Left := 0;
  Top := 0;
  Width := 72;
  Height := 24;
  Visible := True;
  TabStop := True;

  ControlState := ControlState - [csCreating];
end;

destructor TCustomAButton.Destroy;
begin
  FBorder.Free;
  FColor.Free;
  FColorHover.Free;
  FColorPressed.Free;
  FFont.Free;
  FImage.Free;
  FImageHover.Free;
  FImagePressed.Free;

  inherited;
end;

procedure TCustomAButton.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if (Key = 13) or (Key = $20) then
  begin
    ControlState := ControlState + [csClicked];
  end;

  inherited KeyDown(Key, Shift);
end;

procedure TCustomAButton.KeyUp(var Key: Word; Shift: TShiftState);
begin
  if (Key = 13) or (Key = $20) then
  begin
    ControlState := ControlState - [csClicked];
    VirtualPoint := Point(Self.ClientLeft, Self.ClientTop);
    Self.Click;
  end;

  inherited KeyUp(Key, Shift);
end;

procedure TCustomAButton.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  Self.SetFocus;

  ControlState := ControlState + [csClicked];

  inherited MouseDown(Button, Shift, X, Y);
end;

procedure TCustomAButton.MouseEnter;
begin
  ControlState := ControlState + [csMouseHover];
  inherited MouseEnter;
end;

procedure TCustomAButton.MouseLeave;
begin
  ControlState := ControlState - [csMouseHover];
  inherited MouseLeave;
end;

procedure TCustomAButton.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseMove(Shift, X, Y);
end;

procedure TCustomAButton.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  ControlState := ControlState - [csClicked];

  inherited MouseUp(Button, Shift, X, Y);
end;

procedure TCustomAButton.Paint;
var
  X, Y: Integer;
  AFont: TAsphyreFont;
  AImage: TAsphyreImage;
  AColor: TFillColor;
  ABorderColor: TAColor;
  AFontColor: TTextColor;
  bTop, bBottom: TConstraintSize;
begin
  // Set initial values
  X := ClientLeft;
  Y := ClientTop;

  ControlManager.Canvas.Antialias := FAntialiased;

  // Draw Background
  if not FTransparent then
  begin
    // Select Image and Color
    if csClicked in ControlState then
    begin
      AImage := ControlManager.Images.Image[FImagePressed.Image];
      AColor := FColorPressed;
    end
    else if csMouseHover in ControlState then
    begin
      AImage := ControlManager.Images.Image[FImageHover.Image];
      AColor := FColorHover;
    end
    else
    begin
      AImage := ControlManager.Images.Image[FImage.Image];
      AColor := FColor;
    end;

    if AImage <> nil then
    begin
      if csClicked in ControlState then
      begin
        ControlManager.Canvas.UseImagePx(AImage, pRect4(FImagePressed.Rect));
        ControlManager.Canvas.TexMap(pRect4(Rect(X, Y, X + Width, Y + Height)),
          cAlpha4(AColor), beNormal);
      end
      else if csMouseHover in ControlState then
      begin
        ControlManager.Canvas.UseImagePx(AImage, pRect4(FImageHover.Rect));
        ControlManager.Canvas.TexMap(pRect4(Rect(X, Y, X + Width, Y + Height)),
          cAlpha4(AColor), beNormal);
      end
      else
      begin
        ControlManager.Canvas.UseImagePx(AImage, pRect4(FImage.Rect));
        ControlManager.Canvas.TexMap(pRect4(Rect(X, Y, X + Width, Y + Height)),
          cAlpha4(AColor), beNormal);
      end;

    end
    else
    begin
      ControlManager.Canvas.FillRect(Rect(X, Y, X + Width, Y + Height),
        cColor4(AColor), beNormal);
    end;
  end;

  // Draw Border
  if Border.Size > 0 then
  begin
    bTop := 0;
    bBottom := 0;

    // Select Border Color
    if csClicked in ControlState then
    begin
      ABorderColor := FBorder.ColorPressed;
    end
    else if csMouseHover in ControlState then
    begin
      ABorderColor := FBorder.ColorHover;
    end
    else
    begin
      ABorderColor := FBorder.Color;
    end;

    if eTop in Border.Edges then
    begin
      ControlManager.Canvas.FillRect(Rect(X, Y, X + Width, Y + Border.Size),
        ABorderColor, beNormal);
      bTop := Border.Size;
    end;

    if eBottom in Border.Edges then
    begin
      ControlManager.Canvas.FillRect(Rect(X, Y + Height - Border.Size,
        X + Width, Y + Height), ABorderColor, beNormal);
      bBottom := Border.Size;
    end;

    if eLeft in Border.Edges then
      ControlManager.Canvas.FillRect(Rect(X, Y + bTop, X + Border.Size,
        Y + Height - bBottom), ABorderColor, beNormal);

    if eRight in Border.Edges then
      ControlManager.Canvas.FillRect(Rect(X + Width - Border.Size, Y + bTop,
        X + Width, Y + Height - bBottom), ABorderColor, beNormal);
  end;

  // Draw DisplayText
  AFont := ControlManager.Fonts.Font[FFont.Name];
  if (AFont <> nil) and (FCaption <> '') then
  begin
    // Select Font Color
    if csClicked in ControlState then
    begin
      AFontColor := FFont.ColorPressed;
    end
    else if csMouseHover in ControlState then
    begin
      AFontColor := FFont.ColorHover;
    end
    else
    begin
      AFontColor := FFont.Color;
    end;

    AFont.TextRectEx(Point2(X + Border.Size + Margin, Y + Border.Size + Margin +
      1), Point2(Width - (Border.Size * 2) - (Margin * 2),
      Height - (Border.Size * 2) - (Margin * 2)), FCaption, cColor2(AFontColor),
      1.0, FFont.HorizontalAlign, FFont.VerticalAlign, FFont.ParagraphLine);
  end;

  // Draw Shadow
  if (Shadow = True) then
  begin
    ControlManager.Canvas.FillRect(Rect(X + Width, Y + 1, X + Width + 1,
      Y + Height), cColor4($40000000), beShadow);
    ControlManager.Canvas.FillRect(Rect(X + 1, Y + Height, X + Width + 1,
      Y + Height + 1), cColor4($40000000), beShadow);
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

end;

procedure TCustomAButton.SetAntialiased(Value: Boolean);
begin
  FAntialiased := Value;
end;

procedure TCustomAButton.SetBorder(Value: TActiveBorder);
begin
  if Value <> nil then
    FBorder.Assign(Value);
end;

procedure TCustomAButton.SetCaption(Value: String);
begin
  FCaption := Value;
end;

procedure TCustomAButton.SetColor(Color: TFillColor);
begin
  if Color <> nil then
    FColor.Assign(Color);
end;

procedure TCustomAButton.SetColorHover(Color: TFillColor);
begin
  if Color <> nil then
    FColorHover.Assign(Color);
end;

procedure TCustomAButton.SetColorPressed(Color: TFillColor);
begin
  if Color <> nil then
    FColorPressed.Assign(Color);
end;

procedure TCustomAButton.SetImage(Value: TImage);
begin
  if Value <> nil then
    FImage.Assign(Value);
end;

procedure TCustomAButton.SetImageHover(Value: TImage);
begin
  if Value <> nil then
    FImageHover.Assign(Value);
end;

procedure TCustomAButton.SetImagePressed(Value: TImage);
begin
  if Value <> nil then
    FImagePressed.Assign(Value);
end;

procedure TCustomAButton.SetMargin(Value: Word);
begin
  FMargin := Value;
end;

procedure TCustomAButton.SetShadow(Value: Boolean);
begin
  FShadow := Value;
end;

procedure TCustomAButton.SetFocusRect(Value: TFocusRect);
begin
  FFocusRect := Value;
end;

procedure TCustomAButton.SetFont(Value: TActiveFormatedFont);
begin
  if Value <> nil then
    FFont.Assign(Value);
end;

procedure TCustomAButton.SetTransparent(Value: Boolean);
begin
  FTransparent := Value;
end;
{$ENDREGION}

end.
