{
    Sudoku Game
    Copyright (C) 2008 Patrick Lerner [PaddyLerner@gmail.com]

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
}

unit MainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, ComCtrls, SudokuClass, Menus, XPMan, ExtCtrls;

type
  TfrmSudoku = class(TForm)
    Grid: TStringGrid;
    MainMenu1: TMainMenu;
    Game1: TMenuItem;
    NewGame1: TMenuItem;
    XPManifest1: TXPManifest;
    StatusBar1: TStatusBar;
    N1: TMenuItem;
    Exit1: TMenuItem;
    Solution1: TMenuItem;
    Help1: TMenuItem;
    Info1: TMenuItem;
    Comparetosolution1: TMenuItem;
    NoHighlight1: TMenuItem;
    N2: TMenuItem;
    Hint1: TMenuItem;
    Timer: TTimer;
    procedure GridDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure NewGame1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure NoHighlight1Click(Sender: TObject);
    procedure Comparetosolution1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Info1Click(Sender: TObject);
    procedure Hint1Click(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Sudoku: TSudoku;
    solHigh: Boolean;
    Highlight: TPoint;
  end;

var
  frmSudoku: TfrmSudoku;

implementation

uses DifficoultyForm, AboutForm;

{$R *.dfm}

procedure TfrmSudoku.GridDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var
  S: String;
begin
  // color fields
  if (((ARow DIV 3) <> 1) and ((ACol DIV 3) <> 1)) or
     (((ARow DIV 3) = 1) and ((ACol DIV 3) = 1)) then
    Grid.Canvas.Brush.Color := $A5EBF5;

  if solHigh then
  begin
    if Grid.Cells[ACol, ARow] = IntToStr(Sudoku.Solution[ACol, ARow]) then
      Grid.Canvas.Brush.Color := clGreen
    else
      Grid.Canvas.Brush.Color := clRed;
  end;
  if (Highlight.X <> -1) and (ARow = Highlight.Y) and (ACol = Highlight.X) then
    Grid.Canvas.Brush.Color := clLime;

  Grid.Canvas.FillRect(Rect);

  // draw text
  S := Grid.Cells[ACol, ARow];
  Grid.Canvas.TextOut(Rect.Left + 10 - Grid.Canvas.TextWidth(S) div 2,
                      Rect.Top + 9 - Grid.Canvas.TextHeight(S) div 2, S);
end;

procedure TfrmSudoku.NewGame1Click(Sender: TObject);
var
  I, J: Integer;
begin
  for I := 0 to 8 do
    for J := 0 to 8 do
      Grid.Cells[I, J] := '';
  frmDifficoulty.ShowModal;
  while frmDifficoulty.Showing do
  begin
    Application.ProcessMessages;
    Sleep(100);
  end;
  Sudoku.Generate;
  Sudoku.GenerateField(frmDifficoulty.Tag);
  for I := 0 to 8 do
    for J := 0 to 8 do
      if Sudoku.Field[I, J] <> 0 then
        Grid.Cells[I, J] := IntToStr(Sudoku.Field[I, J]);
  Grid.Repaint;
end;

procedure TfrmSudoku.Exit1Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmSudoku.NoHighlight1Click(Sender: TObject);
begin
  solHigh := False;
  Grid.Repaint;
end;

procedure TfrmSudoku.Comparetosolution1Click(Sender: TObject);
begin
  solHigh := True;
  Grid.Repaint;
end;

procedure TfrmSudoku.FormCreate(Sender: TObject);
begin
  Highlight.X := -1;
  Sudoku := TSudoku.Create;
end;

procedure TfrmSudoku.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Sudoku.Free;
end;

procedure TfrmSudoku.Info1Click(Sender: TObject);
begin
  frmAbout.ShowModal;
end;

procedure TfrmSudoku.Hint1Click(Sender: TObject);
var
  I, J, K: Integer;
  X, Y: Integer;
begin
  K := 0;
  repeat
    Inc(K);
    X := Random(9);
    Y := Random(9);
  until (Grid.Cells[X, Y] = '') or (K = 20);
  if K = 20 then
  begin
    for I := 0 to 8 do
      for J := 0 to 8 do
        if (Grid.Cells[I, J] = '') and (K <> -1) then
        begin
          X := I;
          Y := J;
          K := -1;
        end;
  end
  else
    K := -1;
  if K = -1 then
  begin
    if Sudoku.Solution[X, Y] <> 0 then
    begin
      Grid.Cells[X, Y] := IntToStr(Sudoku.Solution[X, Y]);
      Highlight := Point(X, Y);
      Timer.Enabled := True;
    end;
  end
  else
    ShowMessage('No Free Fields anymore');
  Grid.Repaint;
end;

procedure TfrmSudoku.TimerTimer(Sender: TObject);
begin
  Highlight.X := -1;
  Grid.Repaint;
  Timer.Enabled := False;
end;

end.
