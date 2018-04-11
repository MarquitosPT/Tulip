object SetImageForm: TSetImageForm
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Set Image...'
  ClientHeight = 510
  ClientWidth = 707
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnMouseWheel = FormMouseWheel
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Ok: TButton
    Left = 452
    Top = 459
    Width = 77
    Height = 25
    Caption = 'Set image'
    ModalResult = 1
    TabOrder = 0
  end
  object Cancel: TButton
    Left = 624
    Top = 459
    Width = 77
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 197
    Height = 446
    Caption = 'Image list'
    TabOrder = 2
    object ListBoxImages: TListBox
      Left = 8
      Top = 16
      Width = 181
      Height = 393
      ItemHeight = 13
      Sorted = True
      TabOrder = 0
      OnClick = ListBoxImagesClick
    end
    object Import: TButton
      Left = 8
      Top = 412
      Width = 77
      Height = 25
      Caption = 'Import'
      TabOrder = 1
      OnClick = ImportClick
    end
    object Remove: TButton
      Left = 88
      Top = 412
      Width = 77
      Height = 25
      Caption = 'Remove'
      TabOrder = 2
      OnClick = RemoveClick
    end
  end
  object GroupBoxPreview: TGroupBox
    Left = 212
    Top = 8
    Width = 487
    Height = 446
    Caption = 'Image preview'
    TabOrder = 3
    object Label3: TLabel
      Left = 364
      Top = 423
      Width = 30
      Height = 13
      Caption = 'Zoom:'
    end
    object Label1: TLabel
      Left = 20
      Top = 424
      Width = 23
      Height = 13
      Caption = 'Left:'
    end
    object Label2: TLabel
      Left = 96
      Top = 424
      Width = 22
      Height = 13
      Caption = 'Top:'
    end
    object Label4: TLabel
      Left = 172
      Top = 424
      Width = 29
      Height = 13
      Caption = 'Right:'
    end
    object Label5: TLabel
      Left = 256
      Top = 424
      Width = 38
      Height = 13
      Caption = 'Bottom:'
    end
    object Panel1: TPanel
      Left = 8
      Top = 16
      Width = 470
      Height = 400
      BevelOuter = bvNone
      BorderStyle = bsSingle
      Caption = 'Panel1'
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 0
      object PanelExample: TPanel
        Left = 0
        Top = 0
        Width = 450
        Height = 380
        BevelOuter = bvNone
        Color = 10526880
        Ctl3D = False
        ParentBackground = False
        ParentCtl3D = False
        PopupMenu = PopupMenu1
        TabOrder = 0
        TabStop = True
        OnMouseDown = PanelExampleMouseDown
        OnMouseLeave = PanelExampleMouseLeave
        OnMouseMove = PanelExampleMouseMove
        OnMouseUp = PanelExampleMouseUp
      end
      object ScrollBarV: TScrollBar
        Left = 450
        Top = 0
        Width = 17
        Height = 380
        Kind = sbVertical
        PageSize = 0
        TabOrder = 1
        OnChange = ScrollBarVChange
      end
      object ScrollBarH: TScrollBar
        Left = 0
        Top = 380
        Width = 450
        Height = 17
        PageSize = 0
        TabOrder = 2
        OnChange = ScrollBarHChange
      end
    end
    object TrackBarZoom: TTrackBar
      Left = 396
      Top = 419
      Width = 83
      Height = 21
      Max = 4
      Min = 1
      ParentShowHint = False
      PageSize = 1
      Position = 1
      PositionToolTip = ptBottom
      ShowHint = True
      ShowSelRange = False
      TabOrder = 1
      TickMarks = tmBoth
      TickStyle = tsNone
      OnChange = TrackBarZoomChange
    end
    object EditLeft: TEdit
      Left = 44
      Top = 420
      Width = 30
      Height = 21
      NumbersOnly = True
      TabOrder = 2
      Text = '0'
      OnChange = EditLeftChange
    end
    object EditTop: TEdit
      Left = 120
      Top = 420
      Width = 30
      Height = 21
      NumbersOnly = True
      TabOrder = 3
      Text = '0'
      OnChange = EditTopChange
    end
    object EditRight: TEdit
      Left = 204
      Top = 420
      Width = 30
      Height = 21
      NumbersOnly = True
      TabOrder = 4
      Text = '0'
      OnChange = EditRightChange
    end
    object EditBottom: TEdit
      Left = 296
      Top = 420
      Width = 30
      Height = 21
      NumbersOnly = True
      TabOrder = 5
      Text = '0'
      OnChange = EditBottomChange
    end
    object UpDownLeft: TUpDown
      Left = 74
      Top = 420
      Width = 16
      Height = 21
      Associate = EditLeft
      TabOrder = 6
      Thousands = False
    end
    object UpDownTop: TUpDown
      Left = 150
      Top = 420
      Width = 17
      Height = 21
      Associate = EditTop
      TabOrder = 7
      Thousands = False
    end
    object UpDownRight: TUpDown
      Left = 234
      Top = 420
      Width = 17
      Height = 21
      Associate = EditRight
      TabOrder = 8
      Thousands = False
    end
    object UpDownBottom: TUpDown
      Left = 326
      Top = 420
      Width = 17
      Height = 21
      Associate = EditBottom
      TabOrder = 9
      Thousands = False
    end
  end
  object Button1: TButton
    Left = 536
    Top = 459
    Width = 81
    Height = 25
    Caption = 'No image'
    ModalResult = 7
    TabOrder = 4
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 491
    Width = 707
    Height = 19
    Panels = <
      item
        Alignment = taCenter
        Width = 150
      end
      item
        Alignment = taCenter
        Width = 150
      end
      item
        Width = 80
      end>
  end
  object PopupMenu1: TPopupMenu
    Left = 300
    Top = 156
    object PopupReset: TMenuItem
      Caption = 'Reset'
      OnClick = PopupResetClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object PopupHelp: TMenuItem
      Caption = 'Help'
      OnClick = PopupHelpClick
    end
  end
end
