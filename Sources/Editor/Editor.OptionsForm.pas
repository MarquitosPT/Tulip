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
{  The Original Code is Editor.OptionsForm.pas.                                }
{                                                                              }
{  The Initial Developer of the Original Code is Marcos Gomes.                 }
{  Portions created by Marcos Gomes are Copyright (C) 2012, Marcos Gomes.      }
{  All Rights Reserved.                                                        }
{                                                                              }
{******************************************************************************}
{                                                                              }
{  Editor.OptionsForm.pas                               Modified: 05-Out-2012  }
{  --------------------------------------------------------------------------  }
{                                                                              }
{                       Implementation of OptionsForm                          }
{                                                                              }
{                                Version 1.02                                  }
{                                                                              }
{******************************************************************************}

unit Editor.OptionsForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Types, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls,
  // Editor Units
  Editor.Types;

type
  TOptionsForm = class(TForm)
    GroupBox2: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    EditWidth: TEdit;
    EditHeight: TEdit;
    GroupBox3: TGroupBox;
    Label5: TLabel;
    Label7: TLabel;
    CheckBoxShowGrid: TCheckBox;
    CheckBoxSnapToGrid: TCheckBox;
    EditX: TEdit;
    UpDown1: TUpDown;
    EditY: TEdit;
    UpDown2: TUpDown;
    ButtonOk: TButton;
    ButtonCancel: TButton;
    GroupBox1: TGroupBox;
    ComboProvider: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    procedure ButtonOkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ButtonCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  OptionsForm: TOptionsForm;

implementation

uses
  Editor.MainForm;

{$R *.dfm}

procedure TOptionsForm.ButtonCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TOptionsForm.ButtonOkClick(Sender: TObject);
begin
  EditorManager.DisplaySize := Point(StrToInt(EditWidth.Text),
    StrToInt(EditHeight.Text));
  EditorManager.ShowGrid := CheckBoxShowGrid.Checked;
  EditorManager.SnapToGrid := CheckBoxSnapToGrid.Checked;
  EditorManager.Grid := Point(StrToInt(EditX.Text), StrToInt(EditY.Text));
  EditorManager.Provider := TAProvider(ComboProvider.ItemIndex);

  // Save settings to ini file
  EditorManager.SaveSettingsToIniFile;

  // Resize Panel
  MainForm.AsphyrePanel.ClientWidth := EditorManager.DisplaySize.X;
  MainForm.AsphyrePanel.ClientHeight := EditorManager.DisplaySize.Y;

  // Resize SwapChains [0]
  EditorManager.Device.Resize(0, EditorManager.DisplaySize);

  EditorManager.ControlManager.Root.Width := EditorManager.DisplaySize.X;
  EditorManager.ControlManager.Root.Height := EditorManager.DisplaySize.Y;

  Close;
end;

procedure TOptionsForm.FormShow(Sender: TObject);
begin
  // Load Settings
  EditWidth.Text := IntToStr(EditorManager.DisplaySize.X);
  EditHeight.Text := IntToStr(EditorManager.DisplaySize.Y);
  EditX.Text := IntToStr(EditorManager.Grid.X);
  EditY.Text := IntToStr(EditorManager.Grid.Y);
  CheckBoxShowGrid.Checked := EditorManager.ShowGrid;
  CheckBoxSnapToGrid.Checked := EditorManager.SnapToGrid;
  ComboProvider.ItemIndex := Ord(EditorManager.Provider);
end;

end.
