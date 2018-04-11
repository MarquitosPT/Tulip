object ImportImageForm: TImportImageForm
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Import image file...'
  ClientHeight = 314
  ClientWidth = 448
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 12
    Top = 8
    Width = 333
    Height = 57
    Caption = 'Image source'
    TabOrder = 0
    object Label1: TLabel
      Left = 10
      Top = 27
      Width = 16
      Height = 13
      Caption = 'File'
    end
    object txtFileName: TEdit
      Left = 32
      Top = 24
      Width = 265
      Height = 21
      TabOrder = 0
    end
    object bOpenFile: TButton
      Left = 300
      Top = 22
      Width = 24
      Height = 25
      Caption = '...'
      TabOrder = 1
      OnClick = bOpenFileClick
    end
  end
  object GroupSize: TGroupBox
    Left = 12
    Top = 127
    Width = 185
    Height = 154
    Caption = 'Size properties'
    Enabled = False
    TabOrder = 1
    object Label3: TLabel
      Left = 10
      Top = 92
      Width = 69
      Height = 13
      Caption = 'Texture Width'
    end
    object Label4: TLabel
      Left = 10
      Top = 120
      Width = 72
      Height = 13
      Caption = 'Texture Height'
    end
    object Label5: TLabel
      Left = 10
      Top = 52
      Width = 70
      Height = 13
      Caption = 'Pattern Height'
    end
    object Label6: TLabel
      Left = 10
      Top = 24
      Width = 67
      Height = 13
      Caption = 'Pattern Width'
    end
    object txtTextureWidth: TEdit
      Left = 94
      Top = 89
      Width = 57
      Height = 21
      TabOrder = 4
      Text = '0'
      OnChange = txtTextureWidthChange
    end
    object txtTextureHeight: TEdit
      Left = 94
      Top = 117
      Width = 57
      Height = 21
      TabOrder = 6
      Text = '0'
      OnChange = txtTextureHeightChange
    end
    object txtPatternWidth: TEdit
      Left = 94
      Top = 21
      Width = 57
      Height = 21
      TabOrder = 0
      Text = '0'
      OnChange = txtPatternWidthChange
    end
    object txtPatternHeight: TEdit
      Left = 94
      Top = 49
      Width = 57
      Height = 21
      TabOrder = 2
      Text = '0'
      OnChange = txtPatternHeightChange
    end
    object UpDownTextureWidth: TUpDown
      Left = 151
      Top = 89
      Width = 17
      Height = 21
      Associate = txtTextureWidth
      Increment = 16
      TabOrder = 5
      Thousands = False
      OnChangingEx = UpDownTextureWidthChangingEx
    end
    object UpDownTextureHeight: TUpDown
      Left = 151
      Top = 117
      Width = 17
      Height = 21
      Associate = txtTextureHeight
      Increment = 16
      TabOrder = 7
      Thousands = False
      OnChangingEx = UpDownTextureHeightChangingEx
    end
    object UpDownPatternWidth: TUpDown
      Left = 151
      Top = 21
      Width = 17
      Height = 21
      Associate = txtPatternWidth
      TabOrder = 1
      Thousands = False
    end
    object UpDownPatternHeight: TUpDown
      Left = 151
      Top = 49
      Width = 17
      Height = 21
      Associate = txtPatternHeight
      TabOrder = 3
      Thousands = False
    end
  end
  object GroupAlpha: TGroupBox
    Left = 207
    Top = 71
    Width = 138
    Height = 154
    Caption = 'Alpha Channel'
    Enabled = False
    TabOrder = 2
    object Label2: TLabel
      Left = 36
      Top = 107
      Width = 73
      Height = 13
      Caption = 'Color tolerance'
    end
    object Label7: TLabel
      Left = 54
      Top = 80
      Width = 50
      Height = 13
      Caption = 'Mask color'
    end
    object rbFromSource: TRadioButton
      Left = 12
      Top = 23
      Width = 113
      Height = 17
      Caption = 'From source image'
      Checked = True
      TabOrder = 0
      TabStop = True
      OnClick = rbFromSourceClick
    end
    object rbFromMask: TRadioButton
      Left = 12
      Top = 50
      Width = 113
      Height = 17
      Caption = 'Use bit-mask'
      TabOrder = 1
      OnClick = rbFromMaskClick
    end
    object ToleranceRange: TTrackBar
      Left = 8
      Top = 122
      Width = 121
      Height = 24
      Enabled = False
      Max = 100
      ParentShowHint = False
      PageSize = 10
      PositionToolTip = ptBottom
      ShowHint = True
      ShowSelRange = False
      TabOrder = 3
      TickMarks = tmBoth
      TickStyle = tsNone
    end
    object MaskColor: TPanel
      Left = 28
      Top = 77
      Width = 21
      Height = 21
      Cursor = crHandPoint
      Hint = 'Click to change the color.'
      BevelOuter = bvNone
      BorderStyle = bsSingle
      Color = clWhite
      Ctl3D = False
      Enabled = False
      ParentBackground = False
      ParentCtl3D = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = MaskColorClick
    end
  end
  object GroupKey: TGroupBox
    Left = 12
    Top = 71
    Width = 185
    Height = 50
    Caption = 'Key identifier'
    Enabled = False
    TabOrder = 3
    object txtKeyName: TEdit
      Left = 10
      Top = 19
      Width = 163
      Height = 21
      TabOrder = 0
    end
  end
  object GroupPixel: TGroupBox
    Left = 207
    Top = 231
    Width = 138
    Height = 50
    Caption = 'Pixel format'
    Enabled = False
    TabOrder = 4
    object cbPixelFormat: TComboBox
      Left = 8
      Top = 19
      Width = 121
      Height = 21
      Style = csDropDownList
      TabOrder = 0
      OnChange = cbPixelFormatChange
    end
  end
  object bCancel: TButton
    Left = 359
    Top = 47
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 6
  end
  object bImport: TButton
    Left = 359
    Top = 16
    Width = 75
    Height = 25
    Caption = 'Import'
    Enabled = False
    TabOrder = 5
    OnClick = bImportClick
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 295
    Width = 448
    Height = 19
    Panels = <
      item
        Width = 310
      end
      item
        Alignment = taCenter
        Width = 50
      end>
  end
  object OpenDialog1: TOpenDialog
    Filter = 'Image files (*.png;*.jpg;*.bmp)|*.png;*.jpg;*.bmp'
    Title = 'Open image...'
    Left = 388
    Top = 160
  end
  object ColorDialog1: TColorDialog
    Options = [cdFullOpen]
    Left = 388
    Top = 220
  end
end
