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
{  The Original Code is Editor.MainForm.pas.                                   }
{                                                                              }
{  The Initial Developer of the Original Code is Marcos Gomes.                 }
{  Portions created by Marcos Gomes are Copyright (C) 2012, Marcos Gomes.      }
{  All Rights Reserved.                                                        }
{                                                                              }
{******************************************************************************}
{                                                                              }
{  Editor.MainForm.pas                                  Modified: 05-Out-2012  }
{  --------------------------------------------------------------------------  }
{                                                                              }
{                         Implementation of MainForm                           }
{                                                                              }
{                                Version 1.02                                  }
{                                                                              }
{******************************************************************************}

unit Editor.MainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.ToolWin, Vcl.Menus, Vcl.StdCtrls, Vcl.ImgList,
  JvExControls, JvInspector,
  // Asphyre
  AsphyreTimer,
  // Tulip UI
  Tulip.UI,
  // Editor Units
  Editor.Manager, Editor.Classes;

type
  TMainForm = class(TForm)
    MainMenu1: TMainMenu;
    MenuFile: TMenuItem;
    MenuEdit: TMenuItem;
    ToolBar1: TToolBar;
    StatusBar1: TStatusBar;
    Panel1: TPanel;
    ToolButtonFileNew: TToolButton;
    PanelLeft: TPanel;
    Splitter1: TSplitter;
    PanelClient: TPanel;
    ScrollBox1: TScrollBox;
    AsphyrePanel: TPanel;
    Panel2: TPanel;
    Splitter2: TSplitter;
    Panel3: TPanel;
    ComboBox1: TComboBox;
    JvInspector1: TJvInspector;
    TreeView1: TTreeView;
    ImageListTreeView: TImageList;
    MenuFileNew: TMenuItem;
    MenuFileOpen: TMenuItem;
    N1: TMenuItem;
    MenuFileSave: TMenuItem;
    MenuFileSaveAs: TMenuItem;
    N2: TMenuItem;
    MenuFilePreview: TMenuItem;
    N3: TMenuItem;
    MenuFileExit: TMenuItem;
    MenuEditCut: TMenuItem;
    MenuEditCopy: TMenuItem;
    MenuEditPast: TMenuItem;
    N4: TMenuItem;
    MenuEditDelete: TMenuItem;
    N5: TMenuItem;
    MenuEditBringToFront: TMenuItem;
    MenuEditSendToBack: TMenuItem;
    MenuInsert: TMenuItem;
    MenuInsertForm: TMenuItem;
    N6: TMenuItem;
    MenuTools: TMenuItem;
    MenuToolsOptions: TMenuItem;
    N7: TMenuItem;
    MenuHelp: TMenuItem;
    MenuHelpIndex: TMenuItem;
    N8: TMenuItem;
    MenuHelpAbout: TMenuItem;
    PopupEdit: TPopupMenu;
    PopupEditCut: TMenuItem;
    PopupEditCopy: TMenuItem;
    PopupEditPast: TMenuItem;
    MenuItem1: TMenuItem;
    PopupEditInsert: TMenuItem;
    PopupEditInsertForm: TMenuItem;
    MenuItem2: TMenuItem;
    PopupEditDelete: TMenuItem;
    MenuItem3: TMenuItem;
    PopupEditBringToFront: TMenuItem;
    PopupEditSendToBack: TMenuItem;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    ImageListToolBar: TImageList;
    ToolButtonFileOpen: TToolButton;
    ToolButton3: TToolButton;
    ToolButtonFileSave: TToolButton;
    ToolButton5: TToolButton;
    ToolButtonEditCut: TToolButton;
    ToolButtonEditCopy: TToolButton;
    ToolButtonEditPast: TToolButton;
    ToolButtonEditDelete: TToolButton;
    ToolButton10: TToolButton;
    ToolButtonInsertForm: TToolButton;
    ToolButton1: TToolButton;
    ToolButtonFilePreview: TToolButton;
    ToolButtonInsertLabel: TToolButton;
    MenuInsertLabel: TMenuItem;
    PopupEditInsertLabel: TMenuItem;
    ToolButtonInsertPanel: TToolButton;
    MenuInsertPanel: TMenuItem;
    PopupEditInsertPanel: TMenuItem;
    MenuInsertImage: TMenuItem;
    PopupEditInsertImage: TMenuItem;
    ToolButtonInsertImage: TToolButton;
    ToolButtonInsertButton: TToolButton;
    MenuInsertButton: TMenuItem;
    PopupEditInsertButton: TMenuItem;
    ToolButtonInsertEditbox: TToolButton;
    MenuInsertEditBox: TMenuItem;
    PopupEditInsertEditBox: TMenuItem;
    MenuInsertCheckBox: TMenuItem;
    PopupEditInsertCheckBox: TMenuItem;
    ToolButtonInsertCheckBox: TToolButton;
    MenuInsertRadioButton: TMenuItem;
    PopupEditInsertRadioButton: TMenuItem;
    ToolButtonInsertRadioButton: TToolButton;
    MenuInsertProgressBar: TMenuItem;
    PopupEditInsertProgressBar: TMenuItem;
    ToolButtonInsertProgressBar: TToolButton;
    ToolButtonInsertListBox: TToolButton;
    ToolButtonInsertTrackBar: TToolButton;
    ToolButtonInsertPaintBox: TToolButton;
    MenuInsertListBox: TMenuItem;
    MenuInsertTrackBar: TMenuItem;
    MenuInsertPaintBox: TMenuItem;
    PopupEditInsertListBox: TMenuItem;
    PopupEditInsertTrackBar: TMenuItem;
    PopupEditInsertPaintBox: TMenuItem;
    N9: TMenuItem;
    PopupEditShowHide: TMenuItem;
    procedure FormDestroy(Sender: TObject);
    procedure AsphyrePanelMouseLeave(Sender: TObject);
    procedure AsphyrePanelMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure AsphyrePanelMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure AsphyrePanelMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ComboBox1Select(Sender: TObject);
    procedure TreeView1Change(Sender: TObject; Node: TTreeNode);
    procedure JvInspector1ItemValueChanged(Sender: TObject;
      Item: TJvCustomInspectorItem);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure MenuFileNewClick(Sender: TObject);
    procedure MenuFileOpenClick(Sender: TObject);
    procedure MenuFileSaveClick(Sender: TObject);
    procedure MenuFileSaveAsClick(Sender: TObject);
    procedure MenuFileExitClick(Sender: TObject);
    procedure MenuFilePreviewClick(Sender: TObject);
    procedure MenuEditCutClick(Sender: TObject);
    procedure MenuEditCopyClick(Sender: TObject);
    procedure MenuEditPastClick(Sender: TObject);
    procedure MenuEditDeleteClick(Sender: TObject);
    procedure MenuEditBringToFrontClick(Sender: TObject);
    procedure MenuEditSendToBackClick(Sender: TObject);
    procedure MenuInsertFormClick(Sender: TObject);
    procedure MenuHelpAboutClick(Sender: TObject);
    procedure MenuInsertLabelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure MenuToolsOptionsClick(Sender: TObject);
    procedure MenuInsertPanelClick(Sender: TObject);
    procedure MenuInsertImageClick(Sender: TObject);
    procedure MenuInsertButtonClick(Sender: TObject);
    procedure MenuInsertEditBoxClick(Sender: TObject);
    procedure MenuInsertCheckBoxClick(Sender: TObject);
    procedure MenuInsertRadioButtonClick(Sender: TObject);
    procedure MenuInsertProgressBarClick(Sender: TObject);
    procedure MenuInsertListBoxClick(Sender: TObject);
    procedure MenuInsertTrackBarClick(Sender: TObject);
    procedure MenuInsertPaintBoxClick(Sender: TObject);
    procedure MenuHelpIndexClick(Sender: TObject);
    procedure PopupEditPopup(Sender: TObject);
    procedure PopupEditShowHideClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;
  EditorManager: TEditorManager;

implementation

uses
  Editor.PreviewForm, Editor.AboutForm, Editor.OptionsForm;

{$R *.dfm}

procedure TMainForm.AsphyrePanelMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  EditorManager.MouseDown(Sender, Button, Shift, X, Y);
end;

procedure TMainForm.AsphyrePanelMouseLeave(Sender: TObject);
begin
  EditorManager.MouseLeave(Sender);
end;

procedure TMainForm.AsphyrePanelMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  EditorManager.MouseMove(Sender, Shift, X, Y);
end;

procedure TMainForm.AsphyrePanelMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  EditorManager.MouseUp(Sender, Button, Shift, X, Y);
end;

procedure TMainForm.ComboBox1Select(Sender: TObject);
begin
  EditorManager.DoComboBoxSelect(Sender);
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  txt: PChar;
  Result: Integer;
begin
  Timer.Enabled := False;

  txt := 'The current project as been changed. Save before quit?';

  if EditorManager.Changed = True then
  begin
    Result := Application.MessageBox(txt, 'Question',
      MB_YESNOCANCEL + MB_ICONQUESTION);

    if Result = IDYES then
    begin
      MenuFileSaveClick(Self);
      CanClose := True;
    end
    else if Result = IDNo then
    begin
      CanClose := True;
    end
    else
    begin
      CanClose := False;
      Timer.Enabled := True;
    end;
  end;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  EditorManager.Free;
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  EditorManager := TEditorManager.Create(AsphyrePanel);
end;

procedure TMainForm.JvInspector1ItemValueChanged(Sender: TObject;
  Item: TJvCustomInspectorItem);
begin
  EditorManager.DoInspectorItemValueChanged(Sender, Item);
end;

procedure TMainForm.MenuEditBringToFrontClick(Sender: TObject);
begin
  EditorManager.DoEditBringToFrontClick(Sender);
end;

procedure TMainForm.MenuEditCopyClick(Sender: TObject);
begin
  EditorManager.DoEditCopyClick(Sender);
end;

procedure TMainForm.MenuEditCutClick(Sender: TObject);
begin
  EditorManager.DoEditCutClick(Sender);
end;

procedure TMainForm.MenuEditDeleteClick(Sender: TObject);
begin
  EditorManager.DoEditDeleteClick(Sender);
end;

procedure TMainForm.MenuEditPastClick(Sender: TObject);
begin
  EditorManager.DoEditPastClick(Sender);
end;

procedure TMainForm.MenuEditSendToBackClick(Sender: TObject);
begin
  EditorManager.DoEditSendToBackClick(Sender);
end;

procedure TMainForm.MenuFileExitClick(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.MenuFileNewClick(Sender: TObject);
var
  txt: PChar;
  Result: Integer;
begin
  // Stop Timer
  Timer.Enabled := False;

  txt := 'The current project as been changed. Save it?';

  if EditorManager.Changed = True then
  begin
    Result := Application.MessageBox(txt, 'Question',
      MB_YESNOCANCEL + MB_ICONQUESTION);

    if Result = IDYES then
    begin
      MenuFileSaveClick(Self);
    end
    else if Result = IDCancel then
    begin
      // Restart Timer
      Timer.Enabled := True;
      Exit;
    end;
  end;

  // Create New Project
  EditorManager.NewProject;

  // Restart Timer
  Timer.Enabled := True;
end;

procedure TMainForm.MenuFileOpenClick(Sender: TObject);
var
  txt: PChar;
  Result: Integer;
begin
  // Stop Timer
  Timer.Enabled := False;

  txt := 'The current project as been changed. Save it?';

  if EditorManager.Changed = True then
  begin
    Result := Application.MessageBox(txt, 'Question',
      MB_YESNOCANCEL + MB_ICONQUESTION);

    if Result = IDYES then
    begin
      MenuFileSaveClick(Self);
    end
    else if Result = IDCancel then
    begin
      // Restart Timer
      Timer.Enabled := True;
      Exit;
    end;
  end;

  if OpenDialog1.Execute then
  begin
    // Open File
    EditorManager.OpenProject(OpenDialog1.FileName);
  end;

  // Clear FileName
  OpenDialog1.FileName := '';

  // Restart Timer
  Timer.Enabled := True;
end;

procedure TMainForm.MenuFilePreviewClick(Sender: TObject);
begin
  EditorManager.DoFilePreviewClick(Sender);
end;

procedure TMainForm.MenuFileSaveAsClick(Sender: TObject);
begin
  // Stop Timer
  Timer.Enabled := False;

  if SaveDialog1.Execute then
  begin
    EditorManager.SaveProject(SaveDialog1.FileName);
  end;

  // Clear FileName
  SaveDialog1.FileName := '';

  // Restart Timer
  Timer.Enabled := True;
end;

procedure TMainForm.MenuFileSaveClick(Sender: TObject);
begin
  // Stop Timer
  Timer.Enabled := False;

  if EditorManager.FileName <> '' then
  begin
    EditorManager.SaveProject(EditorManager.FileName);
  end
  else
  begin
    MenuFileSaveAsClick(Self);
  end;

  // Restart Timer
  Timer.Enabled := True;
end;

procedure TMainForm.MenuHelpAboutClick(Sender: TObject);
begin
  // Stop Timer
  Timer.Enabled := False;

  AboutForm.ShowModal;

  // Restart Timer
  Timer.Enabled := True;
end;

procedure TMainForm.MenuHelpIndexClick(Sender: TObject);
begin
  Timer.Enabled := False;

  ShowMessage('Not available in this release.');

  Timer.Enabled := True;
end;

procedure TMainForm.MenuInsertButtonClick(Sender: TObject);
begin
  EditorManager.DoInsertButtonClick(Sender);
end;

procedure TMainForm.MenuInsertCheckBoxClick(Sender: TObject);
begin
  EditorManager.DoInsertCheckBoxClick(Sender);
end;

procedure TMainForm.MenuInsertEditBoxClick(Sender: TObject);
begin
  EditorManager.DoInsertEditBoxClick(Sender);
end;

procedure TMainForm.MenuInsertFormClick(Sender: TObject);
begin
  EditorManager.DoInsertFormClick(Sender);
end;

procedure TMainForm.MenuInsertImageClick(Sender: TObject);
begin
  EditorManager.DoInsertImageClick(Sender);
end;

procedure TMainForm.MenuInsertLabelClick(Sender: TObject);
begin
  EditorManager.DoInsertLabelClick(Sender);
end;

procedure TMainForm.MenuInsertListBoxClick(Sender: TObject);
begin
  EditorManager.DoInsertListBoxClick(Sender);
end;

procedure TMainForm.MenuInsertPaintBoxClick(Sender: TObject);
begin
  EditorManager.DoInsertPaintBoxClick(Sender);
end;

procedure TMainForm.MenuInsertPanelClick(Sender: TObject);
begin
  EditorManager.DoInsertPanelClick(Sender);
end;

procedure TMainForm.MenuInsertProgressBarClick(Sender: TObject);
begin
  EditorManager.DoInsertProgressBarClick(Sender);
end;

procedure TMainForm.MenuInsertRadioButtonClick(Sender: TObject);
begin
  EditorManager.DoInsertRadioButtonClick(Sender);
end;

procedure TMainForm.MenuInsertTrackBarClick(Sender: TObject);
begin
  EditorManager.DoInsertTrackBarClick(Sender);
end;

procedure TMainForm.MenuToolsOptionsClick(Sender: TObject);
begin
  Timer.Enabled := False;

  OptionsForm.ShowModal;

  Timer.Enabled := True;
end;

procedure TMainForm.PopupEditPopup(Sender: TObject);
begin
  if (EditorManager.Selected <> nil) and (EditorManager.Selected is TAForm) then
  begin
    if EditorManager.Selected.Visible = true then
      Self.PopupEditShowHide.Caption := 'Hide Form'
    else
      Self.PopupEditShowHide.Caption := 'Show Form';

    Self.PopupEditShowHide.Visible := True;
  end
  else
  begin
    Self.PopupEditShowHide.Visible := False;
  end;
end;

procedure TMainForm.PopupEditShowHideClick(Sender: TObject);
begin
  if (EditorManager.Selected <> nil) and (EditorManager.Selected is TAForm) then
  begin
    EditorManager.Selected.Visible := not EditorManager.Selected.Visible;
    EditorManager.UpdateInspector;
  end
end;

procedure TMainForm.TreeView1Change(Sender: TObject; Node: TTreeNode);
begin
  EditorManager.DoTreeViewChange(Sender, Node);
end;

end.
