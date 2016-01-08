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
{  The Original Code is Tulip.UI.EditBoxes.pas.                                }
{                                                                              }
{  The Initial Developer of the Original Code is Marcos Gomes.                 }
{  Portions created by Marcos Gomes are Copyright (C) 2012, Marcos Gomes.      }
{  All Rights Reserved.                                                        }
{                                                                              }
{******************************************************************************}
{                                                                              }
{  Tulip.UI.EditBoxes.pas                               Modified: 23-Mar-2013  }
{  --------------------------------------------------------------------------  }
{                                                                              }
{                   Base Implementations for EditBox Controls                  }
{                                                                              }
{                                Version 1.03                                  }
{                                                                              }
{******************************************************************************}

unit Tulip.UI.EditBoxes;

interface

uses
  Winapi.Windows, System.SysUtils, System.Classes, System.Math,
  // PXL units
  PXL.Canvas,
  PXL.Fonts,
  PXL.Images,
  PXL.Types,
  // Tulip UI Units
  Tulip.UI.Types, Tulip.UI.Classes, Tulip.UI.Controls, Tulip.UI.Helpers,
  Tulip.UI.Utils;

type
{$REGION 'TCustomAEditBox'}
  TCustomAEditBox = class(TWControl)
  private
    FAntialiased: Boolean;
    FAutoSelect: Boolean;
    FBorder: TBorder;
    FColor: TFillColor;
    FFocusRect: TFocusRect;
    FFont: TEditFont;
    FImage: TImage;
    FMargin: Word;
    FMaxLength: Integer;
    FOnChange: TNotifyEvent;
    FReadOnly: Boolean;
    FSelection: TSelection;
    FText: String;
    FVirtualPosition: Integer;

    function GetTic: Integer;

    procedure SetAntialiased(Value: Boolean);
    procedure SetAutoSelect(Value: Boolean);
    procedure SetBorder(Value: TBorder);
    procedure SetColor(Value: TFillColor);
    procedure SetFocusRect(Value: TFocusRect);
    procedure SetFont(Value: TEditFont);
    procedure SetImage(Value: TImage);
    procedure SetMargin(Value: Word);
    procedure SetMaxLength(Value: Integer);
    procedure SetReadOnly(Value: Boolean);

    // procedure SetSelLength(Value: Integer);
    // procedure SetSelStart(Value: Integer);
    // procedure SetSelText(Value: String);

    procedure SetText(Value: String);
  protected
    procedure AssignTo(Dest: TPersistent); override;
    procedure Change; dynamic;
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function GetSelLength: Integer;
    function GetSelStart: Integer;
    function GetSelText: string;

    procedure Clear;
    procedure ClearSelection;

    procedure CopyToClipboard;
    procedure CutToClipboard;
    procedure PasteFromClipboard;
    procedure SelectAll;

    procedure DoEnter; override;
    procedure DoExit; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure MouseEnter; override;
    procedure MouseLeave; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;

    property Antialiased: Boolean read FAntialiased write SetAntialiased;
    property AutoSelect: Boolean read FAutoSelect write SetAutoSelect;
    property Border: TBorder read FBorder write SetBorder;
    property Color: TFillColor read FColor write SetColor;
    property FocusRect: TFocusRect read FFocusRect write SetFocusRect;
    property Font: TEditFont read FFont write SetFont;
    property Image: TImage read FImage write SetImage;
    property Margin: Word read FMargin write SetMargin;
    property MaxLength: Integer read FMaxLength write SetMaxLength;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property ReadOnly: Boolean read FReadOnly write SetReadOnly;
    property Text: String read FText write SetText;
  end;
{$ENDREGION}

implementation

uses
  Tulip.UI;

var
  Tic: Byte;
  Counter: Cardinal;

{$REGION 'TCustomAEditBox'}
  { TCustomAEditBox }

procedure TCustomAEditBox.AssignTo(Dest: TPersistent);
begin
  ControlState := ControlState + [csReadingState];

  inherited AssignTo(Dest);

  if Dest is TCustomAEditBox then
    with TCustomAEditBox(Dest) do
    begin
      Antialiased := Self.Antialiased;
      AutoSelect := Self.AutoSelect;
      Border := Self.Border;
      Color := Self.Color;
      FocusRect := Self.FocusRect;
      Font := Self.Font;
      Image := Self.Image;
      MaxLength := Self.MaxLength;
      ReadOnly := Self.ReadOnly;
      Text := Self.Text;
    end;

  ControlState := ControlState - [csReadingState];
end;

procedure TCustomAEditBox.Change;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

procedure TCustomAEditBox.Clear;
begin
  Text := '';
  Change;
end;

procedure TCustomAEditBox.ClearSelection;
begin
  FSelection.StartPos := 0;
  FSelection.EndPos := 0;
end;

procedure TCustomAEditBox.CopyToClipboard;
begin
  (ControlManager as TAControlManager).GetClipboard.SetTextBuf
    (PChar(GetSelText));
end;

constructor TCustomAEditBox.Create(AOwner: TComponent);
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
      while AOwner.FindComponent('EditBox' + IntToStr(Num)) <> nil do
        Inc(Num);
      Name := 'EditBox' + IntToStr(Num);
    end;
  end;

  FAntialiased := True;
  FAutoSelect := True;
  FBorder := TBorder.Create;
  FBorder.Color := $B0FFFFFF;
  FBorder.Size := 1;
  FColor := TFillColor.Create($FF4090F0, $FF4090F0, $FF6EAAF4, $FF6EAAF4);
  FFocusRect := fDark;
  FFont := TEditFont.Create;
  FImage := TImage.Create;
  FMargin := 2;
  FMaxLength := 0;
  FReadOnly := False;
  FSelection.StartPos := 0;
  FSelection.EndPos := 0;
  FText := '';

  // Properties
  Left := 0;
  Top := 0;
  Width := 120;
  Height := 24;
  TabStop := True;
  Visible := True;

  Tic := 0;
  Counter := GetTickCount;

  ControlState := ControlState - [csCreating];
end;

procedure TCustomAEditBox.CutToClipboard;
var
  AText: String;
  AMin, AMax, ALength: Integer;
begin
  // Set initial values
  AText := Text;

  AMin := Min(FSelection.StartPos, FSelection.EndPos);
  AMax := Max(FSelection.StartPos, FSelection.EndPos);

  ALength := AMax - AMin;

  // Copy to Clipboard
  CopyToClipboard;

  Delete(AText, AMin + 1, ALength);
  Text := AText;
  // Execute OnChange Event
  Change;

  FSelection.StartPos := AMin;
  FSelection.EndPos := AMin;
end;

destructor TCustomAEditBox.Destroy;
begin
  FBorder.Free;
  FColor.Free;
  FFont.Free;
  FImage.Free;

  inherited;
end;

procedure TCustomAEditBox.DoEnter;
begin
  Tic := 0;

  if FAutoSelect then
    SelectAll;

  inherited;
end;

procedure TCustomAEditBox.DoExit;
begin
  ClearSelection;
  inherited;
end;

function TCustomAEditBox.GetSelLength: Integer;
var
  AMin, AMax: Integer;
begin
  AMin := Min(FSelection.StartPos, FSelection.EndPos);
  AMax := Max(FSelection.StartPos, FSelection.EndPos);

  Result := AMax - AMin;
end;

function TCustomAEditBox.GetSelStart: Integer;
var
  AMin: Integer;
begin
  AMin := Min(FSelection.StartPos, FSelection.EndPos);

  Result := AMin;
end;

function TCustomAEditBox.GetSelText: string;
var
  AMin, AMax, ALength: Integer;
begin
  AMin := Min(FSelection.StartPos, FSelection.EndPos);
  AMax := Max(FSelection.StartPos, FSelection.EndPos);
  ALength := AMax - AMin;

  Result := Copy(Text, AMin + 1, ALength);
end;

function TCustomAEditBox.GetTic: Integer;
begin
  // When the system run continuously for 49.7 days, GetTickCount=0
  if GetTickCount < Counter then
    Counter := GetTickCount;

  if (GetTickCount - Counter) >= 300 then
  begin
    Counter := GetTickCount;
    Tic := Tic + 1;
  end;

  if Tic = 4 then
    Tic := 0;

  Result := Tic;
end;

procedure TCustomAEditBox.KeyDown(var Key: Word; Shift: TShiftState);
var
  AText: String;
  AMin, AMax, ALength: Integer;
begin
  AText := Text;

  AMin := Min(FSelection.StartPos, FSelection.EndPos);
  AMax := Max(FSelection.StartPos, FSelection.EndPos);

  ALength := AMax - AMin;

  // shift pressed
  if Shift = [ssShift] then
  begin
    // user press right key
    if Key = vk_Right then
    begin
      if FSelection.EndPos < Length(Text) then
        Inc(FSelection.EndPos);
    end;

    // user press left key
    if Key = vk_Left then
    begin
      if FSelection.EndPos > 0 then
        Dec(FSelection.EndPos);
    end;

    // user press home key
    if Key = VK_Home then
    begin
      FSelection.EndPos := 0;
    end;

    // user press end key
    if Key = VK_End then
    begin
      FSelection.EndPos := Length(Text);
    end;
  end;

  // Shift not pressed
  if Shift <> [ssShift] then
  begin
    // User press left key
    if (Key = vk_Left) then
    begin
      if FSelection.StartPos = FSelection.EndPos then
      begin
        if FSelection.StartPos > 0 then
        begin
          Dec(FSelection.StartPos);
          FSelection.EndPos := FSelection.StartPos;
        end;
      end
      else if FSelection.StartPos > FSelection.EndPos then
      begin
        FSelection.StartPos := FSelection.EndPos;
      end
      else if FSelection.StartPos < FSelection.EndPos then
      begin
        FSelection.EndPos := FSelection.StartPos;
      end;
    end;

    // User press right key
    if (Key = vk_Right) then
    begin
      if FSelection.StartPos = FSelection.EndPos then
      begin
        if FSelection.EndPos < Length(Text) then
        begin
          Inc(FSelection.EndPos);
          FSelection.StartPos := FSelection.EndPos;
        end;
      end
      else if FSelection.StartPos > FSelection.EndPos then
      begin
        FSelection.EndPos := FSelection.StartPos;
      end
      else if FSelection.StartPos < FSelection.EndPos then
      begin
        FSelection.StartPos := FSelection.EndPos;
      end;
    end;

    // User press Delete or Backspace
    if ((Key = vk_Back) or (Key = vk_Delete)) and not(ReadOnly) then
    begin
      if ALength > 0 then
      begin
        case Key of
          vk_Back:
            Delete(AText, AMin + 1, ALength);
          vk_Delete:
            Delete(AText, AMin + 1, ALength);
        end;
      end
      else
      begin
        case Key of
          vk_Back:
            begin
              Delete(AText, AMin, 1);
              if AMin > 0 then
                Dec(AMin);
            end;
          vk_Delete:
            Delete(AText, AMin + 1, 1);
        end;
      end;

      Text := AText;
      // Execute OnChange Event
      Change;

      FSelection.StartPos := AMin;
      FSelection.EndPos := AMin;
    end;

    // user press home key
    if Key = VK_Home then
    begin
      FSelection.StartPos := 0;
      FSelection.EndPos := 0;
    end;

    // user press end key
    if Key = VK_End then
    begin
      FSelection.StartPos := Length(Text);
      FSelection.EndPos := Length(Text);
    end;
  end;

  Tic := 0;

  inherited KeyDown(Key, Shift);
end;

procedure TCustomAEditBox.KeyPress(var Key: Char);
var
  AText: String;
  AMin, AMax, ALength: Integer;
begin
  AText := Text;

  AMin := Min(FSelection.StartPos, FSelection.EndPos);
  AMax := Max(FSelection.StartPos, FSelection.EndPos);

  ALength := AMax - AMin;

  // Insert Key
  if (Key > #31) and not ReadOnly then
  begin
    Delete(AText, AMin + 1, ALength);

    Inc(AMin);
    Insert(Key, AText, AMin);

    Text := AText;
    // Execute OnChange Event
    Change;

    if AMin > Length(Text) then
      AMin := Length(Text);

    FSelection.StartPos := AMin;
    FSelection.EndPos := AMin;
  end;

  // Copy to Clipboard
  if Key = #3 then
    CopyToClipboard;

  // Paste from Clipboard
  if Key = #22 then
    PasteFromClipboard;

  // Cut to Clipboard
  if Key = #24 then
    CutToClipboard;

  inherited KeyPress(Key);
end;

procedure TCustomAEditBox.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  Index, XPos, AVirtualCursor: Integer;
  AChars: TAChars;
  AFont: TBitmapFont;
begin
  Self.SetFocus;

  AFont := ControlManager.Fonts.Font[FFont.Name];

  if ssDouble in Shift then
  begin
    SelectAll;
  end
  else if AFont <> nil then
  begin
    // Get chars from text
    Index := 0;
    SetLength(AChars, Length(Text) + 1);
    while Index < Length(Text) do
    begin
      AChars[Index].Char := Text[Index + 1];
      AChars[Index].Width := Round(AFont.TextWidth(Text[Index + 1]) (*+ AFont.Kerning*));
      Inc(Index);
    end;

    // Set position to 0
    FSelection.StartPos := 0;
    FSelection.EndPos := 0;

    // Get virtual Bounds
    XPos := ClientLeft + FBorder.Size + FMargin + FVirtualPosition;

    // Set virtual Pos
    AVirtualCursor := XPos;
    for Index := 0 to High(AChars) do
    begin
      if (X > AVirtualCursor) and (X <= AVirtualCursor + AChars[Index].Width)
      then
      begin
        if Index < Length(Text) then
        begin
          FSelection.StartPos := Index + 1;
          FSelection.EndPos := Index + 1;
        end;
        Break;
      end;
      AVirtualCursor := AVirtualCursor + AChars[Index].Width;

      if (Index = High(AChars)) and (X >= AVirtualCursor) then
      begin
        FSelection.StartPos := Index;
        FSelection.EndPos := Index;
      end;
    end;

  end;

  inherited MouseDown(Button, Shift, X, Y);
end;

procedure TCustomAEditBox.MouseEnter;
begin
  // Change the cursor
  if ControlManager.Parent <> nil then
    (ControlManager as TAControlManager).GetParentAsControl.Cursor := crIBeam;

  inherited MouseEnter;
end;

procedure TCustomAEditBox.MouseLeave;
begin
  // Change the cursor
  if ControlManager.Parent <> nil then
    (ControlManager as TAControlManager).GetParentAsControl.Cursor := crDefault;

  inherited MouseLeave;
end;

procedure TCustomAEditBox.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  Index, XPos, AVirtualCursor: Integer;
  AChars: TAChars;
  AFont: TBitmapFont;
begin
  AFont := ControlManager.Fonts.Font[FFont.Name];

  if (AFont <> nil) and (Shift = [ssLeft]) then
  begin
    // Get chars from text
    Index := 0;
    SetLength(AChars, Length(Text) + 1);
    while Index < Length(Text) do
    begin
      AChars[Index].Char := Text[Index + 1];
      AChars[Index].Width := Round(AFont.TextWidth(Text[Index + 1]) (*+ AFont.Kerning*));
      Inc(Index);
    end;

    // Set position to 0
    FSelection.EndPos := 0;

    // Get virtual Bounds
    XPos := ClientLeft + Border.Size + Margin + FVirtualPosition;

    // Set virtual Pos
    AVirtualCursor := XPos;
    for Index := 0 to High(AChars) do
    begin
      if (X > AVirtualCursor) and (X <= AVirtualCursor + AChars[Index].Width)
      then
      begin
        if Index < Length(Text) then
        begin
          FSelection.EndPos := Index + 1;
        end;
        Break;
      end;
      AVirtualCursor := AVirtualCursor + AChars[Index].Width;

      if (Index = High(AChars)) and (X >= AVirtualCursor) then
      begin
        FSelection.EndPos := Index;
      end;
    end;
  end;

  inherited MouseMove(Shift, X, Y);
end;

procedure TCustomAEditBox.Paint;
var
  Index, X, Y, AWidth, AHeight, AVirtualCursor: Integer;
  AMin, AMax: Integer;
  AChars: TAChars;
  ARect: TIntRect;
  bTop, bBottom: TConstraintSize;
  AImage: TAtlasImage;
  AFont: TBitmapFont;
begin
  // Get size Canvas
  ARect := ControlManager.Canvas.ClipRect;

  // Set initial values
  X := ClientLeft;
  Y := ClientTop;

//  if FAntialiased then
//    Include(ControlManager.Canvas.Attributes, Antialias)
//  else
//    Exclude(ControlManager.Canvas.Attributes, Antialias);

  // Draw Background
  AImage := ControlManager.Images.Image[FImage.Image];
  if AImage <> nil then
  begin
    ControlManager.Canvas.UseImagePx(AImage, FloatRect4(FImage.Rect));
    ControlManager.Canvas.TexQuad(FloatRect4(Rect(X, Y, X + Width, Y + Height)),
      cAlpha4(FColor), TBlendingEffect.Normal);
  end
  else
  begin
    ControlManager.Canvas.FillRect(FloatRectBDS(X, Y, X + Width, Y + Height),
      cColor4(FColor), TBlendingEffect.Normal);
  end;

  // Draw Border
  if Border.Size > 0 then
  begin
    bTop := 0;
    bBottom := 0;

    if eTop in Border.Edges then
    begin
      ControlManager.Canvas.FillRect(FloatRectBDS(X, Y, X + Width, Y + Border.Size),
        Border.Color, TBlendingEffect.Normal);
      bTop := Border.Size;
    end;

    if eBottom in Border.Edges then
    begin
      ControlManager.Canvas.FillRect(FloatRectBDS(X, Y + Height - Border.Size,
        X + Width, Y + Height), Border.Color, TBlendingEffect.Normal);
      bBottom := Border.Size;
    end;

    if eLeft in Border.Edges then
      ControlManager.Canvas.FillRect(FloatRectBDS(X, Y + bTop, X + Border.Size,
        Y + Height - bBottom), Border.Color, TBlendingEffect.Normal);

    if eRight in Border.Edges then
      ControlManager.Canvas.FillRect(FloatRectBDS(X + Width - Border.Size, Y + bTop,
        X + Width, Y + Height - bBottom), Border.Color, TBlendingEffect.Normal);
  end;

  // Draw DisplayText
  AFont := ControlManager.Fonts.Font[FFont.Name];
  if (AFont <> nil) then
  begin
    // Set Bounds
    X := X + Margin + Border.Size;
    Y := Y + Margin + Border.Size;
    AWidth := Width - Margin * 2 - Border.Size * 2;
    AHeight := Height - Margin * 2 - Border.Size * 2;

    // Set Rect Canvas
    ControlManager.Canvas.ClipRect :=
      IntersectRect(IntRectBDS(X - 1, Y, X + AWidth, Y + AHeight), ARect);

    // Get chars from text
    Index := 0;
    SetLength(AChars, Length(Text) + 1);
    while Index < Length(Text) do
    begin
      AChars[Index].Char := Text[Index + 1];
      AChars[Index].Width := Round(AFont.TextWidth(Text[Index + 1]) (*+ AFont.Kerning*));
      Inc(Index);
    end;

    // Set virtual Pos
    AVirtualCursor := 0;
    FVirtualPosition := 0;
    for Index := 0 to FSelection.EndPos - 1 do
    begin
      AVirtualCursor := AVirtualCursor + AChars[Index].Width;
    end;

    if AVirtualCursor > AWidth then
    begin
      FVirtualPosition := AWidth - AVirtualCursor;
      X := X + FVirtualPosition;
    end;

    AMin := Min(FSelection.StartPos, FSelection.EndPos);
    AMax := Max(FSelection.StartPos, FSelection.EndPos);

    // Draw Text char by char
    for Index := 0 to High(AChars) do
    begin
      // Draw Selection
      if (Index >= AMin) and (Index < AMax) then
      begin
        if Index = AMin then
          ControlManager.Canvas.FillRect(FloatRectBDS(X - 1, Y, X + AChars[Index].Width,
            Y + AHeight), cColor4(FFont.SelectionColor), TBlendingEffect.Normal)
        else
          ControlManager.Canvas.FillRect(FloatRectBDS(X, Y, X + AChars[Index].Width,
            Y + AHeight), cColor4(FFont.SelectionColor), TBlendingEffect.Normal);

        if (Index = AMin) and (Index = (AMax - 1)) then
          ControlManager.Canvas.FillRect
            (FloatRectBDS(X, Y + 1, X + AChars[Index].Width - 1, Y + AHeight - 1),
            IntColor4($25FFFFFF), TBlendingEffect.Normal)
        else if Index = AMin then
          ControlManager.Canvas.FillRect(FloatRectBDS(X, Y + 1, X + AChars[Index].Width,
            Y + AHeight - 1), IntColor4($25FFFFFF), TBlendingEffect.Normal)
        else if Index = (AMax - 1) then
          ControlManager.Canvas.FillRect
            (FloatRectBDS(X, Y + 1, X + AChars[Index].Width - 1, Y + AHeight - 1),
            IntColor4($25FFFFFF), TBlendingEffect.Normal)
        else
          ControlManager.Canvas.FillRect(FloatRectBDS(X, Y + 1, X + AChars[Index].Width,
            Y + AHeight - 1), IntColor4($25FFFFFF), TBlendingEffect.Normal);

        AFont.DrawText(Point2(X, Y + (AHeight div 2) - (AFont.Size.Y div 2) -
          1), AChars[Index].Char, IntColor2($B0FFFFFF), 1.0);
      end
      else
      begin
        AFont.DrawText(Point2(X, Y + (AHeight div 2) - (AFont.Size.Y div 2) -
          1), AChars[Index].Char, cColor2(FFont.Color), 1.0);
      end;

      // Draw Tic
      if (GetTic <= 1) and (ControlManager.ActiveControl = Self) then
      begin
        if (Index = FSelection.StartPos) and (Index = FSelection.EndPos) then
          ControlManager.Canvas.Line(Point2(X, Y),
            Point2(X, Y + AHeight), IntColorBlack)
        else if Index = FSelection.EndPos then
          ControlManager.Canvas.Line(Point2(X - 1, Y),
            Point2(X - 1, Y + AHeight), IntColorBlack);
      end;

      // Set Next X position
      X := X + AChars[Index].Width;
    end;

    // Set Rect Canvas
    ControlManager.Canvas.ClipRect := ARect;
  end;

  // Set initial values
  X := ClientLeft;
  Y := ClientTop;

  // Draw Focus rect
  if (ControlManager.ActiveControl = Self) and (Self.FocusRect = fLight) then
  begin
    ControlManager.Canvas.FrameRect(FloatRectBDS(X - 1, Y - 1, X + Width + 1,
      Y + Height + 1), IntColor4($40FFFFFF), TBlendingEffect.Normal);
  end;
  if (ControlManager.ActiveControl = Self) and (Self.FocusRect = fDark) then
  begin
    ControlManager.Canvas.FrameRect(FloatRectBDS(X - 1, Y - 1, X + Width + 1,
      Y + Height + 1), IntColor4($20000000), TBlendingEffect.Normal);
  end;

end;

procedure TCustomAEditBox.PasteFromClipboard;
var
  AText, CText: String;
  AMin, AMax, ALength: Integer;
begin
  AText := Text;

  AMin := Min(FSelection.StartPos, FSelection.EndPos);
  AMax := Max(FSelection.StartPos, FSelection.EndPos);

  ALength := AMax - AMin;

  Delete(AText, AMin + 1, ALength);
  CText := (ControlManager as TAControlManager).GetClipboard.AsText;

  Inc(AMin);
  Insert(CText, AText, AMin);

  Text := AText;
  // Execute OnChange Event
  Change;

  Inc(AMin, Length(CText));

  if AMin > Length(Text) then
    AMin := Length(Text);

  FSelection.StartPos := AMin;
  FSelection.EndPos := AMin;
end;

procedure TCustomAEditBox.SelectAll;
begin
  if Enabled then
  begin
    FSelection.StartPos := 0;
    FSelection.EndPos := Length(Text);
  end;
end;

procedure TCustomAEditBox.SetAntialiased(Value: Boolean);
begin
  FAntialiased := Value;
end;

procedure TCustomAEditBox.SetAutoSelect(Value: Boolean);
begin
  FAutoSelect := Value;
end;

procedure TCustomAEditBox.SetBorder(Value: TBorder);
begin
  if Value <> nil then
    FBorder.Assign(Value);
end;

procedure TCustomAEditBox.SetColor(Value: TFillColor);
begin
  if Value <> nil then
    FColor.Assign(Value);
end;

procedure TCustomAEditBox.SetFocusRect(Value: TFocusRect);
begin
  FFocusRect := Value;
end;

procedure TCustomAEditBox.SetFont(Value: TEditFont);
begin
  if Value <> nil then
    FFont.Assign(Value);
end;

procedure TCustomAEditBox.SetImage(Value: TImage);
begin
  if Value <> nil then
    FImage.Assign(Value);
end;

procedure TCustomAEditBox.SetMargin(Value: Word);
begin
  FMargin := Value;
end;

procedure TCustomAEditBox.SetMaxLength(Value: Integer);
begin
  if FMaxLength <> Value then
  begin
    FMaxLength := Value;
    if (Value < Length(Text)) and (Value > 0) then
    begin
      Text := Copy(Text, 0, Value);
    end;
  end;
end;

procedure TCustomAEditBox.SetReadOnly(Value: Boolean);
begin
  FReadOnly := Value;
end;

// procedure TCustomAEditBox.SetSelLength(Value: Integer);
// begin
// FSelection.EndPos := FSelection.StartPos + Value;
//
// if FSelection.EndPos > Length(Text) then
// FSelection.EndPos := Length(Text);
//
// if FSelection.EndPos < 0 then
// FSelection.EndPos := 0;
// end;
//
// procedure TCustomAEditBox.SetSelStart(Value: Integer);
// begin
// if not((Value < 0) and (Value > Length(Text))) then
// begin
// FSelection.StartPos := Value;
// FSelection.EndPos := Value;
// end;
// end;
//
// procedure TCustomAEditBox.SetSelText(Value: String);
// var
// AText: String;
// AMin, AMax, ALength: Integer;
// begin
// AText := Text;
//
// AMin := Min(FSelection.StartPos, FSelection.EndPos);
// AMax := Max(FSelection.StartPos, FSelection.EndPos);
//
// ALength := AMax - AMin;
//
// // Insert Key
// Delete(AText, AMin + 1, ALength);
//
// Inc(AMin);
// Insert(Value, AText, AMin);
//
// Text := AText;
// Change;
//
// if AMin > Length(Text) then
// AMin := Length(Text);
//
// FSelection.StartPos := AMin;
// FSelection.EndPos := AMin + Length(Value);
// end;

procedure TCustomAEditBox.SetText(Value: String);
begin
  if (FMaxLength < Length(Value)) and (FMaxLength > 0) then
  begin
    Value := Copy(Value, 0, FMaxLength);
  end;

  FText := Value;
end;
{$ENDREGION}

end.
