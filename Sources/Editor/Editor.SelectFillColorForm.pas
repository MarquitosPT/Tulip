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
{  The Original Code is Editor.SelectFillColorForm.pas.                        }
{                                                                              }
{  The Initial Developer of the Original Code is Marcos Gomes.                 }
{  Portions created by Marcos Gomes are Copyright (C) 2012, Marcos Gomes.      }
{  All Rights Reserved.                                                        }
{                                                                              }
{******************************************************************************}
{                                                                              }
{  Editor.SelectFillColorForm.pas                       Modified: 05-Out-2012  }
{  --------------------------------------------------------------------------  }
{                                                                              }
{                   Implementation of SelectFillColorForm                      }
{                                                                              }
{                                Version 1.02                                  }
{                                                                              }
{******************************************************************************}

unit Editor.SelectFillColorForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  // Asphyre Units
  AVBevel, AVColorBox;

type
  TSelectFillColorForm = class(TForm)
    GroupBox1: TGroupBox;
    Single: TAVColorBox;
    rbSingle: TRadioButton;
    GroupBox2: TGroupBox;
    Right: TAVColorBox;
    Left: TAVColorBox;
    rbLeftRight: TRadioButton;
    GroupBox3: TGroupBox;
    Bottom: TAVColorBox;
    Top: TAVColorBox;
    rbTopBottom: TRadioButton;
    GroupBox4: TGroupBox;
    BottomRight: TAVColorBox;
    BottomLeft: TAVColorBox;
    TopRight: TAVColorBox;
    TopLeft: TAVColorBox;
    rbFourColors: TRadioButton;
    GroupBox6: TGroupBox;
    Panel1: TPanel;
    ColorPreview: TAVBevel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure rbSingleClick(Sender: TObject);
    procedure rbLeftRightClick(Sender: TObject);
    procedure rbTopBottomClick(Sender: TObject);
    procedure rbFourColorsClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure SingleClick(Sender: TObject);
    procedure LeftClick(Sender: TObject);
    procedure TopClick(Sender: TObject);
    procedure TopLeftClick(Sender: TObject);
  private
    { Private declarations }
    procedure UpdateColorPreview;
    Procedure SetColors;
  public
    { Public declarations }
    Color1: Cardinal;
    Color2: Cardinal;
    Color3: Cardinal;
    Color4: Cardinal;
    procedure GetColors;
  end;

var
  SelectFillColorForm: TSelectFillColorForm;

function SelectColor(out DestColor: Cardinal; SrcColor: Cardinal = 0): Boolean;
  external 'ColorSel.dll';

implementation

uses
  AVTypeUtils;

{$R *.dfm}
{ TSelectFillColorForm }

procedure TSelectFillColorForm.BitBtn1Click(Sender: TObject);
begin
  SetColors;
end;

procedure TSelectFillColorForm.GetColors;
begin
  Single.Color := DisplaceRB(Color1);
  Top.Color := DisplaceRB(Color1);
  Bottom.Color := DisplaceRB(Color4);
  Left.Color := DisplaceRB(Color1);
  Right.Color := DisplaceRB(Color4);
  TopLeft.Color := DisplaceRB(Color1);
  TopRight.Color := DisplaceRB(Color2);
  BottomLeft.Color := DisplaceRB(Color3);
  BottomRight.Color := DisplaceRB(Color4);

  if (Color1 = Color2) and (Color2 = Color3) and (Color3 = Color4) then
  begin
    rbSingleClick(Self);
    Exit;
  end;

  if (Color1 = Color2) and (Color3 = Color4) then
  begin
    rbTopBottomClick(Self);
    Exit;
  end;

  if (Color1 = Color3) and (Color2 = Color4) then
  begin
    rbLeftRightClick(Self);
    Exit;
  end;

  if (Color1 <> Color2) and (Color2 <> Color3) and (Color3 <> Color4) then
  begin
    rbFourColorsClick(Self);
    Exit;
  end;

end;

procedure TSelectFillColorForm.LeftClick(Sender: TObject);
var
  DestColor: Cardinal;
begin
  if SelectColor(DestColor, DisplaceRB((Sender as TAVColorBox).Color)) then
  begin
    (Sender as TAVColorBox).Color := DisplaceRB(DestColor);
  end;

  Self.rbLeftRightClick(Sender);
end;

procedure TSelectFillColorForm.rbFourColorsClick(Sender: TObject);
begin
  rbSingle.Checked := False;
  rbLeftRight.Checked := False;
  rbTopBottom.Checked := False;
  rbFourColors.Checked := True;
  UpdateColorPreview;
end;

procedure TSelectFillColorForm.rbLeftRightClick(Sender: TObject);
begin
  rbSingle.Checked := False;
  rbLeftRight.Checked := True;
  rbTopBottom.Checked := False;
  rbFourColors.Checked := False;
  UpdateColorPreview;
end;

procedure TSelectFillColorForm.rbSingleClick(Sender: TObject);
begin
  rbSingle.Checked := True;
  rbLeftRight.Checked := False;
  rbTopBottom.Checked := False;
  rbFourColors.Checked := False;
  UpdateColorPreview;
end;

procedure TSelectFillColorForm.rbTopBottomClick(Sender: TObject);
begin
  rbSingle.Checked := False;
  rbLeftRight.Checked := False;
  rbTopBottom.Checked := True;
  rbFourColors.Checked := False;
  UpdateColorPreview;
end;

procedure TSelectFillColorForm.SetColors;
begin
  if rbSingle.Checked then
  begin
    Color1 := DisplaceRB(Single.Color);
    Color2 := DisplaceRB(Single.Color);
    Color3 := DisplaceRB(Single.Color);
    Color4 := DisplaceRB(Single.Color);
  end;
  if rbLeftRight.Checked then
  begin
    Color1 := DisplaceRB(Left.Color);
    Color2 := DisplaceRB(Right.Color);
    Color3 := DisplaceRB(Left.Color);
    Color4 := DisplaceRB(Right.Color);
  end;
  if rbTopBottom.Checked then
  begin
    Color1 := DisplaceRB(Top.Color);
    Color2 := DisplaceRB(Top.Color);
    Color3 := DisplaceRB(Bottom.Color);
    Color4 := DisplaceRB(Bottom.Color);
  end;
  if rbFourColors.Checked then
  begin
    Color1 := DisplaceRB(TopLeft.Color);
    Color2 := DisplaceRB(TopRight.Color);
    Color3 := DisplaceRB(BottomLeft.Color);
    Color4 := DisplaceRB(BottomRight.Color);
  end;
end;

procedure TSelectFillColorForm.SingleClick(Sender: TObject);
var
  DestColor: Cardinal;
begin
  if SelectColor(DestColor, DisplaceRB((Sender as TAVColorBox).Color)) then
  begin
    (Sender as TAVColorBox).Color := DisplaceRB(DestColor);
  end;

  Self.rbSingleClick(Sender);
end;

procedure TSelectFillColorForm.TopClick(Sender: TObject);
var
  DestColor: Cardinal;
begin
  if SelectColor(DestColor, DisplaceRB((Sender as TAVColorBox).Color)) then
  begin
    (Sender as TAVColorBox).Color := DisplaceRB(DestColor);
  end;

  Self.rbTopBottomClick(Sender);
end;

procedure TSelectFillColorForm.TopLeftClick(Sender: TObject);
var
  DestColor: Cardinal;
begin
  if SelectColor(DestColor, DisplaceRB((Sender as TAVColorBox).Color)) then
  begin
    (Sender as TAVColorBox).Color := DisplaceRB(DestColor);
  end;

  Self.rbFourColorsClick(Sender);
end;

procedure TSelectFillColorForm.UpdateColorPreview;
begin
  if rbSingle.Checked then
  begin
    ColorPreview.TopLeftColor := Single.Color;
    ColorPreview.TopRightColor := Single.Color;
    ColorPreview.BottomLeftColor := Single.Color;
    ColorPreview.BottomRightColor := Single.Color;
  end;
  if rbLeftRight.Checked then
  begin
    ColorPreview.TopLeftColor := Left.Color;
    ColorPreview.TopRightColor := Right.Color;
    ColorPreview.BottomLeftColor := Left.Color;
    ColorPreview.BottomRightColor := Right.Color;
  end;
  if rbTopBottom.Checked then
  begin
    ColorPreview.TopLeftColor := Top.Color;
    ColorPreview.TopRightColor := Top.Color;
    ColorPreview.BottomLeftColor := Bottom.Color;
    ColorPreview.BottomRightColor := Bottom.Color;
  end;
  if rbFourColors.Checked then
  begin
    ColorPreview.TopLeftColor := TopLeft.Color;
    ColorPreview.TopRightColor := TopRight.Color;
    ColorPreview.BottomLeftColor := BottomLeft.Color;
    ColorPreview.BottomRightColor := BottomRight.Color;
  end;
end;

end.
