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
{  The Original Code is Tulip.UI.Controls.pas.                                 }
{                                                                              }
{  The Initial Developer of the Original Code is Marcos Gomes.                 }
{  Portions created by Marcos Gomes are Copyright (C) 2012, Marcos Gomes.      }
{  All Rights Reserved.                                                        }
{                                                                              }
{******************************************************************************}
{                                                                              }
{  Tulip.UI.Controls.pas                                Modified: 23-Mar-2013  }
{  --------------------------------------------------------------------------  }
{                                                                              }
{             Base Implementations for Controls and ControlManager             }
{                                                                              }
{                                Version 1.03                                  }
{                                                                              }
{******************************************************************************}

unit Tulip.UI.Controls;

interface

uses
  Winapi.Windows, System.SysUtils, System.Classes,
  // pxl units
  PXL.Devices,
  PXL.Canvas,
  PXL.Archives,
  PXL.Fonts,
  PXL.Images,
  PXL.SwapChains,
  // Tulip UI Units
  Tulip.UI.Types, Tulip.UI.Classes, Tulip.UI.Utils, Tulip.UI.Helpers;

type
{$REGION 'Forward declarations'}
  TAControl = class;
  TWControl = class;
  TCustomManager = class;
{$ENDREGION}
{$REGION 'TAControl'}

  TAControl = class(TComponent)
  private
    FControlManager: Pointer;
    FControlState: TControlState;
    FLeft: Integer;
    FTop: Integer;
    FWidth: Integer;
    FHandle: Pointer;
    FHeight: Integer;
    FEnabled: Boolean;
    FVisible: Boolean;
    FParent: Pointer;

    FOnClick: TNotifyEvent;
    FOnDblClick: TNotifyEvent;
    FOnMouseLeave: TNotifyEvent;
    FOnMouseEnter: TNotifyEvent;
    FOnMouseDown: TMouseEvent;
    FOnMouseMove: TMouseMoveEvent;
    FOnMouseUp: TMouseEvent;
    FOnMouseWheel: TMouseWheelEvent;
    FOnMouseWheelDown: TMouseWheelUpDownEvent;
    FOnMouseWheelUp: TMouseWheelUpDownEvent;
    FOnResize: TNotifyEvent;

    FWheelAccumulator: Integer;

    function GetControlManager: TCustomManager;
    function GetParent: TWControl;

    procedure SetVisible(Value: Boolean);
    procedure SetZOrderPosition(Position: Integer);
  protected
    function GetClientLeft: Integer; virtual;
    function GetClientRect: TRect; virtual;
    function GetClientTop: Integer; virtual;
    function GetEnabled: Boolean; virtual;
    function GetHandle: TWControl; virtual;

    procedure AssignTo(Dest: TPersistent); override;

    procedure Paint; dynamic; abstract;
    procedure ReadState(Reader: TReader); override;
    procedure Resize; dynamic;

    procedure SetControlManager(AControlManager: TCustomManager); virtual;
    procedure SetEnabled(Value: Boolean); virtual;
    procedure SetHeight(Value: Integer); virtual;
    procedure SetLeft(Value: Integer); virtual;
    procedure SetParent(AParent: TWControl); virtual;
    procedure SetParentComponent(Value: TComponent); override;
    procedure SetTop(Value: Integer); virtual;
    procedure SetWidth(Value: Integer); virtual;
    procedure SetZOrder(TopMost: Boolean); dynamic;
  public
    procedure Click; dynamic;
    procedure DblClick; dynamic;
    procedure MouseEnter; dynamic;
    procedure MouseLeave; dynamic;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); dynamic;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); dynamic;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); dynamic;
    function MouseWheel(Shift: TShiftState; WheelDelta: Integer;
      MousePos: TPoint): Boolean; dynamic;
    function MouseWheelDown(Shift: TShiftState; MousePos: TPoint)
      : Boolean; dynamic;
    function MouseWheelUp(Shift: TShiftState; MousePos: TPoint)
      : Boolean; dynamic;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function GetParentComponent: TComponent; override;
    function IsVisible: Boolean; virtual;
    function HasParent: Boolean; override;

    procedure Assign(Source: TPersistent); override;
    procedure BringToFront;
    procedure SendToBack;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); virtual;

    property ClientLeft: Integer read GetClientLeft;
    property ClientTop: Integer read GetClientTop;
    property ClientRect: TRect read GetClientRect;
    property ControlManager: TCustomManager read GetControlManager;
    property ControlState: TControlState read FControlState write FControlState;
    property Handle: TWControl read GetHandle;
    property OnClick: TNotifyEvent read FOnClick write FOnClick;
    property OnDblClick: TNotifyEvent read FOnDblClick write FOnDblClick;
    property OnMouseDown: TMouseEvent read FOnMouseDown write FOnMouseDown;
    property OnMouseEnter: TNotifyEvent read FOnMouseEnter write FOnMouseEnter;
    property OnMouseLeave: TNotifyEvent read FOnMouseLeave write FOnMouseLeave;
    property OnMouseMove: TMouseMoveEvent read FOnMouseMove write FOnMouseMove;
    property OnMouseUp: TMouseEvent read FOnMouseUp write FOnMouseUp;
    property OnMouseWheel: TMouseWheelEvent read FOnMouseWheel
      write FOnMouseWheel;
    property OnMouseWheelDown: TMouseWheelUpDownEvent read FOnMouseWheelDown
      write FOnMouseWheelDown;
    property OnMouseWheelUp: TMouseWheelUpDownEvent read FOnMouseWheelUp
      write FOnMouseWheelUp;
    property OnResize: TNotifyEvent read FOnResize write FOnResize;
    property Parent: TWControl read GetParent;
    property WheelAccumulator: Integer read FWheelAccumulator
      write FWheelAccumulator;
  published
    property Enabled: Boolean read GetEnabled write SetEnabled;
    property Height: Integer read FHeight write SetHeight;
    property Left: Integer read FLeft write SetLeft;
    property Top: Integer read FTop write SetTop;
    property Width: Integer read FWidth write SetWidth;
    property Visible: Boolean read FVisible write SetVisible;
  end;

  TAControlClass = class of TAControl;
{$ENDREGION}
{$REGION 'TWControl'}

  TWControl = class(TAControl)
  private
    FControls: TList;
    FTabList: TList;
    FTabStop: Boolean;
    FWControls: TList;

    FOnEnter: TNotifyEvent;
    FOnExit: TNotifyEvent;
    FOnKeyDown: TKeyEvent;
    FOnKeyPress: TKeyPressEvent;
    FOnKeyUp: TKeyEvent;

    function GetControl(Index: Integer): TAControl;
    function GetControlCount: Integer;
    function GetTabOrder: TTabOrder;

    procedure Insert(AControl: TAControl);
    procedure Remove(AControl: TAControl);
    procedure SetTabOrder(Value: TTabOrder);
    procedure SetTabStop(Value: Boolean);
    procedure SetZOrderPosition(Position: Integer);
    procedure UpdateTabOrder(Value: TTabOrder);
  protected
    function FindNextControl(CurControl: TWControl;
      GoForward, CheckTabStop, CheckParent: Boolean): TWControl;
    function GetChildOwner: TComponent; override;

    procedure AssignTo(Dest: TPersistent); override;
    procedure Paint; override;
    procedure SetChildOrder(Child: TComponent; Order: Integer); override;
    procedure SetZOrder(TopMost: Boolean); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function CanFocus: Boolean; dynamic;
    function ControlAtPos(const Pos: TPoint; AllowDisabled: Boolean;
      AllowWControls: Boolean = False; AllLevels: Boolean = False): TAControl;
    function FindChildControl(const ControlName: string;
      AllLevels: Boolean = False): TAControl;
    function GetControls: TList;
    function GetWControls: TList;

    procedure DoEnter; dynamic;
    procedure DoExit; dynamic;
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
    procedure GetTabOrderList(List: TList); dynamic;
    procedure InsertControl(AControl: TAControl);
    procedure KeyDown(var Key: Word; Shift: TShiftState); dynamic;
    procedure KeyUp(var Key: Word; Shift: TShiftState); dynamic;
    procedure KeyPress(var Key: Char); dynamic;
    procedure RemoveControl(AControl: TAControl);
    procedure SelectFirst;
    procedure SelectNext(CurControl: TWControl;
      GoForward, CheckTabStop: Boolean);
    procedure SetFocus; virtual;

    property Controls[Index: Integer]: TAControl read GetControl;
    property ControlCount: Integer read GetControlCount;
    property OnEnter: TNotifyEvent read FOnEnter write FOnEnter;
    property OnExit: TNotifyEvent read FOnExit write FOnExit;
    property OnKeyDown: TKeyEvent read FOnKeyDown write FOnKeyDown;
    property OnKeyPress: TKeyPressEvent read FOnKeyPress write FOnKeyPress;
    property OnKeyUp: TKeyEvent read FOnKeyUp write FOnKeyUp;
  published
    property TabOrder: TTabOrder read GetTabOrder write SetTabOrder;
    property TabStop: Boolean read FTabStop write SetTabStop;
  end;

  TWControlClass = class of TWControl;
{$ENDREGION}
{$REGION 'TWRoot'}

  TWRoot = class(TWControl)
  private
    FFonts: TAStringList;
    FImages: TAStringList;

    procedure SetFonts(Value: TAStringList);
    procedure SetImages(Value: TAStringList);
  protected
    procedure AssignTo(Dest: TPersistent); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Fonts: TAStringList read FFonts write SetFonts;
    property Images: TAStringList read FImages write SetImages;
  end;
{$ENDREGION}
{$REGION 'TCustomManager'}

  TCustomManager = class(TObject)
  private
    FDevice: TCustomDevice;
    FCanvas: TCustomCanvas;
    FImages: TAtlasImages;
    FFonts: TBitmapFonts;

    FActiveControl: TWControl;
    FPrevControl: TAControl;
    FRoot: TWRoot;
    FActive: Boolean;
    FLoading: Boolean;
    FDesign: Boolean;

    FOwnerClick: TNotifyEvent;
    FOwnerDblClick: TNotifyEvent;
    FOwnerKeyDown: TKeyEvent;
    FOwnerKeyPress: TKeyPressEvent;
    FOwnerKeyUp: TKeyEvent;
    FOwnerMouseLeave: TNotifyEvent;
    FOwnerMouseEnter: TNotifyEvent;
    FOwnerMouseDown: TMouseEvent;
    FOwnerMouseUp: TMouseEvent;
    FOwnerMouseMove: TMouseMoveEvent;
    FOwnerMouseWheel: TMouseWheelEvent;
    FOwnerMouseWheelDown: TMouseWheelUpDownEvent;
    FOwnerMouseWheelUp: TMouseWheelUpDownEvent;
    FOwnerShortCut: TShortCutEvent;

    procedure SetActiveControl(const Control: TWControl);
    procedure SetDesign(const Value: Boolean);
    procedure SetLoading(const Value: Boolean);

  protected
    FParent: TComponent;

    procedure SetParent(const AParent: TComponent); virtual;

    property OwnerClick: TNotifyEvent read FOwnerClick write FOwnerClick;
    property OwnerDblClick: TNotifyEvent read FOwnerDblClick
      write FOwnerDblClick;
    property OwnerKeyDown: TKeyEvent read FOwnerKeyDown write FOwnerKeyDown;
    property OwnerKeyPress: TKeyPressEvent read FOwnerKeyPress
      write FOwnerKeyPress;
    property OwnerKeyUp: TKeyEvent read FOwnerKeyUp write FOwnerKeyUp;
    property OwnerMouseEnter: TNotifyEvent read FOwnerMouseEnter
      write FOwnerMouseEnter;
    property OwnerMouseLeave: TNotifyEvent read FOwnerMouseLeave
      write FOwnerMouseLeave;

    property OwnerMouseDown: TMouseEvent read FOwnerMouseDown
      write FOwnerMouseDown;
    property OwnerMouseUp: TMouseEvent read FOwnerMouseUp write FOwnerMouseUp;
    property OwnerMouseMove: TMouseMoveEvent read FOwnerMouseMove
      write FOwnerMouseMove;

    property OwnerMouseWheel: TMouseWheelEvent read FOwnerMouseWheel
      write FOwnerMouseWheel;
    property OwnerMouseWheelDown: TMouseWheelUpDownEvent
      read FOwnerMouseWheelDown write FOwnerMouseWheelDown;
    property OwnerMouseWheelUp: TMouseWheelUpDownEvent read FOwnerMouseWheelUp
      write FOwnerMouseWheelUp;
    property OwnerShortCut: TShortCutEvent read FOwnerShortCut
      write FOwnerShortCut;
  public
    constructor Create(const AOwner: TComponent; const ADevice: TCustomDevice; const ACanvas: TCustomCanvas); virtual;

    destructor Destroy; override;

    function LoadFromArchive(const Archive: TArchive): Boolean;
    function LoadFromArchiveFile(const FileName: string): Boolean;

    function SaveToArchive(const Archive: TArchive): Boolean;
    function SaveToArchiveFile(const FileName: string): Boolean;

    procedure Render; // Render all Controls.
    procedure Clear;

    property Active: Boolean read FActive write FActive;
    property ActiveControl: TWControl read FActiveControl
      write SetActiveControl;
    property PreviousControl: TAControl read FPrevControl write FPrevControl;

    property DesignMode: Boolean read FDesign write SetDesign;
    property Loading: Boolean read FLoading write SetLoading;

    property Root: TWRoot read FRoot;
    // The root container that contains all the components

    property Device: TCustomDevice read FDevice write FDevice;
    property Canvas: TCustomCanvas read FCanvas write FCanvas;
    property Fonts: TBitmapFonts read FFonts write FFonts;
    property Images: TAtlasImages read FImages;
    property Parent: TComponent read FParent write SetParent;
  end;

  TCustomManagerClass = class of TCustomManager;
{$ENDREGION}

var
  VirtualPoint: TPoint;

implementation

{$REGION 'TAControl'}
  { TAControl }

procedure TAControl.Assign(Source: TPersistent);
begin
  ControlState := ControlState + [csReadingState];
  inherited;
  ControlState := ControlState - [csReadingState];
end;

procedure TAControl.AssignTo(Dest: TPersistent);
begin
  if Dest is TAControl then
    with TAControl(Dest) do
    begin
      // inherited properties
      try
        Name := Self.Name;
      except
        on EComponentError do
        begin
        end;
      end;
      Tag := Self.Tag;

      Enabled := Self.Enabled;
      Height := Self.Height;
      Left := Self.Left;
      OnClick := Self.OnClick;
      OnDblClick := Self.OnDblClick;
      OnMouseLeave := Self.OnMouseLeave;
      OnMouseEnter := Self.OnMouseEnter;
      OnMouseDown := Self.OnMouseDown;
      OnMouseMove := Self.OnMouseMove;
      OnMouseUp := Self.OnMouseUp;
      OnMouseWheel := Self.OnMouseWheel;
      OnMouseWheelDown := Self.OnMouseWheelDown;
      OnMouseWheelUp := Self.OnMouseWheelUp;
      OnResize := Self.OnResize;
      Top := Self.Top;
      WheelAccumulator := Self.WheelAccumulator;
      Width := Self.Width;
      Visible := Self.Visible;
    end
  else
    inherited AssignTo(Dest);

end;

procedure TAControl.BringToFront;
begin
  SetZOrder(True);
end;

procedure TAControl.Click;
var
  BoundsRect: TRect;
begin
  BoundsRect := Rect(ClientLeft, ClientTop, ClientLeft + Width,
    ClientTop + Height);

  if (PtInRect(BoundsRect, VirtualPoint)) then
    if Assigned(FOnClick) then
      FOnClick(Self);
end;

constructor TAControl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FLeft := 0;
  FTop := 0;
  FWidth := 0;
  FHeight := 0;
  FHandle := Self;
  FEnabled := True;
  FVisible := True;

  if (AOwner <> nil) and (AOwner <> Self) and (AOwner is TWControl) then
  begin
    TWControl(AOwner).InsertControl(Self);
    SetControlManager(TWControl(AOwner).ControlManager);
  end;
end;

procedure TAControl.DblClick;
var
  BoundsRect: TRect;
begin
  BoundsRect := Rect(ClientLeft, ClientTop, ClientLeft + Width,
    ClientTop + Height);

  if (PtInRect(BoundsRect, VirtualPoint)) then
    if Assigned(FOnDblClick) then
      FOnDblClick(Self);
end;

destructor TAControl.Destroy;
begin

  inherited;
end;

function TAControl.GetClientLeft: Integer;
var
  Temp: TWControl;
begin
  Temp := Parent;
  Result := FLeft;
  while Temp <> nil do
  begin
    Result := Result + Temp.FLeft;
    Temp := Temp.Parent;
  end;
end;

function TAControl.GetClientRect: TRect;
begin
  Result.Left := 0;
  Result.Top := 0;
  Result.Right := Width;
  Result.Bottom := Height;
end;

function TAControl.GetClientTop: Integer;
var
  Temp: TWControl;
begin
  Temp := Parent;
  Result := FTop;
  while Temp <> nil do
  begin
    Result := Result + Temp.FTop;
    Temp := Temp.Parent;
  end;
end;

function TAControl.GetControlManager: TCustomManager;
begin
  Result := FControlManager;
end;

function TAControl.GetEnabled: Boolean;
begin
  Result := FEnabled;
end;

function TAControl.GetHandle: TWControl;
begin
  Result := FHandle;
end;

function TAControl.GetParent: TWControl;
begin
  Result := FParent;
end;

function TAControl.GetParentComponent: TComponent;
begin
  Result := FParent;
end;

function TAControl.HasParent: Boolean;
begin
  Result := FParent <> nil;
end;

function TAControl.IsVisible: Boolean;
var
  Temp: TAControl;
begin
  Temp := Self;
  Result := FVisible;
  while Temp.Parent <> nil do
  begin
    Result := (Result and Temp.FVisible);
    Temp := Temp.Parent;
  end;
end;

procedure TAControl.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  Include(FControlState, csClicked);
  // get the down point
  VirtualPoint.X := X;
  VirtualPoint.Y := Y;

  if ControlManager.ActiveControl <> Self then
  begin
    // Bring Handle to front and set focus
    Handle.BringToFront;

    if ControlManager.ActiveControl <> nil then
    begin
      if (Self is TWControl) then
      begin
        if TWControl(Self).FindChildControl(ControlManager.ActiveControl.Name) = nil
        then
        begin
          TWControl(Self).SetFocus;
          TWControl(Self).SelectFirst;
        end;
      end
      else
      begin
        if Handle.FindChildControl(ControlManager.ActiveControl.Name) = nil then
        begin
          Handle.SetFocus;
          Handle.SelectFirst;
        end;
      end;
    end
    else
    begin
      Handle.SetFocus;
      Handle.SelectFirst;
    end;
  end;

  if Assigned(FOnMouseDown) then
    FOnMouseDown(Self, Button, Shift, X, Y);
end;

procedure TAControl.MouseEnter;
begin
  if Assigned(FOnMouseEnter) then
    FOnMouseEnter(Self);
end;

procedure TAControl.MouseLeave;
begin
  if Assigned(FOnMouseLeave) then
    FOnMouseLeave(Self);
end;

procedure TAControl.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  // get the current point
  VirtualPoint.X := X;
  VirtualPoint.Y := Y;

  if Assigned(FOnMouseMove) then
    FOnMouseMove(Self, Shift, X, Y);
end;

procedure TAControl.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  Exclude(FControlState, csClicked);

  // get the release point
  VirtualPoint.X := X;
  VirtualPoint.Y := Y;

  if Assigned(FOnMouseUp) then
    FOnMouseUp(Self, Button, Shift, X, Y);
end;

function TAControl.MouseWheel(Shift: TShiftState; WheelDelta: Integer;
  MousePos: TPoint): Boolean;
var
  IsNeg: Boolean;
begin
  Result := False;
  if Assigned(FOnMouseWheel) then
    FOnMouseWheel(Self, Shift, WheelDelta, MousePos, Result);
  if not Result then
  begin
    Inc(FWheelAccumulator, WheelDelta);
    while Abs(FWheelAccumulator) >= WHEEL_DELTA do
    begin
      IsNeg := FWheelAccumulator < 0;
      FWheelAccumulator := Abs(FWheelAccumulator) - WHEEL_DELTA;
      if IsNeg then
      begin
        if FWheelAccumulator <> 0 then
          FWheelAccumulator := -FWheelAccumulator;
        Result := MouseWheelDown(Shift, MousePos);
      end
      else
        Result := MouseWheelUp(Shift, MousePos);
    end;
  end;
end;

function TAControl.MouseWheelDown(Shift: TShiftState; MousePos: TPoint)
  : Boolean;
begin
  Result := False;
  if Assigned(FOnMouseWheelDown) then
    FOnMouseWheelDown(Self, Shift, MousePos, Result);
end;

function TAControl.MouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean;
begin
  Result := False;
  if Assigned(FOnMouseWheelUp) then
    FOnMouseWheelUp(Self, Shift, MousePos, Result);
end;

procedure TAControl.ReadState(Reader: TReader);
begin
  Include(FControlState, csReadingState);
  inherited ReadState(Reader);
  Exclude(FControlState, csReadingState);
end;

procedure TAControl.Resize;
begin
  if Assigned(FOnResize) then
    FOnResize(Self);
end;

procedure TAControl.SendToBack;
begin
  SetZOrder(False);
end;

procedure TAControl.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  if ((ALeft <> FLeft) or (ATop <> FTop) or (AWidth <> FWidth) or
    (AHeight <> FHeight)) then
  begin
    FLeft := ALeft;
    FTop := ATop;
    FWidth := AWidth;
    FHeight := AHeight;
    // if not(csLoading in ComponentState) then
    Resize;
  end;
end;

procedure TAControl.SetControlManager(AControlManager: TCustomManager);
begin
  FControlManager := AControlManager;
end;

procedure TAControl.SetEnabled(Value: Boolean);
begin
  if FEnabled <> Value then
  begin
    FEnabled := Value;
  end;
end;

procedure TAControl.SetHeight(Value: Integer);
begin
  SetBounds(FLeft, FTop, FWidth, Value);
end;

procedure TAControl.SetLeft(Value: Integer);
begin
  SetBounds(Value, FTop, FWidth, FHeight);
end;

procedure TAControl.SetParent(AParent: TWControl);
begin
  if FParent <> AParent then
  begin
    if AParent = Self then
      Exit;
    if FParent <> nil then
      Parent.RemoveControl(Self);
    if AParent <> nil then
    begin
      AParent.InsertControl(Self);
    end;
  end;
end;

procedure TAControl.SetParentComponent(Value: TComponent);
begin
  if (Parent <> Value) and (Value is TWControl) then
    SetParent(TWControl(Value));
end;

procedure TAControl.SetTop(Value: Integer);
begin
  SetBounds(FLeft, Value, FWidth, FHeight);
end;

procedure TAControl.SetVisible(Value: Boolean);
begin
  if FVisible <> Value then
  begin
    FVisible := Value;

    // Execute events that possible haven't been executed yet.
    if Value = False then
    begin
      MouseLeave;
      if Self is TWControl then
        TWControl(Self).DoExit;
    end;
  end;
end;

procedure TAControl.SetWidth(Value: Integer);
begin
  SetBounds(FLeft, FTop, Value, FHeight);
end;

procedure TAControl.SetZOrder(TopMost: Boolean);
var
  AParent: TWControl;
begin
  AParent := Parent;

  if AParent <> nil then
  begin
    if TopMost then
    begin
      SetZOrderPosition(AParent.FControls.Count - 1)
    end
    else
      SetZOrderPosition(0);
  end;
end;

procedure TAControl.SetZOrderPosition(Position: Integer);
var
  I, Count: Integer;
  AParent: TWControl;
begin
  AParent := Parent;

  if AParent <> nil then
  begin
    I := AParent.FControls.IndexOf(Self);
    if I >= 0 then
    begin
      Count := AParent.FControls.Count;
      if Position < 0 then
        Position := 0;
      if Position >= Count then
        Position := Count - 1;
      if Position <> I then
      begin
        AParent.FControls.Delete(I);
        AParent.FControls.Insert(Position, Self);
      end;
    end;
  end;
end;
{$ENDREGION}
{$REGION 'TWControl'}
{ TWControl }

procedure TWControl.AssignTo(Dest: TPersistent);
var
  I: Integer;
  AClass: TAControlClass;
  Control: TAControl;
begin
  inherited AssignTo(Dest);

  if Dest is TWControl then
    with TWControl(Dest) do
    begin
      TabStop := Self.TabStop;
      OnEnter := Self.OnEnter;
      OnExit := Self.OnExit;
      OnKeyDown := Self.OnKeyDown;
      OnKeyPress := Self.OnKeyPress;
      OnKeyUp := Self.OnKeyUp;

      if Self.ControlCount <> 0 then
      begin
        for I := 0 to Self.ControlCount - 1 do
        begin
          AClass := TAControlClass(Self.Controls[I].ClassType);
          Control := AClass.Create(TWControl(Dest));
          Control.Assign(Self.Controls[I]);
        end;
      end;
    end;
end;

function TWControl.CanFocus: Boolean;
var
  Control: TWControl;
begin
  Result := False;

  Control := Self;
  while Control.Parent <> ControlManager.Root do
  begin
    if not(Control.FVisible and Control.Enabled) then
      Exit;
    Control := Control.Parent;
  end;
  Result := True;

end;

function TWControl.ControlAtPos(const Pos: TPoint;
  AllowDisabled, AllowWControls, AllLevels: Boolean): TAControl;
var
  I: Integer;
  P: TPoint;
  LControl: TAControl;

  function GetControlAtPos(AControl: TAControl): Boolean;
  begin
    with AControl do
    begin
      P := Point(Pos.X - ClientLeft, Pos.Y - ClientTop);
      Result := (PtInRect(ClientRect, P) and
        (IsVisible or (IsVisible and (Enabled or AllowDisabled))))
      { or ((IsVisible or (Parent <> ControlManager.Root)) and
        PtInRect(ClientRect, P) and (ControlManager.DesignMode)) };
      if Result then
        LControl := AControl;
    end;
  end;

begin
  LControl := nil;

  // // do not check for child controls if self control is not visible
  // if (IsVisible = false) {and
  // ((Parent = ControlManager.Root) or (ControlManager.DesignMode = False))} then
  // begin
  // Result := LControl;
  // Exit;
  // end;

  if AllowWControls and (FWControls <> nil) then
    for I := FWControls.Count - 1 downto 0 do
    begin
      if AllLevels then
        if TWControl(FWControls[I]).FWControls <> nil then
          LControl := TWControl(FWControls[I]).ControlAtPos(Pos, AllowDisabled,
            True, True);

      // if found a WControl on Sub Level
      if (LControl <> nil) then
      begin
        Break;
      end;

      // Not found on sub Level, check curent level
      if (LControl = nil) and GetControlAtPos(TWControl(FWControls[I])) then
        Break;

    end;

  // find FControls on result WControl
  if (LControl <> nil) and (LControl is TWControl) then
    if (TWControl(LControl).FControls <> nil) then
      for I := TWControl(LControl).FControls.Count - 1 downto 0 do
        if GetControlAtPos(TWControl(LControl).FControls[I]) then
          Break;

  // if nothing found and has FControls, search in FControls list
  if (FControls <> nil) and (LControl = nil) then
  begin
    for I := FControls.Count - 1 downto 0 do
      if GetControlAtPos(FControls[I]) then
        Break;
  end;

  Result := LControl;
end;

constructor TWControl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FTabStop := False;
end;

destructor TWControl.Destroy;
var
  I: Integer;
  Instance: TAControl;
begin
  Destroying;

  I := ControlCount;
  while I <> 0 do
  begin
    Instance := Controls[I - 1];
    Remove(Instance);
    FreeAndNil(Instance);
    I := ControlCount;
  end;

  inherited Destroy;
end;

procedure TWControl.DoEnter;
begin
  if Assigned(FOnEnter) then
    FOnEnter(Self);
end;

procedure TWControl.DoExit;
begin
  if Assigned(FOnExit) then
    FOnExit(Self);
end;

function TWControl.FindChildControl(const ControlName: string;
  AllLevels: Boolean): TAControl;
var
  I: Integer;
begin
  Result := nil;

  if FControls <> nil then
    for I := 0 to FControls.Count - 1 do
      if CompareText(TWControl(FControls[I]).Name, ControlName) = 0 then
      begin
        Result := TAControl(FControls[I]);
        Exit;
      end;

  if FWControls <> nil then
    for I := 0 to FWControls.Count - 1 do
    begin
      if CompareText(TWControl(FWControls[I]).Name, ControlName) = 0 then
      begin
        Result := TAControl(FWControls[I]);
        Exit;
      end;
      if AllLevels = True then
        if TWControl(FWControls[I]).FindChildControl(ControlName, AllLevels) <> nil
        then
        begin
          Result := TWControl(FWControls[I]).FindChildControl(ControlName,
            AllLevels);
          Exit;
        end;
    end;
end;

function TWControl.FindNextControl(CurControl: TWControl;
  GoForward, CheckTabStop, CheckParent: Boolean): TWControl;
var
  I, StartIndex: Integer;
  List: TList;
begin
  Result := nil;
  List := TList.Create;
  try
    GetTabOrderList(List);
    if List.Count > 0 then
    begin
      StartIndex := List.IndexOf(CurControl);
      if StartIndex = -1 then
        if GoForward then
          StartIndex := List.Count - 1
        else
          StartIndex := 0;
      I := StartIndex;
      repeat
        if GoForward then
        begin
          Inc(I);
          if I = List.Count then
            I := 0;
        end
        else
        begin
          if I = 0 then
            I := List.Count;
          Dec(I);
        end;
        CurControl := TWControl(List[I]);
        if CurControl.CanFocus and (not CheckTabStop or CurControl.TabStop) and
          (not CheckParent or (CurControl.Parent = Self)) then
          Result := CurControl;
      until (Result <> nil) or (I = StartIndex);
    end;
  finally
    List.Free;
  end;
end;

function TWControl.GetChildOwner: TComponent;
begin
  Result := Self;
end;

procedure TWControl.GetChildren(Proc: TGetChildProc; Root: TComponent);
var
  I: Integer;
  Control: TAControl;
begin
  for I := 0 to ControlCount - 1 do
  begin
    Control := Controls[I];
    // if Control.Owner = Root then
    Proc(Control);
  end;
end;

function TWControl.GetControl(Index: Integer): TAControl;
var
  N: Integer;
begin
  if FControls <> nil then
    N := FControls.Count
  else
    N := 0;
  if Index < N then
    Result := FControls[Index]
  else
    Result := FWControls[Index - N];
end;

function TWControl.GetControlCount: Integer;
begin
  Result := 0;
  if FControls <> nil then
    Inc(Result, FControls.Count);
  if FWControls <> nil then
    Inc(Result, FWControls.Count);
end;

function TWControl.GetControls: TList;
begin
  Result := FControls;
end;

function TWControl.GetTabOrder: TTabOrder;
begin
  if FParent <> nil then
    Result := Parent.FTabList.IndexOf(Self)
  else
    Result := -1;
end;

procedure TWControl.GetTabOrderList(List: TList);
var
  I: Integer;
  Control: TWControl;
begin
  if FTabList <> nil then
    for I := 0 to FTabList.Count - 1 do
    begin
      Control := TWControl(FTabList[I]);
      List.Add(Control);
      Control.GetTabOrderList(List);
    end;
end;

function TWControl.GetWControls: TList;
begin
  Result := FWControls
end;

procedure TWControl.Insert(AControl: TAControl);
var
  Form: TWControl;
begin
  if AControl <> nil then
  begin
    if AControl is TWControl then
    begin
      ListAdd(FWControls, AControl);
      ListAdd(FTabList, AControl);
    end
    else
      ListAdd(FControls, AControl);
    AControl.FParent := Self;

    // Get the parent Form from Engine.Root and set it as handler
    Form := Self;
    if (ControlManager <> nil) then
    begin
      if not(Form = ControlManager.Root) then
      begin
        while Form.Parent <> ControlManager.Root do
          Form := Form.Parent;
        AControl.FHandle := Form;
      end
      else
      begin
        AControl.FHandle := AControl;
      end;
    end;
  end;

end;

procedure TWControl.InsertControl(AControl: TAControl);
begin
  AControl.ValidateContainer(Self);
  Insert(AControl);
end;

procedure TWControl.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if (Shift = [ssShift, ssCtrl]) or (Shift = [ssShift]) then
  begin
    case Key of
      vk_Tab:
        Self.Handle.SelectNext(Self, False, True);
    end;
  end;

  if (Shift = [ssCtrl]) or (Shift = []) then
  begin
    case Key of
      vk_Tab:
        Self.Handle.SelectNext(Self, True, True);
    end;
  end;

  if Assigned(FOnKeyDown) then
    FOnKeyDown(Self, Key, Shift);
end;

procedure TWControl.KeyPress(var Key: Char);
begin
  if Assigned(FOnKeyPress) then
    FOnKeyPress(Self, Key);
end;

procedure TWControl.KeyUp(var Key: Word; Shift: TShiftState);
begin
  if Assigned(FOnKeyUp) then
    FOnKeyUp(Self, Key, Shift);
end;

procedure TWControl.Paint;
var
  Control, WControl: Integer;
begin
  if FControls <> nil then
  begin
    for Control := 0 to FControls.Count - 1 do
    begin
      with TAControl(FControls[Control]) do
        if (Visible) { or (Self.ControlManager.FDesign) } then
          Paint;
    end;
  end;
  if FWControls <> nil then
  begin
    for WControl := 0 to FWControls.Count - 1 do
    begin
      with TWControl(FWControls[WControl]) do
        if (Visible) { or (Self.ControlManager.FDesign) } then
          Paint;
    end;
  end;
end;

procedure TWControl.Remove(AControl: TAControl);
begin
  if AControl is TWControl then
  begin
    ListRemove(FTabList, AControl);
    ListRemove(FWControls, AControl);
  end
  else
    ListRemove(FControls, AControl);
  AControl.FParent := nil;
  AControl.FHandle := AControl;
end;

procedure TWControl.RemoveControl(AControl: TAControl);
begin
  Remove(AControl);
end;

procedure TWControl.SelectFirst;
var
  Control: TWControl;
begin
  Control := FindNextControl(nil, True, True, False);
  if Control = nil then
    Control := FindNextControl(nil, True, False, False);
  if Control <> nil then
  begin
    Control.SetFocus;
  end;
end;

procedure TWControl.SelectNext(CurControl: TWControl;
  GoForward, CheckTabStop: Boolean);
begin
  CurControl := FindNextControl(CurControl, GoForward, CheckTabStop,
    not CheckTabStop);
  if CurControl <> nil then
    CurControl.SetFocus;
end;

procedure TWControl.SetChildOrder(Child: TComponent; Order: Integer);
begin
  if Child is TWControl then
    TWControl(Child).SetZOrderPosition(Order)
  else if Child is TAControl then
    TAControl(Child).SetZOrderPosition(Order);
end;

procedure TWControl.SetFocus;
var
  Control: TWControl;
begin
  Control := Self;
  if Control.CanFocus then
  begin
    if ControlManager.ActiveControl <> nil then
      if ControlManager.ActiveControl <> Control then
        ControlManager.ActiveControl.DoExit;
    ControlManager.ActiveControl := Control;
    Control.DoEnter;
  end;
end;

procedure TWControl.SetTabOrder(Value: TTabOrder);
begin
  UpdateTabOrder(Value);
end;

procedure TWControl.SetTabStop(Value: Boolean);
begin
  if FTabStop <> Value then
  begin
    FTabStop := Value;
  end;
end;

procedure TWControl.SetZOrder(TopMost: Boolean);
var
  N, M: Integer;
begin
  if FParent <> nil then
  begin
    if TopMost then
      N := Parent.FWControls.Count - 1
    else
      N := 0;
    M := 0;
    if Parent.FControls <> nil then
      M := Parent.FControls.Count;
    SetZOrderPosition(M + N);
  end;
end;

procedure TWControl.SetZOrderPosition(Position: Integer);
var
  I, Count: Integer;
begin
  if FParent <> nil then
  begin
    if Parent.FControls <> nil then
      Dec(Position, Parent.FControls.Count);
    I := Parent.FWControls.IndexOf(Self);
    if I >= 0 then
    begin
      Count := Parent.FWControls.Count;
      if Position < 0 then
        Position := 0;
      if Position >= Count then
        Position := Count - 1;
      if Position <> I then
      begin
        Parent.FWControls.Delete(I);
        Parent.FWControls.Insert(Position, Self);
      end;
    end;
  end;
end;

procedure TWControl.UpdateTabOrder(Value: TTabOrder);
var
  CurIndex, Count: Integer;
begin
  CurIndex := GetTabOrder;
  if CurIndex >= 0 then
  begin
    Count := Parent.FTabList.Count;
    if Value < 0 then
      Value := 0;
    if Value >= Count then
      Value := Count - 1;
    if Value <> CurIndex then
    begin
      Parent.FTabList.Delete(CurIndex);
      Parent.FTabList.Insert(Value, Self);
    end;
  end;
end;
{$ENDREGION}
{$REGION 'TWRoot'}
{ TWRoot }

procedure TWRoot.AssignTo(Dest: TPersistent);
begin
  inherited AssignTo(Dest);

  if Dest is TWRoot then
    with TWRoot(Dest) do
    begin
      Fonts := Self.Fonts;
      Images := Self.Images;
    end;
end;

constructor TWRoot.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FFonts := TAStringList.Create;
  FImages := TAStringList.Create;
end;

destructor TWRoot.Destroy;
begin
  FFonts.Free;
  FImages.Free;

  inherited;
end;

procedure TWRoot.SetFonts(Value: TAStringList);
begin
  if (Value <> nil) then
    FFonts.Assign(Value);
end;

procedure TWRoot.SetImages(Value: TAStringList);
begin
  if Value <> nil then
    FImages.Assign(Value);
end;

{$ENDREGION}
{$REGION 'TCustomManager'}
{ TCustomManager }

procedure TCustomManager.Clear;
var
  I: Integer;
  Instance: TAControl;
begin
  FActiveControl := nil;
  FPrevControl := nil;

  I := FRoot.ControlCount;
  while I <> 0 do
  begin
    Instance := FRoot.Controls[I - 1];
    FRoot.Remove(Instance);
    FreeAndNil(Instance);
    I := FRoot.ControlCount;
  end;

  // Clear Font and Image Lists
  FRoot.Fonts.Clear;
  FRoot.Images.Clear;

  // free current fonts
  FFonts.Clear;
  //FFonts.Images.RemoveAll;
  FFonts.Canvas := FCanvas;

  // free current images
  FImages.Clear;
end;

constructor TCustomManager.Create(const AOwner: TComponent;
  const ADevice: TCustomDevice; const ACanvas: TCustomCanvas);
begin
  FDevice := ADevice;
  FCanvas := ACanvas;
  FFonts := TBitmapFonts.Create(ADevice);
  //FFonts.Images := TAsphyreImages.Create;
  FImages := TAtlasImages.Create(ADevice);
  Parent := AOwner;

  FRoot := TWRoot.Create(nil);
  FRoot.Left := 0;
  FRoot.Top := 0;

  if (ADevice <> nil) and (ADevice is TCustomSwapChainDevice) then
  begin
    FRoot.Width := TCustomSwapChainDevice(ADevice).SwapChains.Items[0].Width;
    FRoot.Height := TCustomSwapChainDevice(ADevice).SwapChains.Items[0].Height;
  end
  else
  begin
    FRoot.Width := 0;
    FRoot.Height := 0;
  end;

  FRoot.FControlManager := Self;

  FDesign := False;

  FActive := True;
  FLoading := False;
end;

destructor TCustomManager.Destroy;
begin
  FDevice := nil;
  FCanvas := nil;
  FParent := nil;

  //FFonts.Images.RemoveAll;
  //FFonts.Images.Free;
  FFonts.Clear;
  FImages.Clear;
  FreeAndNil(FFonts);
  FreeAndNil(FImages);
  FreeAndNil(FRoot);

  inherited Destroy;
end;

function TCustomManager.LoadFromArchive(const Archive: TArchive)
  : Boolean;
var
  AControl: TWRoot;
  Stream: TMemoryStream;
  I: Integer;
begin
  // Clear all controls
  Self.Clear;

  Stream := TMemoryStream.Create();

  Result := Archive.ReadMemStream('Interface.ui', Stream);

  if Result = True then
  begin
    try
      AControl := Stream.ReadComponent(nil) as TWRoot;
      Root.Assign(AControl);
    finally
      FreeAndNil(AControl);
    end;

    // Set Device size again
    if (FDevice <> nil) and (FDevice is TCustomSwapChainDevice) then
    begin
      FRoot.Width := TCustomSwapChainDevice(FDevice).SwapChains.Items[0].Width;
      FRoot.Height := TCustomSwapChainDevice(FDevice).SwapChains.Items[0].Height;
    end;

    if FRoot.Fonts.Count > 0 then
    begin
      for I := 0 to FRoot.Fonts.Count - 1 do
        FFonts.InsertFromArchive(FRoot.Fonts.Items[I], Archive, foFonts);
    end;

    if FRoot.Images.Count > 0 then
    begin
      for I := 0 to FRoot.Images.Count - 1 do
        FImages.InsertFromArchive(FRoot.Images.Items[I], Archive, foImages);
    end;
  end;

  Stream.Free();
end;

function TCustomManager.LoadFromArchiveFile(const FileName: string): Boolean;
var
  Media: TArchive;
begin
  Media := TArchive.Create;

  Media.OpenMode := TArchive.TOpenMode.ReadOnly;

  Result := Media.OpenFile(FileName);

  if Result = True then
  begin
    LoadFromArchive(Media);
  end;

  Media.Free;
end;

procedure TCustomManager.Render;
begin
  if FLoading then
    Exit;

  FRoot.Paint;
end;

function TCustomManager.SaveToArchive(const Archive: TArchive): Boolean;
var
  Stream: TMemoryStream;
  I: Integer;
begin
  Result := False;

  if Archive = nil then
    Exit;

  if (FFonts.Count > 0) then
  begin
    if not(FFonts.SaveAllToArchive(Archive, foFonts)) then
    begin
      Exit;
    end;

    FRoot.Fonts.Clear;
    for I := 0 to FFonts.Count - 1 do
    begin
      FRoot.Fonts.Add(FFonts.Items[I].Name);
    end;
  end;

  if (FImages.ItemCount > 0) then
  begin
    if not(FImages.SaveAllToArchive(Archive, foImages)) then
    begin
      Exit;
    end;

    FRoot.Images.Clear;
    for I := 0 to FImages.ItemCount - 1 do
    begin
      if not (Assigned(Self.Images[I])) then
      begin
        Continue;
      end;

      FRoot.Images.Add(FImages.Items[I].Name);
    end;
  end;

  Stream := TMemoryStream.Create();
  Stream.WriteComponent(FRoot);

  Result := Archive.WriteStream('Interface.ui', Stream, TArchive.TEntryType.AnyFile);

  Stream.Free();
end;

function TCustomManager.SaveToArchiveFile(const FileName: string): Boolean;
var
  Media: TArchive;
begin
  Media := TArchive.Create;

  Media.OpenMode := TArchive.TOpenMode.Update;

  Result := Media.OpenFile(FileName);

  if (Result = True) then
  begin
    SaveToArchive(Media);
  end;

  Media.Free;
end;

procedure TCustomManager.SetActiveControl(const Control: TWControl);
begin
  if FActiveControl <> Control then
    FActiveControl := Control;
end;

procedure TCustomManager.SetDesign(const Value: Boolean);
begin
  if FDesign <> Value then
    FDesign := Value;
end;

procedure TCustomManager.SetLoading(const Value: Boolean);
begin
  if FLoading <> Value then
    FLoading := Value;
end;

procedure TCustomManager.SetParent(const AParent: TComponent);
begin
  if FParent <> AParent then
  begin
    FParent := AParent;
  end;
end;
{$ENDREGION}

initialization

RegisterClasses([TAControl, TWControl, TWRoot]);

finalization

UnRegisterClasses([TAControl, TWControl, TWRoot]);

end.
