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

unit DifficoultyForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TfrmDifficoulty = class(TForm)
    rbEasy: TRadioButton;
    rbMedium: TRadioButton;
    rbHard: TRadioButton;
    btnOk: TButton;
    lblDiff: TLabel;
    procedure btnOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDifficoulty: TfrmDifficoulty;

implementation

{$R *.dfm}

procedure TfrmDifficoulty.btnOkClick(Sender: TObject);
begin
  if rbEasy.Checked then
    Self.Tag := 25
  else if rbMedium.Checked then
    Self.Tag := 40
  else if rbHard.Checked then
  begin
    Self.Tag := 60;
    ShowMessage('Good luck, sucker :)');
  end;
  Close;
end;

end.
