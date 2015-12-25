{******************************************************************************}
{                                                                              }
{                        Tulip - User Interface Library                        }
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
{  The Original Code is Tulip.UI.Types.pas.                                    }
{                                                                              }
{  The Initial Developer of the Original Code is Marcos Gomes.                 }
{  Portions created by Marcos Gomes are Copyright (C) 2012, Marcos Gomes.      }
{  All Rights Reserved.                                                        }
{                                                                              }
{******************************************************************************}
{                                                                              }
{  Tulip.UI.Types.pas                                   Modified: 05-Out-2012  }
{  --------------------------------------------------------------------------  }
{                                                                              }
{                      Type definitions used by Controls                       }
{                                                                              }
{                                Version 1.02                                  }
{                                                                              }
{******************************************************************************}

unit Tulip.UI.Types;

interface

uses
  Winapi.Messages, System.Classes, System.Types, System.UITypes;

const
{$REGION 'Cursors'}
  crDefault = System.UITypes.crDefault;
  crNone = System.UITypes.crNone;
  crArrow = System.UITypes.crArrow;
  crCross = System.UITypes.crCross;
  crIBeam = System.UITypes.crIBeam;
  crSize = System.UITypes.crSize;
  crSizeNESW = System.UITypes.crSizeNESW;
  crSizeNS = System.UITypes.crSizeNS;
  crSizeNWSE = System.UITypes.crSizeNWSE;
  crSizeWE = System.UITypes.crSizeWE;
  crUpArrow = System.UITypes.crUpArrow;
  crHourGlass = System.UITypes.crHourGlass;
  crDrag = System.UITypes.crDrag;
  crNoDrop = System.UITypes.crNoDrop;
  crHSplit = System.UITypes.crHSplit;
  crVSplit = System.UITypes.crVSplit;
  crMultiDrag = System.UITypes.crMultiDrag;
  crSQLWait = System.UITypes.crSQLWait;
  crNo = System.UITypes.crNo;
  crAppStart = System.UITypes.crAppStart;
  crHelp = System.UITypes.crHelp;
  crHandPoint = System.UITypes.crHandPoint;
  crSizeAll = System.UITypes.crSizeAll;
{$ENDREGION}
{$REGION 'MouseButtons'}
  mbLeft = System.UITypes.TMouseButton.mbLeft;
  mbRight = System.UITypes.TMouseButton.mbRight;
  mbMiddle = System.UITypes.TMouseButton.mbMiddle;
{$ENDREGION}

type

{$REGION 'Controls'}
  TAColor = Cardinal;

  TEdge = (eLeft, eTop, eRight, eBottom);
  TEdges = set of Tulip.UI.Types.TEdge;
  TConstraintSize = 0 .. MaxInt;

  TControlState = set of (csLButtonDown, csClicked, csPalette, csReadingState,
    csAlignmentNeeded, csFocusing, csCreating, csPaintCopy, csCustomPaint,
    csDestroyingHandle, csDocking, csDesignerHide, csPanning, csRecreating,
    csAligning, csGlassPaint, csPrintClient, csMouseHover);

  TFocusRect = (fNone, fLight, fDark);

  TMouseButton = System.UITypes.TMouseButton;

  TProgressDisplay = (pdNone, pdValue, pdPercentage, pdCustom);

  TTabOrder = System.UITypes.TTabOrder;

  TUpDownType = (udNone, udUp, udDown);

{$ENDREGION}
{$REGION 'Events'}
  TMouseEvent = procedure(Sender: TObject; Button: TMouseButton;
    Shift: TShiftState; X, Y: Integer) of object;

  TMouseMoveEvent = procedure(Sender: TObject; Shift: TShiftState;
    X, Y: Integer) of object;

  TKeyEvent = procedure(Sender: TObject; var Key: Word; Shift: TShiftState)
    of object;

  TKeyPressEvent = procedure(Sender: TObject; var Key: Char) of object;

  TMouseWheelEvent = procedure(Sender: TObject; Shift: TShiftState;
    WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean) of object;

  TMouseWheelUpDownEvent = procedure(Sender: TObject; Shift: TShiftState;
    MousePos: TPoint; var Handled: Boolean) of object;

  TShortCutEvent = procedure(var Msg: TWMKey; var Handled: Boolean) of object;
{$ENDREGION}
{$REGION 'Text'}
  TStringArray = array of String;

  TSelection = record
    StartPos, EndPos: Integer;
  end;

  TAChar = record
    Char: Char;
    Width: Integer;
  end;

  TAChars = array of Tulip.UI.Types.TAChar;
  TEditCharCase = (ecNormal, ecUpperCase, ecLowerCase);

  THorizontalAlign = (aLeft, aCenter, aRight, aJustify);

  TVerticalAlign = (aTop, aMiddle, aBottom);

{$ENDREGION}

implementation

end.
