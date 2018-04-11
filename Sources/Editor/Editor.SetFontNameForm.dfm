object SetFontNameForm: TSetFontNameForm
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Select font...'
  ClientHeight = 355
  ClientWidth = 333
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Ok: TButton
    Left = 244
    Top = 12
    Width = 81
    Height = 25
    Caption = 'Ok'
    ModalResult = 1
    TabOrder = 1
    OnClick = OkClick
  end
  object Cancel: TButton
    Left = 244
    Top = 40
    Width = 81
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 225
    Height = 257
    Caption = 'Font list'
    TabOrder = 0
    object ListBox1: TListBox
      Left = 8
      Top = 16
      Width = 209
      Height = 205
      ItemHeight = 13
      Sorted = True
      TabOrder = 0
      OnDblClick = ListBox1DblClick
    end
    object Import: TButton
      Left = 8
      Top = 224
      Width = 77
      Height = 25
      Caption = 'Import'
      TabOrder = 1
      OnClick = ImportClick
    end
    object Remove: TButton
      Left = 88
      Top = 224
      Width = 77
      Height = 25
      Caption = 'Remove'
      TabOrder = 2
      OnClick = RemoveClick
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 268
    Width = 317
    Height = 77
    Caption = 'Example preview'
    TabOrder = 3
    object PanelExample: TPanel
      Left = 8
      Top = 16
      Width = 300
      Height = 50
      BevelOuter = bvNone
      BorderStyle = bsSingle
      Color = clWhite
      Ctl3D = False
      ParentBackground = False
      ParentCtl3D = False
      TabOrder = 0
    end
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = 'xml'
    Filter = 'Asphyre Font Files (*.xml)|*.xml'
    Left = 264
    Top = 144
  end
end
