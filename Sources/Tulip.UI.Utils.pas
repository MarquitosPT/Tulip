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
{  The Original Code is Tulip.UI.Utils.pas.                                    }
{                                                                              }
{  The Initial Developer of the Original Code is Marcos Gomes.                 }
{  Portions created by Marcos Gomes are Copyright (C) 2012, Marcos Gomes.      }
{  All Rights Reserved.                                                        }
{                                                                              }
{******************************************************************************}
{                                                                              }
{  Tulip.UI.Utils.pas                                   Modified: 05-Out-2012  }
{  --------------------------------------------------------------------------  }
{                                                                              }
{                        Util routines for handling data                       }
{                                                                              }
{                                Version 1.02                                  }
{                                                                              }
{******************************************************************************}

unit Tulip.UI.Utils;

interface

uses
  System.Classes,
  // Asphyre
  StreamUtils, SystemSurfaces, AsphyreTypes, AsphyreConv, AsphyreBitmaps,
  AsphyrePNG, AsphyreJPG, AsphyreBMP,
  // Tulip UI Units
  Tulip.UI.Classes;
{$REGION 'Colors'}
function cAlpha4(c: TFillColor): TColor4; overload;
function cColor2(c: TTextColor): TColor2; overload;
function cColor4(c: TFillColor): TColor4; overload;
function cColor4(c: TTextColor): TColor4; overload;
{$ENDREGION}
{$REGION 'Lists'}
procedure ListAdd(var List: TList; Item: Pointer);
procedure ListRemove(var List: TList; Item: Pointer);
{$ENDREGION}
{$REGION 'Stream'}
function XmlFileToStream(FileName: String; out AStream: TMemoryStream): Boolean;
function ImageFileToStream(FileName: String;
  out AStream: TMemoryStream): Boolean;
{$ENDREGION}

implementation

{$REGION 'Colors'}
function cAlpha4(c: TFillColor): TColor4;
begin
  Result[0] := cAlpha1(cGetAlpha1(c.TopLeft));
  Result[1] := cAlpha1(cGetAlpha1(c.TopRight));
  Result[2] := cAlpha1(cGetAlpha1(c.BottomRight));
  Result[3] := cAlpha1(cGetAlpha1(c.BottomLeft));
end;

function cColor2(c: TTextColor): TColor2;
begin
  Result[0] := c.Top;
  Result[1] := c.Bottom;
end;

function cColor4(c: TFillColor): TColor4;
begin
  Result[0] := c.TopLeft;
  Result[1] := c.TopRight;
  Result[2] := c.BottomRight;
  Result[3] := c.BottomLeft;
end;

function cColor4(c: TTextColor): TColor4;
begin
  Result[0] := c.Top;
  Result[1] := c.Top;
  Result[2] := c.Bottom;
  Result[3] := c.Bottom;
end;
{$ENDREGION}
{$REGION 'Lists'}

procedure ListAdd(var List: TList; Item: Pointer);
begin
  if List = nil then
    List := TList.Create;
  List.Add(Item);
end;

procedure ListRemove(var List: TList; Item: Pointer);
var
  Count: Integer;
begin
  Count := List.Count;
  if Count > 0 then
  begin
    { On destruction usually the last item is deleted first }
    if List[Count - 1] = Item then
      List.Delete(Count - 1)
    else
      List.Remove(Item);
  end;
  if List.Count = 0 then
  begin
    List.Free;
    List := nil;
  end;
end;
{$ENDREGION}
{$REGION 'Stream'}

function XmlFileToStream(FileName: String; out AStream: TMemoryStream): Boolean;
begin
  Result := False;

  try
    AStream.LoadFromFile(FileName);
  except
    Exit;
  end;

  Result := True;
end;

function ImageFileToStream(FileName: String;
  out AStream: TMemoryStream): Boolean;
var
  AuxMem: Pointer;
  AuxSize: Integer;
  Image: TSystemSurface;
  Index: Integer;
begin
  Image := TSystemSurface.Create;

  Result := BitmapManager.LoadFromFile(FileName, Image);

  if not Result then
  begin
    Image.Free;
    Exit;
  end;

  // --> Format
  StreamPutByte(AStream, Byte(apf_A8R8G8B8));
  // --> Pattern Size
  StreamPutWord(AStream, Image.Width);
  StreamPutWord(AStream, Image.Height);
  // --> Pattern Count
  StreamPutLongInt(AStream, 1);
  // --> Visible Size
  StreamPutWord(AStream, Image.Width);
  StreamPutWord(AStream, Image.Height);
  // --> Texture Size
  StreamPutWord(AStream, Image.Width);
  StreamPutWord(AStream, Image.Height);
  // --> Texture Count
  StreamPutWord(AStream, 1);

  // Allocate auxiliary memory for pixel conversion.
  AuxSize := (Image.Width * AsphyrePixelFormatBits[apf_A8R8G8B8]) div 8;
  AuxMem := AllocMem(AuxSize);

  // Convert pixel data and write it to the stream.
  try
    for Index := 0 to Image.Height - 1 do
    begin
      Pixel32toXArray(Image.ScanLine[Index], AuxMem, apf_A8R8G8B8, Image.Width);
      AStream.WriteBuffer(AuxMem^, AuxSize);
    end;
  except
    FreeMem(AuxMem);
    Image.Free;

    Result := False;
    Exit;
  end;

  // Release auxiliary memory.
  FreeMem(AuxMem);
  Image.Free;

  // position to the beginning of our stream
  AStream.Seek(0, soFromBeginning);

  Result := True;
end;
{$ENDREGION}

end.
