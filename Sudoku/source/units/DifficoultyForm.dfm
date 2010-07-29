object frmDifficoulty: TfrmDifficoulty
  Left = 192
  Top = 110
  BorderStyle = bsToolWindow
  Caption = 'Difficoulty'
  ClientHeight = 137
  ClientWidth = 164
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object lblDiff: TLabel
    Left = 8
    Top = 8
    Width = 148
    Height = 13
    Caption = 'How hard should the game be?'
  end
  object rbEasy: TRadioButton
    Left = 8
    Top = 24
    Width = 113
    Height = 17
    Caption = 'Easy'
    Checked = True
    TabOrder = 0
    TabStop = True
  end
  object rbMedium: TRadioButton
    Left = 8
    Top = 48
    Width = 113
    Height = 17
    Caption = 'Medium'
    TabOrder = 1
  end
  object rbHard: TRadioButton
    Left = 8
    Top = 72
    Width = 113
    Height = 17
    Caption = 'Hard'
    TabOrder = 2
  end
  object btnOk: TButton
    Left = 80
    Top = 104
    Width = 75
    Height = 25
    Caption = '&Ok'
    TabOrder = 3
    OnClick = btnOkClick
  end
end
