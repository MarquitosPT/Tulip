object OptionsForm: TOptionsForm
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Options'
  ClientHeight = 260
  ClientWidth = 256
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox2: TGroupBox
    Left = 8
    Top = 8
    Width = 107
    Height = 129
    Caption = 'Editor size'
    TabOrder = 0
    object Label3: TLabel
      Left = 16
      Top = 22
      Width = 28
      Height = 13
      Caption = 'Width'
    end
    object Label4: TLabel
      Left = 16
      Top = 70
      Width = 31
      Height = 13
      Caption = 'Height'
    end
    object EditWidth: TEdit
      Left = 16
      Top = 39
      Width = 71
      Height = 21
      Alignment = taRightJustify
      NumbersOnly = True
      TabOrder = 0
    end
    object EditHeight: TEdit
      Left = 16
      Top = 87
      Width = 71
      Height = 21
      Alignment = taRightJustify
      NumbersOnly = True
      TabOrder = 1
    end
  end
  object GroupBox3: TGroupBox
    Left = 123
    Top = 8
    Width = 122
    Height = 129
    Caption = 'Grid options'
    TabOrder = 1
    object Label5: TLabel
      Left = 24
      Top = 70
      Width = 6
      Height = 13
      Caption = 'X'
    end
    object Label7: TLabel
      Left = 24
      Top = 97
      Width = 6
      Height = 13
      Caption = 'Y'
    end
    object CheckBoxShowGrid: TCheckBox
      Left = 24
      Top = 21
      Width = 89
      Height = 17
      Caption = 'Show Grid'
      TabOrder = 0
    end
    object CheckBoxSnapToGrid: TCheckBox
      Left = 24
      Top = 44
      Width = 89
      Height = 17
      Caption = 'Snap to Grid'
      TabOrder = 1
    end
    object EditX: TEdit
      Left = 36
      Top = 67
      Width = 53
      Height = 21
      TabOrder = 2
      Text = '2'
    end
    object UpDown1: TUpDown
      Left = 89
      Top = 67
      Width = 16
      Height = 21
      Associate = EditX
      Min = 2
      Position = 2
      TabOrder = 3
    end
    object EditY: TEdit
      Left = 36
      Top = 94
      Width = 53
      Height = 21
      TabOrder = 4
      Text = '2'
    end
    object UpDown2: TUpDown
      Left = 89
      Top = 94
      Width = 16
      Height = 21
      Associate = EditY
      Min = 2
      Position = 2
      TabOrder = 5
    end
  end
  object ButtonOk: TButton
    Left = 89
    Top = 227
    Width = 75
    Height = 25
    Caption = 'Apply'
    ModalResult = 1
    TabOrder = 2
    OnClick = ButtonOkClick
  end
  object ButtonCancel: TButton
    Left = 170
    Top = 227
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 3
    OnClick = ButtonCancelClick
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 143
    Width = 237
    Height = 78
    Caption = 'Graphics Provider'
    TabOrder = 4
    object Label1: TLabel
      Left = 11
      Top = 51
      Width = 216
      Height = 13
      Caption = 'Provider will only take effect on next restart.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 11
      Top = 27
      Width = 40
      Height = 13
      Caption = 'Provider'
    end
    object ComboProvider: TComboBox
      Left = 57
      Top = 24
      Width = 99
      Height = 21
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 0
      Text = 'DirectX 9'
      Items.Strings = (
        'DirectX 9'
        'DirectX 10'
        'DirectX 11'
        'OpenGL')
    end
  end
end
