{******************************************************************************}
{                                                                              }
{                    Tulip - Graphical User Interface Editor                   }
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
{  The Original Code is Editor.Manager.pas.                                    }
{                                                                              }
{  The Initial Developer of the Original Code is Marcos Gomes.                 }
{  Portions created by Marcos Gomes are Copyright (C) 2012, Marcos Gomes.      }
{  All Rights Reserved.                                                        }
{                                                                              }
{******************************************************************************}
{                                                                              }
{  Editor.Manager.pas                                   Modified: 05-Out-2012  }
{  --------------------------------------------------------------------------  }
{                                                                              }
{                      Implementation of Editor Manager                        }
{                                                                              }
{                                Version 1.02                                  }
{                                                                              }
{******************************************************************************}

unit Editor.Manager;

interface

uses
  WinApi.Windows, System.Classes, System.Types, System.SysUtils, System.Math,
  System.IniFiles, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Vcl.ComCtrls, Vcl.ExtCtrls, JvInspector,
  // Asphyre Units
  AsphyreFactory, DX9Providers, DX10Providers, DX11Providers, WGLProviders,
  AbstractDevices, AbstractCanvas, AsphyreFonts, AsphyreImages, AsphyreArchives,
  AsphyreEvents, AsphyreTimer, AsphyreTypes, Vectors2, Vectors2px,
  // Tulip UI Units
  Tulip.UI, Tulip.UI.Controls, Tulip.UI.Helpers,
  // Editor Units
  Editor.Types, Editor.Classes, Editor.SetFontNameForm, Editor.SetImageForm;

type
  TEditorManager = class(TObject)
  private
    FDevice: TAsphyreDevice;
    FCanvas: TAsphyreCanvas;
    FFonts: TAsphyreFonts;
    FImages: TAsphyreImages;
    FArchive: TAsphyreArchive;
    FControlManager: TAControlManager;
    FRenderTarget: TRenderTarget;

    FChanged: Boolean;
    FSelectState: TSelectState;
    FSelected: TAControl;

    FTitle: string;
    FFileName: string;
    FClipboardStream: TMemoryStream;

    FDisplaySize: TPoint;
    FProvider: TAProvider;
    FShowGrid: Boolean;
    FSnapToGrid: Boolean;
    FGrid: TPoint;

    procedure DoTimer(Sender: TObject);
    procedure DoProcess(Sender: TObject);
    procedure DoRenderAsphyrePanel(Sender: TObject);
    procedure DoRenderFontPreview(Sender: TObject);
    procedure DoRenderImagePreview(Sender: TObject);
    procedure DoRenderPreview(Sender: TObject);

    procedure OnDeviceCreate(Sender: TObject; Param: Pointer;
      var Handled: Boolean);

    procedure SetSelected(AControl: TAControl);
    procedure SetListData(Parent: TTreeNode; WControl: TWControl);
 public
    procedure UpdateList;
    procedure UpdateInspector;
  public
    constructor Create(AOwner: TControl);
    destructor Destroy; override;

    procedure DoEditBringToFrontClick(Sender: TObject);
    procedure DoEditCopyClick(Sender: TObject);
    procedure DoEditCutClick(Sender: TObject);
    procedure DoEditDeleteClick(Sender: TObject);
    procedure DoEditPastClick(Sender: TObject);
    procedure DoEditSendToBackClick(Sender: TObject);

    procedure DoFilePreviewClick(Sender: TObject);

    procedure DoInsertButtonClick(Sender: TObject);
    procedure DoInsertCheckBoxClick(Sender: TObject);
    procedure DoInsertEditBoxClick(Sender: TObject);
    procedure DoInsertFormClick(Sender: TObject);
    procedure DoInsertImageClick(Sender: TObject);
    procedure DoInsertLabelClick(Sender: TObject);
    procedure DoInsertListBoxClick(Sender: TObject);
    procedure DoInsertPaintBoxClick(Sender: TObject);
    procedure DoInsertPanelClick(Sender: TObject);
    procedure DoInsertProgressBarClick(Sender: TObject);
    procedure DoInsertRadioButtonClick(Sender: TObject);
    procedure DoInsertTrackBarClick(Sender: TObject);

    procedure DoComboBoxSelect(Sender: TObject);
    procedure DoTreeViewChange(Sender: TObject; Node: TTreeNode);
    procedure DoInspectorItemValueChanged(Sender: TObject;
      Item: TJvCustomInspectorItem);

    procedure SetImageMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure SetImageMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SetImageMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);

    procedure MouseLeave(Sender: TObject);
    procedure MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer);

    procedure NewProject;
    procedure OpenProject(AFileName: String);
    procedure SaveProject(AFileName: String);

    procedure LoadSettingsFromIniFile;
    procedure SaveSettingsToIniFile;

    property Canvas: TAsphyreCanvas read FCanvas;
    property Changed: Boolean read FChanged write FChanged;
    property ControlManager: TAControlManager read FControlManager;
    property Device: TAsphyreDevice read FDevice;
    property DisplaySize: TPoint read FDisplaySize write FDisplaySize;
    property FileName: String read FFileName;
    property Grid: TPoint read FGrid write FGrid;
    property Provider: TAProvider read FProvider write FProvider;
    property RenderTarget: TRenderTarget read FRenderTarget write FRenderTarget;
    property Selected: TAControl read FSelected write SetSelected;
    property SelectState: TSelectState read FSelectState write FSelectState;
    property ShowGrid: Boolean read FShowGrid write FShowGrid;
    property SnapToGrid: Boolean read FSnapToGrid write FSnapToGrid;
  end;

implementation

uses
  Editor.MainForm, Editor.PreviewForm;

var
  XPos, YPos: Integer;
  L, T, W, H: Integer;

  { TEditorManager }

constructor TEditorManager.Create(AOwner: TControl);
var
  DesignPanel: TPanel;
begin
  // Identify Controls
  DesignPanel := MainForm.AsphyrePanel;

  // Load Initial Settings
  LoadSettingsFromIniFile;

  FChanged := False;
  FSelectState := sNone;
  FSelected := nil;

  FTitle := 'Tulip - Graphical User Interface Editor';
  FFileName := '';

  // Indicate that we're using
  case FProvider of
    apDirectX9:
      Factory.UseProvider(idDirectX9);
    apDirectX10:
      Factory.UseProvider(idDirectX10);
    apDirectX11:
      Factory.UseProvider(idDirectX11);
    apOpenGL:
      Factory.UseProvider(idWinOpenGL);
  else
    Factory.UseProvider(idDirectX9);
  end;

  // Create Asphyre components in run-time.
  FDevice := Factory.CreateDevice;
  FCanvas := Factory.CreateCanvas;
  FFonts := TAsphyreFonts.Create;
  FImages := TAsphyreImages.Create;
  FArchive := TAsphyreArchive.Create;

  FFonts.Images := FImages;
  FFonts.Canvas := FCanvas;

  FArchive.OpenMode := aomReadOnly;
  ArchiveTypeAccess := ataAnyFile;

  FArchive.FileName := ExtractFilePath(ParamStr(0)) + 'media.asvf';

  // Configure Device
  FRenderTarget := rtDesignPanel;

  // SetFontNameForm := TSetFontNameForm.Create(SetFontNameForm);

  FDevice.SwapChains.Add(TWinControl(AOwner).Handle, FDisplaySize);
  FDevice.SwapChains.Add(SetFontNameForm.PanelExample.Handle, Point(300, 50));
  FDevice.SwapChains.Add(SetImageForm.PanelExample.Handle, Point(450, 380));
  FDevice.SwapChains.Items[0].VSync := True;
  FDevice.SwapChains.Items[1].VSync := True;
  FDevice.SwapChains.Items[2].VSync := True;

  // Resize AsphyrePanel
  DesignPanel.ClientWidth := FDisplaySize.X;
  DesignPanel.ClientHeight := FDisplaySize.Y;

  EventDeviceCreate.Subscribe(ClassName, OnDeviceCreate, 0);

  // Attempt to initialize Asphyre device.
  if (not FDevice.Initialize) then
  begin
    ShowMessage('Failed to initialize Asphyre device.');
    FArchive.Free;
    FImages.Free;
    FFonts.Free;
    FCanvas.Free;
    FDevice.Free;

    Application.Terminate();
    Exit;
  end;

  FControlManager := TAControlManager.Create(nil, FDevice, FCanvas);

  // Set to Design mode
  FControlManager.DesignMode := True;

  // Create an empty project
  Self.NewProject;

  // Create rendering timer.
  Timer.OnTimer := DoTimer;
  Timer.OnProcess := DoProcess;
  Timer.Speed := 60.0;
  Timer.MaxFPS := 120;

  Timer.Enabled := True;
end;

destructor TEditorManager.Destroy;
begin
  Timer.Enabled := False;

  if Assigned(FClipboardStream) then
    FClipboardStream.Free;

  FControlManager.Free;
  FArchive.Free;
  FImages.Free;
  FFonts.Free;
  FCanvas.Free;
  FDevice.Free;

  inherited;
end;

procedure TEditorManager.DoComboBoxSelect(Sender: TObject);
var
  ComboBox: TComboBox;
begin
  ComboBox := Sender as TComboBox;
  Selected := TAControl(ComboBox.Items.Objects[ComboBox.ItemIndex]);
end;

procedure TEditorManager.DoEditBringToFrontClick(Sender: TObject);
begin
  if Selected <> nil then
  begin
    Selected.BringToFront;
    UpdateList;
  end
  else
  begin
    Application.MessageBox('Nothing selected.', 'Information',
      MB_OK + MB_ICONINFORMATION);
  end;
end;

procedure TEditorManager.DoEditCopyClick(Sender: TObject);
begin
  if Selected <> nil then
  begin
    if Assigned(FClipboardStream) then
      FClipboardStream.Free;

    try
      FClipboardStream := TMemoryStream.Create;
      FClipboardStream.WriteComponent(Selected);
    finally
    end;
  end
  else
  begin
    Application.MessageBox('Nothing selected.', 'Information',
      MB_OK + MB_ICONINFORMATION);
  end;
end;

procedure TEditorManager.DoEditCutClick(Sender: TObject);
var
  AControl: TAControl;
begin
  AControl := Selected;

  if (AControl <> nil) then
  begin
    try
      DoEditCopyClick(Sender);
      Selected.Parent.RemoveControl(AControl);
      FreeAndNil(AControl);
    finally
      Selected := nil;
      Changed := True;
    end;
  end
  else
  begin
    Application.MessageBox('Nothing selected.', 'Information',
      MB_OK + MB_ICONINFORMATION);
  end;
end;

procedure TEditorManager.DoEditDeleteClick(Sender: TObject);
var
  AControl: TAControl;
  txt: string;

  StatusBar: TStatusBar;
begin
  // Identify MainForm Controls
  StatusBar := MainForm.StatusBar1;

  AControl := Selected;

  if AControl <> nil then
  begin
    txt := '"' + Selected.Name + '" is about to be deleted. Delete it?';
    if Application.MessageBox(PChar(txt), 'Question',
      MB_YESNO + MB_ICONQUESTION) = IDYES then
    begin
      try
        Selected.Parent.RemoveControl(AControl);
        FreeAndNil(AControl);
      finally
        Selected := nil;
        Changed := True;
      end;
    end;
  end
  else
  begin
    Application.MessageBox('Nothing selected.', 'Information',
      MB_OK + MB_ICONINFORMATION);
  end;

  if (Selected = nil) then
  begin
    StatusBar.Panels[1].Text := 'Selected: ';
  end;
end;

procedure TEditorManager.DoEditPastClick(Sender: TObject);
var
  AClass: TAControlClass;
  AControl: TAControl;
begin
  if not Assigned(FClipboardStream) then
  begin
    Application.MessageBox('Nothing in memory.', 'Information',
      MB_OK + MB_ICONINFORMATION);
    Exit;
  end;

  AControl := nil;
  try
    FClipboardStream.Seek(0, soFromBeginning);
    AClass := TAControlClass(FClipboardStream.ReadComponent(nil).ClassType);

    if (AClass = TAForm) then
    begin
      AControl := AClass.Create(FControlManager.Root);
      FClipboardStream.Seek(0, soFromBeginning);
      AControl.Assign(FClipboardStream.ReadComponent(nil));
    end
    else if (Selected <> nil) then
    begin
      AControl := AClass.Create(Selected.Handle);
      FClipboardStream.Seek(0, soFromBeginning);
      AControl.Assign(FClipboardStream.ReadComponent(nil));
    end
    else if (Selected = nil) then
    begin
      AControl := nil;
      Application.MessageBox('You must create or select a form first.',
        'Warning', MB_OK + MB_ICONWARNING);
    end;
  finally
    Selected := AControl;
    Changed := True;
  end;
end;

procedure TEditorManager.DoEditSendToBackClick(Sender: TObject);
begin
  if Selected <> nil then
  begin
    Selected.SendToBack;
    UpdateList;
  end
  else
  begin
    Application.MessageBox('Nothing selected.', 'Information',
      MB_OK + MB_ICONINFORMATION);
  end;
end;

procedure TEditorManager.DoFilePreviewClick(Sender: TObject);
var
  DestFile: String;

  DesignPanel: TPanel;
  PrevForm: TForm;
begin
  // Identify Controls
  DesignPanel := MainForm.AsphyrePanel;
  PrevForm := PreviewForm;

  Selected := nil;

  // Stop Timer
  Timer.Enabled := False;

  // Save data to temp file
  DestFile := GetEnvironmentVariable('TEMP') + '\Temp.asgui';
  FControlManager.SaveToArchiveFile(DestFile);

  // Change Handle
  FDevice.Finalize;
  FRenderTarget := rtPreviewForm;
  FDevice.SwapChains.Items[0].WindowHandle := PrevForm.Handle;

  // Resize PreviewForm
  PrevForm.ClientWidth := FDisplaySize.X;
  PrevForm.ClientHeight := FDisplaySize.Y;

  // Attempt to initialize Asphyre device.
  if (not FDevice.Initialize()) then
  begin
    ShowMessage('Failed to initialize Asphyre device.');

    Application.Terminate();
    Exit;
  end;

  FControlManager.Parent := PrevForm;
  FControlManager.DesignMode := False;

  FControlManager.LoadFromArchiveFile(DestFile);

  // Enable Timer
  Timer.Enabled := True;

  PrevForm.ShowModal;

  // The user has closed the PreviewForm
  // Revert to original rendertarget

  // Stop Timer
  Timer.Enabled := False;

  // Change Handle
  FDevice.Finalize;
  FRenderTarget := rtDesignPanel;
  FDevice.SwapChains.Items[0].WindowHandle := DesignPanel.Handle;

  // Resize AsphyrePanel
  DesignPanel.ClientWidth := FDisplaySize.X;
  DesignPanel.ClientHeight := FDisplaySize.Y;

  // Attempt to initialize Asphyre device.
  if (not FDevice.Initialize()) then
  begin
    ShowMessage('Failed to initialize Asphyre device.');

    Application.Terminate();
    Exit;
  end;

  FControlManager.Parent := nil;
  FControlManager.DesignMode := True;

  FControlManager.LoadFromArchiveFile(DestFile);

  // Delete temp file
  if FileExists(DestFile) then
  begin
    DeleteFile(DestFile);
  end;

  // Enable Timer
  Timer.Enabled := True;
end;

procedure TEditorManager.DoInsertButtonClick(Sender: TObject);
begin
  if Selected <> nil then
  begin
    if (Selected is TAPanel) then
      Selected := TAButton.Create(Selected)
    else if (Selected.Parent is TAPanel) then
      Selected := TAButton.Create(Selected.Parent)
    else
      Selected := TAButton.Create(Selected.Handle);
    Changed := True;
  end
  else
  begin
    Application.MessageBox('You must create or select a form first.', 'Warning',
      MB_OK + MB_ICONWARNING);
  end;
end;

procedure TEditorManager.DoInsertCheckBoxClick(Sender: TObject);
begin
  if Selected <> nil then
  begin
    if (Selected is TAPanel) then
      Selected := TACheckBox.Create(Selected)
    else if (Selected.Parent is TAPanel) then
      Selected := TACheckBox.Create(Selected.Parent)
    else
      Selected := TACheckBox.Create(Selected.Handle);
    Changed := True;
  end
  else
  begin
    Application.MessageBox('You must create or select a form first.', 'Warning',
      MB_OK + MB_ICONWARNING);
  end;
end;

procedure TEditorManager.DoInsertEditBoxClick(Sender: TObject);
begin
  if Selected <> nil then
  begin
    if (Selected is TAPanel) then
      Selected := TAEditBox.Create(Selected)
    else if (Selected.Parent is TAPanel) then
      Selected := TAEditBox.Create(Selected.Parent)
    else
      Selected := TAEditBox.Create(Selected.Handle);
    Changed := True;
  end
  else
  begin
    Application.MessageBox('You must create or select a form first.', 'Warning',
      MB_OK + MB_ICONWARNING);
  end;
end;

procedure TEditorManager.DoInsertFormClick(Sender: TObject);
begin
  Selected := TAForm.Create(FControlManager.Root);
  FChanged := True;
end;

procedure TEditorManager.DoInsertImageClick(Sender: TObject);
begin
  if Selected <> nil then
  begin
    if (Selected is TAPanel) then
      Selected := TAImage.Create(Selected)
    else if (Selected.Parent is TAPanel) then
      Selected := TAImage.Create(Selected.Parent)
    else
      Selected := TAImage.Create(Selected.Handle);
    Changed := True;
  end
  else
  begin
    Application.MessageBox('You must create or select a form first.', 'Warning',
      MB_OK + MB_ICONWARNING);
  end;
end;

procedure TEditorManager.DoInsertLabelClick(Sender: TObject);
begin
  if Selected <> nil then
  begin
    if (Selected is TAPanel) then
      Selected := TALabel.Create(Selected)
    else if (Selected.Parent is TAPanel) then
      Selected := TALabel.Create(Selected.Parent)
    else
      Selected := TALabel.Create(Selected.Handle);
    Changed := True;
  end
  else
  begin
    Application.MessageBox('You must create or select a form first.', 'Warning',
      MB_OK + MB_ICONWARNING);
  end;
end;

procedure TEditorManager.DoInsertListBoxClick(Sender: TObject);
begin
  if Selected <> nil then
  begin
    if (Selected is TAPanel) then
      Selected := TAListBox.Create(Selected)
    else if (Selected.Parent is TAPanel) then
      Selected := TAListBox.Create(Selected.Parent)
    else
      Selected := TAListBox.Create(Selected.Handle);
    Changed := True;
  end
  else
  begin
    Application.MessageBox('You must create or select a form first.', 'Warning',
      MB_OK + MB_ICONWARNING);
  end;
end;

procedure TEditorManager.DoInsertPaintBoxClick(Sender: TObject);
begin
  if Selected <> nil then
  begin
    if (Selected is TAPanel) then
      Selected := TAPaintBox.Create(Selected)
    else if (Selected.Parent is TAPanel) then
      Selected := TAPaintBox.Create(Selected.Parent)
    else
      Selected := TAPaintBox.Create(Selected.Handle);
    Changed := True;
  end
  else
  begin
    Application.MessageBox('You must create or select a form first.', 'Warning',
      MB_OK + MB_ICONWARNING);
  end;
end;

procedure TEditorManager.DoInsertPanelClick(Sender: TObject);
begin
  if Selected <> nil then
  begin
    Selected := TAPanel.Create(Selected.Handle);
    Changed := True;
  end
  else
  begin
    Application.MessageBox('You must create or select a form first.', 'Warning',
      MB_OK + MB_ICONWARNING);
  end;
end;

procedure TEditorManager.DoInsertProgressBarClick(Sender: TObject);
begin
  if Selected <> nil then
  begin
    if (Selected is TAPanel) then
      Selected := TAProgressBar.Create(Selected)
    else if (Selected.Parent is TAPanel) then
      Selected := TAProgressBar.Create(Selected.Parent)
    else
      Selected := TAProgressBar.Create(Selected.Handle);
    Changed := True;
  end
  else
  begin
    Application.MessageBox('You must create or select a form first.', 'Warning',
      MB_OK + MB_ICONWARNING);
  end;
end;

procedure TEditorManager.DoInsertRadioButtonClick(Sender: TObject);
begin
  if Selected <> nil then
  begin
    if (Selected is TAPanel) then
      Selected := TARadioButton.Create(Selected)
    else if (Selected.Parent is TAPanel) then
      Selected := TARadioButton.Create(Selected.Parent)
    else
      Selected := TARadioButton.Create(Selected.Handle);
    Changed := True;
  end
  else
  begin
    Application.MessageBox('You must create or select a form first.', 'Warning',
      MB_OK + MB_ICONWARNING);
  end;
end;

procedure TEditorManager.DoInsertTrackBarClick(Sender: TObject);
begin
  if Selected <> nil then
  begin
    if (Selected is TAPanel) then
      Selected := TATrackBar.Create(Selected)
    else if (Selected.Parent is TAPanel) then
      Selected := TATrackBar.Create(Selected.Parent)
    else
      Selected := TATrackBar.Create(Selected.Handle);
    Changed := True;
  end
  else
  begin
    Application.MessageBox('You must create or select a form first.', 'Warning',
      MB_OK + MB_ICONWARNING);
  end;
end;

procedure TEditorManager.DoInspectorItemValueChanged(Sender: TObject;
  Item: TJvCustomInspectorItem);
begin
  if Changed = False then
    Changed := True;

  if Item.Name = 'Name' then
    UpdateList;
end;

procedure TEditorManager.DoProcess(Sender: TObject);
begin
end;

procedure TEditorManager.DoRenderAsphyrePanel(Sender: TObject);
var
  L1, T1, W1, H1: Integer;
  xgrid, ygrid: Integer;
begin
  // Render Grid
  if (FShowGrid = True) then
  begin
    xgrid := 0;
    ygrid := 0;

    while (ygrid <= (FDisplaySize.Y - FGrid.Y)) do
    begin
      while (xgrid <= (FDisplaySize.X - FGrid.X)) do
      begin
        FCanvas.PutPixel(Point2(xgrid, ygrid), $FFCCCCCC);
        xgrid := xgrid + FGrid.X;
      end;

      xgrid := 0;
      ygrid := ygrid + FGrid.Y;
    end;
  end;

  // Render Controls
  FControlManager.Render;

  // Render Lines
  if Selected <> nil then
  begin
    with Selected do
    begin
      FCanvas.FrameRect(Rect(ClientLeft, ClientTop, ClientLeft + Width,
        ClientTop + Height), cColor4($FFFF0000), beNormal);
      FCanvas.FillRect(Rect(ClientLeft, ClientTop, ClientLeft + Width,
        ClientTop + Height), cColor4($2FFFFFFF), beNormal);

      if (FSelectState = sSizingW) then
      begin
        L1 := ClientLeft;
        T1 := ClientTop + Height div 2;
        W1 := Parent.ClientLeft;
        H1 := ClientTop + Height div 2;
        FFonts[0].TextOut(Point2(W1 + 2, T1 - 14), Inttostr(Abs(W1 - L1)),
          cColor2($FF0000FF));
        FCanvas.Line(Point2(W1, T1), Point2(L1, H1), $FF0000FF);

        L1 := ClientLeft;
        T1 := ClientTop + Height div 2;
        W1 := ClientLeft + Width;
        H1 := ClientTop + Height div 2;
        FFonts[0].TextOut(Point2(L1 + 2, T1 - 14), Inttostr(W1 - L1),
          cColor2($FFFF0000));
        FCanvas.Line(Point2(L1, T1), Point2(W1, H1), $FFFF0000);
      end;

      if (FSelectState = sSizingN) then
      begin
        L1 := ClientLeft + Width div 2;
        T1 := ClientTop;
        W1 := ClientLeft + Width div 2;
        H1 := Parent.ClientTop;
        FFonts[0].TextOut(Point2(L1 + 2, H1), Inttostr(Abs(H1 - T1)),
          cColor2($FF0000FF));
        FCanvas.Line(Point2(L1, H1), Point2(W1, T1), $FF0000FF);

        L1 := ClientLeft + Width div 2;
        T1 := ClientTop;
        W1 := ClientLeft + Width div 2;
        H1 := ClientTop + Height;
        FFonts[0].TextOut(Point2(L1 + 2, T1), Inttostr(H1 - T1),
          cColor2($FFFF0000));
        FCanvas.Line(Point2(L1, H1), Point2(W1, T1), $FFFF0000);
      end;

      if (FSelectState = sSizingE) then
      begin
        L1 := ClientLeft + Width;
        T1 := ClientTop + Height div 2;
        W1 := Parent.ClientLeft + Parent.Width;
        H1 := ClientTop + Height div 2;
        FFonts[0].TextOut(Point2(L1 + 2, T1 - 14), Inttostr(W1 - L1),
          cColor2($FF0000FF));
        FCanvas.Line(Point2(L1, T1), Point2(W1, H1), $FF0000FF);

        L1 := ClientLeft;
        T1 := ClientTop + Height div 2;
        W1 := ClientLeft + Width;
        H1 := ClientTop + Height div 2;
        FFonts[0].TextOut(Point2(L1 + 2, T1 - 14), Inttostr(W1 - L1),
          cColor2($FFFF0000));
        FCanvas.Line(Point2(L1, T1), Point2(W1, H1), $FFFF0000);
      end;

      if (FSelectState = sSizingS) then
      begin
        L1 := ClientLeft + Width div 2;
        T1 := ClientTop + Height;
        W1 := ClientLeft + Width div 2;
        H1 := Parent.ClientTop + Parent.Height;
        FFonts[0].TextOut(Point2(L1 + 2, T1), Inttostr(H1 - T1),
          cColor2($FF0000FF));
        FCanvas.Line(Point2(L1, T1), Point2(W1, H1), $FF0000FF);

        L1 := ClientLeft + Width div 2;
        T1 := ClientTop;
        W1 := ClientLeft + Width div 2;
        H1 := ClientTop + Height;
        FFonts[0].TextOut(Point2(L1 + 2, T1), Inttostr(H1 - T1),
          cColor2($FFFF0000));
        FCanvas.Line(Point2(L1, H1), Point2(W1, T1), $FFFF0000);
      end;

      if (FSelectState = sSizingNW) then
      begin
        L1 := ClientLeft;
        T1 := ClientTop + Height div 2;
        W1 := Parent.ClientLeft;
        H1 := ClientTop + Height div 2;
        FFonts[0].TextOut(Point2(W1 + 2, T1 - 14), Inttostr(Abs(W1 - L1)),
          cColor2($FF0000FF));
        FCanvas.Line(Point2(W1, T1), Point2(L1, H1), $FF0000FF);

        L1 := ClientLeft + Width div 2;
        T1 := ClientTop;
        W1 := ClientLeft + Width div 2;
        H1 := Parent.ClientTop;
        FFonts[0].TextOut(Point2(L1 + 2, H1), Inttostr(Abs(H1 - T1)),
          cColor2($FF0000FF));
        FCanvas.Line(Point2(L1, H1), Point2(W1, T1), $FF0000FF);

        L1 := ClientLeft + Width div 2;
        T1 := ClientTop;
        W1 := ClientLeft + Width div 2;
        H1 := ClientTop + Height;
        FFonts[0].TextOut(Point2(L1 + 2, T1), Inttostr(H1 - T1),
          cColor2($FFFF0000));
        FCanvas.Line(Point2(L1, H1), Point2(W1, T1), $FFFF0000);

        L1 := ClientLeft;
        T1 := ClientTop + Height div 2;
        W1 := ClientLeft + Width;
        H1 := ClientTop + Height div 2;
        FFonts[0].TextOut(Point2(L1 + 2, T1 - 14), Inttostr(W1 - L1),
          cColor2($FFFF0000));
        FCanvas.Line(Point2(L1, T1), Point2(W1, H1), $FFFF0000);
      end;

      if (FSelectState = sSizingNE) then
      begin
        L1 := ClientLeft + Width div 2;
        T1 := ClientTop;
        W1 := ClientLeft + Width div 2;
        H1 := Parent.ClientTop;
        FFonts[0].TextOut(Point2(L1 + 2, H1), Inttostr(Abs(H1 - T1)),
          cColor2($FF0000FF));
        FCanvas.Line(Point2(L1, H1), Point2(W1, T1), $FF0000FF);

        L1 := ClientLeft + Width;
        T1 := ClientTop + Height div 2;
        W1 := Parent.ClientLeft + Parent.Width;
        H1 := ClientTop + Height div 2;
        FFonts[0].TextOut(Point2(L1 + 2, T1 - 14), Inttostr(W1 - L1),
          cColor2($FF0000FF));
        FCanvas.Line(Point2(L1, T1), Point2(W1, H1), $FF0000FF);

        L1 := ClientLeft + Width div 2;
        T1 := ClientTop;
        W1 := ClientLeft + Width div 2;
        H1 := ClientTop + Height;
        FFonts[0].TextOut(Point2(L1 + 2, T1), Inttostr(H1 - T1),
          cColor2($FFFF0000));
        FCanvas.Line(Point2(L1, H1), Point2(W1, T1), $FFFF0000);

        L1 := ClientLeft;
        T1 := ClientTop + Height div 2;
        W1 := ClientLeft + Width;
        H1 := ClientTop + Height div 2;
        FFonts[0].TextOut(Point2(L1 + 2, T1 - 14), Inttostr(W1 - L1),
          cColor2($FFFF0000));
        FCanvas.Line(Point2(L1, T1), Point2(W1, H1), $FFFF0000);
      end;

      if (FSelectState = sSizingSE) then
      begin
        L1 := ClientLeft + Width;
        T1 := ClientTop + Height div 2;
        W1 := Parent.ClientLeft + Parent.Width;
        H1 := ClientTop + Height div 2;
        FFonts[0].TextOut(Point2(L1 + 2, T1 - 14), Inttostr(W1 - L1),
          cColor2($FF0000FF));
        FCanvas.Line(Point2(L1, T1), Point2(W1, H1), $FF0000FF);

        L1 := ClientLeft + Width div 2;
        T1 := ClientTop + Height;
        W1 := ClientLeft + Width div 2;
        H1 := Parent.ClientTop + Parent.Height;
        FFonts[0].TextOut(Point2(L1 + 2, T1), Inttostr(H1 - T1),
          cColor2($FF0000FF));
        FCanvas.Line(Point2(L1, T1), Point2(W1, H1), $FF0000FF);

        L1 := ClientLeft + Width div 2;
        T1 := ClientTop;
        W1 := ClientLeft + Width div 2;
        H1 := ClientTop + Height;
        FFonts[0].TextOut(Point2(L1 + 2, T1), Inttostr(H1 - T1),
          cColor2($FFFF0000));
        FCanvas.Line(Point2(L1, H1), Point2(W1, T1), $FFFF0000);

        L1 := ClientLeft;
        T1 := ClientTop + Height div 2;
        W1 := ClientLeft + Width;
        H1 := ClientTop + Height div 2;
        FFonts[0].TextOut(Point2(L1 + 2, T1 - 14), Inttostr(W1 - L1),
          cColor2($FFFF0000));
        FCanvas.Line(Point2(L1, T1), Point2(W1, H1), $FFFF0000);
      end;

      if (FSelectState = sSizingSW) then
      begin
        L1 := ClientLeft + Width div 2;
        T1 := ClientTop + Height;
        W1 := ClientLeft + Width div 2;
        H1 := Parent.ClientTop + Parent.Height;
        FFonts[0].TextOut(Point2(L1 + 2, T1), Inttostr(H1 - T1),
          cColor2($FF0000FF));
        FCanvas.Line(Point2(L1, T1), Point2(W1, H1), $FF0000FF);

        L1 := ClientLeft;
        T1 := ClientTop + Height div 2;
        W1 := Parent.ClientLeft;
        H1 := ClientTop + Height div 2;
        FFonts[0].TextOut(Point2(W1 + 2, T1 - 14), Inttostr(Abs(W1 - L1)),
          cColor2($FF0000FF));
        FCanvas.Line(Point2(W1, T1), Point2(L1, H1), $FF0000FF);

        L1 := ClientLeft + Width div 2;
        T1 := ClientTop;
        W1 := ClientLeft + Width div 2;
        H1 := ClientTop + Height;
        FFonts[0].TextOut(Point2(L1 + 2, T1), Inttostr(H1 - T1),
          cColor2($FFFF0000));
        FCanvas.Line(Point2(L1, H1), Point2(W1, T1), $FFFF0000);

        L1 := ClientLeft;
        T1 := ClientTop + Height div 2;
        W1 := ClientLeft + Width;
        H1 := ClientTop + Height div 2;
        FFonts[0].TextOut(Point2(L1 + 2, T1 - 14), Inttostr(W1 - L1),
          cColor2($FFFF0000));
        FCanvas.Line(Point2(L1, T1), Point2(W1, H1), $FFFF0000);
      end;

      if (FSelectState = sMoving) then
      begin
        L1 := ClientLeft + Width;
        T1 := ClientTop + Height div 2;
        W1 := Parent.ClientLeft + Parent.Width;
        H1 := ClientTop + Height div 2;
        FFonts[0].TextOut(Point2(L1 + 2, T1 - 14), Inttostr(W1 - L1),
          cColor2($FF0000FF));
        FCanvas.Line(Point2(L1, T1), Point2(W1, H1), $FF0000FF);

        L1 := ClientLeft + Width div 2;
        T1 := ClientTop + Height;
        W1 := ClientLeft + Width div 2;
        H1 := Parent.ClientTop + Parent.Height;
        FFonts[0].TextOut(Point2(L1 + 2, T1), Inttostr(H1 - T1),
          cColor2($FF0000FF));
        FCanvas.Line(Point2(L1, T1), Point2(W1, H1), $FF0000FF);

        L1 := ClientLeft;
        T1 := ClientTop + Height div 2;
        W1 := Parent.ClientLeft;
        H1 := ClientTop + Height div 2;
        FFonts[0].TextOut(Point2(W1 + 2, T1 - 14), Inttostr(Abs(W1 - L1)),
          cColor2($FF0000FF));
        FCanvas.Line(Point2(W1, T1), Point2(L1, H1), $FF0000FF);

        L1 := ClientLeft + Width div 2;
        T1 := ClientTop;
        W1 := ClientLeft + Width div 2;
        H1 := Parent.ClientTop;
        FFonts[0].TextOut(Point2(L1 + 2, H1), Inttostr(Abs(H1 - T1)),
          cColor2($FF0000FF));
        FCanvas.Line(Point2(L1, H1), Point2(W1, T1), $FF0000FF);
      end;
    end;
  end;
end;

procedure TEditorManager.DoRenderFontPreview(Sender: TObject);
var
  i, j: Integer;
  ListBox: TListBox;
begin
  ListBox := SetFontNameForm.ListBox1;

  // Draw gray background.
  for j := 0 to (FDevice.SwapChains.Items[1].Height div 8) do
    for i := 0 to (FDevice.SwapChains.Items[1].Width div 8) do
    begin
      if odd(j) then
      begin
        if odd(i) then
        begin
          FCanvas.FillQuad(pBounds4(i * 8, j * 8, 8, 8), cColor4($FF808080));
        end
        else
        begin
          FCanvas.FillQuad(pBounds4(i * 8, j * 8, 8, 8), cColor4($FF606060));
        end;
      end
      else
      begin
        if odd(i) then
        begin
          FCanvas.FillQuad(pBounds4(i * 8, j * 8, 8, 8), cColor4($FF606060));
        end
        else
        begin
          FCanvas.FillQuad(pBounds4(i * 8, j * 8, 8, 8), cColor4($FF808080));
        end;
      end;
    end;

  if ListBox.ItemIndex <> -1 then
  begin
    ControlManager.Fonts.Font[ListBox.Items[ListBox.ItemIndex]]
      .TextMid(Point2px(150, 25), 'This is an example text.',
      cColor2($FFFFFFFF));
  end;
end;

procedure TEditorManager.DoRenderImagePreview(Sender: TObject);
var
  i, j: Integer;
  Selected: TSelectedImage;
begin
  Selected := SetImageForm.SelImage;

  ControlManager.Canvas.Antialias := False;

  // Draw Image
  if (Selected.Image <> nil) then
  begin
    with Selected do
    begin
      // Draw gray background.
      for j := 0 to (Min(380, Image.Texture[SelTexture].Height * Zoom)
        div 8) - 1 do
        for i := 0 to (Min(450, Image.Texture[SelTexture].Width * Zoom)
          div 8) - 1 do
        begin
          if odd(j) then
          begin
            if odd(i) then
            begin
              FCanvas.FillQuad(pBounds4(i * 8, j * 8, 8, 8),
                cColor4($FF808080));
            end
            else
            begin
              FCanvas.FillQuad(pBounds4(i * 8, j * 8, 8, 8),
                cColor4($FF606060));
            end;
          end
          else
          begin
            if odd(i) then
            begin
              FCanvas.FillQuad(pBounds4(i * 8, j * 8, 8, 8),
                cColor4($FF606060));
            end
            else
            begin
              FCanvas.FillQuad(pBounds4(i * 8, j * 8, 8, 8),
                cColor4($FF808080));
            end;
          end;
        end;

      ControlManager.Canvas.UseTexturePx(Image.Texture[SelTexture],
        pBounds4(HPos / Zoom, VPos / Zoom, Min(450 / Zoom,
        Image.Texture[SelTexture].Width), Min(380 / Zoom,
        Image.Texture[SelTexture].Height)));

      ControlManager.Canvas.TexMap
        (pRect4(Rect(0, 0, Min(450, Image.Texture[SelTexture].Width * Zoom),
        Min(380, Image.Texture[SelTexture].Height * Zoom))), cColor4($FFFFFFFF),
        beNormal);

      ControlManager.Canvas.FillRect
        (Rect(0, 0 - VPos, Image.Texture[SelTexture].Width * Zoom,
        SelPos.Top * Zoom - VPos), $CC808080, beNormal);

      ControlManager.Canvas.FillRect(Rect(0, SelPos.Bottom * Zoom - VPos,
        Image.Texture[SelTexture].Width * Zoom, Image.Texture[SelTexture].Height
        * Zoom - VPos), $CC808080, beNormal);

      ControlManager.Canvas.FillRect(Rect(0, SelPos.Top * Zoom - VPos,
        SelPos.Left * Zoom - HPos, SelPos.Bottom * Zoom - VPos), $CC808080,
        beNormal);

      ControlManager.Canvas.FillRect(Rect(SelPos.Right * Zoom - HPos,
        SelPos.Top * Zoom - VPos, Image.Texture[SelTexture].Width * Zoom,
        SelPos.Bottom * Zoom - VPos), $CC808080, beNormal);
    end
  end;
end;

procedure TEditorManager.DoRenderPreview(Sender: TObject);
begin
  FControlManager.Render;
end;

procedure TEditorManager.DoTimer(Sender: TObject);
begin
  if (FRenderTarget = rtDesignPanel) then
  begin
    FDevice.Render(DoRenderAsphyrePanel, $00FFFFFF);
  end
  else if (FRenderTarget = rtPreviewForm) then
  begin
    FDevice.Render(DoRenderPreview, $00FFFFFF);
  end
  else if (FRenderTarget = rtFontPreview) then
  begin
    FDevice.Render(1, DoRenderFontPreview, $00FFFFFF);
  end
  else if (FRenderTarget = rtImagePreview) then
  begin
    FDevice.Render(2, DoRenderImagePreview, $00A0A0A0);
  end;

  Timer.Process();
end;

procedure TEditorManager.DoTreeViewChange(Sender: TObject; Node: TTreeNode);
var
  TreeView: TTreeView;
begin
  TreeView := Sender as TTreeView;
  Selected := TreeView.Selected.Data;
end;

procedure TEditorManager.LoadSettingsFromIniFile;
var
  IniFile: TCustomIniFile;
begin
  // Load values from ini File
  IniFile := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'Editor.ini');
  try
    FDisplaySize.X := IniFile.ReadInteger('Editor', 'Width', 640);
    FDisplaySize.Y := IniFile.ReadInteger('Editor', 'Height', 480);
    FGrid.X := IniFile.ReadInteger('Editor', 'GridX', 8);
    FGrid.Y := IniFile.ReadInteger('Editor', 'GridY', 8);
    FProvider := TAProvider(IniFile.ReadInteger('Editor', 'Provider', 0));
    ShowGrid := IniFile.ReadBool('Editor', 'ShowGrid', True);
    SnapToGrid := IniFile.ReadBool('Editor', 'SnapToGrid', True);
  finally
    IniFile.Free;
  end;
end;

procedure TEditorManager.MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  P: TPoint;
  Inspector: TJvInspector;
  StatusBar: TStatusBar;
begin
  // Identify MainForm Controls
  Inspector := MainForm.JvInspector1;
  StatusBar := MainForm.StatusBar1;

  Inspector.InspectObject := nil;

  Selected := FControlManager.Root.ControlAtPos(Point(X, Y), True, True, True);
  FSelectState := sNone;

  Inspector.InspectObject := Selected;

  if (Selected <> nil) then
  begin
    XPos := X - Selected.Left;
    YPos := Y - Selected.Top;
    L := X;
    T := Y;
    W := Selected.Width;
    H := Selected.Height;
  end;

  if (Selected <> nil) then
  begin
    with Selected do
    begin
      P := Point(X - ClientLeft, Y - ClientTop);
      if PtInRect(ClientRect, P) then
      begin
        if (X >= ClientLeft) and (X < (ClientLeft + 4)) and (Y >= ClientTop) and
          (Y < (ClientTop + 4)) then
        begin
          FSelectState := sSizingNW;
        end;

        if (X >= ClientLeft + Width - 4) and (X < (ClientLeft + Width)) and
          (Y >= ClientTop + Height - 4) and (Y < (ClientTop + Height)) then
        begin
          FSelectState := sSizingSE;
        end;

        if (X >= ClientLeft) and (X < (ClientLeft + 4)) and
          (Y >= ClientTop + Height - 4) and (Y < (ClientTop + Height)) then
        begin
          FSelectState := sSizingSW;
        end;

        if (X >= ClientLeft + Width - 4) and (X < (ClientLeft + Width)) and
          (Y >= ClientTop) and (Y < (ClientTop + 4)) then
        begin
          FSelectState := sSizingNE;
        end;

        if (X >= ClientLeft + 4) and (X < ClientLeft + Width - 4) and
          (Y >= ClientTop) and (Y < ClientTop + 4) then
        begin
          FSelectState := sSizingN;
        end;

        if (X >= ClientLeft + 4) and (X < ClientLeft + Width - 4) and
          (Y >= ClientTop + Height - 4) and (Y < ClientTop + Height) then
        begin
          FSelectState := sSizingS;
        end;

        if (X >= ClientLeft) and (X < ClientLeft + 4) and (Y >= ClientTop + 4)
          and (Y < ClientTop + Height - 4) then
        begin
          FSelectState := sSizingW;
        end;

        if (X >= ClientLeft + Width - 4) and (X < ClientLeft + Width) and
          (Y >= ClientTop + 4) and (Y < ClientTop + Height - 4) then
        begin
          FSelectState := sSizingE;
        end;

        if (X >= ClientLeft + 4) and (X < ClientLeft + Width - 4) and
          (Y >= ClientTop + 4) and (Y < ClientTop + Height - 4) then
        begin
          FSelectState := sMoving;
        end;
      end
      else
      begin
        FSelectState := sNone;
      end;
    end;
  end
  else
  begin
    FSelectState := sNone;
  end;

  // Update StatusBar
  if (Selected <> nil) then
  begin
    StatusBar.Panels[1].Text := 'Selected: ' + Selected.Name +
      Format(' (Left: %d Top: %d Width: %d Height: %d)',
      [Selected.Left, Selected.Top, Selected.Width, Selected.Height]);
  end
  else
  begin
    StatusBar.Panels[1].Text := 'Selected: ';
  end;
end;

procedure TEditorManager.MouseLeave(Sender: TObject);
var
  StatusBar: TStatusBar;
begin
  // Identify MainForm Controls
  StatusBar := MainForm.StatusBar1;

  // Update StatusBar
  StatusBar.Panels[0].Text := '';
  StatusBar.Panels[2].Text := 'Hover: ';
end;

procedure TEditorManager.MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var
  AControl: TAControl;
  P: TPoint;

  Inspector: TJvInspector;
  Panel: TPanel;
  StatusBar: TStatusBar;
begin
  // Identify Mainform Controls
  Inspector := MainForm.JvInspector1;
  Panel := MainForm.AsphyrePanel;
  StatusBar := MainForm.StatusBar1;

  // Set Cursor
  if (Selected <> nil) then
  begin
    if (Selected.IsVisible = True)
    { or (Selected.Parent <> FControlManager.Root) }
    then
    begin
      with Selected do
      begin
        P := Point(X - ClientLeft, Y - ClientTop);
        if PtInRect(ClientRect, P) then
        begin
          if (X >= ClientLeft) and (X < (ClientLeft + 4)) and (Y >= ClientTop)
            and (Y < (ClientTop + 4)) or (X >= ClientLeft + Width - 4) and
            (X < (ClientLeft + Width)) and (Y >= ClientTop + Height - 4) and
            (Y < (ClientTop + Height)) then
          begin
            Panel.Cursor := crSizeNWSE;
          end
          else if (X >= ClientLeft) and (X < (ClientLeft + 4)) and
            (Y >= ClientTop + Height - 4) and (Y < (ClientTop + Height)) or
            (X >= ClientLeft + Width - 4) and (X < (ClientLeft + Width)) and
            (Y >= ClientTop) and (Y < (ClientTop + 4)) then
          begin
            Panel.Cursor := crSizeNESW;
          end
          else if (X >= ClientLeft + 4) and (X < ClientLeft + Width - 4) and
            (Y >= ClientTop) and (Y < ClientTop + 4) or (X >= ClientLeft + 4)
            and (X < ClientLeft + Width - 4) and (Y >= ClientTop + Height - 4)
            and (Y < ClientTop + Height) then
          begin
            Panel.Cursor := crSizeNS;
          end
          else if (X >= ClientLeft) and (X < ClientLeft + 4) and
            (Y >= ClientTop + 4) and (Y < ClientTop + Height - 4) or
            (X >= ClientLeft + Width - 4) and (X < ClientLeft + Width) and
            (Y >= ClientTop + 4) and (Y < ClientTop + Height - 4) then
          begin
            Panel.Cursor := crSizeWE;
          end
          else if (X >= ClientLeft + 4) and (X < ClientLeft + Width - 4) and
            (Y >= ClientTop + 4) and (Y < ClientTop + Height - 4) then
          begin
            Panel.Cursor := crDefault;
          end;
        end
        else
        begin
          Panel.Cursor := crDefault;
        end;
      end;
    end
    else
    begin
      Panel.Cursor := crDefault;
    end;
  end
  else
  begin
    Panel.Cursor := crDefault;
  end;

  // Moving and Sizing routines
  if (Selected <> nil) and (Shift = [ssLeft]) then
  begin
    // moving routines
    if (FSelectState = sMoving) then
    begin
      if (FSnapToGrid = True) then
      begin
        Selected.Left := X - XPos - (X - XPos) mod FGrid.X;
        Selected.Top := Y - YPos - (Y - YPos) mod FGrid.Y;
      end
      else
      begin
        Selected.Left := X - XPos;
        Selected.Top := Y - YPos;
      end;
    end;

    // sizing routines
    if (FSelectState = sSizingW) then
    begin
      if (FSnapToGrid = True) then
      begin
        Selected.Left := X - XPos - (X - XPos) mod FGrid.X;
        Selected.Width := W + L - X + (X - XPos) mod FGrid.X;
      end
      else
      begin
        Selected.Left := X - XPos;
        Selected.Width := W + L - X;
      end;
    end;

    if (FSelectState = sSizingE) then
    begin
      if (FSnapToGrid = True) then
      begin
        Selected.Width := W + X - L - (W + X - L) mod FGrid.X;
      end
      else
      begin
        Selected.Width := W + X - L;
      end;
    end;

    if (FSelectState = sSizingN) then
    begin
      if (FSnapToGrid = True) then
      begin
        Selected.Top := Y - YPos - (Y - YPos) mod FGrid.Y;
        Selected.Height := H + T - Y + (Y - YPos) mod FGrid.Y;
      end
      else
      begin
        Selected.Top := Y - YPos;
        Selected.Height := H + T - Y;
      end;
    end;

    if (FSelectState = sSizingS) then
    begin
      if (FSnapToGrid = True) then
      begin
        Selected.Height := H + Y - T - (H + Y - T) mod FGrid.Y;
      end
      else
      begin
        Selected.Height := H + Y - T;
      end;
    end;

    if (FSelectState = sSizingNE) then
    begin
      if (FSnapToGrid = True) then
      begin
        Selected.Top := Y - YPos - (Y - YPos) mod FGrid.Y;
        Selected.Height := H + T - Y + (Y - YPos) mod FGrid.Y;
        Selected.Width := W + X - L - (W + X - L) mod FGrid.X;
      end
      else
      begin
        Selected.Width := W + X - L;
        Selected.Top := Y - YPos;
        Selected.Height := H + T - Y;
      end;
    end;

    if (FSelectState = sSizingSE) then
    begin
      if (FSnapToGrid = True) then
      begin
        Selected.Height := H + Y - T - (H + Y - T) mod FGrid.Y;
        Selected.Width := W + X - L - (W + X - L) mod FGrid.X;
      end
      else
      begin
        Selected.Width := W + X - L;
        Selected.Height := H + Y - T;
      end;
    end;

    if (FSelectState = sSizingNW) then
    begin
      if (FSnapToGrid = True) then
      begin
        Selected.Top := Y - YPos - (Y - YPos) mod FGrid.Y;
        Selected.Height := H + T - Y + (Y - YPos) mod FGrid.Y;
        Selected.Left := X - XPos - (X - XPos) mod FGrid.X;
        Selected.Width := W + L - X + (X - XPos) mod FGrid.X;
      end
      else
      begin
        Selected.Left := X - XPos;
        Selected.Width := W + L - X;
        Selected.Top := Y - YPos;
        Selected.Height := H + T - Y;
      end;
    end;

    if (FSelectState = sSizingSW) then
    begin
      if (FSnapToGrid = True) then
      begin
        Selected.Height := H + Y - T - (H + Y - T) mod FGrid.Y;
        Selected.Left := X - XPos - (X - XPos) mod FGrid.X;
        Selected.Width := W + L - X + (X - XPos) mod FGrid.X;
      end
      else
      begin
        Selected.Left := X - XPos;
        Selected.Width := W + L - X;
        Selected.Height := H + Y - T;
      end;
    end;

    // minimun width and height
    if Selected.Width < 10 then
      Selected.Width := 10;
    if Selected.Height < 10 then
      Selected.Height := 10;

    // Refresh Inspector
    Inspector.RefreshValues;

    // Set Changed to true;
    if FChanged = False then
      FChanged := True;
  end;

  // Update StatusBar
  StatusBar.Panels[0].Text := Format('X: %d, Y: %d', [X, Y]);

  if (FSelected = nil) then
  begin
    StatusBar.Panels[1].Text := 'Selected: ';
  end
  else
  begin
    StatusBar.Panels[1].Text := 'Selected: ' + FSelected.Name +
      Format(' (Left: %d Top: %d Width: %d Height: %d)',
      [FSelected.Left, FSelected.Top, FSelected.Width, FSelected.Height]);
  end;

  if FSelectState = sNone then
  begin
    AControl := FControlManager.Root.ControlAtPos(Point(X, Y), True,
      True, True);

    if AControl <> nil then
      StatusBar.Panels[2].Text := 'Hover: ' + AControl.Name
    else
      StatusBar.Panels[2].Text := 'Hover: ';
  end;
end;

procedure TEditorManager.MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  FSelectState := sNone;
end;

procedure TEditorManager.NewProject;
begin
  FSelected := nil;
  FSelectState := sNone;
  FControlManager.Clear;

  // Insert Default Fonts
  FControlManager.Fonts.InsertFromArchive('tahoma10', FArchive);
  FControlManager.Fonts.InsertFromArchive('tahoma10b', FArchive);
  FControlManager.Fonts.InsertFromArchive('tahoma10c', FArchive);
  FControlManager.Root.Fonts.Add('tahoma10');
  FControlManager.Root.Fonts.Add('tahoma10b');
  FControlManager.Root.Fonts.Add('tahoma10c');

  UpdateList;
  UpdateInspector;

  FFileName := '';
  FChanged := False;
  MainForm.Caption := FTitle;
end;

procedure TEditorManager.OnDeviceCreate(Sender: TObject; Param: Pointer;
  var Handled: Boolean);
var
  Success: Boolean;
  Tahoma, Tahomab: Integer;
begin
  // This variable returns "Success" to Device initialization, so if you
  // set it to False, device creation will fail.
  Success := PBoolean(Param)^;

  Tahoma := FFonts.InsertFromArchive('tahoma10', FArchive);
  Tahomab := FFonts.InsertFromArchive('tahoma10b', FArchive);

  // Make sure everything has been loaded properly.
  Success := Success and (Tahoma <> -1) and (Tahomab <> -1);

  PBoolean(Param)^ := Success;
end;

procedure TEditorManager.OpenProject(AFileName: String);
begin
  Selected := nil;

  if (FControlManager.LoadFromArchiveFile(AFileName)) then
  begin
    UpdateList;
    UpdateInspector;

    FFileName := AFileName;
    Changed := False;
    MainForm.Caption := FTitle + ' - ' + FFileName;
  end;
end;

procedure TEditorManager.SaveProject(AFileName: String);
begin
  if (FControlManager.SaveToArchiveFile(AFileName)) then
  begin
    FFileName := AFileName;
    Changed := False;
    MainForm.Caption := FTitle + ' - ' + FFileName;

    Application.MessageBox('File Saved. ', 'Information',
      MB_OK + MB_ICONINFORMATION);
  end
  else
  begin
    Application.MessageBox('Error saving the project.', 'Error...',
      MB_OK + MB_ICONERROR);
  end;
end;

procedure TEditorManager.SaveSettingsToIniFile;
var
  IniFile: TCustomIniFile;
begin
  // Save to Ini file
  IniFile := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'Editor.ini');
  try
    IniFile.WriteInteger('Editor', 'Width', DisplaySize.X);
    IniFile.WriteInteger('Editor', 'Height', DisplaySize.Y);
    IniFile.WriteInteger('Editor', 'GridX', Grid.X);
    IniFile.WriteInteger('Editor', 'GridY', Grid.Y);
    IniFile.WriteBool('Editor', 'ShowGrid', ShowGrid);
    IniFile.WriteBool('Editor', 'SnapToGrid', SnapToGrid);
    IniFile.WriteInteger('Editor', 'Provider', Ord(Provider));
  finally
    IniFile.Free;
  end;
end;

procedure TEditorManager.SetImageMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin

end;

procedure TEditorManager.SetImageMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var
  Selected: TSelectedImage;
begin
  Selected := SetImageForm.SelImage;

  if (Selected.Image <> nil) then
  begin
    with Selected do
    begin
      if (X <= (Image.Texture[SelTexture].Width * Zoom) - HPos) and
        (Y <= (Image.Texture[SelTexture].Height * Zoom) - VPos) then
      begin
        (Sender as TPanel).Cursor := crCross;
        SetImageForm.StatusBar1.Panels[2].Text :=
          Format('X:%d, Y:%d', [Max(0, (X + HPos) div Zoom),
          Max(0, (Y + VPos) div Zoom)]);
      end
      else
      begin
        (Sender as TPanel).Cursor := crDefault;
        SetImageForm.StatusBar1.Panels[2].Text := '';
      end;
    end;

  end;
end;

procedure TEditorManager.SetImageMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin

end;

procedure TEditorManager.SetListData(Parent: TTreeNode; WControl: TWControl);
var
  Node: TTreeNode;
  Counter: Integer;
  Current: TAControl;

  ComboBox: TComboBox;
  TreeView: TTreeView;
begin
  // Identify MainForm Controls
  ComboBox := MainForm.ComboBox1;
  TreeView := MainForm.TreeView1;

  for Counter := 0 to WControl.ControlCount - 1 do
  begin
    Current := WControl.Controls[Counter];

    Node := TreeView.Items.AddChild(Parent, Current.Name);
    Node.Data := Current;
    Node.Selected := Current = Selected;
    if Current is TAForm then
    begin
      Node.ImageIndex := 1;
      Node.SelectedIndex := 1;
      Node.ExpandedImageIndex := 1;
    end
    else
    begin
      Node.ImageIndex := 2;
      Node.SelectedIndex := 2;
      Node.ExpandedImageIndex := 2;
    end;

    ComboBox.AddItem(Current.Name, Current);
    ComboBox.ItemIndex := ComboBox.Items.IndexOfObject(Selected);

    if Current is TWControl then
      SetListData(Node, TWControl(Current));
  end;
end;

procedure TEditorManager.SetSelected(AControl: TAControl);
begin
  if FSelected <> AControl then
  begin
    FSelected := AControl;
    FSelectState := sNone;
    UpdateList;
    UpdateInspector;
  end;
end;

procedure TEditorManager.UpdateInspector;
var
  Inspector: TJvInspector;
begin
  // Identify MainForm Controls
  Inspector := MainForm.JvInspector1;

  Inspector.InspectObject := Selected;
end;

procedure TEditorManager.UpdateList;
var
  Parent: TTreeNode;

  ComboBox: TComboBox;
  TreeView: TTreeView;
begin
  // Identify MainForm Controls
  ComboBox := MainForm.ComboBox1;
  TreeView := MainForm.TreeView1;

  ComboBox.Items.Clear;
  with TreeView.Items do
  begin
    Clear;
    Parent := Add(nil, 'Desktop');
    Parent.ImageIndex := 0;
    Parent.SelectedIndex := 0;
    Parent.ExpandedImageIndex := 0;
    Parent.Data := nil;

    SetListData(Parent, FControlManager.Root);
  end;
  TreeView.Items[0].Expand(True);
end;

end.
