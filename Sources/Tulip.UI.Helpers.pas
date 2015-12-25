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
{  The Original Code is Tulip.UI.Helpers.pas.                                  }
{                                                                              }
{  The Initial Developer of the Original Code is Marcos Gomes.                 }
{  Portions created by Marcos Gomes are Copyright (C) 2012, Marcos Gomes.      }
{  All Rights Reserved.                                                        }
{                                                                              }
{******************************************************************************}
{                                                                              }
{  Tulip.UI.Helpers.pas                                 Modified: 23-Mar-2013  }
{  --------------------------------------------------------------------------  }
{                                                                              }
{    Helper routines for importing and saving content from Images and Fonts    }
{                                                                              }
{                                Version 1.03                                  }
{                                                                              }
{******************************************************************************}

unit Tulip.UI.Helpers;

interface

uses
  System.Classes, System.SysUtils, System.Math, System.Generics.Collections,
  // Asphyre Units
  AsphyreDef, AsphyreTypes, AsphyreArchives, AsphyreFonts, AsphyreImages,
  AsphyreXML, MediaUtils, StreamUtils, Vectors2, Vectors2px,
  // Tulip UI Units
  Tulip.UI.Types;

const
  foFonts = 'Fonts\';
  foImages = 'Images\';
  foNone = '';

type

{$REGION 'TAsphyreFont'}
  TAsphyreFontHelper = class helper for TAsphyreFont
  private
    function ParseStream(const Stream: TMemoryStream): Boolean;

  public
    function SaveXmlToArchive(const Archive: TAsphyreArchive;
      const Folder: String = foNone): Boolean;
    function SaveXmlToArchiveFile(const FileName: String;
      const Folder: String = foNone): Boolean;

    function SaveXmlToMemStream: TMemoryStream;

    procedure TextRectEx(const Pos, Size: TPoint2; const Text: UniString;
      const Colors: TColor2; Alpha: SizeFloat;
      const HorizontalAlign: THorizontalAlign = aLeft;
      const VerticalAlign: TVerticalAlign = aTop;
      ParagraphLine: Boolean = True);
  end;
{$ENDREGION}
{$REGION 'TAsphyreFonts'}

  TAsphyreFontsHelper = class helper for TAsphyreFonts
    function InsertFromArchive(const Name: String;
      const Archive: TAsphyreArchive; const Folder: String = foNone): Integer;
    function InsertFromArchiveFile(const Name, FileName: String;
      const Folder: String = foNone): Integer;

    function InsertFromMemStream(const Name: String;
      const FontStream, ImageStream: TMemoryStream): Integer;

    function SaveAllToArchive(const Archive: TAsphyreArchive;
      const Folder: String = foNone): Boolean;
    function SaveAllToArchiveFile(const FileName: String;
      const Folder: String = foNone): Boolean;

    function SaveToArchive(const Name: String; const Archive: TAsphyreArchive;
      const Folder: String = foNone): Boolean; overload;
    function SaveToArchiveFile(const Name, FileName: String;
      const Folder: String = foNone): Boolean; overload;

    function SaveToArchive(const Index: Integer; const Archive: TAsphyreArchive;
      const Folder: String = foNone): Boolean; overload;
    function SaveToArchiveFile(const Index: Integer; const FileName: String;
      const Folder: String = foNone): Boolean; overload;
  end;
{$ENDREGION}
{$REGION 'TAsphyreImage'}

  TAsphyreImageHelper = class helper for TAsphyreImage
    function SaveToArchive(const Archive: TAsphyreArchive;
      const Folder: String = foNone): Boolean;
    function SaveToArchiveFile(const FileName: String;
      const Folder: String = foNone): Boolean;

    function SaveToMemStream: TMemoryStream;
  end;
{$ENDREGION}
{$REGION 'TAsphyreImages'}

  TAsphyreImagesHelper = class helper for TAsphyreImages
    function InsertFromArchive(const Name: String;
      const Archive: TAsphyreArchive; const Folder: String = foNone): Integer;
    function InsertFromArchiveFile(const Name, FileName: String;
      const Folder: String = foNone): Integer;

    function InsertFromStream(const Name: String;
      const ImageStream: TMemoryStream): Integer;

    function SaveAllToArchive(const Archive: TAsphyreArchive;
      const Folder: String = foNone): Boolean;
    function SaveAllToArchiveFile(const FileName: String;
      const Folder: String = foNone): Boolean;

    function SaveToArchive(const Name: String; const Archive: TAsphyreArchive;
      const Folder: String = foNone): Boolean; overload;
    function SaveToArchiveFile(const Name, FileName: String;
      const Folder: String = foNone): Boolean; overload;

    function SaveToArchive(const Index: Integer; const Archive: TAsphyreArchive;
      const Folder: String = foNone): Boolean; overload;
    function SaveToArchiveFile(const Index: Integer; const FileName: String;
      const Folder: String = foNone): Boolean; overload;
  end;
{$ENDREGION}

implementation

{$REGION 'TAsphyreFont'}
{ TAsphyreFontHelper }

function TAsphyreFontHelper.ParseStream(const Stream: TMemoryStream): Boolean;
var
  Node, Child: TXMLNode;
begin
  Node := LoadXMLFromStream(Stream);

  Result := Node <> nil;
  if (not Result) then
    Exit;

  Self.FFontSize.x := ParseInt(Node.FieldValue['width'], 0);
  Self.FFontSize.y := ParseInt(Node.FieldValue['height'], 0);
  Self.Kerning := ParseFloat(Node.FieldValue['kerning'], 0);

  for Child in Node do
    if (SameText(Child.Name, 'item')) then
      Self.ParseEntry(Child);

  FreeAndNil(Node);
end;

function TAsphyreFontHelper.SaveXmlToArchive(const Archive: TAsphyreArchive;
  const Folder: String = foNone): Boolean;
var
  Stream: TMemoryStream;
begin
  Result := False;

  if (Archive = nil) then
    Exit;

  Stream := Self.SaveXmlToMemStream;

  if Stream = nil then
    Exit;

  Result := Archive.WriteRecord(Folder + Self.Name + '.xml', Stream.Memory,
    Stream.Size, artFile);

  Stream.Free;
end;

function TAsphyreFontHelper.SaveXmlToArchiveFile(const FileName: String;
  const Folder: String = foNone): Boolean;
var
  Media: TAsphyreArchive;
begin
  Media := TAsphyreArchive.Create;

  ArchiveTypeAccess := ataAnyFile;
  Media.OpenMode := aomUpdate;

  Result := Media.OpenFile(FileName);

  if (Result) then
  begin
    Result := SaveXmlToArchive(Media, Folder);
  end;

  Media.Free;
end;

function TAsphyreFontHelper.SaveXmlToMemStream: TMemoryStream;
var
  Node, Child: TXMLNode;
  Stream: TMemoryStream;
  BoolResult: Boolean;
  Entry: TLetterEntry;
  I: Integer;
begin
  Node := TXMLNode.Create('font');
  Node.AddField('width', IntToStr(Self.FFontSize.x));
  Node.AddField('height', IntToStr(Self.FFontSize.y));
  Node.AddField('kerning', FloatToStr(Self.Kerning));

  for I := 0 to 65535 do
  begin
    Entry := Self.Entries[I];

    if ((Entry.Top = 0) and (Entry.Pos = Point2px(0, 0)) and
      (Entry.Size = Point2px(0, 0)) and (Entry.Leading = 0) and
      (Entry.Trailing = 0)) then
    begin
      Continue;
    end;

    Child := Node.AddChild('item');

    if I <= 126 then
    begin
      Child.AddField('ascii', IntToStr(I));
    end
    else
    begin
      Child.AddField('ucode', IntToStr(I));
    end;
    if (I > 32) and (I <> 34) then
      Child.AddField('raw', WideChar(I));
    Child.AddField('top', IntToStr(Entry.Top));
    Child.AddField('x', IntToStr(Entry.Pos.x));
    Child.AddField('y', IntToStr(Entry.Pos.y));
    Child.AddField('width', IntToStr(Entry.Size.x));
    Child.AddField('height', IntToStr(Entry.Size.y));
    Child.AddField('leading', IntToStr(Entry.Leading));
    Child.AddField('trailing', IntToStr(Entry.Trailing));
  end;

  Stream := TMemoryStream.Create;
  BoolResult := Node.SaveToStream(Stream);

  if not BoolResult then
  begin
    Stream.Free;
    FreeAndNil(Node);
    Result := nil;
    Exit;
  end;

  Result := Stream;

  FreeAndNil(Node);
end;

procedure TAsphyreFontHelper.TextRectEx(const Pos, Size: TPoint2;
  const Text: UniString; const Colors: TColor2; Alpha: SizeFloat;
  const HorizontalAlign: THorizontalAlign; const VerticalAlign: TVerticalAlign;
  ParagraphLine: Boolean);
var
  Para, ParaTo: Integer;
  WordNo, WordTo, NoWords, Index: Integer;
  CurSize, PreSize, BlnkSpace, MaxSize, Height, Ident, PosAdd: Single;
  CurPos: TPoint2;

  I, ParaNo: Integer;
  EmptySizeX, EmptySizeY, xPos, YPos: Single;
  LineText: WideString;
  Lines: TList<UniString>;
  ParaList: TList<Integer>;
begin
  Lines := TList<UniString>.Create;
  ParaList := TList<Integer>.Create;

  Self.SplitText(Text);

  Para := -1;
  ParaNo := 0;
  WordNo := 0;

  Self.ClearStyles();
  Self.PushStyle(Colors, 0);

  CurPos.x := Pos.x;
  CurPos.y := Pos.y;
  Height := 0;
  MaxSize := Size.x;

  while (WordNo < Length(Self.Words)) do
  begin
    CurSize := 0;
    BlnkSpace := 0;

    WordTo := WordNo;
    ParaTo := Para;

    while (CurSize + BlnkSpace < MaxSize) and (WordTo < Length(Self.Words)) and
      (ParaTo = Para) do
    begin
      CurSize := CurSize + TextWidth(Self.Words[WordTo].Text);
      BlnkSpace := BlnkSpace + Self.FWhitespace * Self.FScale;
      ParaTo := Self.Words[WordTo].ParaNum;

      Inc(WordTo);
    end;

    NoWords := (WordTo - WordNo) - 1;
    if (WordTo >= Length(Self.Words)) and (CurSize + BlnkSpace < MaxSize) then
    begin
      Inc(NoWords);
    end;

    if (NoWords < 1) then
    begin
      // Case 1. New paragraph.
      if (ParaTo <> Para) then
      begin
        Para := ParaTo;

        if (WordNo >= 1) and (HorizontalAlign = aJustify) then
        begin
          ParaList.Add(ParaNo);
        end;

        if (WordNo >= 1) and (ParagraphLine) then
          Lines.Add('');

        Inc(ParaNo);
        Continue;
      end
      else
        // Case 2. Exhausted words or size doesn't fit.
        Break;
    end;

    if ((Height + Self.FLinespace) * (Lines.Count + 1)) <= Size.y then
    begin
      LineText := '';
      for Index := WordNo to WordNo + NoWords - 1 do
      begin
        if Index = (WordNo + NoWords - 1) then
          LineText := LineText + Self.Words[Index].Text
        else
          LineText := LineText + Self.Words[Index].Text + ' ';
      end;
      Lines.Add(LineText);

      // Calculate max line height
      Height := Max(Height, TextHeight(LineText));
    end
    else
      Break;

    Inc(ParaNo);
    Inc(WordNo, NoWords);
  end;

  // Draw all lines
  for I := 0 to Lines.Count - 1 do
  begin
    EmptySizeX := Size.x - TextWidth(Lines[I]);
    EmptySizeY := Size.y - ((Height + Self.FLinespace) * (Lines.Count));

    case VerticalAlign of
      aTop:
        YPos := CurPos.y;
      aMiddle:
        YPos := CurPos.y + Round(EmptySizeY / 2);
      aBottom:
        YPos := CurPos.y + Round(EmptySizeY);
    else
      YPos := CurPos.y;
    end;

    case HorizontalAlign of
      aLeft:
        xPos := CurPos.x;
      aCenter:
        xPos := CurPos.x + Round(EmptySizeX / 2);
      aRight:
        xPos := CurPos.x + Round(EmptySizeX);
      aJustify:
        begin
          xPos := CurPos.x;

          Self.SplitText(Lines[I]);

          PreSize := 0.0;
          for index := 0 to Length(Self.Words) - 1 do
          begin
            PreSize := PreSize + TextWidth(Self.Words[Index].Text);
          end;

          if (Length(Self.Words) - 1) > 0 then
            Ident := (Size.x - PreSize) / (Length(Self.Words) - 1)
          else
            Ident := 0.0;

          // Next line is paragraph
          for index := 0 to ParaList.Count - 1 do
          begin
            if ParagraphLine then
              if (ParaList[index] = (I + 2)) then
              begin
                Ident := Self.FWhitespace * Self.FScale;
                Break;
              end
              else if (ParaList[index] = (I + 1)) then
              begin
                Ident := Self.FWhitespace * Self.FScale;
                Break;
              end;
          end;

          // Is the last Line
          if (I = (Lines.Count - 1)) then
            Ident := Self.FWhitespace * Self.FScale;

          // Draw word by word
          PosAdd := 0.0;
          for Index := 0 to Length(Self.Words) - 1 do
          begin
            Self.DisplayText(Point2(xPos + Round(PosAdd), YPos),
              Self.Words[Index].Text, Alpha);
            PosAdd := PosAdd + Self.TextWidth(Self.Words[Index].Text) + Ident;
          end;
        end
    else
      xPos := CurPos.x;
    end;

    if HorizontalAlign <> aJustify then
      Self.DisplayText(Point2(xPos, YPos), Lines[I], Alpha);

    CurPos.x := Pos.x;
    CurPos.y := CurPos.y + Height + Self.FLinespace;
  end;

  Self.ClearStyles();

  Lines.Free;
  ParaList.Free;
end;
{$ENDREGION}
{$REGION 'TAsphyreFonts'}
{ TAsphyreFontsHelper }

function TAsphyreFontsHelper.InsertFromArchive(const Name: String;
  const Archive: TAsphyreArchive; const Folder: String = foNone): Integer;
var
  FontStream: TMemoryStream;
  ImageStream: TMemoryStream;
begin
  Result := -1;

  if (Archive = nil) then
    Exit;

  FontStream := TMemoryStream.Create;

  if not(Archive.ReadMemStream(Folder + Name + '.xml', FontStream)) then
  begin
    FontStream.Free;
    Exit;
  end;

  ImageStream := TMemoryStream.Create;

  if not(Archive.ReadMemStream(Folder + Name + '.image', ImageStream)) then
  begin
    FontStream.Free;
    ImageStream.Free;
    Exit;
  end;

  Result := InsertFromMemStream(Name, FontStream, ImageStream);

  FontStream.Free;
  ImageStream.Free;
end;

function TAsphyreFontsHelper.InsertFromArchiveFile(const Name, FileName: String;
  const Folder: String = foNone): Integer;
var
  Media: TAsphyreArchive;
begin
  Result := -1;

  Media := TAsphyreArchive.Create;

  ArchiveTypeAccess := ataAnyFile;
  Media.OpenMode := aomReadOnly;

  if (Media.OpenFile(FileName)) then
  begin
    Result := InsertFromArchive(Name, Media, Folder);
  end;

  Media.Free;
end;

function TAsphyreFontsHelper.InsertFromMemStream(const Name: String;
  const FontStream, ImageStream: TMemoryStream): Integer;
var
  ImageIndex: Integer;
begin
  Result := -1;

  // (1) Check whether a valid image list is provided.
  if (Self.FImages = nil) then
    Exit;

  // (2) Resolve the bitmap font's graphics.
  ImageIndex := Self.FImages.InsertFromStream(Name, ImageStream);
  if (ImageIndex = -1) then
    Exit;

  // (3) Create new font and try to parse its description.
  Result := Self.InsertFont();
  if (not Self.Fonts[Result].ParseStream(FontStream)) then
  begin
    RemoveFont(Result);
    Result := -1;
    Exit;
  end;

  // (4) Assign font attributes.
  Self.Fonts[Result].ImageIndex := ImageIndex;
  Self.Fonts[Result].Name := Name;
end;

function TAsphyreFontsHelper.SaveAllToArchive(const Archive: TAsphyreArchive;
  const Folder: String = foNone): Boolean;
var
  I: Integer;
begin
  Result := False;

  if (Archive = nil) or (Self.Count = 0) then
    Exit;

  for I := 0 to Self.Count - 1 do
  begin
    if not(Self.SaveToArchive(Self.Items[I].Name, Archive, Folder)) then
    begin
      Exit;
    end;
  end;

  Result := True;
end;

function TAsphyreFontsHelper.SaveAllToArchiveFile(const FileName: String;
  const Folder: String = foNone): Boolean;
var
  Media: TAsphyreArchive;
begin
  Media := TAsphyreArchive.Create;

  ArchiveTypeAccess := ataAnyFile;
  Media.OpenMode := aomUpdate;

  Result := Media.OpenFile(FileName);

  if (Result) then
  begin
    Result := SaveAllToArchive(Media, Folder);
  end;

  Media.Free;
end;

function TAsphyreFontsHelper.SaveToArchive(const Name: String;
  const Archive: TAsphyreArchive; const Folder: String = foNone): Boolean;
begin
  Result := False;

  if (Archive = nil) then
    Exit;

  if not(Self.Images.Image[Name].SaveToArchive(Archive, Folder)) then
  begin
    Exit;
  end;

  if not(Self.Font[Name].SaveXmlToArchive(Archive, Folder)) then
  begin
    Exit;
  end;

  Result := True;
end;

function TAsphyreFontsHelper.SaveToArchiveFile(const Name, FileName: String;
  const Folder: String = foNone): Boolean;
var
  Media: TAsphyreArchive;
begin
  Media := TAsphyreArchive.Create;

  ArchiveTypeAccess := ataAnyFile;
  Media.OpenMode := aomUpdate;

  Result := Media.OpenFile(FileName);

  if (Result) then
  begin
    Result := Self.SaveToArchive(Name, Media, Folder);
  end;

  Media.Free;
end;

function TAsphyreFontsHelper.SaveToArchive(const Index: Integer;
  const Archive: TAsphyreArchive; const Folder: String = foNone): Boolean;
begin
  Result := False;

  if (Archive = nil) then
    Exit;

  if not(Self.Images.Items[Self.Items[Index].ImageIndex].SaveToArchive(Archive, Folder)) then
  begin
    Exit;
  end;

  if not(Self.Items[Index].SaveXmlToArchive(Archive, Folder)) then
  begin
    Exit;
  end;

  Result := True;
end;

function TAsphyreFontsHelper.SaveToArchiveFile(const Index: Integer;
  const FileName: String; const Folder: String = foNone): Boolean;
var
  Media: TAsphyreArchive;
begin
  Media := TAsphyreArchive.Create;

  ArchiveTypeAccess := ataAnyFile;
  Media.OpenMode := aomUpdate;

  Result := Media.OpenFile(FileName);

  if (Result) then
  begin
    Result := Self.SaveToArchive(Index, Media, Folder);
  end;

  Media.Free;
end;
{$ENDREGION}
{$REGION 'TAsphyreImage'}
{ TAsphyreImageHelper }

function TAsphyreImageHelper.SaveToArchive(const Archive: TAsphyreArchive;
  const Folder: String = foNone): Boolean;
var
  Stream: TMemoryStream;
begin
  Result := False;

  if (Archive = nil) then
    Exit;

  Stream := Self.SaveToMemStream;

  if Stream = nil then
    Exit;

  // position to the beginning of our stream
  Stream.Seek(0, soFromBeginning);
  Result := Archive.WriteRecord(Folder + Self.Name + '.image', Stream.Memory,
    Stream.Size, artImage);

  Stream.Free;
end;

function TAsphyreImageHelper.SaveToArchiveFile(const FileName: String;
  const Folder: String = foNone): Boolean;
var
  Media: TAsphyreArchive;
begin
  Media := TAsphyreArchive.Create;

  ArchiveTypeAccess := ataAnyFile;
  Media.OpenMode := aomUpdate;

  Result := Media.OpenFile(FileName);

  if (Result) then
  begin
    Result := SaveToArchive(Media, Folder);
  end;

  Media.Free;
end;

function TAsphyreImageHelper.SaveToMemStream: TMemoryStream;
var
  ImageStream: TMemoryStream;
  Bits: Pointer;
  Pitch: Integer;
  Index: Integer;
  Bytes: Integer;
  TextureNo: Integer;
  BoolResult: Boolean;
begin
  ImageStream := TMemoryStream.Create;

  // --> Format
  StreamPutByte(ImageStream, Byte(Self.PixelFormat));
  // --> Pattern Size
  StreamPutWord(ImageStream, Self.PatternSize.x);
  StreamPutWord(ImageStream, Self.PatternSize.y);
  // --> Pattern Count
  StreamPutLongInt(ImageStream, Self.PatternCount);
  // --> Visible Size
  StreamPutWord(ImageStream, Self.VisibleSize.x);
  StreamPutWord(ImageStream, Self.VisibleSize.y);
  // --> Texture Size
  StreamPutWord(ImageStream, Self.Texture[0].Width);
  StreamPutWord(ImageStream, Self.Texture[0].Height);
  // --> Texture Count
  StreamPutWord(ImageStream, Self.TextureCount);

  for TextureNo := 0 to Self.TextureCount - 1 do
  begin
    Bytes := Self.Texture[TextureNo].BytesPerPixel * Self.Texture
      [TextureNo].Width;

    Self.Texture[TextureNo].Lock(Bounds(0, 0, Self.Texture[TextureNo].Width,
      Self.Texture[TextureNo].Height), Bits, Pitch);

    BoolResult := (Bits <> nil) and (Pitch > 0);
    if (not BoolResult) then
    begin
      ImageStream.Free;
      Result := nil;
      Exit;
    end;

    for Index := 0 to Self.Texture[TextureNo].Height - 1 do
    begin
      ImageStream.WriteBuffer(Bits^, Bytes);

      Inc(PtrInt(Bits), Pitch);
    end;

    Self.Texture[TextureNo].Unlock();
  end;

  Result := ImageStream;
end;
{$ENDREGION}
{$REGION 'TAsphyreImages'}
{ TAsphyreImagesHelper }

function TAsphyreImagesHelper.InsertFromArchive(const Name: String;
  const Archive: TAsphyreArchive; const Folder: String = foNone): Integer;
var
  ImageStream: TMemoryStream;
begin
  Result := -1;

  if (Archive = nil) then
    Exit;

  ImageStream := TMemoryStream.Create;

  if not(Archive.ReadMemStream(Folder + Name + '.image', ImageStream)) then
  begin
    ImageStream.Free;
    Exit;
  end;

  Result := Self.InsertFromStream(Name, ImageStream);

  ImageStream.Free;
end;

function TAsphyreImagesHelper.InsertFromArchiveFile(const Name,
  FileName: String; const Folder: String = foNone): Integer;
var
  Media: TAsphyreArchive;
begin
  Result := -1;

  Media := TAsphyreArchive.Create;

  ArchiveTypeAccess := ataAnyFile;
  Media.OpenMode := aomReadOnly;

  if (Media.OpenFile(FileName)) then
  begin
    Result := Self.InsertFromArchive(Name, Media, Folder);
  end;

  Media.Free;
end;

function TAsphyreImagesHelper.InsertFromStream(const Name: String;
  const ImageStream: TMemoryStream): Integer;
var
  ImageItem: TAsphyreImage;
begin
  ImageItem := TAsphyreImage.Create();

  ImageItem.Name := Name;
  ImageItem.MipMapping := True;
  ImageItem.DynamicImage := False;
  ImageItem.PixelFormat := apf_Unknown;

  ImageStream.Seek(0, soFromBeginning);
  if (not ImageItem.LoadFromStream(ImageStream)) then
  begin
    FreeAndNil(ImageItem);
    Result := -1;
    Exit;
  end;

  Result := Self.Insert(ImageItem);
end;

function TAsphyreImagesHelper.SaveAllToArchive(const Archive: TAsphyreArchive;
  const Folder: String = foNone): Boolean;
var
  I: Integer;
begin
  Result := False;

  if (Archive = nil) or (Self.ItemCount = 0) then
    Exit;

  for I := 0 to Self.ItemCount - 1 do
  begin
    if not (Assigned(Self.Images[I])) then
    begin
      Continue;
    end;

    if not(Self.SaveToArchive(I, Archive, Folder)) then
    begin
      Exit;
    end;
  end;

  Result := True;
end;

function TAsphyreImagesHelper.SaveAllToArchiveFile(const FileName: String;
  const Folder: String = foNone): Boolean;
var
  Media: TAsphyreArchive;
begin
  Media := TAsphyreArchive.Create;

  ArchiveTypeAccess := ataAnyFile;
  Media.OpenMode := aomUpdate;

  Result := Media.OpenFile(FileName);

  if (Result) then
  begin
    Result := Self.SaveAllToArchive(Media, Folder);
  end;

  Media.Free;
end;

function TAsphyreImagesHelper.SaveToArchive(const Index: Integer;
  const Archive: TAsphyreArchive; const Folder: String = foNone): Boolean;
begin
  Result := False;

  if (Archive = nil) then
    Exit;

  if not(Self.Items[Index].SaveToArchive(Archive, Folder)) then
  begin
    Exit;
  end;

  Result := True;
end;

function TAsphyreImagesHelper.SaveToArchive(const Name: String;
  const Archive: TAsphyreArchive; const Folder: String = foNone): Boolean;
begin
  Result := False;

  if (Archive = nil) then
    Exit;

  if not(Self.Image[Name].SaveToArchive(Archive, Folder)) then
  begin
    Exit;
  end;

  Result := True;
end;

function TAsphyreImagesHelper.SaveToArchiveFile(const Index: Integer;
  const FileName: String; const Folder: String = foNone): Boolean;
var
  Media: TAsphyreArchive;
begin
  Media := TAsphyreArchive.Create;

  ArchiveTypeAccess := ataAnyFile;
  Media.OpenMode := aomUpdate;

  Result := Media.OpenFile(FileName);

  if (Result) then
  begin
    Result := Self.SaveToArchive(Index, Media, Folder);
  end;

  Media.Free;
end;

function TAsphyreImagesHelper.SaveToArchiveFile(const Name, FileName: String;
  const Folder: String = foNone): Boolean;
var
  Media: TAsphyreArchive;
begin
  Media := TAsphyreArchive.Create;

  ArchiveTypeAccess := ataAnyFile;
  Media.OpenMode := aomUpdate;

  Result := Media.OpenFile(FileName);

  if (Result) then
  begin
    Result := Self.SaveToArchive(Name, Media, Folder);
  end;

  Media.Free;
end;
{$ENDREGION}

end.
