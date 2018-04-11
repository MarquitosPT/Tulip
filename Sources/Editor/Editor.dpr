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
{  The Original Code is Editor.dpr.                                            }
{                                                                              }
{  The Initial Developer of the Original Code is Marcos Gomes.                 }
{  Portions created by Marcos Gomes are Copyright (C) 2012, Marcos Gomes.      }
{  All Rights Reserved.                                                        }
{                                                                              }
{******************************************************************************}
{                                                                              }
{  Editor.dpr                                           Modified: 05-Out-2012  }
{  --------------------------------------------------------------------------  }
{                                                                              }
{                                Main program                                  }
{                                                                              }
{                                Version 1.02                                  }
{                                                                              }
{******************************************************************************}

program Editor;

uses
  Vcl.Forms,
  Editor.MainForm in 'Editor.MainForm.pas' {MainForm},
  Editor.Manager in 'Editor.Manager.pas',
  Editor.Types in 'Editor.Types.pas',
  Editor.Classes in 'Editor.Classes.pas',
  Editor.PreviewForm in 'Editor.PreviewForm.pas' {PreviewForm},
  Editor.AboutForm in 'Editor.AboutForm.pas' {AboutForm},
  Editor.SelectFillColorForm in 'Editor.SelectFillColorForm.pas' {SelectFillColorForm},
  Editor.SelectTextColorForm in 'Editor.SelectTextColorForm.pas' {SelectTextColorForm},
  Editor.SetTextForm in 'Editor.SetTextForm.pas' {SetTextForm},
  Editor.SetFontNameForm in 'Editor.SetFontNameForm.pas' {SetFontNameForm},
  Editor.OptionsForm in 'Editor.OptionsForm.pas' {OptionsForm},
  Editor.SetImageForm in 'Editor.SetImageForm.pas' {SetImageForm},
  Editor.ImportImageForm in 'Editor.ImportImageForm.pas' {ImportImageForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Tulip - Graphical User Interface Editor';
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TPreviewForm, PreviewForm);
  Application.CreateForm(TAboutForm, AboutForm);
  Application.CreateForm(TSelectFillColorForm, SelectFillColorForm);
  Application.CreateForm(TSelectTextColorForm, SelectTextColorForm);
  Application.CreateForm(TSetTextForm, SetTextForm);
  Application.CreateForm(TSetFontNameForm, SetFontNameForm);
  Application.CreateForm(TOptionsForm, OptionsForm);
  Application.CreateForm(TSetImageForm, SetImageForm);
  Application.CreateForm(TImportImageForm, ImportImageForm);
  Application.Run;
end.
