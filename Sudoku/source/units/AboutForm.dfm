object frmAbout: TfrmAbout
  Left = 547
  Top = 248
  BorderStyle = bsDialog
  Caption = 'About Sudoku'
  ClientHeight = 129
  ClientWidth = 231
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 8
    Top = 8
    Width = 217
    Height = 89
    BevelInner = bvRaised
    BevelOuter = bvLowered
    ParentColor = True
    TabOrder = 0
    object ProgramIcon: TImage
      Left = 8
      Top = 8
      Width = 33
      Height = 33
      Picture.Data = {
        055449636F6E0000010001002020100001000400E80200001600000028000000
        2000000040000000010004000000000000000000000000000000000000000000
        0000000000000000FFFFFF000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000111111110111111110111
        1111100000011011111011000011011110111000000110111110110111110111
        1011100000011000111011011111011110111000000110110110110111110111
        1011100000011011011011011111011100111000000110001110110111110111
        1011100000011111111011111111011111111000000000000000000000000000
        0000000000011111111011111111011111111000000110001110110000110111
        1011100000011111011011111101011110111000000111110110110000010100
        0000100000011000111010111101011010111000000110111110101111010111
        0011100000011000011011000011011110111000000111111110111111110111
        1111100000000000000000000000000000000000000111111110111111110111
        1111100000011000011011101111011111111000000111011110111011110111
        1111100000011110111011110111011111111000000111110110111110110111
        1111100000011011011011111011011111111000000111001110110000110111
        1111100000011111111011111111011111111000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000FFFFFFFFFFFFFFFFC0000003C0000003C0000003C0000003C0000003
        C0000003C0000003C0000003C0000003C0000003C0000003C0000003C0000003
        C0000003C0000003C0000003C0000003C0000003C0000003C0000003C0000003
        C0000003C0000003C0000003C0000003C0000003C0000003C0000003FFFFFFFF
        FFFFFFFF}
      Stretch = True
      IsControl = True
    end
    object ProductName: TLabel
      Left = 48
      Top = 8
      Width = 37
      Height = 13
      Caption = 'Sudoku'
      IsControl = True
    end
    object Version: TLabel
      Left = 96
      Top = 8
      Width = 15
      Height = 13
      Caption = '1.0'
      IsControl = True
    end
    object Copyright: TLabel
      Left = 48
      Top = 24
      Width = 154
      Height = 13
      Caption = 'Copyright 2008 by Patrick Lerner'
      IsControl = True
    end
    object Comments: TLabel
      Left = 8
      Top = 48
      Width = 201
      Height = 39
      Caption = 'Released under the tems of the GPL v3 License'
      WordWrap = True
      IsControl = True
    end
  end
  object OKButton: TButton
    Left = 151
    Top = 100
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
    OnClick = OKButtonClick
  end
end
