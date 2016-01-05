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
{  The Original Code is Tulip.UI.Images.pas.                                   }
{                                                                              }
{  The Initial Developer of the Original Code is Marcos Gomes.                 }
{  Portions created by Marcos Gomes are Copyright (C) 2012, Marcos Gomes.      }
{  All Rights Reserved.                                                        }
{                                                                              }
{******************************************************************************}
{                                                                              }
{  Tulip.UI.Images.pas                                  Modified: 05-Out-2012  }
{  --------------------------------------------------------------------------  }
{                                                                              }
{                    Base Implementations for Image Controls                   }
{                                                                              }
{                                Version 1.02                                  }
{                                                                              }
{******************************************************************************}

unit Tulip.UI.Images;

interface

uses
  System.Classes, System.SysUtils,
  // PXL Units
  PXL.Canvas,
  PXL.Images,
  PXL.Types,
  // Tulip UI Units
  Tulip.UI.Controls, Tulip.UI.Classes, Tulip.UI.Types, Tulip.UI.Forms,
  Tulip.UI.Utils;

type
{$REGION 'TCustomAImage'}
  TCustomAImage = class(TAControl)
  private
    FAntialiased: Boolean;
    FBorder: TBorder;
    FCanMoveHandle: Boolean;
    FColor: TFillColor;
    FImage: TImage;
    procedure SetAntialiased(Value: Boolean);
    procedure SetBorder(Value: TBorder);
    procedure SetCanMoveHandle(Value: Boolean);
    procedure SetColor(Color: TFillColor);
    procedure SetImage(Value: TImage);
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
    property Color: TFillColor read FColor write SetColor;
    property Image: TImage read FImage write SetImage;
  end;
{$ENDREGION}

implementation

var
  XOffSet, YOffSet: Integer;

{$REGION 'TCustomAImage'}
  { TCustomAImage }

procedure TCustomAImage.AssignTo(Dest: TPersistent);
begin
  ControlState := ControlState + [csReadingState];

  inherited AssignTo(Dest);

  if Dest is TCustomAImage then
    with TCustomAImage(Dest) do
    begin
      Antialiased := Self.Antialiased;
      Border := Self.Border;
      CanMoveHandle := Self.CanMoveHandle;
      Color := Self.Color;
      Image := Self.Image;
    end;

  ControlState := ControlState - [csReadingState];
end;

constructor TCustomAImage.Create(AOwner: TComponent);
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
      while (TWControl(AOwner).Handle.FindChildControl('Image' + IntToStr(Num),
        True) <> nil) do
        Inc(Num);
      Name := 'Image' + IntToStr(Num);
    end;
  end;

  // Fields
  FAntialiased := True;
  FBorder := TBorder.Create;
  FBorder.Color := $B0FFFFFF;
  FBorder.Size := 0;
  FCanMoveHandle := True;
  FColor := TFillColor.Create;
  FImage := TImage.Create;

  // Properties
  Left := 0;
  Top := 0;
  Width := 80;
  Height := 80;
  Visible := True;

  ControlState := ControlState - [csCreating];
end;

destructor TCustomAImage.Destroy;
begin
  FBorder.Free;
  FColor.Free;
  FImage.Free;

  inherited;
end;

procedure TCustomAImage.MouseDown(Button: TMouseButton; Shift: TShiftState;
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

procedure TCustomAImage.MouseMove(Shift: TShiftState; X, Y: Integer);
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

procedure TCustomAImage.MouseUp(Button: TMouseButton; Shift: TShiftState;
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

procedure TCustomAImage.Paint;
var
  X, Y: Integer;
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
  AImage := ControlManager.Images.Image[FImage.Image];
  if AImage <> nil then
  begin
    ControlManager.Canvas.UseImagePx(AImage, FloatRect4(FImage.Rect));
    ControlManager.Canvas.TexQuad(FloatRect4(Rect(X, Y, X + Width, Y + Height)),
      cAlpha4(FColor), Normal);
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
end;

procedure TCustomAImage.SetAntialiased(Value: Boolean);
begin
  FAntialiased := Value;
end;

procedure TCustomAImage.SetBorder(Value: TBorder);
begin
  if Value <> nil then
    FBorder.Assign(Value);
end;

procedure TCustomAImage.SetCanMoveHandle(Value: Boolean);
begin
  if FCanMoveHandle <> Value then
    FCanMoveHandle := Value;
end;

procedure TCustomAImage.SetColor(Color: TFillColor);
begin
  if Color <> nil then
    FColor.Assign(Color);
end;

procedure TCustomAImage.SetImage(Value: TImage);
begin
  if Value <> nil then
    FImage.Assign(Value);
end;
{$ENDREGION}

end.
