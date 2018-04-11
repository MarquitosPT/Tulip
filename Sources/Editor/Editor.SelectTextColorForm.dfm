object SelectTextColorForm: TSelectTextColorForm
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Select color...'
  ClientHeight = 188
  ClientWidth = 297
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
  object GroupBox3: TGroupBox
    Left = 8
    Top = 79
    Width = 137
    Height = 65
    Caption = 'Gradient Top to Bottom'
    TabOrder = 0
    object Bottom: TAVColorBox
      Left = 78
      Top = 21
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
    object Top: TAVColorBox
      Left = 40
      Top = 21
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
      Left = 17
      Top = 29
      Width = 17
      Height = 17
      TabOrder = 0
      OnClick = rbTopBottomClick
    end
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 137
    Height = 65
    Caption = 'Single Color'
    TabOrder = 1
    object Single: TAVColorBox
      Left = 40
      Top = 22
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
      Left = 17
      Top = 30
      Width = 17
      Height = 17
      TabOrder = 0
      OnClick = rbSingleClick
    end
  end
  object GroupBox2: TGroupBox
    Left = 152
    Top = 8
    Width = 137
    Height = 137
    Caption = 'Preview'
    TabOrder = 2
    object Panel1: TPanel
      Left = 8
      Top = 16
      Width = 121
      Height = 113
      BevelOuter = bvNone
      BorderWidth = 1
      Color = clBlack
      ParentBackground = False
      TabOrder = 0
      object ColorPreview: TAVBevel
        Left = 1
        Top = 1
        Width = 119
        Height = 111
        TopLeftColor = 14075574
        TopRightColor = 11049096
        BottomLeftColor = 13153956
        BottomRightColor = 9404014
        BorderColor = 16443872
        ShowBorder = False
        ShowInnerBorder = False
        Align = alClient
        ExplicitWidth = 160
        ExplicitHeight = 133
      end
    end
  end
  object BitBtn1: TBitBtn
    Left = 132
    Top = 155
    Width = 75
    Height = 25
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 3
    OnClick = BitBtn1Click
  end
  object BitBtn2: TBitBtn
    Left = 213
    Top = 155
    Width = 75
    Height = 25
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 4
  end
end
