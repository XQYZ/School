object frmMain: TfrmMain
  Left = 192
  Top = 122
  BorderStyle = bsToolWindow
  Caption = 'Calculator'
  ClientHeight = 34
  ClientWidth = 191
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Input: TEdit
    Left = 8
    Top = 8
    Width = 177
    Height = 21
    TabOrder = 0
    OnKeyPress = InputKeyPress
  end
end
