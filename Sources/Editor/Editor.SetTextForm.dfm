object SetTextForm: TSetTextForm
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Set text...'
  ClientHeight = 252
  ClientWidth = 419
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 8
    Top = 8
    Width = 401
    Height = 201
    ScrollBars = ssBoth
    TabOrder = 0
    WordWrap = False
  end
  object BitBtn1: TBitBtn
    Left = 254
    Top = 219
    Width = 75
    Height = 25
    Caption = '&OK'
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 1
  end
  object BitBtn2: TBitBtn
    Left = 335
    Top = 219
    Width = 75
    Height = 25
    Caption = '&Cancel'
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 2
  end
end
