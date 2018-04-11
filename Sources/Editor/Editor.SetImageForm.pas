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
{  The Original Code is Editor.SetImageForm.pas.                               }
{                                                                              }
{  The Initial Developer of the Original Code is Marcos Gomes.                 }
{  Portions created by Marcos Gomes are Copyright (C) 2012, Marcos Gomes.      }
{  All Rights Reserved.                                                        }
{                                                                              }
{******************************************************************************}
{                                                                              }
{  Editor.SetImageForm.pas                              Modified: 05-Out-2012  }
{  --------------------------------------------------------------------------  }
{                                                                              }
{                       Implementation of SetImageForm                         }
{                                                                              }
{                                Version 1.02                                  }
{                                                                              }
{******************************************************************************}

unit Editor.SetImageForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, System.Math, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Menus,
  // Asphyre Units
  AsphyreTimer, AsphyreImages, Vectors2px,
  // Editor Units
  Editor.ImportImageForm, Editor.Types;

type
  TSetImageForm = class(TForm)
    Ok: TButton;
    Cancel: TButton;
    GroupBox1: TGroupBox;
    ListBoxImages: TListBox;
    Import: TButton;
    Remove: TButton;
    GroupBoxPreview: TGroupBox;
    Button1: TButton;
    Panel1: TPanel;
    PanelExample: TPanel;
    ScrollBarV: TScrollBar;
    ScrollBarH: TScrollBar;
    StatusBar1: TStatusBar;
    TrackBarZoom: TTrackBar;
    Label3: TLabel;
    Label1: TLabel;
    EditLeft: TEdit;
    EditTop: TEdit;
    EditRight: TEdit;
    EditBottom: TEdit;
    Label2: TLabel;
    UpDownLeft: TUpDown;
    UpDownTop: TUpDown;
    Label4: TLabel;
    Label5: TLabel;
    UpDownRight: TUpDown;
    UpDownBottom: TUpDown;
    PopupMenu1: TPopupMenu;
    PopupReset: TMenuItem;
    N1: TMenuItem;
    PopupHelp: TMenuItem;
    procedure ImportClick(Sender: TObject);
    procedure ListBoxImagesClick(Sender: TObject);
    procedure RemoveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure PanelExampleMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure ScrollBarVChange(Sender: TObject);
    procedure ScrollBarHChange(Sender: TObject);
    procedure PanelExampleMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PanelExampleMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PanelExampleMouseLeave(Sender: TObject);
    procedure TrackBarZoomChange(Sender: TObject);
    procedure EditLeftChange(Sender: TObject);
    procedure EditTopChange(Sender: TObject);
    procedure EditRightChange(Sender: TObject);
    procedure EditBottomChange(Sender: TObject);
    procedure PopupResetClick(Sender: TObject);
    procedure PopupHelpClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
  private
    { Private declarations }
    procedure SetStatusBarSelectedSize;
  public
    { Public declarations }
    SelImage: TSelectedImage;
    procedure SetDisplaySize;
  end;

var
  SetImageForm: TSetImageForm;
  XPos, YPos: Integer;

implementation

uses
  Editor.MainForm;

{$R *.dfm}

procedure TSetImageForm.EditBottomChange(Sender: TObject);
begin
  SelImage.SelPos.Bottom := UpDownBottom.Position;
  // UpDownTop.Max := UpDownBottom.Position - 1;

  SetStatusBarSelectedSize;
end;

procedure TSetImageForm.EditLeftChange(Sender: TObject);
begin
  SelImage.SelPos.Left := UpDownLeft.Position;
  // UpDownRight.Min := UpDownLeft.Position + 1;

  SetStatusBarSelectedSize;
end;

procedure TSetImageForm.EditRightChange(Sender: TObject);
begin
  SelImage.SelPos.Right := UpDownRight.Position;
  // UpDownLeft.Max := UpDownRight.Position - 1;

  SetStatusBarSelectedSize;
end;

procedure TSetImageForm.EditTopChange(Sender: TObject);
begin
  SelImage.SelPos.Top := UpDownTop.Position;
  // UpDownBottom.Min := UpDownTop.Position + 1;

  SetStatusBarSelectedSize;
end;

procedure TSetImageForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Timer.Enabled := False;
end;

procedure TSetImageForm.FormCreate(Sender: TObject);
begin
  SelImage.Image := nil;
  SelImage.SelTexture := 0;
  SelImage.HPos := 0;
  SelImage.VPos := 0;
  SelImage.Zoom := 1;
  SelImage.SelPos := Rect(0, 0, 0, 0);

  ScrollBarH.Min := 0;
  ScrollBarH.Max := 0;
  ScrollBarH.Position := 0;
  ScrollBarH.Enabled := False;

  ScrollBarV.Min := 0;
  ScrollBarV.Max := 0;
  ScrollBarV.Position := 0;
  ScrollBarV.Enabled := False;

  UpDownLeft.Min := 0;
  UpDownTop.Min := 0;
  UpDownRight.Min := 0;
  UpDownBottom.Min := 0;

  UpDownLeft.Max := 0;
  UpDownTop.Max := 0;
  UpDownRight.Max := 0;
  UpDownBottom.Max := 0;

  UpDownLeft.Position := 0;
  UpDownTop.Position := 0;
  UpDownRight.Position := 0;
  UpDownBottom.Position := 0;

  TrackBarZoom.Position := 1;
end;

procedure TSetImageForm.FormMouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
var
  control: TControl;
  cpoint: TPoint;
begin
  cpoint := ScreenToClient(MousePos);
  control := Self.ControlAtPos(cpoint, False, true, False);

  if control is TWinControl then
  begin
    cpoint := control.ParentToClient(cpoint);
    if TWinControl(control).ControlCount > 0 then
      control := TWinControl(control).ControlAtPos(cpoint, False, true, False);
  end;

  if control = Panel1 then
  begin
    if Shift = [] then
      ScrollBarV.Position := ScrollBarV.Position - WheelDelta;

    if Shift = [ssCtrl] then
      ScrollBarH.Position := ScrollBarH.Position - WheelDelta;

    Handled := true;
  end;

end;

procedure TSetImageForm.FormShow(Sender: TObject);
begin
  Timer.Enabled := true;
end;

procedure TSetImageForm.ImportClick(Sender: TObject);
var
  i: Integer;
begin
  // Stop timer
  Timer.Enabled := False;

  ImportImageForm.ShowModal;

  if (ImportImageForm.ModalResult = mrOk) then
  begin
    ListBoxImages.Clear;
    for i := 0 to EditorManager.ControlManager.Root.Images.Count - 1 do
    begin
      ListBoxImages.Items.Add
        (EditorManager.ControlManager.Root.Images.Items[i]);
    end;

    if ListBoxImages.Count > 0 then
    begin
      ListBoxImages.ItemIndex := 0;
      SetDisplaySize;
    end;
  end;

  // Start Timer
  Timer.Enabled := true;
end;

procedure TSetImageForm.ListBoxImagesClick(Sender: TObject);
begin
  SetDisplaySize;
end;

procedure TSetImageForm.PanelExampleMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  EditorManager.SetImageMouseDown(Sender, Button, Shift, X, Y);

  XPos := (X + SelImage.HPos) div SelImage.Zoom;
  YPos := (Y + SelImage.VPos) div SelImage.Zoom;

  if SelImage.Image <> nil then
  begin
    if (X <= (SelImage.Image.Texture[SelImage.SelTexture].Width * SelImage.Zoom)
      - SelImage.HPos) and
      (Y <= (SelImage.Image.Texture[SelImage.SelTexture].Height * SelImage.Zoom)
      - SelImage.VPos) then
    begin
      if (Shift = [ssLeft]) then
      begin
        UpDownLeft.Position := XPos;
        UpDownTop.Position := YPos;
        UpDownRight.Position := XPos + 1;
        UpDownBottom.Position := YPos + 1;
      end;

      if (Shift = [ssLeft, ssShift]) then
      begin
        if XPos < UpDownRight.Position then
        begin
          UpDownLeft.Position := XPos;
          XPos := UpDownRight.Position;
        end
        else
        begin
          UpDownLeft.Position := XPos;
          UpDownRight.Position := XPos + 1;
        end;

        if YPos < UpDownBottom.Position then
        begin
          UpDownTop.Position := YPos;
          YPos := UpDownBottom.Position;
        end
        else
        begin
          UpDownTop.Position := YPos;
          UpDownBottom.Position := YPos + 1;
        end;
      end;

      if (Shift = [ssLeft, ssCtrl]) then
      begin
        if XPos > UpDownLeft.Position then
        begin
          UpDownRight.Position := XPos;
          XPos := UpDownLeft.Position;
        end
        else
        begin
          UpDownLeft.Position := XPos;
          UpDownRight.Position := XPos + 1;
        end;

        if YPos > UpDownTop.Position then
        begin
          UpDownBottom.Position := YPos;
          YPos := UpDownTop.Position;
        end
        else
        begin
          UpDownTop.Position := YPos;
          UpDownBottom.Position := YPos + 1;
        end;
      end;
    end;
  end;
end;

procedure TSetImageForm.PanelExampleMouseLeave(Sender: TObject);
begin
  SetImageForm.StatusBar1.Panels[2].Text := '';
end;

procedure TSetImageForm.PanelExampleMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  XStart, XEnd: Integer;
  YStart, YEnd: Integer;
  CurX, CurY: Integer;
begin
  EditorManager.SetImageMouseMove(Sender, Shift, X, Y);

  XStart := UpDownLeft.Position;
  XEnd := UpDownRight.Position;
  YStart := UpDownTop.Position;
  YEnd := UpDownBottom.Position;

  CurX := Min(SelImage.Image.Texture[SelImage.SelTexture].Width,
    (X + SelImage.HPos) div SelImage.Zoom);
  CurY := Min(SelImage.Image.Texture[SelImage.SelTexture].Height,
    (Y + SelImage.VPos) div SelImage.Zoom);

  if SelImage.Image <> nil then
  begin
    if (ssLeft in Shift) then
    begin
      if XPos > CurX then
      begin
        XStart := CurX;
      end
      else
      begin
        XEnd := CurX;
      end;

      if YPos > CurY then
      begin
        YStart := CurY;
      end
      else
      begin
        YEnd := CurY;
      end;

      UpDownLeft.Position := XStart;
      UpDownRight.Position := XEnd;
      UpDownTop.Position := YStart;
      UpDownBottom.Position := YEnd;
    end;
  end;

  if (X > 430) and (ssLeft in Shift) then
  begin
    if Self.ScrollBarH.Position < Self.ScrollBarH.Max then
    begin
      Self.ScrollBarH.Position := Self.ScrollBarH.Position + 4;
    end;
  end;
  if (X < 20) and (ssLeft in Shift) then
  begin
    if Self.ScrollBarH.Position > Self.ScrollBarH.Min then
    begin
      Self.ScrollBarH.Position := Self.ScrollBarH.Position - 4;
    end;
  end;

  if (Y > 360) and (ssLeft in Shift) then
  begin
    if Self.ScrollBarV.Position < Self.ScrollBarV.Max then
    begin
      Self.ScrollBarV.Position := Self.ScrollBarV.Position + 4;
    end;
  end;
  if (Y < 20) and (ssLeft in Shift) then
  begin
    if Self.ScrollBarV.Position > Self.ScrollBarV.Min then
    begin
      Self.ScrollBarV.Position := Self.ScrollBarV.Position - 4;
    end;
  end;

end;

procedure TSetImageForm.PanelExampleMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  EditorManager.SetImageMouseUp(Sender, Button, Shift, X, Y);
end;

procedure TSetImageForm.PopupHelpClick(Sender: TObject);
var
  str: String;
begin
  Timer.Enabled := False;
  str := 'To select a rectangle area:' + #10#13 +
    '  - Press mouse Left button and drag cursor.' + #10#13 + #10#13 +
    'To adjust selected top and left edges:' + #10#13 +
    '  - Press Shift + mouse Left button and drag cursor.' + #10#13 + #10#13 +
    'To adjust selected bottom and right edges:' + #10#13 +
    '  - Press Ctrl + mouse Left button and drag cursor.';

  Application.MessageBox(PChar(str), 'How to select coordinates with mouse...',
    MB_OK + MB_ICONINFORMATION);

  Timer.Enabled := true;
end;

procedure TSetImageForm.PopupResetClick(Sender: TObject);
begin
  if SelImage.Image <> nil then
  begin
    UpDownLeft.Position := 0;
    UpDownTop.Position := 0;
    UpDownRight.Position := SelImage.Image.PatternSize.X;
    UpDownBottom.Position := SelImage.Image.PatternSize.Y;
  end
  else
  begin
    UpDownLeft.Position := 0;
    UpDownTop.Position := 0;
    UpDownRight.Position := 0;
    UpDownBottom.Position := 0;
  end;
end;

procedure TSetImageForm.RemoveClick(Sender: TObject);
var
  txt, ImageName: String;
  ImageIndex, ListIndex: Integer;
begin
  // Stop Timer
  Timer.Enabled := False;

  if ListBoxImages.ItemIndex <> -1 then
  begin
    ListIndex := ListBoxImages.ItemIndex;
    ImageName := ListBoxImages.Items[ListIndex];
    txt := 'The image "' + ImageName + '" is about to be deleted. Delete it?';
    if Application.MessageBox(PChar(txt), 'Question',
      MB_YESNO + MB_ICONQUESTION) = IDYES then
    begin
      ImageIndex := EditorManager.ControlManager.Images.IndexOf(ImageName);

      if (ImageIndex <> -1) then
      begin
        ListBoxImages.Items.Delete(ListIndex);
        ListBoxImages.ItemIndex := ListIndex - 1;

        EditorManager.ControlManager.Root.Images.Remove(ImageName);

        EditorManager.ControlManager.Images.Remove(ImageIndex);
      end;
    end;
  end;

  Self.SetDisplaySize;

  // restart timer
  Timer.Enabled := true;
end;

procedure TSetImageForm.ScrollBarHChange(Sender: TObject);
begin
  SelImage.HPos := ScrollBarH.Position;
end;

procedure TSetImageForm.ScrollBarVChange(Sender: TObject);
begin
  SelImage.VPos := ScrollBarV.Position;
end;

procedure TSetImageForm.SetDisplaySize;
begin
  Timer.Enabled := False;

  if (ListBoxImages.ItemIndex <> -1) then
  begin
    SelImage.Image := EditorManager.ControlManager.Images.Image
      [ListBoxImages.Items[ListBoxImages.ItemIndex]];
    SelImage.SelTexture := 0;
    SelImage.HPos := 0;
    SelImage.VPos := 0;
    SelImage.Zoom := 1;
    SelImage.SelPos := Rect(0, 0, SelImage.Image.PatternSize.X,
      SelImage.Image.PatternSize.Y);

    ScrollBarH.Min := 0;
    if SelImage.Image.Texture[0].Width * SelImage.Zoom > PanelExample.Width then
    begin
      ScrollBarH.Max := (SelImage.Image.Texture[0].Width * SelImage.Zoom) -
        PanelExample.Width;
      ScrollBarH.Enabled := true;
      ScrollBarH.SmallChange := ScrollBarH.Max div 8;
      ScrollBarH.LargeChange := ScrollBarH.Max div 4;
    end
    else
    begin
      ScrollBarH.Max := 0;
      ScrollBarH.Enabled := False;
    end;
    ScrollBarH.Position := 0;

    ScrollBarV.Min := 0;
    if SelImage.Image.Texture[0].Height * SelImage.Zoom > PanelExample.Height
    then
    begin
      ScrollBarV.Max := (SelImage.Image.Texture[0].Height * SelImage.Zoom) -
        PanelExample.Height;
      ScrollBarV.Enabled := true;
      ScrollBarV.SmallChange := ScrollBarV.Max div 8;
      ScrollBarV.LargeChange := ScrollBarV.Max div 4;
    end
    else
    begin
      ScrollBarV.Max := 0;
      ScrollBarV.Enabled := False;
    end;
    ScrollBarV.Position := 0;

    UpDownLeft.Min := 0;
    UpDownTop.Min := 0;
    UpDownRight.Min := 1;
    UpDownBottom.Min := 1;

    UpDownLeft.Max := SelImage.Image.Texture[0].Width - 1;
    UpDownTop.Max := SelImage.Image.Texture[0].Height - 1;
    UpDownRight.Max := SelImage.Image.Texture[0].Width;
    UpDownBottom.Max := SelImage.Image.Texture[0].Height;

    UpDownLeft.Position := SelImage.SelPos.Left;
    UpDownTop.Position := SelImage.SelPos.Top;
    UpDownRight.Position := SelImage.SelPos.Right;
    UpDownBottom.Position := SelImage.SelPos.Bottom;

    TrackBarZoom.Position := 1;

    GroupBoxPreview.Enabled := true;

    StatusBar1.Panels[0].Text := Format('Image size: %dx%d',
      [SelImage.Image.Texture[0].Width, SelImage.Image.Texture[0].Height]);
  end
  else
  begin
    SelImage.Image := nil;
    SelImage.SelTexture := 0;
    SelImage.HPos := 0;
    SelImage.VPos := 0;
    SelImage.Zoom := 1;
    SelImage.SelPos := Rect(0, 0, 0, 0);

    ScrollBarH.Min := 0;
    ScrollBarH.Max := 0;
    ScrollBarH.Position := 0;
    ScrollBarH.Enabled := False;

    ScrollBarV.Min := 0;
    ScrollBarV.Max := 0;
    ScrollBarV.Position := 0;
    ScrollBarV.Enabled := False;

    UpDownLeft.Min := 0;
    UpDownTop.Min := 0;
    UpDownRight.Min := 0;
    UpDownBottom.Min := 0;

    UpDownLeft.Max := 0;
    UpDownTop.Max := 0;
    UpDownRight.Max := 0;
    UpDownBottom.Max := 0;

    UpDownLeft.Position := SelImage.SelPos.Left;
    UpDownTop.Position := SelImage.SelPos.Top;
    UpDownRight.Position := SelImage.SelPos.Right;
    UpDownBottom.Position := SelImage.SelPos.Bottom;

    TrackBarZoom.Position := 1;

    GroupBoxPreview.Enabled := False;

    StatusBar1.Panels[0].Text := '';
  end;

  Timer.Enabled := true;
end;

procedure TSetImageForm.SetStatusBarSelectedSize;
begin
  if SelImage.Image <> nil then
  begin
    StatusBar1.Panels[1].Text := Format('Selected size: %dx%d',
      [SelImage.SelPos.Right - SelImage.SelPos.Left, SelImage.SelPos.Bottom -
      SelImage.SelPos.Top]);
  end
  else
  begin
    StatusBar1.Panels[1].Text := '';
  end;
end;

procedure TSetImageForm.TrackBarZoomChange(Sender: TObject);
begin
  if (ListBoxImages.ItemIndex <> -1) then
  begin
    SelImage.Zoom := TrackBarZoom.Position;

    if SelImage.Image.Texture[SelImage.SelTexture].Width * SelImage.Zoom >
      PanelExample.Width then
    begin
      ScrollBarH.Max := (SelImage.Image.Texture[SelImage.SelTexture].Width *
        SelImage.Zoom) - PanelExample.Width;
      ScrollBarH.Enabled := true;
      ScrollBarH.SmallChange := ScrollBarH.Max div 8;
      ScrollBarH.LargeChange := ScrollBarH.Max div 4;
    end
    else
    begin
      ScrollBarH.Max := 0;
      ScrollBarH.Enabled := False;
    end;
    ScrollBarH.Position := 0;

    ScrollBarV.Min := 0;
    if SelImage.Image.Texture[SelImage.SelTexture].Height * SelImage.Zoom >
      PanelExample.Height then
    begin
      ScrollBarV.Max := (SelImage.Image.Texture[SelImage.SelTexture].Height *
        SelImage.Zoom) - PanelExample.Height;
      ScrollBarV.Enabled := true;
      ScrollBarV.SmallChange := ScrollBarV.Max div 8;
      ScrollBarV.LargeChange := ScrollBarV.Max div 4;
    end
    else
    begin
      ScrollBarV.Max := 0;
      ScrollBarV.Enabled := False;
    end;
    ScrollBarV.Position := 0;
  end;
end;

end.
