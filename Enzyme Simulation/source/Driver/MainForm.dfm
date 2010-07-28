object frmGraphic: TfrmGraphic
  Left = 192
  Top = 122
  BorderStyle = bsToolWindow
  Caption = 'Driver Config'
  ClientHeight = 145
  ClientWidth = 192
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 153
    Height = 13
    Caption = 'Waehlen Sie den gewuenschten'
  end
  object Label2: TLabel
    Left = 8
    Top = 24
    Width = 175
    Height = 13
    Caption = 'Grafiktreiber fuer die Simulation aus:'
  end
  object OpenGL: TRadioButton
    Left = 16
    Top = 40
    Width = 113
    Height = 17
    Caption = 'OpenGL'
    Checked = True
    TabOrder = 0
    TabStop = True
  end
  object DirectX: TRadioButton
    Left = 16
    Top = 64
    Width = 113
    Height = 17
    Caption = 'DirectX'
    TabOrder = 1
  end
  object GDI: TRadioButton
    Left = 16
    Top = 88
    Width = 113
    Height = 17
    Caption = 'GDI'
    TabOrder = 2
  end
  object Button1: TButton
    Left = 112
    Top = 112
    Width = 75
    Height = 25
    Caption = '&Speichern'
    TabOrder = 3
    OnClick = Button1Click
  end
  object XPManifest1: TXPManifest
    Left = 152
    Top = 56
  end
end
