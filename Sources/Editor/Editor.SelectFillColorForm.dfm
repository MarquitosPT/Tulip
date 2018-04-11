object SelectFillColorForm: TSelectFillColorForm
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Select color...'
  ClientHeight = 334
  ClientWidth = 441
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
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 137
    Height = 58
    Caption = 'Single Color'
    TabOrder = 0
    object Single: TAVColorBox
      Left = 41
      Top = 17
      Width = 32
      Height = 32
      Color = -2135765284
      OuterColor = 2239537
      InnerColor = 14147555
      GridColor1 = 5202032
      GridColor2 = 3687504
      GridSize = 16
      ShowHint = True
      ParentShowHint = False
      OnClick = SingleClick
    end
    object rbSingle: TRadioButton
      Left = 15
      Top = 24
      Width = 17
      Height = 17
      TabOrder = 0
      OnClick = rbSingleClick
    end
  end
  object GroupBox2: TGroupBox
    Left = 9
    Top = 68
    Width = 136
    Height = 58
    Caption = 'Gradient Left to Right'
    TabOrder = 1
    object Right: TAVColorBox
      Left = 78
      Top = 18
      Width = 32
      Height = 32
      ParentCustomHint = False
      Color = -2135765284
      OuterColor = 2239537
      InnerColor = 14147555
      GridColor1 = 5202032
      GridColor2 = 3687504
      GridSize = 16
      ShowHint = True
      ParentShowHint = False
      OnClick = LeftClick
    end
    object Left: TAVColorBox
      Left = 40
      Top = 18
      Width = 32
      Height = 32
      Color = -2135765284
      OuterColor = 2239537
      InnerColor = 14147555
      GridColor1 = 5202032
      GridColor2 = 3687504
      GridSize = 16
      ShowHint = True
      ParentShowHint = False
      OnClick = LeftClick
    end
    object rbLeftRight: TRadioButton
      Left = 14
      Top = 26
      Width = 17
      Height = 17
      TabOrder = 0
      OnClick = rbLeftRightClick
    end
  end
  object GroupBox3: TGroupBox
    Left = 9
    Top = 128
    Width = 136
    Height = 58
    Caption = 'Gradient Top to Bottom'
    TabOrder = 2
    object Bottom: TAVColorBox
      Left = 78
      Top = 18
      Width = 32
      Height = 32
      ParentCustomHint = False
      Color = -2135765284
      OuterColor = 2239537
      InnerColor = 14147555
      GridColor1 = 5202032
      GridColor2 = 3687504
      GridSize = 16
      ShowHint = True
      ParentShowHint = False
      OnClick = TopClick
    end
    object Top: TAVColorBox
      Left = 40
      Top = 18
      Width = 32
      Height = 32
      Color = -2135765284
      OuterColor = 2239537
      InnerColor = 14147555
      GridColor1 = 5202032
      GridColor2 = 3687504
      GridSize = 16
      ShowHint = True
      ParentShowHint = False
      OnClick = TopClick
    end
    object rbTopBottom: TRadioButton
      Left = 14
      Top = 26
      Width = 17
      Height = 17
      TabOrder = 0
      OnClick = rbTopBottomClick
    end
  end
  object GroupBox4: TGroupBox
    Left = 8
    Top = 190
    Width = 137
    Height = 100
    Caption = 'Gradient Four Colors'
    TabOrder = 3
    object BottomRight: TAVColorBox
      Left = 79
      Top = 57
      Width = 32
      Height = 32
      Color = -2135765284
      OuterColor = 2239537
      InnerColor = 14147555
      GridColor1 = 5202032
      GridColor2 = 3687504
      GridSize = 16
      ShowHint = True
      ParentShowHint = False
      OnClick = TopLeftClick
    end
    object BottomLeft: TAVColorBox
      Left = 41
      Top = 57
      Width = 32
      Height = 32
      Color = -2135765284
      OuterColor = 2239537
      InnerColor = 14147555
      GridColor1 = 5202032
      GridColor2 = 3687504
      GridSize = 16
      ShowHint = True
      ParentShowHint = False
      OnClick = TopLeftClick
    end
    object TopRight: TAVColorBox
      Left = 79
      Top = 19
      Width = 32
      Height = 32
      ParentCustomHint = False
      Color = -2135765284
      OuterColor = 2239537
      InnerColor = 14147555
      GridColor1 = 5202032
      GridColor2 = 3687504
      GridSize = 16
      ShowHint = True
      ParentShowHint = False
      OnClick = TopLeftClick
    end
    object TopLeft: TAVColorBox
      Left = 41
      Top = 19
      Width = 32
      Height = 32
      Color = -2135765284
      OuterColor = 2239537
      InnerColor = 14147555
      GridColor1 = 5202032
      GridColor2 = 3687504
      GridSize = 16
      ShowHint = True
      ParentShowHint = False
      OnClick = TopLeftClick
    end
    object rbFourColors: TRadioButton
      Left = 15
      Top = 43
      Width = 17
      Height = 17
      TabOrder = 0
      OnClick = rbFourColorsClick
    end
  end
  object GroupBox6: TGroupBox
    Left = 152
    Top = 8
    Width = 281
    Height = 281
    Caption = 'Preview'
    TabOrder = 4
    object Panel1: TPanel
      Left = 8
      Top = 16
      Width = 265
      Height = 257
      BevelOuter = bvNone
      BorderWidth = 1
      Color = clBlack
      ParentBackground = False
      TabOrder = 0
      object ColorPreview: TAVBevel
        Left = 1
        Top = 1
        Width = 263
        Height = 255
        TopLeftColor = 14075574
        TopRightColor = 11049096
        BottomLeftColor = 13153956
        BottomRightColor = 9404014
        BorderColor = 16443872
        ShowBorder = False
        ShowInnerBorder = False
        Align = alClient
        ExplicitWidth = 280
        ExplicitHeight = 279
      end
    end
  end
  object BitBtn1: TBitBtn
    Left = 275
    Top = 300
    Width = 75
    Height = 25
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 5
    OnClick = BitBtn1Click
  end
  object BitBtn2: TBitBtn
    Left = 356
    Top = 300
    Width = 75
    Height = 25
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 6
  end
end
