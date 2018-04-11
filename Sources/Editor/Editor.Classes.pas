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
{  The Original Code is Editor.Classes.pas.                                    }
{                                                                              }
{  The Initial Developer of the Original Code is Marcos Gomes.                 }
{  Portions created by Marcos Gomes are Copyright (C) 2012, Marcos Gomes.      }
{  All Rights Reserved.                                                        }
{                                                                              }
{******************************************************************************}
{                                                                              }
{  Editor.Classes.pas                                   Modified: 05-Out-2012  }
{  --------------------------------------------------------------------------  }
{                                                                              }
{                 Implementation of Classes used by Editor                     }
{                                                                              }
{                                Version 1.02                                  }
{                                                                              }
{******************************************************************************}

unit Editor.Classes;

interface

uses
  Winapi.Windows, System.SysUtils, System.Classes, System.Types, System.TypInfo,
  Vcl.Controls, Vcl.Graphics, Vcl.Buttons, Vcl.Themes, Vcl.Forms,
  JvInspector, JvJCLUtils, JvThemes,
  // Asphyre Units
  AbstractDevices, AbstractCanvas, AsphyreImages, AsphyreFonts, AVTypeUtils,
  AsphyreTimer,
  // Tulip UI Units
  Tulip.UI.Types, Tulip.UI.Classes, Tulip.UI,
  // Editor Units
  Editor.SelectFillColorForm, Editor.SelectTextColorForm, Editor.SetTextForm,
  Editor.SetFontNameForm, Editor.SetImageForm, Editor.Types;

type
{$REGION 'TColorInspector'}
  TColorInspector = class(TJvCustomInspectorItem)
  private
    procedure DrawColor(ARect: TRect; MyColor: cardinal;
      const ACanvas: TCanvas);
  protected
    procedure SetFlags(const Value: TInspectorItemFlags); override;
    procedure Edit; override;
  public
    procedure DrawValue(const ACanvas: TCanvas); override;
    class procedure RegisterAsDefaultItem;
    class procedure UnregisterAsDefaultItem;
  end;
{$ENDREGION}
{$REGION 'TFillColorInspector'}

  TFillColorInspector = class(TJvInspectorClassItem)
  private
    FColor1: cardinal;
    FColor2: cardinal;
    FColor3: cardinal;
    FColor4: cardinal;
  protected
    procedure SetFlags(const Value: TInspectorItemFlags); override;
    procedure SetItemClassFlags(Value: TInspectorClassFlags); override;
    procedure Edit; override;
  public
    constructor Create(const AParent: TJvCustomInspectorItem;
      const AData: TJvCustomInspectorData); override;

    procedure DrawValue(const ACanvas: TCanvas); override;

    class procedure RegisterAsDefaultItem;
    class procedure UnregisterAsDefaultItem;
  end;
{$ENDREGION}
{$REGION 'TFontInspector'}

  TFontInspector = class(TJvInspectorStringItem)
  protected
    procedure SetFlags(const Value: TInspectorItemFlags); override;
    procedure Edit; override;
  public
    class procedure RegisterAsDefaultItem;
    class procedure UnregisterAsDefaultItem;
  end;
{$ENDREGION}
{$REGION 'TImageInspector'}

  TImageInspector = class(TJvInspectorClassItem)
  private
    FBottom: Integer;
    FImage: String;
    FLeft: Integer;
    FRight: Integer;
    FTop: Integer;
  protected
    procedure SetFlags(const Value: TInspectorItemFlags); override;
    procedure SetItemClassFlags(Value: TInspectorClassFlags); override;
    procedure Edit; override;
  public
    constructor Create(const AParent: TJvCustomInspectorItem;
      const AData: TJvCustomInspectorData); override;

    procedure DrawValue(const ACanvas: TCanvas); override;
    class procedure RegisterAsDefaultItem;
    class procedure UnregisterAsDefaultItem;
  end;
{$ENDREGION}
{$REGION 'TAStringListInspector'}

  TAStringListInspector = class(TJvInspectorClassItem)
  private
    FText: String;
  protected
    procedure SetFlags(const Value: TInspectorItemFlags); override;
    procedure SetItemClassFlags(Value: TInspectorClassFlags); override;
    procedure Edit; override;
  public
    constructor Create(const AParent: TJvCustomInspectorItem;
      const AData: TJvCustomInspectorData); override;

    procedure DrawValue(const ACanvas: TCanvas); override;
    class procedure RegisterAsDefaultItem;
    class procedure UnregisterAsDefaultItem;
  end;
{$ENDREGION}
{$REGION 'TTextColorInspector'}

  TTextColorInspector = class(TJvInspectorClassItem)
  private
    FColor1: cardinal;
    FColor2: cardinal;
  protected
    procedure SetFlags(const Value: TInspectorItemFlags); override;
    procedure SetItemClassFlags(Value: TInspectorClassFlags); override;
    procedure Edit; override;
  public
    constructor Create(const AParent: TJvCustomInspectorItem;
      const AData: TJvCustomInspectorData); override;

    procedure DrawValue(const ACanvas: TCanvas); override;
    class procedure RegisterAsDefaultItem;
    class procedure UnregisterAsDefaultItem;
  end;
{$ENDREGION}
{$REGION 'TTextInspector'}

  TTextInspector = class(TJvInspectorStringItem)
  private
  protected
    procedure SetFlags(const Value: TInspectorItemFlags); override;
    procedure Edit; override;
  public
    class procedure RegisterAsDefaultItem;
    class procedure UnregisterAsDefaultItem;
  end;
{$ENDREGION}

function SelectColor(out DestColor: cardinal; SrcColor: cardinal = 0): Boolean;
  external 'ColorSel.dll';

implementation

uses
  Editor.MainForm;

{$REGION 'TColorInspector'}
{ TColorInspector }

procedure TColorInspector.DrawColor(ARect: TRect; MyColor: cardinal;
  const ACanvas: TCanvas);
var
  ImageBmp: TBitmap;
  ColorBmp: TBitmap;
  i: Integer;
  j: Integer;
begin
  // Draw Color on Inspector
  // The code bellow is based on TAvColorBox by M. Sc. Yuriy Kotsarenko
  ColorBmp := TBitmap.Create;
  ImageBmp := TBitmap.Create;
  ColorBmp.Width := ARect.Right - ARect.Left;
  ColorBmp.Height := ARect.Bottom - ARect.Top;
  ColorBmp.PixelFormat := pf32bit;
  ImageBmp.Width := ColorBmp.Width;
  ImageBmp.Height := ColorBmp.Height;
  ImageBmp.PixelFormat := pf32bit;
  // draw grid
  with ImageBmp.Canvas do
  begin
    Brush.Style := bsSolid;
    for j := 0 to ColorBmp.Height div 4 do
      for i := 0 to ColorBmp.Width div 4 do
      begin
        Brush.Color := $4F6070;
        if ((i + j) and $1 = 0) then
          Brush.Color := $384450;
        FillRect(Bounds(i * 4, j * 4, 4, 4));
      end;
  end;
  // fill image with single color
  ClearBitmap(ColorBmp, MyColor or 4278190080);
  for i := 0 to ImageBmp.Height - 1 do
    RenderLineAlpha(ColorBmp.ScanLine[i], ImageBmp.ScanLine[i], ImageBmp.Width,
      MyColor shr 24);
  BitBlt(ACanvas.Handle, ARect.Left, ARect.Top, ImageBmp.Width, ImageBmp.Height,
    ImageBmp.Canvas.Handle, 0, 0, SRCCOPY);
  ColorBmp.Free;
  ImageBmp.Free;
end;

procedure TColorInspector.DrawValue(const ACanvas: TCanvas);
var
  MyColor: cardinal;
  R, ARect: TRect;
  BFlags: Integer;
  W, G, i: Integer;
begin
  if Assigned(Data) then
  begin
    ARect := Rects[iprEditValue];

    MyColor := DisplaceRB(Data.AsOrdinal);

    DrawColor(ARect, MyColor, ACanvas);
  end;

  // Draw EditButton
  R := Rects[iprEditButton];
  if not IsRectEmpty(R) then
  begin
    BFlags := 0;
    if iifEditButton in Flags then
    begin
      if Pressed then
        BFlags := BF_FLAT;
      if StyleServices.Enabled then
        DrawThemedButtonFace(Inspector, ACanvas, R, 0, bsNew, False, Pressed,
          False, False)
      else
        DrawEdge(ACanvas.Handle, R, EDGE_RAISED,
          BF_RECT or BF_MIDDLE or BFlags);
      W := 2;
      G := (RectWidth(R) - 2 * Ord(Pressed) - (3 * W)) div 4;
      if G < 1 then
      begin
        W := 1;
        G := (RectWidth(R) - 2 * Ord(Pressed) - (3 * W)) div 4;
      end;
      if G < 1 then
        G := 1;
      if G > 3 then
        G := 3;

      BFlags := R.Left + (RectWidth(R) - 3 * W - 2 * G) div 2 + Ord(Pressed);
      i := R.Top + (RectHeight(R) - W) div 2;
      PatBlt(ACanvas.Handle, BFlags, i, W, W, BLACKNESS);
      PatBlt(ACanvas.Handle, BFlags + G + W, i, W, W, BLACKNESS);
      PatBlt(ACanvas.Handle, BFlags + 2 * G + 2 * W, i, W, W, BLACKNESS);
    end;
  end;
end;

procedure TColorInspector.Edit;
var
  DestColor: cardinal;
begin
  if Assigned(Data) then
  begin
    Timer.Enabled := False;

    if SelectColor(DestColor, Data.AsOrdinal) then
    begin
      Data.AsOrdinal := DestColor;
    end;

    Timer.Enabled := True;
  end;
end;

class procedure TColorInspector.RegisterAsDefaultItem;
begin
  with TJvCustomInspectorData.ItemRegister do
  begin
    if IndexOf(Self) = -1 then
    begin
      Add(TJvInspectorPropRegItem.Create(Self, TActiveBorder, 'Color', nil));
      Add(TJvInspectorPropRegItem.Create(Self, TActiveBorder,
        'ColorHover', nil));
      Add(TJvInspectorPropRegItem.Create(Self, TActiveBorder,
        'ColorPressed', nil));
      Add(TJvInspectorPropRegItem.Create(Self, TBorder, 'Color', nil));
      Add(TJvInspectorPropRegItem.Create(Self, TCkBox, 'CheckedColor', nil));
    end;
  end;
end;

procedure TColorInspector.SetFlags(const Value: TInspectorItemFlags);
begin
  inherited SetFlags(Value + [iifEditButton, iifReadonly]);
end;

class procedure TColorInspector.UnregisterAsDefaultItem;
begin
  TJvCustomInspectorData.ItemRegister.Delete(Self);
end;
{$ENDREGION}
{$REGION 'TFillColorInspector'}
{ TFillColorInspector }

constructor TFillColorInspector.Create(const AParent: TJvCustomInspectorItem;
  const AData: TJvCustomInspectorData);
begin
  inherited Create(AParent, AData);

  if Assigned(Data) then
  begin
    Self.CreateMembers;
    FColor1 := Self.GetItems(2).Data.AsOrdinal;
    FColor2 := Self.GetItems(3).Data.AsOrdinal;
    FColor3 := Self.GetItems(0).Data.AsOrdinal;
    FColor4 := Self.GetItems(1).Data.AsOrdinal;
    Self.DeleteMembers;
  end;
end;

procedure TFillColorInspector.DrawValue(const ACanvas: TCanvas);
var
  c1, c2, c3, c4: cardinal;
  R, ARect: TRect;
  BFlags: Integer;
  W, G, i: Integer;
begin

  if Assigned(Data) then
  begin
    ARect := Rects[iprEditValue];

    c1 := DisplaceRB(FColor1);
    c2 := DisplaceRB(FColor2);
    c3 := DisplaceRB(FColor3);
    c4 := DisplaceRB(FColor4);

    AVFillQuad(ACanvas.Handle, AVBounds4(ARect.Left, ARect.Top, ARect.Width,
      ARect.Height), AVColor4(c1, c2, c4, c3));
  end;

  // Draw EditButton
  R := Rects[iprEditButton];
  if not IsRectEmpty(R) then
  begin
    BFlags := 0;
    if iifEditButton in Flags then
    begin
      if Pressed then
        BFlags := BF_FLAT;
      if StyleServices.Enabled then
        DrawThemedButtonFace(Inspector, ACanvas, R, 0, bsNew, False, Pressed,
          False, False)
      else
        DrawEdge(ACanvas.Handle, R, EDGE_RAISED,
          BF_RECT or BF_MIDDLE or BFlags);
      W := 2;
      G := (RectWidth(R) - 2 * Ord(Pressed) - (3 * W)) div 4;
      if G < 1 then
      begin
        W := 1;
        G := (RectWidth(R) - 2 * Ord(Pressed) - (3 * W)) div 4;
      end;
      if G < 1 then
        G := 1;
      if G > 3 then
        G := 3;

      BFlags := R.Left + (RectWidth(R) - 3 * W - 2 * G) div 2 + Ord(Pressed);
      i := R.Top + (RectHeight(R) - W) div 2;
      PatBlt(ACanvas.Handle, BFlags, i, W, W, BLACKNESS);
      PatBlt(ACanvas.Handle, BFlags + G + W, i, W, W, BLACKNESS);
      PatBlt(ACanvas.Handle, BFlags + 2 * G + 2 * W, i, W, W, BLACKNESS);
    end;
  end;
end;

// ----------------------------------------------------------------------------
procedure TFillColorInspector.Edit;

begin

  if Assigned(Data) then
  begin
    Timer.Enabled := False;

    SelectFillColorForm.Color1 := FColor1;
    SelectFillColorForm.Color2 := FColor2;
    SelectFillColorForm.Color3 := FColor3;
    SelectFillColorForm.Color4 := FColor4;
    SelectFillColorForm.GetColors;

    if SelectFillColorForm.ShowModal = mrOk then
    begin
      FColor1 := SelectFillColorForm.Color1;
      FColor2 := SelectFillColorForm.Color2;
      FColor3 := SelectFillColorForm.Color3;
      FColor4 := SelectFillColorForm.Color4;

      Self.CreateMembers;
      Self.GetItems(2).Data.AsOrdinal := FColor1;
      Self.GetItems(3).Data.AsOrdinal := FColor2;
      Self.GetItems(0).Data.AsOrdinal := FColor3;
      Self.GetItems(1).Data.AsOrdinal := FColor4;
      Self.DeleteMembers;
    end;

    Timer.Enabled := True;
  end;

end;

class procedure TFillColorInspector.RegisterAsDefaultItem;
begin
  with TJvCustomInspectorData.ItemRegister do
  begin
    if IndexOf(Self) = -1 then
    begin
      Add(TJvInspectorPropRegItem.Create(Self, TAForm, 'Color', nil));
      Add(TJvInspectorPropRegItem.Create(Self, TALabel, 'Color', nil));
      Add(TJvInspectorPropRegItem.Create(Self, TAPanel, 'Color', nil));
      Add(TJvInspectorPropRegItem.Create(Self, TAButton, 'Color', nil));
      Add(TJvInspectorPropRegItem.Create(Self, TAButton, 'ColorHover', nil));
      Add(TJvInspectorPropRegItem.Create(Self, TAButton, 'ColorPressed', nil));
      Add(TJvInspectorPropRegItem.Create(Self, TAEditbox, 'Color', nil));
      Add(TJvInspectorPropRegItem.Create(Self, TAImage, 'Color', nil));
      Add(TJvInspectorPropRegItem.Create(Self, TACheckBox, 'Color', nil));
      Add(TJvInspectorPropRegItem.Create(Self, TARadioButton, 'Color', nil));
      Add(TJvInspectorPropRegItem.Create(Self, TCkBox, 'Color', nil));
      Add(TJvInspectorPropRegItem.Create(Self, TAProgressBar, 'Color', nil));
      Add(TJvInspectorPropRegItem.Create(Self, TAProgressBar,
        'ProgressColor', nil));
      Add(TJvInspectorPropRegItem.Create(Self, TATrackBar, 'Color', nil));
      Add(TJvInspectorPropRegItem.Create(Self, TBtBox, 'Color', nil));
      Add(TJvInspectorPropRegItem.Create(Self, TBtBox, 'ColorHover', nil));
      Add(TJvInspectorPropRegItem.Create(Self, TBtBox, 'ColorPressed', nil));
      Add(TJvInspectorPropRegItem.Create(Self, TAListBox, 'Color', nil));
    end;
  end;
end;

procedure TFillColorInspector.SetFlags(const Value: TInspectorItemFlags);
begin
  inherited SetFlags(Value + [iifEditButton, iifReadonly]);
end;

procedure TFillColorInspector.SetItemClassFlags(Value: TInspectorClassFlags);
begin
  inherited SetItemClassFlags(Value - [icfShowClassName, icfCreateMemberItems]);
end;

class procedure TFillColorInspector.UnregisterAsDefaultItem;
begin
  TJvCustomInspectorData.ItemRegister.Delete(Self);
end;

{$ENDREGION}
{$REGION 'TFontInspector'}
{ TFontInspector }

procedure TFontInspector.Edit;
var
  i: Integer;
  control: TAControlManager;
begin
  inherited;

  control := EditorManager.ControlManager;

  SetFontNameForm.ListBox1.Clear;
  for i := 0 to control.Root.Fonts.Count - 1 do
  begin
    SetFontNameForm.ListBox1.Items.Add(control.Root.Fonts.Items[i]);
  end;

  if Assigned(Data) then
  begin
    Timer.Enabled := False;

    SetFontNameForm.ListBox1.ItemIndex := SetFontNameForm.ListBox1.Items.IndexOf
      (Data.AsString);

    EditorManager.RenderTarget := rtFontPreview;
    if SetFontNameForm.ShowModal = mrOk then
    begin
      if SetFontNameForm.ListBox1.Count > 0 then
      begin
        Data.AsString := SetFontNameForm.ListBox1.Items
          [SetFontNameForm.ListBox1.ItemIndex];
      end
      else
      begin
        Data.AsString := '';
      end;
    end;
    EditorManager.RenderTarget := rtDesignPanel;

    Timer.Enabled := True;
  end;
end;

class procedure TFontInspector.RegisterAsDefaultItem;
begin
  with TJvCustomInspectorData.ItemRegister do
  begin
    if IndexOf(Self) = -1 then
    begin
      Add(TJvInspectorPropRegItem.Create(Self, TActiveFormatedFont,
        'Name', nil));
      Add(TJvInspectorPropRegItem.Create(Self, TFormatedFont, 'Name', nil));
      Add(TJvInspectorPropRegItem.Create(Self, TEditFont, 'Name', nil));
    end;
  end;
end;

procedure TFontInspector.SetFlags(const Value: TInspectorItemFlags);
begin
  inherited SetFlags(Value + [iifEditButton, iifEditFixed]);
end;

class procedure TFontInspector.UnregisterAsDefaultItem;
begin
  TJvCustomInspectorData.ItemRegister.Delete(Self);
end;
{$ENDREGION}
{$REGION 'TImageInspector'}
{ TImageInspector }

constructor TImageInspector.Create(const AParent: TJvCustomInspectorItem;
  const AData: TJvCustomInspectorData);
begin
  inherited Create(AParent, AData);

  if Assigned(Data) then
  begin
    Self.CreateMembers;
    FBottom := Self.GetItems(0).Data.AsOrdinal;
    FImage := Self.GetItems(1).Data.AsString;
    FLeft := Self.GetItems(2).Data.AsOrdinal;
    FRight := Self.GetItems(3).Data.AsOrdinal;
    FTop := Self.GetItems(4).Data.AsOrdinal;
    Self.DeleteMembers;
  end;
end;

procedure TImageInspector.DrawValue(const ACanvas: TCanvas);
var
  R, ARect: TRect;
  BFlags: Integer;
  W, G, i: Integer;
begin

  if Assigned(Data) then
  begin
    ARect := Rects[iprEditValue];
    ACanvas.TextRect(ARect, FImage);
  end;

  // Draw EditButton
  R := Rects[iprEditButton];
  if not IsRectEmpty(R) then
  begin
    BFlags := 0;
    if iifEditButton in Flags then
    begin
      if Pressed then
        BFlags := BF_FLAT;
      if StyleServices.Enabled then
        DrawThemedButtonFace(Inspector, ACanvas, R, 0, bsNew, False, Pressed,
          False, False)
      else
        DrawEdge(ACanvas.Handle, R, EDGE_RAISED,
          BF_RECT or BF_MIDDLE or BFlags);
      W := 2;
      G := (RectWidth(R) - 2 * Ord(Pressed) - (3 * W)) div 4;
      if G < 1 then
      begin
        W := 1;
        G := (RectWidth(R) - 2 * Ord(Pressed) - (3 * W)) div 4;
      end;
      if G < 1 then
        G := 1;
      if G > 3 then
        G := 3;

      BFlags := R.Left + (RectWidth(R) - 3 * W - 2 * G) div 2 + Ord(Pressed);
      i := R.Top + (RectHeight(R) - W) div 2;
      PatBlt(ACanvas.Handle, BFlags, i, W, W, BLACKNESS);
      PatBlt(ACanvas.Handle, BFlags + G + W, i, W, W, BLACKNESS);
      PatBlt(ACanvas.Handle, BFlags + 2 * G + 2 * W, i, W, W, BLACKNESS);
    end;
  end;
end;

procedure TImageInspector.Edit;
var
  i: Integer;
  control: TAControlManager;
  Form: TSetImageForm;
begin
  inherited;
  // Define Controls
  control := EditorManager.ControlManager;
  Form := SetImageForm;

  // Clear list images and refill it
  Form.ListBoxImages.Clear;
  for i := 0 to control.Root.Images.Count - 1 do
  begin
    Form.ListBoxImages.Items.Add(control.Root.Images.Items[i]);
  end;

  if Assigned(Data) then
  begin
    Timer.Enabled := False;

    EditorManager.RenderTarget := rtImagePreview;

    Form.ListBoxImages.ItemIndex := Form.ListBoxImages.Items.IndexOf(FImage);

    Form.SetDisplaySize;

    Form.UpDownLeft.Position := FLeft;
    Form.UpDownTop.Position := FTop;
    Form.UpDownRight.Position := FRight;
    Form.UpDownBottom.Position := FBottom;

    Form.ShowModal;

    // user selected an image
    if Form.ModalResult = mrOk then
    begin
      if Form.ListBoxImages.Count > 0 then
      begin
        FImage := Form.ListBoxImages.Items[Form.ListBoxImages.ItemIndex];
        FLeft := Form.SelImage.SelPos.Left;
        FTop := Form.SelImage.SelPos.Top;
        FRight := Form.SelImage.SelPos.Right;
        FBottom := Form.SelImage.SelPos.Bottom;

        Self.CreateMembers;
        Self.GetItems(0).Data.AsOrdinal := FBottom;
        Self.GetItems(1).Data.AsString := FImage;
        Self.GetItems(2).Data.AsOrdinal := FLeft;
        Self.GetItems(3).Data.AsOrdinal := FRight;
        Self.GetItems(4).Data.AsOrdinal := FTop;

        Self.DeleteMembers;
      end
      else
      begin
        FImage := '';
        FLeft := 0;
        FTop := 0;
        FRight := 0;
        FBottom := 0;

        Self.CreateMembers;
        Self.GetItems(0).Data.AsOrdinal := FBottom;
        Self.GetItems(1).Data.AsString := FImage;
        Self.GetItems(2).Data.AsOrdinal := FLeft;
        Self.GetItems(3).Data.AsOrdinal := FRight;
        Self.GetItems(4).Data.AsOrdinal := FTop;
        Self.DeleteMembers;
      end;
    end;

    // User selected no image.
    if Form.ModalResult = mrNo then
    begin
      FImage := '';
      FLeft := 0;
      FTop := 0;
      FRight := 0;
      FBottom := 0;

      Self.CreateMembers;
      Self.GetItems(0).Data.AsOrdinal := FBottom;
      Self.GetItems(1).Data.AsString := FImage;
      Self.GetItems(2).Data.AsOrdinal := FLeft;
      Self.GetItems(3).Data.AsOrdinal := FRight;
      Self.GetItems(4).Data.AsOrdinal := FTop;
      Self.DeleteMembers;
    end;

    EditorManager.RenderTarget := rtDesignPanel;

    Timer.Enabled := True;
  end;
end;

class procedure TImageInspector.RegisterAsDefaultItem;
begin
  with TJvCustomInspectorData.ItemRegister do
  begin
    if IndexOf(Self) = -1 then
    begin
      Add(TJvInspectorPropRegItem.Create(Self, TAForm, 'Image', nil));
      Add(TJvInspectorPropRegItem.Create(Self, TAPanel, 'Image', nil));
      Add(TJvInspectorPropRegItem.Create(Self, TALabel, 'Image', nil));
      Add(TJvInspectorPropRegItem.Create(Self, TAImage, 'Image', nil));
      Add(TJvInspectorPropRegItem.Create(Self, TAButton, 'Image', nil));
      Add(TJvInspectorPropRegItem.Create(Self, TAButton, 'ImageHover', nil));
      Add(TJvInspectorPropRegItem.Create(Self, TAButton, 'ImagePressed', nil));
      Add(TJvInspectorPropRegItem.Create(Self, TAEditbox, 'Image', nil));
      Add(TJvInspectorPropRegItem.Create(Self, TCkBox, 'Image', nil));
      Add(TJvInspectorPropRegItem.Create(Self, TCkBox, 'CheckedImage', nil));
      Add(TJvInspectorPropRegItem.Create(Self, TACheckBox, 'Image', nil));
      Add(TJvInspectorPropRegItem.Create(Self, TARadioButton, 'Image', nil));
      Add(TJvInspectorPropRegItem.Create(Self, TAProgressBar, 'Image', nil));
      Add(TJvInspectorPropRegItem.Create(Self, TATrackBar, 'Image', nil));
      Add(TJvInspectorPropRegItem.Create(Self, TBtBox, 'Image', nil));
      Add(TJvInspectorPropRegItem.Create(Self, TBtBox, 'ImageHover', nil));
      Add(TJvInspectorPropRegItem.Create(Self, TBtBox, 'ImagePressed', nil));
      Add(TJvInspectorPropRegItem.Create(Self, TAListBox, 'Image', nil));
    end;
  end;
end;

procedure TImageInspector.SetFlags(const Value: TInspectorItemFlags);
begin
  inherited SetFlags(Value + [iifEditButton, iifReadonly]);
end;

procedure TImageInspector.SetItemClassFlags(Value: TInspectorClassFlags);
begin
  inherited SetItemClassFlags(Value - [icfShowClassName, icfCreateMemberItems]);
end;

class procedure TImageInspector.UnregisterAsDefaultItem;
begin
  TJvCustomInspectorData.ItemRegister.Delete(Self);
end;
{$ENDREGION}
{$REGION 'TAStringListInspector'}
{ TAStringListInspector }

constructor TAStringListInspector.Create(const AParent: TJvCustomInspectorItem;
  const AData: TJvCustomInspectorData);
begin
  inherited Create(AParent, AData);

  if Assigned(Data) then
  begin
    Self.CreateMembers;
    FText := Self.GetItems(0).Data.AsString;
    Self.DeleteMembers;
  end;
end;

procedure TAStringListInspector.DrawValue(const ACanvas: TCanvas);
var
  R, ARect: TRect;
  BFlags: Integer;
  W, G, i: Integer;
begin

  if Assigned(Data) then
  begin
    ARect := Rects[iprEditValue];
    ACanvas.TextRect(ARect, FText);
  end;

  // Draw EditButton
  R := Rects[iprEditButton];
  if not IsRectEmpty(R) then
  begin
    BFlags := 0;
    if iifEditButton in Flags then
    begin
      if Pressed then
        BFlags := BF_FLAT;
      if StyleServices.Enabled then
        DrawThemedButtonFace(Inspector, ACanvas, R, 0, bsNew, False, Pressed,
          False, False)
      else
        DrawEdge(ACanvas.Handle, R, EDGE_RAISED,
          BF_RECT or BF_MIDDLE or BFlags);
      W := 2;
      G := (RectWidth(R) - 2 * Ord(Pressed) - (3 * W)) div 4;
      if G < 1 then
      begin
        W := 1;
        G := (RectWidth(R) - 2 * Ord(Pressed) - (3 * W)) div 4;
      end;
      if G < 1 then
        G := 1;
      if G > 3 then
        G := 3;

      BFlags := R.Left + (RectWidth(R) - 3 * W - 2 * G) div 2 + Ord(Pressed);
      i := R.Top + (RectHeight(R) - W) div 2;
      PatBlt(ACanvas.Handle, BFlags, i, W, W, BLACKNESS);
      PatBlt(ACanvas.Handle, BFlags + G + W, i, W, W, BLACKNESS);
      PatBlt(ACanvas.Handle, BFlags + 2 * G + 2 * W, i, W, W, BLACKNESS);
    end;
  end;
end;

procedure TAStringListInspector.Edit;
var
  Form: TSetTextForm;
begin
  inherited;
  // Define Controls
  Form := SetTextForm;

  if Assigned(Data) then
  begin
    Timer.Enabled := False;

    Form.Memo1.Text := FText;

    Form.ShowModal;

    if Form.ModalResult = mrOk then
    begin
      FText := Form.Memo1.Text;

      Self.CreateMembers;
      Self.GetItems(0).Data.AsString := FText;
      Self.DeleteMembers;
    end;

    Timer.Enabled := True;
  end;
end;

class procedure TAStringListInspector.RegisterAsDefaultItem;
begin
  with TJvCustomInspectorData.ItemRegister do
  begin
    if IndexOf(Self) = -1 then
    begin
      Add(TJvInspectorPropRegItem.Create(Self, TAListBox, 'Lines', nil));
    end;
  end;
end;

procedure TAStringListInspector.SetFlags(const Value: TInspectorItemFlags);
begin
  inherited SetFlags(Value + [iifEditButton, iifReadonly]);
end;

procedure TAStringListInspector.SetItemClassFlags(Value: TInspectorClassFlags);
begin
  inherited SetItemClassFlags(Value - [icfShowClassName, icfCreateMemberItems]);
end;

class procedure TAStringListInspector.UnregisterAsDefaultItem;
begin
  TJvCustomInspectorData.ItemRegister.Delete(Self);
end;
{$ENDREGION}
{$REGION 'TTextColorInspector'}
{ TTextColorInspector }

constructor TTextColorInspector.Create(const AParent: TJvCustomInspectorItem;
  const AData: TJvCustomInspectorData);
begin
  inherited;

  if Assigned(Data) then
  begin
    Self.CreateMembers;
    FColor1 := Self.GetItems(1).Data.AsOrdinal;
    FColor2 := Self.GetItems(0).Data.AsOrdinal;
    Self.DeleteMembers;
  end;

end;

procedure TTextColorInspector.DrawValue(const ACanvas: TCanvas);
var
  c1, c2: cardinal;
  R, ARect: TRect;
  BFlags: Integer;
  W, G, i: Integer;
begin

  if Assigned(Data) then
  begin
    ARect := Rects[iprEditValue];

    c1 := DisplaceRB(FColor1);
    c2 := DisplaceRB(FColor2);

    AVFillRectV(ACanvas.Handle, ARect, c1, c2);
  end;

  // Draw EditButton
  R := Rects[iprEditButton];
  if not IsRectEmpty(R) then
  begin
    BFlags := 0;
    if iifEditButton in Flags then
    begin
      if Pressed then
        BFlags := BF_FLAT;
      if StyleServices.Enabled then
        DrawThemedButtonFace(Inspector, ACanvas, R, 0, bsNew, False, Pressed,
          False, False)
      else
        DrawEdge(ACanvas.Handle, R, EDGE_RAISED,
          BF_RECT or BF_MIDDLE or BFlags);
      W := 2;
      G := (RectWidth(R) - 2 * Ord(Pressed) - (3 * W)) div 4;
      if G < 1 then
      begin
        W := 1;
        G := (RectWidth(R) - 2 * Ord(Pressed) - (3 * W)) div 4;
      end;
      if G < 1 then
        G := 1;
      if G > 3 then
        G := 3;

      BFlags := R.Left + (RectWidth(R) - 3 * W - 2 * G) div 2 + Ord(Pressed);
      i := R.Top + (RectHeight(R) - W) div 2;
      PatBlt(ACanvas.Handle, BFlags, i, W, W, BLACKNESS);
      PatBlt(ACanvas.Handle, BFlags + G + W, i, W, W, BLACKNESS);
      PatBlt(ACanvas.Handle, BFlags + 2 * G + 2 * W, i, W, W, BLACKNESS);
    end;
  end;
end;

procedure TTextColorInspector.Edit;
begin
  if Assigned(Data) then
  begin
    Timer.Enabled := False;

    SelectTextColorForm.Color1 := FColor1;
    SelectTextColorForm.Color2 := FColor2;
    SelectTextColorForm.GetColors;

    if SelectTextColorForm.ShowModal = mrOk then
    begin
      FColor1 := SelectTextColorForm.Color1;
      FColor2 := SelectTextColorForm.Color2;

      Self.CreateMembers;
      Self.GetItems(1).Data.AsOrdinal := FColor1;
      Self.GetItems(0).Data.AsOrdinal := FColor2;
      Self.DeleteMembers;
    end;

    Timer.Enabled := True;
  end;
end;

class procedure TTextColorInspector.RegisterAsDefaultItem;
begin
  with TJvCustomInspectorData.ItemRegister do
  begin
    if IndexOf(Self) = -1 then
    begin
      Add(TJvInspectorPropRegItem.Create(Self, TActiveFormatedFont,
        'Color', nil));
      Add(TJvInspectorPropRegItem.Create(Self, TActiveFormatedFont,
        'ColorHover', nil));
      Add(TJvInspectorPropRegItem.Create(Self, TActiveFormatedFont,
        'ColorPressed', nil));
      Add(TJvInspectorPropRegItem.Create(Self, TFormatedFont, 'Color', nil));
      Add(TJvInspectorPropRegItem.Create(Self, TEditFont, 'Color', nil));
      Add(TJvInspectorPropRegItem.Create(Self, TEditFont,
        'SelectionColor', nil));
    end;
  end;
end;

procedure TTextColorInspector.SetFlags(const Value: TInspectorItemFlags);
begin
  inherited SetFlags(Value + [iifEditButton, iifReadonly]);

end;

procedure TTextColorInspector.SetItemClassFlags(Value: TInspectorClassFlags);
begin
  inherited SetItemClassFlags(Value - [icfShowClassName, icfCreateMemberItems]);
end;

class procedure TTextColorInspector.UnregisterAsDefaultItem;
begin
  TJvCustomInspectorData.ItemRegister.Delete(Self);
end;

{$ENDREGION}
{$REGION 'TTextInspector'}
{ TTextInspector }

procedure TTextInspector.Edit;
begin
  inherited;
  if Assigned(Data) then
  begin
    Timer.Enabled := False;

    SetTextForm.Memo1.Text := Data.AsString;
    if SetTextForm.ShowModal = mrOk then
    begin
      Data.AsString := SetTextForm.Memo1.Text;
    end;

    Timer.Enabled := True;
  end;
end;

class procedure TTextInspector.RegisterAsDefaultItem;
begin
  with TJvCustomInspectorData.ItemRegister do
  begin
    if IndexOf(Self) = -1 then
    begin
      Add(TJvInspectorPropRegItem.Create(Self, nil, 'Caption', nil));
    end;
  end;
end;

procedure TTextInspector.SetFlags(const Value: TInspectorItemFlags);
begin
  inherited SetFlags(Value + [iifEditButton]);
end;

class procedure TTextInspector.UnregisterAsDefaultItem;
begin
  TJvCustomInspectorData.ItemRegister.Delete(Self);
end;
{$ENDREGION}

initialization

TColorInspector.RegisterAsDefaultItem;
TFillColorInspector.RegisterAsDefaultItem;
TFontInspector.RegisterAsDefaultItem;
TImageInspector.RegisterAsDefaultItem;
TAStringListInspector.RegisterAsDefaultItem;
TTextColorInspector.RegisterAsDefaultItem;
TTextInspector.RegisterAsDefaultItem;

finalization

TColorInspector.UnregisterAsDefaultItem;
TFillColorInspector.UnregisterAsDefaultItem;
TFontInspector.UnregisterAsDefaultItem;
TImageInspector.UnregisterAsDefaultItem;
TAStringListInspector.UnregisterAsDefaultItem;
TTextColorInspector.UnregisterAsDefaultItem;
TTextInspector.UnregisterAsDefaultItem;

end.
