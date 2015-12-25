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
{  The Original Code is Tulip.UI.pas.                                          }
{                                                                              }
{  The Initial Developer of the Original Code is Marcos Gomes.                 }
{  Portions created by Marcos Gomes are Copyright (C) 2012, Marcos Gomes.      }
{  All Rights Reserved.                                                        }
{                                                                              }
{******************************************************************************}
{                                                                              }
{  Tulip.UI.pas                                         Modified: 23-Mar-2013  }
{  --------------------------------------------------------------------------  }
{                                                                              }
{                      User Controls and ControlManager                        }
{                                                                              }
{                                Version 1.03                                  }
{                                                                              }
{******************************************************************************}

unit Tulip.UI;

interface

uses
  Winapi.Messages, System.Types, System.Classes, Vcl.Controls, Vcl.Forms,
  Vcl.Clipbrd,
  // Asphyre Units
  AbstractDevices, AbstractCanvas,
  // Tulip UI Units
  Tulip.UI.Controls, Tulip.UI.Forms, Tulip.UI.Images, Tulip.UI.Labels,
  Tulip.UI.Panels, Tulip.UI.Buttons, Tulip.UI.EditBoxes,
  Tulip.UI.CheckBoxes, Tulip.UI.RadioButtons, Tulip.UI.ProgressBars,
  Tulip.UI.PaintBoxes, Tulip.UI.TrackBars, Tulip.UI.ListBoxes;

type

{$REGION 'TAButton'}
  TAButton = class(TCustomAButton)
  published
    property Antialiased;
    property Border;
    property Caption;
    property Color;
    property ColorHover;
    property ColorPressed;
    property FocusRect;
    property Font;
    property Image;
    property ImageHover;
    property ImagePressed;
    property Margin;
    property Shadow;
    property Transparent;
  end;

  TAButtonClass = class of TAButton;
{$ENDREGION}
{$REGION 'TACheckBox'}

  TACheckBox = class(TCustomACheckBox)
  published
    property Antialiased;
    property Border;
    property Box;
    property Caption;
    property Checked;
    property Color;
    property FocusRect;
    property Font;
    property Image;
    property Margin;
    property ReadOnly;
    property Transparent;
  end;

  TACheckBoxClass = class of TACheckBox;
{$ENDREGION}
{$REGION 'TAEditBox'}

  TAEditBox = class(TCustomAEditBox)
  published
    property Antialiased;
    property AutoSelect;
    property Border;
    property Color;
    property FocusRect;
    property Font;
    property Image;
    property Margin;
    property MaxLength;
    property ReadOnly;
    property Text;
  end;

  TAEditboxClass = class of TAEditBox;
{$ENDREGION}
{$REGION 'TAForm'}

  TAForm = class(TCustomAForm)
  published
    property Antialiased;
    property Border;
    property BoundToScreen;
    property Caption;
    property CanMove;
    property Color;
    property Font;
    property Image;
    property Margin;
    property Shadow;
    property WordWrap;
  end;

  TAFormClass = class of TAForm;
{$ENDREGION}
{$REGION 'TAImage'}

  TAImage = class(TCustomAImage)
  published
    property Antialiased;
    property Border;
    property CanMoveHandle;
    property Color;
    property Image;
  end;

  TAImageClass = class of TAImage;
{$ENDREGION}
{$REGION 'TALabel'}

  TALabel = class(TCustomALabel)
  published
    property Antialiased;
    property Border;
    property CanMoveHandle;
    property Caption;
    property Color;
    property FocusControl;
    property Font;
    property Image;
    property Margin;
    property Transparent;
    property WordWrap;
  end;

  TALabelClass = class of TALabel;
{$ENDREGION}
{$REGION 'TAListBox'}

  TAListBox = class(TCustomAListBox)
  published
    property Antialiased;
    property Border;
    property Color;
    property DownButton;
    property FocusRect;
    property Font;
    property Image;
    property ItemIndex;
    property LineHeight;
    property Lines;
    property Margin;
    property ScrollButton;
    property Transparent;
    property UpButton;
  end;

  TAListBoxClass = class of TAListBox;
{$ENDREGION}
{$REGION 'TAPaintBox'}

  TAPaintBox = class(TCustomAPaintBox)
  published
    property Antialiased;
    property CanMoveHandle;
  end;

  TAPaintBoxClass = class of TAPaintBox;
{$ENDREGION}
{$REGION 'TAPanel'}

  TAPanel = class(TCustomAPanel)
  published
    property Antialiased;
    property Border;
    property CanMoveHandle;
    property Caption;
    property Color;
    property Font;
    property Image;
    property Margin;
    property Transparent;
  end;

  TAPanelClass = class of TAPanel;
{$ENDREGION}
{$REGION 'TAProgressBar'}

  TAProgressBar = class(TCustomAProgressBar)
  published
    property Antialiased;
    property Border;
    property CanMoveHandle;
    property Caption;
    property Color;
    property Display;
    property Font;
    property Image;
    property Margin;
    property Max;
    property Min;
    property Position;
    property ProgressColor;
    property Transparent;
  end;

  TAProgressBarClass = class of TAProgressBar;
{$ENDREGION}
{$REGION 'TARadioButton'}

  TARadioButton = class(TCustomARadioButton)
  published
    property Antialiased;
    property Border;
    property Box;
    property Caption;
    property Checked;
    property Color;
    property FocusRect;
    property Font;
    property Image;
    property Margin;
    property ReadOnly;
    property Transparent;
  end;

  TARadioButtonClass = class of TARadioButton;
{$ENDREGION}
{$REGION 'TATrackBar'}

  TATrackBar = class(TCustomATrackBar)
  published
    property Antialiased;
    property Border;
    property Button;
    property Color;
    property FocusRect;
    property Image;
    property Increment;
    property Margin;
    property Max;
    property Min;
    property Position;
    property Transparent;
  end;

  TATrackBarClass = class of TATrackBar;
{$ENDREGION}
{$REGION 'TAControlManager'}

  TAControlManager = class(TCustomManager)
  private
    procedure AcquireEvents;
    procedure RestoreEvents;
    procedure ShortCut(var Msg: TWMKey; var Handled: Boolean);
  protected
    procedure Click(Sender: TObject); virtual;
    procedure DblClick(Sender: TObject); virtual;

    procedure KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState); virtual;
    procedure KeyPress(Sender: TObject; var Key: Char); virtual;
    procedure KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState); virtual;

    procedure MouseEnter(Sender: TObject); virtual;
    procedure MouseLeave(Sender: TObject); virtual;

    procedure MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer); virtual;
    procedure MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); virtual;
    procedure MouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer); virtual;

    procedure MouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean); virtual;
    procedure MouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean); virtual;
    procedure MouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean); virtual;

    procedure SetParent(const AParent: TComponent); override;
  public
    destructor Destroy; override;

    function GetClipboard: TClipboard;
    function GetParentAsControl: TControl;

    function AButton(const Parent, Name: String): TAButton;
    function ACheckBox(const Parent, Name: String): TACheckBox;
    function AEditBox(const Parent, Name: String): TAEditBox;
    function AForm(const Name: String): TAForm;
    function AImage(const Parent, Name: String): TAImage;
    function ALabel(const Parent, Name: String): TALabel;
    function AListBox(const Parent, Name: String): TAListBox;
    function APaintBox(const Parent, Name: String): TAPaintBox;
    function APanel(const Parent, Name: String): TAPanel;
    function AProgressBar(const Parent, Name: String): TAProgressBar;
    function ARadioButton(const Parent, Name: String): TARadioButton;
    function ATrackBar(const Parent, Name: String): TATrackBar;
  end;
{$ENDREGION}

implementation

{$REGION 'TAControlManager'}
{ TAControlManager }

function TAControlManager.AButton(const Parent, Name: String): TAButton;
var
  AControl: TAControl;
begin
  Result := nil;

  AControl := Self.Root.FindChildControl(Parent, False);

  if AControl <> nil then
    if AControl is TAForm then
      AControl := TAForm(AControl).FindChildControl(Name, True);

  if AControl <> nil then
    if AControl is TAButton then
      Result := TAButton(AControl);
end;

function TAControlManager.ACheckBox(const Parent, Name: String): TACheckBox;
var
  AControl: TAControl;
begin
  Result := nil;

  AControl := Self.Root.FindChildControl(Parent, False);

  if AControl <> nil then
    if AControl is TAForm then
      AControl := TAForm(AControl).FindChildControl(Name, True);

  if AControl <> nil then
    if AControl is TACheckBox then
      Result := TACheckBox(AControl);
end;

procedure TAControlManager.AcquireEvents;
begin
  if Parent is TForm then
  begin
    Self.OwnerMouseEnter := TForm(Parent).OnMouseEnter;
    Self.OwnerMouseLeave := TForm(Parent).OnMouseLeave;
    Self.OwnerMouseDown := TForm(Parent).OnMouseDown;
    Self.OwnerMouseUp := TForm(Parent).OnMouseUp;
    Self.OwnerMouseMove := TForm(Parent).OnMouseMove;
    Self.OwnerMouseWheel := TForm(Parent).OnMouseWheel;
    Self.OwnerMouseWheelDown := TForm(Parent).OnMouseWheelDown;
    Self.OwnerMouseWheelUp := TForm(Parent).OnMouseWheelUp;

    Self.OwnerKeyDown := TForm(Parent).OnKeyDown;
    Self.OwnerKeyUp := TForm(Parent).OnKeyUp;
    Self.OwnerKeyPress := TForm(Parent).OnKeyPress;
    Self.OwnerShortCut := TForm(Parent).OnShortCut;

    Self.OwnerClick := TForm(Parent).OnClick;
    Self.OwnerDblClick := TForm(Parent).OnDblClick;

    TForm(Parent).OnMouseDown := MouseDown;
    TForm(Parent).OnMouseUp := MouseUp;
    TForm(Parent).OnMouseMove := MouseMove;
    TForm(Parent).OnMouseEnter := MouseEnter;
    TForm(Parent).OnMouseLeave := MouseLeave;
    TForm(Parent).OnMouseWheel := MouseWheel;
    TForm(Parent).OnMouseWheelDown := MouseWheelDown;
    TForm(Parent).OnMouseWheelUp := MouseWheelUp;

    TForm(Parent).OnKeyDown := KeyDown;
    TForm(Parent).OnKeyUp := KeyUp;
    TForm(Parent).OnKeyPress := KeyPress;

    TForm(Parent).OnClick := Click;
    TForm(Parent).OnDblClick := DblClick;
    TForm(Parent).OnShortCut := ShortCut;

  end;
end;

function TAControlManager.AEditBox(const Parent, Name: String): TAEditBox;
var
  AControl: TAControl;
begin
  Result := nil;

  AControl := Self.Root.FindChildControl(Parent, False);

  if AControl <> nil then
    if AControl is TAForm then
      AControl := TAForm(AControl).FindChildControl(Name, True);

  if AControl <> nil then
    if AControl is TAEditBox then
      Result := TAEditBox(AControl);
end;

function TAControlManager.AForm(const Name: String): TAForm;
var
  AControl: TAControl;
begin
  Result := nil;

  AControl := Self.Root.FindChildControl(Name, False);

  if AControl <> nil then
    if AControl is TAForm then
      Result := TAForm(AControl);
end;

function TAControlManager.AImage(const Parent, Name: String): TAImage;
var
  AControl: TAControl;
begin
  Result := nil;

  AControl := Self.Root.FindChildControl(Parent, False);

  if AControl <> nil then
    if AControl is TAForm then
      AControl := TAForm(AControl).FindChildControl(Name, True);

  if AControl <> nil then
    if AControl is TAImage then
      Result := TAImage(AControl);
end;

function TAControlManager.ALabel(const Parent, Name: String): TALabel;
var
  AControl: TAControl;
begin
  Result := nil;

  AControl := Self.Root.FindChildControl(Parent, False);

  if AControl <> nil then
    if AControl is TAForm then
      AControl := TAForm(AControl).FindChildControl(Name, True);

  if AControl <> nil then
    if AControl is TALabel then
      Result := TALabel(AControl);
end;

function TAControlManager.AListBox(const Parent, Name: String): TAListBox;
var
  AControl: TAControl;
begin
  Result := nil;

  AControl := Self.Root.FindChildControl(Parent, False);

  if AControl <> nil then
    if AControl is TAForm then
      AControl := TAForm(AControl).FindChildControl(Name, True);

  if AControl <> nil then
    if AControl is TAListBox then
      Result := TAListBox(AControl);
end;

function TAControlManager.APaintBox(const Parent, Name: String): TAPaintBox;
var
  AControl: TAControl;
begin
  Result := nil;

  AControl := Self.Root.FindChildControl(Parent, False);

  if AControl <> nil then
    if AControl is TAForm then
      AControl := TAForm(AControl).FindChildControl(Name, True);

  if AControl <> nil then
    if AControl is TAPaintBox then
      Result := TAPaintBox(AControl);
end;

function TAControlManager.APanel(const Parent, Name: String): TAPanel;
var
  AControl: TAControl;
begin
  Result := nil;

  AControl := Self.Root.FindChildControl(Parent, False);

  if AControl <> nil then
    if AControl is TAForm then
      AControl := TAForm(AControl).FindChildControl(Name, True);

  if AControl <> nil then
    if AControl is TAPanel then
      Result := TAPanel(AControl);
end;

function TAControlManager.AProgressBar(const Parent, Name: String)
  : TAProgressBar;
var
  AControl: TAControl;
begin
  Result := nil;

  AControl := Self.Root.FindChildControl(Parent, False);

  if AControl <> nil then
    if AControl is TAForm then
      AControl := TAForm(AControl).FindChildControl(Name, True);

  if AControl <> nil then
    if AControl is TAProgressBar then
      Result := TAProgressBar(AControl);
end;

function TAControlManager.ARadioButton(const Parent, Name: String)
  : TARadioButton;
var
  AControl: TAControl;
begin
  Result := nil;

  AControl := Self.Root.FindChildControl(Parent, False);

  if AControl <> nil then
    if AControl is TAForm then
      AControl := TAForm(AControl).FindChildControl(Name, True);

  if AControl <> nil then
    if AControl is TARadioButton then
      Result := TARadioButton(AControl);
end;

function TAControlManager.ATrackBar(const Parent, Name: String): TATrackBar;
var
  AControl: TAControl;
begin
  Result := nil;

  AControl := Self.Root.FindChildControl(Parent, False);

  if AControl <> nil then
    if AControl is TAForm then
      AControl := TAForm(AControl).FindChildControl(Name, True);

  if AControl <> nil then
    if AControl is TATrackBar then
      Result := TATrackBar(AControl);
end;

procedure TAControlManager.Click(Sender: TObject);
var
  Control: TAControl;
begin
  if (Assigned(OwnerClick)) then
    OwnerClick(Sender);
  if (Active) then
  begin
    Control := PreviousControl;
    if (Control <> nil) then
      if (Control.Enabled) and (Control.Visible) then
        Control.Click;
  end;
end;

procedure TAControlManager.DblClick(Sender: TObject);
var
  Control: TAControl;
begin
  if (Assigned(OwnerDblClick)) then
    OwnerDblClick(Sender);
  if (Active) then
  begin
    Control := PreviousControl;
    if (Control <> nil) then
      if (Control.Enabled) and (Control.Visible) then
        Control.DblClick;
  end;
end;

destructor TAControlManager.Destroy;
begin
  RestoreEvents;

  inherited;
end;

procedure TAControlManager.ShortCut(var Msg: TWMKey; var Handled: Boolean);
var
  Key: Word;
  Shift: TShiftState;
begin
  if Msg.CharCode = 9 then
  begin
    Key := Msg.CharCode;
    Shift := KeyDataToShiftState(Msg.KeyData);
    Self.KeyDown(Parent, Key, Shift);
    Handled := True;
  end;
end;

function TAControlManager.GetClipboard: TClipboard;
begin
  Result := Clipboard;
end;

function TAControlManager.GetParentAsControl: TControl;
begin
  if Parent is TControl then
    Result := Parent as TControl
  else
    Result := nil;
end;

procedure TAControlManager.KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  Control: TWControl;
begin
  if (Assigned(OwnerKeyDown)) then
    OwnerKeyDown(Sender, Key, Shift);
  if (Active) then
  begin
    Control := ActiveControl;
    if Control <> nil then
    begin
      if (Control.Enabled) and (Control.Visible) then
        Control.KeyDown(Key, Shift);
    end
    else if Root.GetWControls <> nil then
      TWControl(Root.GetWControls[Root.GetWControls.Count - 1])
        .KeyDown(Key, Shift)
    else
      Root.KeyDown(Key, Shift);
  end;
end;

procedure TAControlManager.KeyPress(Sender: TObject; var Key: Char);
var
  Control: TWControl;
begin
  if (Assigned(OwnerKeyPress)) then
    OwnerKeyPress(Sender, Key);
  if (Active) then
  begin
    Control := ActiveControl;
    if Control <> nil then
    begin
      if (Control.Enabled) and (Control.Visible) then
        Control.KeyPress(Key);
    end
    else if Root.GetWControls <> nil then
      TWControl(Root.GetWControls[Root.GetWControls.Count - 1]).KeyPress(Key)
    else
      Root.KeyPress(Key);
  end;
end;

procedure TAControlManager.KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  Control: TWControl;
begin
  if (Assigned(OwnerKeyUp)) then
    OwnerKeyUp(Sender, Key, Shift);
  if (Active) then
  begin
    Control := ActiveControl;
    if Control <> nil then
    begin
      if (Control.Enabled) and (Control.Visible) then
        Control.KeyUp(Key, Shift);
    end
    else if Root.GetWControls <> nil then
      TWControl(Root.GetWControls[Root.GetWControls.Count - 1])
        .KeyUp(Key, Shift)
    else
      Root.KeyUp(Key, Shift);
  end;
end;

procedure TAControlManager.MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  Control: TAControl;
begin
  // fixes coordinates when scaled
  if (Self.Parent is TControl) then
  begin
    if Self.Device.SwapChains.Items[0].Width <> TControl(Self.Parent).ClientWidth
    then
      X := Trunc(X * (Self.Device.SwapChains.Items[0].Width /
        TControl(Self.Parent).ClientWidth));
    if Self.Device.SwapChains.Items[0].Height <> TControl(Self.Parent).ClientHeight
    then
      Y := Trunc(Y * (Self.Device.SwapChains.Items[0].Height /
        TControl(Self.Parent).ClientHeight));
  end;

  if (Assigned(OwnerMouseDown)) then
    OwnerMouseDown(Sender, Button, Shift, X, Y);
  if (Active) then
  begin
    Control := Root.ControlAtPos(Point(X, Y), True, True, True);

    // Check if is Modal
    if ActiveControl <> nil then
    begin
      if ActiveControl.Handle <> nil then
      begin
        if ActiveControl.Handle is TAForm then
        begin
          if (TAForm(ActiveControl.Handle).IsModal) and
            (ActiveControl.Handle <> Control) then
          begin
            if (Control <> nil) then
            begin
              if ActiveControl.Handle.FindChildControl(Control.Name, True) = nil
              then
                Exit;
            end
            else
            begin
              Exit;
            end;
          end;
        end;
      end;
    end;

    if (Control <> nil) then
    begin
      if (Control.Enabled = True) then
        Control.MouseDown(Button, Shift, X, Y);
      PreviousControl := Control;
    end;
  end;
end;

procedure TAControlManager.MouseEnter(Sender: TObject);
var
  Control: TAControl;
begin
  if (Assigned(OwnerMouseEnter)) then
    OwnerMouseEnter(Sender);
  if (Active) then
  begin
    Root.MouseEnter;
    Control := PreviousControl;
    if (Control <> nil) then
      if (Control.Enabled) and (Control.Visible) then
        Control.MouseEnter;
  end;
end;

procedure TAControlManager.MouseLeave(Sender: TObject);
var
  Control: TAControl;
begin
  if (Assigned(OwnerMouseLeave)) then
    OwnerMouseLeave(Sender);
  if (Active) then
  begin
    Root.MouseLeave;
    Control := PreviousControl;
    if (Control <> nil) then
      if (Control.Enabled) and (Control.Visible) then
        Control.MouseLeave;
  end;
end;

procedure TAControlManager.MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var
  Control: TAControl;
begin
  // fixes coordinates when scaled
  if (Self.Parent is TControl) then
  begin
    if Self.Device.SwapChains.Items[0].Width <> TControl(Self.Parent).ClientWidth
    then
      X := Trunc(X * (Self.Device.SwapChains.Items[0].Width /
        TControl(Self.Parent).ClientWidth));
    if Self.Device.SwapChains.Items[0].Height <> TControl(Self.Parent).ClientHeight
    then
      Y := Trunc(Y * (Self.Device.SwapChains.Items[0].Height /
        TControl(Self.Parent).ClientHeight));
  end;

  if (Assigned(OwnerMouseMove)) then
    OwnerMouseMove(Sender, Shift, X, Y);

  if (Active) then
  begin
    if Shift = [ssLeft] then
      Control := PreviousControl
    else
      Control := Root.ControlAtPos(Point(X, Y), True, True, True);

    // Check if is Modal
    if ActiveControl <> nil then
    begin
      if ActiveControl.Handle <> nil then
      begin
        if ActiveControl.Handle is TAForm then
        begin
          if (TAForm(ActiveControl.Handle).IsModal) and
            (ActiveControl.Handle <> Control) then
          begin
            if (Control <> nil) then
            begin
              if ActiveControl.Handle.FindChildControl(Control.Name, True) = nil
              then
                Exit;
            end
            else
            begin
              Exit;
            end;
          end;
        end;
      end;
    end;

    if (PreviousControl <> Control) then
    begin
      if (PreviousControl <> nil) then
      begin
        if (PreviousControl.Enabled) and (PreviousControl.Visible) then
          if PreviousControl is TWControl then
          begin
            if Control <> nil then
            begin
              if TWControl(PreviousControl).FindChildControl(Control.Name) = nil
              then
                PreviousControl.MouseLeave;
            end
            else
              PreviousControl.MouseLeave;
          end
          else
            PreviousControl.MouseLeave;
      end;
      if (Control <> nil) then
      begin
        if (Control.Enabled) and (Control.Visible) then
          Control.MouseEnter;
      end;
      PreviousControl := Control;
    end;

    if (Control <> nil) then
    begin
      if (Control.Enabled) and (Control.Visible) then
        Control.MouseMove(Shift, X, Y);
    end;

    // used for tests only
    {
      if Control <> nil then
      TForm(Parent).caption := '(' + Inttostr(X) + ',' + Inttostr(Y)
      + ') - ' + Control.Name
      else
      TForm(Parent).caption := '(' + Inttostr(X) + ',' + Inttostr(Y) + ')';
    }
  end;
end;

procedure TAControlManager.MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  Control: TAControl;
begin
  // fixes coordinates when scaled
  if (Self.Parent is TControl) then
  begin
    if Self.Device.SwapChains.Items[0].Width <> TControl(Self.Parent).ClientWidth
    then
      X := Trunc(X * (Self.Device.SwapChains.Items[0].Width /
        TControl(Self.Parent).ClientWidth));
    if Self.Device.SwapChains.Items[0].Height <> TControl(Self.Parent).ClientHeight
    then
      Y := Trunc(Y * (Self.Device.SwapChains.Items[0].Height /
        TControl(Self.Parent).ClientHeight));
  end;

  if (Assigned(OwnerMouseUp)) then
    OwnerMouseUp(Sender, Button, Shift, X, Y);
  if (Active) then
  begin
    if Button = mbLeft then
    begin
      Control := PreviousControl;

      // if (FPrevControl is TADropPanel) then
      // begin
      // Control := FRoot.ControlAtPos(Point(X, Y), True, True, True);
      //
      // if not(Control is TADropPanel) then
      // begin
      // Control := FPrevControl;
      // end;
      // end;
    end
    else
      Control := Root.ControlAtPos(Point(X, Y), True, True, True);

    if (Control <> nil) then
    begin
      if (Control.Enabled) and (Control.Visible) then
        Control.MouseUp(Button, Shift, X, Y);

      // if (FPrevControl <> Control) and (FPrevControl is TADropPanel) then
      // TADropPanel(FPrevControl).DragItem := False;

      PreviousControl := Control;
    end;
  end;
end;

procedure TAControlManager.MouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
var
  Control: TAControl;
begin
  if (Assigned(OwnerMouseWheel)) then
    OwnerMouseWheel(Sender, Shift, WheelDelta, MousePos, Handled);
  if (Active) then
  begin
    Control := PreviousControl;
    if (Control <> nil) then
      if (Control.Enabled) and (Control.Visible) then
        Control.MouseWheel(Shift, WheelDelta, MousePos);
  end;
end;

procedure TAControlManager.MouseWheelDown(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
var
  Control: TAControl;
begin
  if (Assigned(OwnerMouseWheelDown)) then
    OwnerMouseWheelDown(Sender, Shift, MousePos, Handled);
  if (Active) then
  begin
    Control := PreviousControl;
    if (Control <> nil) then
      if (Control.Enabled) and (Control.Visible) then
        Control.MouseWheelDown(Shift, MousePos);
  end;
end;

procedure TAControlManager.MouseWheelUp(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
var
  Control: TAControl;
begin
  if (Assigned(OwnerMouseWheelUp)) then
    OwnerMouseWheelUp(Sender, Shift, MousePos, Handled);
  if (Active) then
  begin
    Control := PreviousControl;
    if (Control <> nil) then
      if (Control.Enabled) and (Control.Visible) then
        Control.MouseWheelUp(Shift, MousePos);
  end;
end;

procedure TAControlManager.RestoreEvents;
begin
  if Parent is TForm then
  begin
    TForm(Parent).OnMouseDown := Self.OwnerMouseDown;
    TForm(Parent).OnMouseUp := Self.OwnerMouseUp;
    TForm(Parent).OnMouseMove := Self.OwnerMouseMove;
    TForm(Parent).OnMouseEnter := Self.OwnerMouseEnter;
    TForm(Parent).OnMouseLeave := Self.OwnerMouseLeave;
    TForm(Parent).OnMouseWheel := Self.OwnerMouseWheel;
    TForm(Parent).OnMouseWheelDown := Self.OwnerMouseWheelDown;
    TForm(Parent).OnMouseWheelUp := Self.OwnerMouseWheelUp;

    TForm(Parent).OnKeyDown := Self.OwnerKeyDown;
    TForm(Parent).OnKeyUp := Self.OwnerKeyUp;
    TForm(Parent).OnKeyPress := Self.OwnerKeyPress;
    TForm(Parent).OnShortCut := Self.OwnerShortCut;

    TForm(Parent).OnClick := Self.OwnerClick;
    TForm(Parent).OnDblClick := Self.OwnerDblClick;
  end;
end;

procedure TAControlManager.SetParent(const AParent: TComponent);
begin
  if FParent <> AParent then
  begin
    if FParent <> nil then
      RestoreEvents;

    FParent := AParent;

    if Device <> nil then
      AcquireEvents;
  end;
end;
{$ENDREGION}

initialization

RegisterClasses([TAForm, TAImage, TALabel, TAPanel, TAButton, TAEditBox,
  TACheckBox, TARadioButton, TAProgressBar, TAPaintBox, TATrackBar, TAListBox]);

finalization

UnRegisterClasses([TAForm, TAImage, TALabel, TAPanel, TAButton, TAEditBox,
  TACheckBox, TARadioButton, TAProgressBar, TAPaintBox, TATrackBar, TAListBox]);

end.
