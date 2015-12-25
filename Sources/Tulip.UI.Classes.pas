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
{  The Original Code is Tulip.UI.Classes.pas.                                  }
{                                                                              }
{  The Initial Developer of the Original Code is Marcos Gomes.                 }
{  Portions created by Marcos Gomes are Copyright (C) 2012, Marcos Gomes.      }
{  All Rights Reserved.                                                        }
{                                                                              }
{******************************************************************************}
{                                                                              }
{  Tulip.UI.Classes.pas                                 Modified: 23-Mar-2013  }
{  --------------------------------------------------------------------------  }
{                                                                              }
{                  Implementations of Objects used by Controls                 }
{                                                                              }
{                                Version 1.03                                  }
{                                                                              }
{******************************************************************************}

unit Tulip.UI.Classes;

interface

uses
  System.Classes, System.StrUtils, System.Types,
  // Tulip UI Units
  Tulip.UI.Types;

type

{$REGION 'Forward Declarations'}
  TAStringList = class;
  TActiveBorder = class;
  TActiveFormatedFont = class;
  TBorder = class;
  TBtBox = class;
  TCkBox = class;
  TEditFont = class;
  TFillColor = class;
  TFormatedFont = class;
  TImage = class;
  TTextColor = class;
{$ENDREGION}
{$REGION 'TAStringList'}

  TAStringList = class(TPersistent)
  private
    FItems: TStringArray;
    FText: String;
    function GetCount: Integer;
    procedure SetText(AText: String);
  protected
    procedure AssignTo(Dest: TPersistent); override;
  public
    constructor Create;
    destructor Destroy; override;

    function Add(AString: String): Integer;
    function IndexOf(AString: String): Integer;
    function Insert(AString: String; Index: Integer = 0): Integer;
    function Remove(AString: String): Boolean; overload;
    function Remove(Index: Integer): Boolean; overload;
    procedure Clear;

    property Count: Integer read GetCount;
    property Items: TStringArray read FItems;
  published
    property Text: String read FText write SetText;
  end;
{$ENDREGION}
{$REGION 'TActiveBorder'}

  TActiveBorder = class(TPersistent)
  private
    FColor: TAColor;
    FColorHover: TAColor;
    FColorPressed: TAColor;
    FEdges: TEdges;
    FSize: TConstraintSize;
  protected
    procedure AssignTo(Dest: TPersistent); override;
  public
    constructor Create;
  published
    property Color: TAColor read FColor write FColor;
    property ColorHover: TAColor read FColorHover write FColorHover;
    property ColorPressed: TAColor read FColorPressed write FColorPressed;
    property Edges: TEdges read FEdges write FEdges;
    property Size: TConstraintSize read FSize write FSize;
  end;
{$ENDREGION}
{$REGION 'TActiveFormatedFont'}

  TActiveFormatedFont = class(TPersistent)
  private
    FColor: TTextColor;
    FColorHover: TTextColor;
    FColorPressed: TTextColor;
    FName: String;
    FPLine: Boolean;
    FHAlign: THorizontalAlign;
    FVAlign: TVerticalAlign;
    procedure SetColor(Value: TTextColor);
    procedure SetColorHover(Value: TTextColor);
    procedure SetColorPressed(Value: TTextColor);
    procedure SetName(Value: String);
  protected
    procedure AssignTo(Dest: TPersistent); override;
  public
    constructor Create;
    destructor Destroy; override;
  published
    property Color: TTextColor read FColor write SetColor;
    property ColorHover: TTextColor read FColorHover write SetColorHover;
    property ColorPressed: TTextColor read FColorPressed write SetColorPressed;
    property Name: String read FName write SetName;
    property HorizontalAlign: THorizontalAlign read FHAlign write FHAlign;
    property ParagraphLine: Boolean read FPLine write FPLine;
    property VerticalAlign: TVerticalAlign read FVAlign write FVAlign;
  end;
{$ENDREGION}
{$REGION 'TBorder'}

  TBorder = class(TPersistent)
  private
    FColor: TAColor;
    FEdges: TEdges;
    FSize: TConstraintSize;
  protected
    procedure AssignTo(Dest: TPersistent); override;
  public
    constructor Create; overload;
    constructor Create(AColor: TAColor; AEdges: TEdges;
      ASize: TConstraintSize); overload;
  published
    property Color: TAColor read FColor write FColor;
    property Edges: TEdges read FEdges write FEdges;
    property Size: TConstraintSize read FSize write FSize;
  end;
{$ENDREGION}
{$REGION 'TBtBox'}

  TBtBox = class(TPersistent)
  private
    FBorder: TActiveBorder;
    FColor: TFillColor;
    FColorHover: TFillColor;
    FColorPressed: TFillColor;
    FControlState: TControlState;
    FEnabled: Boolean;
    FImage: TImage;
    FImageHover: TImage;
    FImagePressed: TImage;
    FHeight: TConstraintSize;
    FWidth: TConstraintSize;
    FVisible: Boolean;

    procedure SetBorder(Value: TActiveBorder);
    procedure SetColor(Value: TFillColor);
    procedure SetColorHover(Value: TFillColor);
    procedure SetColorPressed(Value: TFillColor);
    procedure SetEnabled(Value: Boolean);
    procedure SetImage(Value: TImage);
    procedure SetImageHover(Value: TImage);
    procedure SetImagePressed(Value: TImage);
    procedure SetHeight(Value: TConstraintSize);
    procedure SetVisible(Value: Boolean);
    procedure SetWidth(Value: TConstraintSize);
  protected
    procedure AssignTo(Dest: TPersistent); override;
  public
    constructor Create;
    destructor Destroy; override;

    property ControlState: TControlState read FControlState write FControlState;
  published
    property Border: TActiveBorder read FBorder write SetBorder;
    property Color: TFillColor read FColor write SetColor;
    property ColorHover: TFillColor read FColorHover write SetColorHover;
    property ColorPressed: TFillColor read FColorPressed write SetColorPressed;
    property Enabled: Boolean read FEnabled write SetEnabled;
    property Image: TImage read FImage write SetImage;
    property ImageHover: TImage read FImageHover write SetImageHover;
    property ImagePressed: TImage read FImagePressed write SetImagePressed;
    property Height: TConstraintSize read FHeight write SetHeight;
    property Visible: Boolean read FVisible write SetVisible;
    property Width: TConstraintSize read FWidth write SetWidth;
  end;
{$ENDREGION}
{$REGION 'TCkBox'}

  TCkBox = class(TPersistent)
  private
    FBorder: TBorder;
    FCheckedColor: TAColor;
    FCheckedImage: TImage;
    FColor: TFillColor;
    FImage: TImage;
    FSize: Word;

    procedure SetBorder(Value: TBorder);
    procedure SetCheckedColor(Value: TAColor);
    procedure SetCheckedImage(Value: TImage);
    procedure SetColor(Value: TFillColor);
    procedure SetImage(Value: TImage);
    procedure SetSize(Value: Word);
  protected
    procedure AssignTo(Dest: TPersistent); override;
  public
    constructor Create;
    destructor Destroy; override;
  published
    property Border: TBorder read FBorder write SetBorder;
    property CheckedColor: TAColor read FCheckedColor write SetCheckedColor;
    property CheckedImage: TImage read FCheckedImage write SetCheckedImage;
    property Color: TFillColor read FColor write SetColor;
    property Image: TImage read FImage write SetImage;
    property Size: Word read FSize write SetSize;
  end;
{$ENDREGION}
{$REGION 'TEditFont'}

  TEditFont = class(TPersistent)
  private
    FColor: TTextColor;
    FName: String;
    FSelectionColor: TTextColor;
    procedure SetColor(Value: TTextColor);
    procedure SetName(Value: String);
    procedure SetSelectionColor(Value: TTextColor);
  protected
    procedure AssignTo(Dest: TPersistent); override;
  public
    constructor Create;
    destructor Destroy; override;
  published
    property Color: TTextColor read FColor write SetColor;
    property Name: String read FName write SetName;
    property SelectionColor: TTextColor read FSelectionColor
      write SetSelectionColor;
  end;
{$ENDREGION}
{$REGION 'TFillColor'}

  TFillColor = class(TPersistent)
  private
    fa: TAColor;
    fb: TAColor;
    fc: TAColor;
    fd: TAColor;
    procedure SetA(c: TAColor);
    procedure SetB(c: TAColor);
    procedure SetC(c: TAColor);
    procedure SetD(c: TAColor);
  protected
    procedure AssignTo(Dest: TPersistent); override;
  public
    constructor Create; overload;
    constructor Create(a, b, c, d: TAColor); overload;

    procedure SetFillColor(a, b, c, d: TAColor);
  published
    property TopLeft: TAColor read fa write SetA;
    property TopRight: TAColor read fb write SetB;
    property BottomRight: TAColor read fc write SetC;
    property BottomLeft: TAColor read fd write SetD;
  end;
{$ENDREGION}
{$REGION 'TFormatedFont'}

  TFormatedFont = class(TPersistent)
  private
    FColor: TTextColor;
    FName: String;
    FPLine: Boolean;
    FHAlign: THorizontalAlign;
    FVAlign: TVerticalAlign;
    procedure SetColor(Value: TTextColor);
    procedure SetName(Value: String);
  protected
    procedure AssignTo(Dest: TPersistent); override;
  public
    constructor Create;
    destructor Destroy; override;
  published
    property Color: TTextColor read FColor write SetColor;
    property Name: String read FName write SetName;
    property HorizontalAlign: THorizontalAlign read FHAlign write FHAlign;
    property ParagraphLine: Boolean read FPLine write FPLine;
    property VerticalAlign: TVerticalAlign read FVAlign write FVAlign;
  end;
{$ENDREGION}
{$REGION 'TImage'}

  TImage = class(TPersistent)
  private
    FImage: String;
    FBottom: Integer;
    FLeft: Integer;
    FRight: Integer;
    FTop: Integer;
    procedure SetImage(Value: String);
  protected
    procedure AssignTo(Dest: TPersistent); override;
  public
    constructor Create;
    destructor Destroy; override;

    function Rect: TRect;
  published
    property Image: String read FImage write SetImage;
    property Bottom: Integer read FBottom write FBottom;
    property Left: Integer read FLeft write FLeft;
    property Right: Integer read FRight write FRight;
    property Top: Integer read FTop write FTop;
  end;
{$ENDREGION}
{$REGION 'TTextColor'}

  TTextColor = class(TPersistent)
  private
    fa: TAColor;
    fb: TAColor;
    procedure SetA(c: TAColor);
    procedure SetB(c: TAColor);
  protected
    procedure AssignTo(Dest: TPersistent); override;
  public
    constructor Create; overload;
    constructor Create(a, b: TAColor); overload;

    procedure SetColor(a, b: TAColor);
  published
    property Top: TAColor read fa write SetA;
    property Bottom: TAColor read fb write SetB;
  end;
{$ENDREGION}

implementation

{$REGION 'TAStringList'}
{ TAStringList }

function TAStringList.Add(AString: String): Integer;
var
  temp: string;
begin
  temp := FText;

  // Check if new string contains #10 and #13 chars
  // We want to add just one single string each time
  if (ContainsText(AString, #10)) or (ContainsText(AString, #13)) then
  begin
    AString := ReplaceText(AString, #10, '');
    AString := ReplaceText(AString, #13, '');
  end;

  if temp = '' then
  begin
    temp := AString + #13;
  end
  else
  begin
    temp := temp + AString + #13;
  end;

  Text := temp;
  Result := GetCount;
end;

procedure TAStringList.AssignTo(Dest: TPersistent);
begin
  if Dest is TAStringList then
    with TAStringList(Dest) do
    begin
      Text := Self.Text;
    end
  else
    inherited;
end;

procedure TAStringList.Clear;
begin
  SetLength(FItems, 0);
  FText := '';
end;

constructor TAStringList.Create;
begin
  Clear;
end;

destructor TAStringList.Destroy;
begin
  Clear;
  FItems := nil;

  inherited;
end;

function TAStringList.GetCount: Integer;
begin
  Result := Length(FItems);
end;

function TAStringList.IndexOf(AString: String): Integer;
var
  I, Count: Integer;
begin
  Result := -1;

  Count := GetCount;
  if Count > 0 then
  begin
    for I := 0 to Count - 1 do
    begin
      if FItems[I] = AString then
      begin
        Result := I;
        Break;
      end;
    end;
  end;
end;

function TAStringList.Insert(AString: String; Index: Integer = 0): Integer;
var
  temp: String;
  I, IniPos: Integer;
begin
  Result := -1;

  if (Index < 0) and (Index >= GetCount) then
    Exit;

  temp := Text;

  // Check if new string contains #10 and #13 chars
  // We want to insert just one single string each time
  if (ContainsText(AString, #10)) or (ContainsText(AString, #13)) then
  begin
    AString := ReplaceText(AString, #10, '');
    AString := ReplaceText(AString, #13, '');
  end;

  if (Index = 0) then // insert on begining
  begin
    if temp = '' then
      temp := AString + #13
    else
      temp := AString + #13 + temp;
  end
  else
  begin
    IniPos := 1;
    for I := 0 to Index - 1 do
    begin
      if PosEx(#13, temp, IniPos + 1) > 0 then
        IniPos := PosEx(#13, temp, IniPos + 1);
    end;

    System.Insert(#13 + AString, temp, IniPos);
  end;

  Result := Index;
  Text := temp;
end;

function TAStringList.Remove(Index: Integer): Boolean;
var
  s, temp: String;
  I, IniPos: Integer;
begin
  Result := False;

  if (Index < 0) or (Index >= GetCount) then
    Exit;

  temp := FText;
  s := FItems[Index];

  if Index = 0 then
  begin
    if GetCount > 1 then
      Delete(temp, 1, Pos(#13, temp))
    else
      temp := '';
  end
  else
  begin
    IniPos := 0;
    for I := 0 to Index - 1 do
    begin
      if PosEx(#13, temp, IniPos + 1) > 0 then
        IniPos := PosEx(#13, temp, IniPos + 1);
    end;

    Delete(temp, IniPos, Length(s) + 1);
  end;

  Text := temp;
  Result := True;
end;

function TAStringList.Remove(AString: String): Boolean;
var
  Index: Integer;
begin
  Result := False;
  Index := IndexOf(AString);

  if Index <> -1 then
  begin
    Result := Remove(Index);
  end;
end;

procedure TAStringList.SetText(AText: String);
var
  I, J: Integer;
begin
  if FText <> AText then
  begin
    Clear;
    FText := AText;

    if Length(AText) > 0 then
    begin
      J := GetCount;
      for I := 1 to Length(AText) do
      begin
        SetLength(FItems, J + 1);

        if (AText[I] <> #13) then
        begin
          if (AText[I] <> #10) then
            FItems[J] := FItems[J] + AText[I]
        end
        else
          J := J + 1;
      end;
    end;
  end;
end;
{$ENDREGION}
{$REGION 'TActiveBorder'}
{ TActiveBorder }

procedure TActiveBorder.AssignTo(Dest: TPersistent);
begin
  if Dest is TActiveBorder then
    with TActiveBorder(Dest) do
    begin
      Color := Self.Color;
      ColorHover := Self.ColorHover;
      ColorPressed := Self.ColorPressed;
      Edges := Self.Edges;
      Size := Self.Size;
    end
  else
    inherited;
end;

constructor TActiveBorder.Create;
begin
  FColor := $FF000000;
  FColorHover := $FF000000;
  FColorPressed := $FF000000;
  FEdges := [eLeft, eTop, eRight, eBottom];
  FSize := 1;
end;
{$ENDREGION}
{$REGION 'TActiveFormatedFont'}
{ TActiveFormatedFont }

procedure TActiveFormatedFont.AssignTo(Dest: TPersistent);
begin
  if Dest is TActiveFormatedFont then
    with TActiveFormatedFont(Dest) do
    begin
      Color := Self.Color;
      ColorHover := Self.ColorHover;
      ColorPressed := Self.ColorPressed;
      Name := Self.Name;
      ParagraphLine := Self.ParagraphLine;
      HorizontalAlign := Self.HorizontalAlign;
      VerticalAlign := Self.VerticalAlign;
    end
  else
    inherited;
end;

constructor TActiveFormatedFont.Create;
begin
  FColor := TTextColor.Create;
  FColorHover := TTextColor.Create;
  FColorPressed := TTextColor.Create;
  FName := 'Tahoma10';
  FPLine := True;
  FHAlign := aCenter;
  FVAlign := aMiddle;
end;

destructor TActiveFormatedFont.Destroy;
begin
  FColor.Free;
  FColorHover.Free;
  FColorPressed.Free;

  inherited;
end;

procedure TActiveFormatedFont.SetColor(Value: TTextColor);
begin
  if Value <> nil then
    FColor.Assign(Value);
end;

procedure TActiveFormatedFont.SetColorHover(Value: TTextColor);
begin
  if Value <> nil then
    FColorHover.Assign(Value);
end;

procedure TActiveFormatedFont.SetColorPressed(Value: TTextColor);
begin
  if Value <> nil then
    FColorPressed.Assign(Value);
end;

procedure TActiveFormatedFont.SetName(Value: String);
begin
  FName := Value;
end;
{$ENDREGION}
{$REGION 'TBorder'}
{ TBorder }

procedure TBorder.AssignTo(Dest: TPersistent);
begin
  if Dest is TBorder then
    with TBorder(Dest) do
    begin
      Color := Self.Color;
      Edges := Self.Edges;
      Size := Self.Size;
    end
  else
    inherited;
end;

constructor TBorder.Create;
begin
  FColor := $FF000000;
  FEdges := [eLeft, eTop, eRight, eBottom];
  FSize := 1;
end;

constructor TBorder.Create(AColor: TAColor; AEdges: TEdges;
  ASize: TConstraintSize);
begin
  FColor := AColor;
  FEdges := AEdges;
  FSize := ASize;
end;
{$ENDREGION}
{$REGION 'TBtBox'}
{ TBtBox }

procedure TBtBox.AssignTo(Dest: TPersistent);
begin
  if Dest is TBtBox then
    with TBtBox(Dest) do
    begin
      Border := Self.Border;
      Color := Self.Color;
      ColorHover := Self.ColorHover;
      ColorPressed := Self.ColorPressed;
      Enabled := Self.Enabled;
      Image := Self.Image;
      ImageHover := Self.ImageHover;
      ImagePressed := Self.ImagePressed;
      Height := Self.Height;
      Width := Self.Width;
      Visible := Self.Visible;
    end
  else
    inherited;
end;

constructor TBtBox.Create;
begin
  FBorder := TActiveBorder.Create;
  FBorder.Color := $B0FFFFFF;
  FBorder.ColorHover := $C0FFFFFF;
  FBorder.ColorPressed := $C0FFFFFF;
  FBorder.Size := 1;
  FColor := TFillColor.Create($FFA6CAF0, $FFA6CAF0, $FF4090F0, $FF4090F0);
  FColorHover := TFillColor.Create($FFB6DAF0, $FFB6DAF0, $FF409AF0, $FF409AF0);
  FColorPressed := TFillColor.Create($FF4090F0, $FF4090F0, $FFA6CAF0,
    $FFA6CAF0);
  FControlState := [];
  FEnabled := True;
  FImage := TImage.Create;
  FImageHover := TImage.Create;
  FImagePressed := TImage.Create;
  FHeight := 12;
  FWidth := 12;
  FVisible := True;
end;

destructor TBtBox.Destroy;
begin
  FBorder.Free;
  FColor.Free;
  FColorHover.Free;
  FColorPressed.Free;
  FImage.Free;
  FImageHover.Free;
  FImagePressed.Free;

  inherited;
end;

procedure TBtBox.SetBorder(Value: TActiveBorder);
begin
  if Value <> nil then
    FBorder.Assign(Value);
end;

procedure TBtBox.SetColor(Value: TFillColor);
begin
  if Value <> nil then
    FColor.Assign(Value);
end;

procedure TBtBox.SetColorHover(Value: TFillColor);
begin
  if Value <> nil then
    FColorHover.Assign(Value);
end;

procedure TBtBox.SetColorPressed(Value: TFillColor);
begin
  if Value <> nil then
    FColorPressed.Assign(Value);
end;

procedure TBtBox.SetEnabled(Value: Boolean);
begin
  FEnabled := Value;
end;

procedure TBtBox.SetHeight(Value: TConstraintSize);
begin
  FHeight := Value;
end;

procedure TBtBox.SetImage(Value: TImage);
begin
  if Value <> nil then
    FImage.Assign(Value);
end;

procedure TBtBox.SetImageHover(Value: TImage);
begin
  if Value <> nil then
    FImageHover.Assign(Value);
end;

procedure TBtBox.SetImagePressed(Value: TImage);
begin
  if Value <> nil then
    FImagePressed.Assign(Value);
end;

procedure TBtBox.SetVisible(Value: Boolean);
begin
  FVisible := Value;
end;

procedure TBtBox.SetWidth(Value: TConstraintSize);
begin
  FWidth := Value;
end;
{$ENDREGION}
{$REGION 'TCkBox'}
{ TCkBox }

procedure TCkBox.AssignTo(Dest: TPersistent);
begin
  if Dest is TCkBox then
    with TCkBox(Dest) do
    begin
      Border := Self.Border;
      CheckedColor := Self.CheckedColor;
      CheckedImage := Self.CheckedImage;
      Color := Self.Color;
      Image := Self.Image;
      Size := Self.Size;
    end
  else
    inherited;
end;

constructor TCkBox.Create;
begin
  FBorder := TBorder.Create;
  FBorder.Color := $B0FFFFFF;
  FCheckedColor := $B0FFFFFF;
  FCheckedImage := TImage.Create;
  FColor := TFillColor.Create($FF4090F0, $FF4090F0, $FF6EAAF4, $FF6EAAF4);
  FImage := TImage.Create;
  FSize := 16;
end;

destructor TCkBox.Destroy;
begin
  FBorder.Free;
  FCheckedImage.Free;
  FColor.Free;
  FImage.Free;

  inherited;
end;

procedure TCkBox.SetBorder(Value: TBorder);
begin
  if Value <> nil then
    FBorder.Assign(Value);
end;

procedure TCkBox.SetCheckedColor(Value: TAColor);
begin
  FCheckedColor := Value;
end;

procedure TCkBox.SetCheckedImage(Value: TImage);
begin
  if Value <> nil then
    FCheckedImage.Assign(Value);
end;

procedure TCkBox.SetColor(Value: TFillColor);
begin
  if Value <> nil then
    FColor.Assign(Value);
end;

procedure TCkBox.SetImage(Value: TImage);
begin
  if Value <> nil then
    FImage.Assign(Value);
end;

procedure TCkBox.SetSize(Value: Word);
begin
  FSize := Value;
end;
{$ENDREGION}
{$REGION 'TEditFont'}
{ TEditFont }

procedure TEditFont.AssignTo(Dest: TPersistent);
begin
  if Dest is TEditFont then
    with TEditFont(Dest) do
    begin
      Color := Self.Color;
      Name := Self.Name;
      SelectionColor := Self.SelectionColor;
    end
  else
    inherited;
end;

constructor TEditFont.Create;
begin
  FColor := TTextColor.Create;
  FName := 'Tahoma10';
  FSelectionColor := TTextColor.Create($B0206DBE, $B0206DBE);
end;

destructor TEditFont.Destroy;
begin
  FColor.Free;
  FSelectionColor.Free;

  inherited;
end;

procedure TEditFont.SetColor(Value: TTextColor);
begin
  if Value <> nil then
    FColor.Assign(Value);
end;

procedure TEditFont.SetName(Value: String);
begin
  FName := Value;
end;

procedure TEditFont.SetSelectionColor(Value: TTextColor);
begin
  if Value <> nil then
    FSelectionColor.Assign(Value);
end;
{$ENDREGION}
{$REGION 'TFillColor'}
{ TFillColor }

procedure TFillColor.AssignTo(Dest: TPersistent);
begin
  if Dest is TFillColor then
    with TFillColor(Dest) do
    begin
      fa := Self.fa;
      fb := Self.fb;
      fc := Self.fc;
      fd := Self.fd;
    end
  else
    inherited;
end;

constructor TFillColor.Create;
begin
  inherited Create;

  // Set white color for all subcolors
  fa := $FFFFFFFF;
  fb := $FFFFFFFF;
  fc := $FFFFFFFF;
  fd := $FFFFFFFF;
end;

constructor TFillColor.Create(a, b, c, d: TAColor);
begin
  inherited Create;

  fa := a;
  fb := b;
  fc := c;
  fd := d;
end;

procedure TFillColor.SetA(c: TAColor);
begin
  if fa <> c then
    fa := c;
end;

procedure TFillColor.SetB(c: TAColor);
begin
  if fb <> c then
    fb := c;
end;

procedure TFillColor.SetC(c: TAColor);
begin
  if fc <> c then
    fc := c;
end;

procedure TFillColor.SetD(c: TAColor);
begin
  if fd <> c then
    fd := c;
end;

procedure TFillColor.SetFillColor(a, b, c, d: TAColor);
begin
  fa := a;
  fb := b;
  fc := c;
  fd := d;
end;
{$ENDREGION}
{$REGION 'TFormatedFont'}
{ TFormatedFont }

procedure TFormatedFont.AssignTo(Dest: TPersistent);
begin
  if Dest is TFormatedFont then
    with TFormatedFont(Dest) do
    begin
      Color := Self.Color;
      Name := Self.Name;
      ParagraphLine := Self.ParagraphLine;
      HorizontalAlign := Self.HorizontalAlign;
      VerticalAlign := Self.VerticalAlign;
    end
  else
    inherited;
end;

constructor TFormatedFont.Create;
begin
  FColor := TTextColor.Create;
  FName := 'Tahoma10';
  FPLine := True;
  FHAlign := aCenter;
  FVAlign := aMiddle;
end;

destructor TFormatedFont.Destroy;
begin
  FColor.Free;

  inherited;
end;

procedure TFormatedFont.SetColor(Value: TTextColor);
begin
  if Value <> nil then
    FColor.Assign(Value);
end;

procedure TFormatedFont.SetName(Value: String);
begin
  FName := Value;
end;
{$ENDREGION}
{$REGION 'TImage'}
{ TImage }

procedure TImage.AssignTo(Dest: TPersistent);
begin
  if Dest is TImage then
    with TImage(Dest) do
    begin
      Image := Self.Image;
      Left := Self.Left;
      Top := Self.Top;
      Right := Self.Right;
      Bottom := Self.Bottom;
    end
  else
    inherited;
end;

constructor TImage.Create;
begin
  FImage := '';
  FLeft := 0;
  FTop := 0;
  FRight := 0;
  FBottom := 0;
end;

destructor TImage.Destroy;
begin
  inherited;
end;

function TImage.Rect: TRect;
begin
  Result := System.Types.Rect(FLeft, FTop, FRight, FBottom);
end;

procedure TImage.SetImage(Value: String);
begin
  FImage := Value;
end;
{$ENDREGION}
{$REGION 'TTextColor'}
{ TTextColor }

procedure TTextColor.AssignTo(Dest: TPersistent);
begin
  if Dest is TTextColor then
    with TTextColor(Dest) do
    begin
      fa := Self.fa;
      fb := Self.fb;
    end
  else
    inherited;
end;

constructor TTextColor.Create;
begin
  inherited;

  fa := $FFFFFFFF;
  fb := $FFEEEEEE;
end;

constructor TTextColor.Create(a, b: TAColor);
begin
  inherited Create;

  fa := a;
  fb := b;
end;

procedure TTextColor.SetA(c: TAColor);
begin
  if fa <> c then
    fa := c;
end;

procedure TTextColor.SetB(c: TAColor);
begin
  if fb <> c then
    fb := c;
end;

procedure TTextColor.SetColor(a, b: TAColor);
begin
  fa := a;
  fb := b;
end;
{$ENDREGION}

end.
