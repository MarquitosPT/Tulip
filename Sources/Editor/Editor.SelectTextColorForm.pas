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
{  The Original Code is Editor.SelectTextColorForm.pas.                        }
{                                                                              }
{  The Initial Developer of the Original Code is Marcos Gomes.                 }
{  Portions created by Marcos Gomes are Copyright (C) 2012, Marcos Gomes.      }
{  All Rights Reserved.                                                        }
{                                                                              }
{******************************************************************************}
{                                                                              }
{  Editor.SelectTextColorForm.pas                       Modified: 05-Out-2012  }
{  --------------------------------------------------------------------------  }
{                                                                              }
{                   Implementation of SelectTextColorForm                      }
{                                                                              }
{                                Version 1.02                                  }
{                                                                              }
{******************************************************************************}

unit Editor.SelectTextColorForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons,
  // Asphyre Units
  AVColorBox, AVBevel, AVTypeUtils;

type
  TSelectTextColorForm = class(TForm)
    GroupBox3: TGroupBox;
    Bottom: TAVColorBox;
    Top: TAVColorBox;
    rbTopBottom: TRadioButton;
    GroupBox1: TGroupBox;
    Single: TAVColorBox;
    rbSingle: TRadioButton;
    GroupBox2: TGroupBox;
    Panel1: TPanel;
    ColorPreview: TAVBevel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure rbSingleClick(Sender: TObject);
    procedure rbTopBottomClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure SingleClick(Sender: TObject);
    procedure TopClick(Sender: TObject);
  private
    { Private declarations }
    procedure UpdateColorPreview;
    Procedure SetColors;
  public
    { Public declarations }
    Color1: Cardinal;
    Color2: Cardinal;
    procedure GetColors;
  end;

var
  SelectTextColorForm: TSelectTextColorForm;

function SelectColor(out DestColor: Cardinal; SrcColor: Cardinal = 0): Boolean;
  external 'ColorSel.dll';

implementation

{$R *.dfm}
{ TSelectTextColorForm }

procedure TSelectTextColorForm.BitBtn1Click(Sender: TObject);
begin
  SetColors;
end;

procedure TSelectTextColorForm.GetColors;
begin
  Single.Color := DisplaceRB(Color1);
  Top.Color := DisplaceRB(Color1);
  Bottom.Color := DisplaceRB(Color2);

  if (Color1 = Color2) then
  begin
    rbSingleClick(Self);
  end
  else
  begin
    rbTopBottomClick(Self);
  end;
end;

procedure TSelectTextColorForm.rbSingleClick(Sender: TObject);
begin
  rbSingle.Checked := True;
  rbTopBottom.Checked := False;
  UpdateColorPreview;
end;

procedure TSelectTextColorForm.rbTopBottomClick(Sender: TObject);
begin
  rbSingle.Checked := False;
  rbTopBottom.Checked := True;
  UpdateColorPreview;
end;

procedure TSelectTextColorForm.SetColors;
begin
  if rbSingle.Checked then
  begin
    Color1 := DisplaceRB(Single.Color);
    Color2 := DisplaceRB(Single.Color);
  end;
  if rbTopBottom.Checked then
  begin
    Color1 := DisplaceRB(Top.Color);
    Color2 := DisplaceRB(Bottom.Color);
  end;
end;

procedure TSelectTextColorForm.SingleClick(Sender: TObject);
var
  DestColor: Cardinal;
begin
  if SelectColor(DestColor, DisplaceRB((Sender as TAVColorBox).Color)) then
  begin
    (Sender as TAVColorBox).Color := DisplaceRB(DestColor);
  end;

  Self.rbSingleClick(Sender);
end;

procedure TSelectTextColorForm.TopClick(Sender: TObject);
var
  DestColor: Cardinal;
begin
  if SelectColor(DestColor, DisplaceRB((Sender as TAVColorBox).Color)) then
  begin
    (Sender as TAVColorBox).Color := DisplaceRB(DestColor);
  end;

  Self.rbTopBottomClick(Sender);
end;

procedure TSelectTextColorForm.UpdateColorPreview;
begin
  if rbSingle.Checked then
  begin
    ColorPreview.TopLeftColor := Single.Color;
    ColorPreview.TopRightColor := Single.Color;
    ColorPreview.BottomLeftColor := Single.Color;
    ColorPreview.BottomRightColor := Single.Color;
  end;
  if rbTopBottom.Checked then
  begin
    ColorPreview.TopLeftColor := Top.Color;
    ColorPreview.TopRightColor := Top.Color;
    ColorPreview.BottomLeftColor := Bottom.Color;
    ColorPreview.BottomRightColor := Bottom.Color;
  end;
end;

end.
