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

program Sudoku;

uses
  Forms,
  MainForm in 'units\MainForm.pas' {frmSudoku},
  SudokuClass in 'units\SudokuClass.pas',
  DifficoultyForm in 'units\DifficoultyForm.pas' {frmDifficoulty},
  AboutForm in 'units\AboutForm.pas' {frmAbout};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Sudoku';
  Application.CreateForm(TfrmSudoku, frmSudoku);
  Application.CreateForm(TfrmDifficoulty, frmDifficoulty);
  Application.CreateForm(TfrmAbout, frmAbout);
  Application.Run;
end.
