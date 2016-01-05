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
{  The Original Code is Tulip.UI.Panels.pas.                                   }
{                                                                              }
{  The Initial Developer of the Original Code is Marcos Gomes.                 }
{  Portions created by Marcos Gomes are Copyright (C) 2012, Marcos Gomes.      }
{  All Rights Reserved.                                                        }
{                                                                              }
{******************************************************************************}
{                                                                              }
{  Tulip.UI.Panels.pas                                  Modified: 05-Out-2012  }
{  --------------------------------------------------------------------------  }
{                                                                              }
{                    Base Implementations for Panel Controls                   }
{                                                                              }
{                                Version 1.02                                  }
{                                                                              }
{******************************************************************************}

unit Tulip.UI.Panels;

interface

uses
  System.SysUtils, System.Classes,
  // PXL Units
  PXL.Canvas,
  PXL.Images,
  PXL.Fonts,
  PXL.Types,
  // Tulip UI Units
  Tulip.UI.Types, Tulip.UI.Classes, Tulip.UI.Controls, Tulip.UI.Helpers,
  Tulip.UI.Forms, Tulip.UI.Utils;

type
{$REGION 'TCustomAPanel'}
  TCustomAPanel = class(TWControl)
  private
    FAntialiased: Boolean;
    FBorder: TBorder;
    FCanMoveHandle: Boolean;
    FCaption: String;
    FColor: TFillColor;
    FFont: TFormatedFont;
    FImage: TImage;
    FMargin: Word;
    FTransparent: Boolean;

    procedure SetAntialiased(Value: Boolean);
    procedure SetBorder(Value: TBorder);
    procedure SetCanMoveHandle(Value: Boolean);
    procedure SetCaption(Value: String);
    procedure SetColor(Color: TFillColor);
    procedure SetFont(Value: TFormatedFont);
    procedure SetImage(Value: TImage);
    procedure SetMargin(Value: Word);
    procedure SetTransparent(Value: Boolean);
  protected
    procedure AssignTo(Dest: TPersistent); override;
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

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
    property Font: TFormatedFont read FFont write SetFont;
    property Image: TImage read FImage write SetImage;
    property Margin: Word read FMargin write SetMargin;
    property Transparent: Boolean read FTransparent write SetTransparent;
  end;
{$ENDREGION}

implementation

var
  XOffSet, YOffSet: Integer;

{$REGION 'TCustomAPanel'}
  { TCustomAPanel }

procedure TCustomAPanel.AssignTo(Dest: TPersistent);
begin
  ControlState := ControlState + [csReadingState];

  inherited AssignTo(Dest);

  if Dest is TCustomAPanel then
    with TCustomAPanel(Dest) do
    begin
      Antialiased := Self.Antialiased;
      Border := Self.Border;
      CanMoveHandle := Self.CanMoveHandle;
      Caption := Self.Caption;
      Color := Self.Color;
      Font := Self.Font;
      Image := Self.Image;
      Margin := Self.Margin;
      Transparent := Self.Transparent;
    end;

  ControlState := ControlState - [csReadingState];
end;

constructor TCustomAPanel.Create(AOwner: TComponent);
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
      while (TWControl(AOwner).Handle.FindChildControl('Panel' + IntToStr(Num),
        True) <> nil) do
        Inc(Num);
      Name := 'Panel' + IntToStr(Num);
    end;
  end;

  // Fields
  FAntialiased := True;
  FBorder := TBorder.Create;
  FBorder.Color := $B0FFFFFF;
  FBorder.Size := 1;
  FCanMoveHandle := True;
  FCaption := '';
  FColor := TFillColor.Create($FFA6CAF0, $FFA6CAF0, $FF4090F0, $FF4090F0);
  FFont := TFormatedFont.Create;
  FImage := TImage.Create;
  FMargin := 2;
  FTransparent := False;

  // Properties
  Left := 0;
  Top := 0;
  Width := 120;
  Height := 80;
  Visible := True;

  ControlState := ControlState - [csCreating];
end;

destructor TCustomAPanel.Destroy;
begin
  FBorder.Free;
  FColor.Free;
  FFont.Free;
  FImage.Free;

  inherited;
end;

procedure TCustomAPanel.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
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

procedure TCustomAPanel.MouseMove(Shift: TShiftState; X, Y: Integer);
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

procedure TCustomAPanel.MouseUp(Button: TMouseButton; Shift: TShiftState;
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

procedure TCustomAPanel.Paint;
var
  X, Y: Integer;
  AFont: TBitmapFont;
  AImage: TAtlasImage;
  bTop, bBottom: TConstraintSize;
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

  // Draw DisplayText
  AFont := ControlManager.Fonts.Font[FFont.Name];
  if (AFont <> nil) and (FCaption <> '') then
  begin
    AFont.TextRectEx(Point2(X + Border.Size + Margin, Y + Border.Size + Margin +
      1), Point2(Width - (Border.Size * 2) - (Margin * 2),
      Height - (Border.Size * 2) - (Margin * 2)), FCaption,
      cColor2(FFont.Color), 1.0, FFont.HorizontalAlign, FFont.VerticalAlign,
      FFont.ParagraphLine);
  end;

  inherited Paint;
end;

procedure TCustomAPanel.SetAntialiased(Value: Boolean);
begin
  FAntialiased := Value;
end;

procedure TCustomAPanel.SetBorder(Value: TBorder);
begin
  if Value <> nil then
    FBorder.Assign(Value);
end;

procedure TCustomAPanel.SetCanMoveHandle(Value: Boolean);
begin
  FCanMoveHandle := Value;
end;

procedure TCustomAPanel.SetCaption(Value: String);
begin
  FCaption := Value;
end;

procedure TCustomAPanel.SetColor(Color: TFillColor);
begin
  if Color <> nil then
    FColor.Assign(Color);
end;

procedure TCustomAPanel.SetImage(Value: TImage);
begin
  if Value <> nil then
    FImage.Assign(Value);
end;

procedure TCustomAPanel.SetMargin(Value: Word);
begin
  FMargin := Value;
end;

procedure TCustomAPanel.SetFont(Value: TFormatedFont);
begin
  if Value <> nil then
    FFont.Assign(Value);
end;

procedure TCustomAPanel.SetTransparent(Value: Boolean);
begin
  FTransparent := Value;
end;
{$ENDREGION}

end.
