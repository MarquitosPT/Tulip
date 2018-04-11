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
{  The Original Code is Editor.SetFontNameForm.pas.                            }
{                                                                              }
{  The Initial Developer of the Original Code is Marcos Gomes.                 }
{  Portions created by Marcos Gomes are Copyright (C) 2012, Marcos Gomes.      }
{  All Rights Reserved.                                                        }
{                                                                              }
{******************************************************************************}
{                                                                              }
{  Editor.SetFontNameForm.pas                           Modified: 05-Out-2012  }
{  --------------------------------------------------------------------------  }
{                                                                              }
{                     Implementation of SetFontNameForm                        }
{                                                                              }
{                                Version 1.02                                  }
{                                                                              }
{******************************************************************************}

unit Editor.SetFontNameForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls,
  // Asphyre
  AsphyreTimer,
  // Tulip UI
  Tulip.UI.Helpers, Tulip.UI.Utils;

type
  TSetFontNameForm = class(TForm)
    Ok: TButton;
    Cancel: TButton;
    GroupBox1: TGroupBox;
    ListBox1: TListBox;
    Import: TButton;
    Remove: TButton;
    GroupBox2: TGroupBox;
    PanelExample: TPanel;
    OpenDialog1: TOpenDialog;
    procedure ListBox1DblClick(Sender: TObject);
    procedure ImportClick(Sender: TObject);
    procedure RemoveClick(Sender: TObject);
    procedure OkClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SetFontNameForm: TSetFontNameForm;

implementation

uses
  Editor.MainForm;

{$R *.dfm}

procedure TSetFontNameForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  // Stop Timer
  Timer.Enabled := False;
end;

procedure TSetFontNameForm.FormShow(Sender: TObject);
begin
  // Start Timer
  Timer.Enabled := True;
end;

procedure TSetFontNameForm.ImportClick(Sender: TObject);
var
  FontStream: TMemoryStream;
  ImageStream: TMemoryStream;
  FontName, FontFile, ImageFile: String;
  FontResult: Boolean;
  ImageResult: Boolean;
  IntegerResult, ListBoxResult: Integer;
begin
  // Stop Timer
  Timer.Enabled := False;

  if (OpenDialog1.Execute) then
  begin
    // Font file .xml
    FontFile := OpenDialog1.FileName;

    // Image file .png
    ImageFile := OpenDialog1.FileName;
    Delete(ImageFile, pos('.xml', ImageFile), Length(ImageFile));
    ImageFile := ImageFile + '.png';

    // FontName
    FontName := LowerCase(ExtractFileName(FontFile));
    Delete(FontName, pos('.xml', FontName), Length(FontName));

    if EditorManager.ControlManager.Root.Fonts.IndexOf(FontName) <> -1 then
    begin
      ShowMessage('Your project already contains the font "' + FontName + '".');
      // restart timer
      Timer.Enabled := True;
      Exit;
    end;

    // Create Streams to hold file data
    FontStream := TMemoryStream.Create;
    ImageStream := TMemoryStream.Create;

    FontResult := XmlFileToStream(FontFile, FontStream);
    ImageResult := ImageFileToStream(ImageFile, ImageStream);

    if (FontResult) and (ImageResult) then
    begin
      FontName := LowerCase(ExtractFileName(OpenDialog1.FileName));
      Delete(FontName, pos('.xml', FontName), Length(FontName));
      IntegerResult := EditorManager.ControlManager.Fonts.InsertFromMemStream
        (FontName, FontStream, ImageStream);
      if IntegerResult <> -1 then
      begin
        EditorManager.ControlManager.Root.Fonts.Add(FontName);
        ListBoxResult := Self.ListBox1.Items.Add(FontName);
        ListBox1.ItemIndex := ListBoxResult;
      end
      else
      begin
        ShowMessage('Error importing font.');
      end;
    end
    else
    begin
      ShowMessage('Error loading content files.');
    end;

    FontStream.Free;
    ImageStream.Free;
  end;

  // restart timer
  Timer.Enabled := True;
end;

procedure TSetFontNameForm.ListBox1DblClick(Sender: TObject);
begin
  if ListBox1.ItemIndex <> -1 then
  begin
    ModalResult := mrOk;
  end;
end;

procedure TSetFontNameForm.OkClick(Sender: TObject);
begin
  if (ListBox1.ItemIndex = -1) and (ListBox1.Count > 0) then
  begin
    ListBox1.ItemIndex := 0;
  end;
end;

procedure TSetFontNameForm.RemoveClick(Sender: TObject);
var
  txt, FontName: String;
  FontIndex, ImageIndex, ListIndex: Integer;
begin
  // Stop Timer
  Timer.Enabled := False;

  if ListBox1.ItemIndex <> -1 then
  begin
    ListIndex := ListBox1.ItemIndex;
    FontName := ListBox1.Items[ListIndex];
    txt := 'The font "' + FontName + '" is about to be deleted. Delete it?';
    if Application.MessageBox(PChar(txt), 'Question',
      MB_YESNO + MB_ICONQUESTION) = IDYES then
    begin
      FontIndex := EditorManager.ControlManager.Fonts.IndexOf(FontName);
      ImageIndex := EditorManager.ControlManager.Fonts.Images.IndexOf(FontName);

      if (FontIndex <> -1) and (ImageIndex <> -1) then
      begin
        ListBox1.Items.Delete(ListIndex);
        ListBox1.ItemIndex := ListIndex - 1;

        EditorManager.ControlManager.Root.Fonts.Remove(FontName);

        EditorManager.ControlManager.Fonts.RemoveFont(FontIndex);
        EditorManager.ControlManager.Fonts.Images.Remove(ImageIndex);
      end;
    end;
  end;

  // restart timer
  Timer.Enabled := True;
end;

end.
