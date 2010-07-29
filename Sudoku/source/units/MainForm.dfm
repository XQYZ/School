object frmSudoku: TfrmSudoku
  Left = 192
  Top = 114
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Sudoku'
  ClientHeight = 224
  ClientWidth = 207
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Grid: TStringGrid
    Left = 8
    Top = 8
    Width = 192
    Height = 192
    ColCount = 9
    DefaultColWidth = 20
    DefaultRowHeight = 20
    FixedCols = 0
    RowCount = 9
    FixedRows = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goEditing]
    ScrollBars = ssNone
    TabOrder = 0
    OnDrawCell = GridDrawCell
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 205
    Width = 207
    Height = 19
    Panels = <>
  end
  object MainMenu1: TMainMenu
    Left = 168
    Top = 168
    object Game1: TMenuItem
      Caption = '&Game'
      object NewGame1: TMenuItem
        Caption = '&New Game...'
        ShortCut = 113
        OnClick = NewGame1Click
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Hint1: TMenuItem
        Caption = '&Hint'
        ShortCut = 16456
        OnClick = Hint1Click
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object Exit1: TMenuItem
        Caption = 'E&xit'
        OnClick = Exit1Click
      end
    end
    object Solution1: TMenuItem
      Caption = '&Solution'
      object Comparetosolution1: TMenuItem
        Caption = '&Compare to solution'
        OnClick = Comparetosolution1Click
      end
      object NoHighlight1: TMenuItem
        Caption = '&No Highlight'
        OnClick = NoHighlight1Click
      end
    end
    object Help1: TMenuItem
      Caption = '&Help'
      object Info1: TMenuItem
        Caption = '&Info'
        OnClick = Info1Click
      end
    end
  end
  object XPManifest1: TXPManifest
    Left = 136
    Top = 168
  end
  object Timer: TTimer
    Enabled = False
    OnTimer = TimerTimer
    Left = 104
    Top = 168
  end
end
