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
{  The Original Code is Tulip.UI.PaintBoxes.pas.                               }
{                                                                              }
{  The Initial Developer of the Original Code is Marcos Gomes.                 }
{  Portions created by Marcos Gomes are Copyright (C) 2012, Marcos Gomes.      }
{  All Rights Reserved.                                                        }
{                                                                              }
{******************************************************************************}
{                                                                              }
{  Tulip.UI.PaintBoxes.pas                              Modified: 05-Out-2012  }
{  --------------------------------------------------------------------------  }
{                                                                              }
{                  Base Implementations for PaintBox Controls                  }
{                                                                              }
{                                Version 1.02                                  }
{                                                                              }
{******************************************************************************}

unit Tulip.UI.PaintBoxes;

interface

uses
  System.SysUtils, System.Classes,
  // Tulip UI Units
  Tulip.UI.Types, Tulip.UI.Controls, Tulip.UI.Forms;

type
{$REGION 'TCustomAPaintBox'}
  TCustomAPaintBox = class(TAControl)
  private
    FAntialiased: Boolean;
    FCanMoveHandle: Boolean;
    FOnPaint: TNotifyEvent;
    procedure SetAntialiased(Value: Boolean);
    procedure SetCanMoveHandle(Value: Boolean);
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
    property CanMoveHandle: Boolean read FCanMoveHandle write SetCanMoveHandle;
    property OnPaint: TNotifyEvent read FOnPaint write FOnPaint;
  end;
{$ENDREGION}

implementation

var
  XOffSet, YOffSet: Integer;

{$REGION 'TCustomAPaintBox'}
  { TCustomAPaintBox }

procedure TCustomAPaintBox.AssignTo(Dest: TPersistent);
begin
  ControlState := ControlState + [csReadingState];

  inherited AssignTo(Dest);

  if Dest is TCustomAPaintBox then
    with TCustomAPaintBox(Dest) do
    begin
      Antialiased := Self.Antialiased;
      CanMoveHandle := Self.CanMoveHandle;
    end;

  ControlState := ControlState - [csReadingState];
end;

constructor TCustomAPaintBox.Create(AOwner: TComponent);
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
      while (TWControl(AOwner).Handle.FindChildControl('PaintBox' +
        IntToStr(Num), True) <> nil) do
        Inc(Num);
      Name := 'PaintBox' + IntToStr(Num);
    end;
  end;

  // Fields
  FAntialiased := True;
  FCanMoveHandle := False;

  // Properties
  Left := 0;
  Top := 0;
  Width := 120;
  Height := 80;
  Visible := True;

  ControlState := ControlState - [csCreating];
end;

destructor TCustomAPaintBox.Destroy;
begin

  inherited;
end;

procedure TCustomAPaintBox.MouseDown(Button: TMouseButton; Shift: TShiftState;
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

procedure TCustomAPaintBox.MouseMove(Shift: TShiftState; X, Y: Integer);
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

procedure TCustomAPaintBox.MouseUp(Button: TMouseButton; Shift: TShiftState;
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

procedure TCustomAPaintBox.Paint;
begin
  if Assigned(FOnPaint) then
  begin
    ControlManager.Canvas.Antialias := FAntialiased;
    FOnPaint(Self);
  end;
end;

procedure TCustomAPaintBox.SetAntialiased(Value: Boolean);
begin
  FAntialiased := Value;
end;

procedure TCustomAPaintBox.SetCanMoveHandle(Value: Boolean);
begin
  FCanMoveHandle := Value;
end;
{$ENDREGION}

end.
