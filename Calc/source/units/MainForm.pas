{
    Calculator
    Copyright (C) 2009 Patrick Lerner [PaddyLerner@gmail.com]

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
  Dialogs, StdCtrls, Math;

type
  TfrmMain = class(TForm)
    Input: TEdit;
    procedure InputKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    function Pop: Real;
    procedure Push(N: Real);
  end;

var
  frmMain: TfrmMain;
  Stack: array of Real;

implementation

{$R *.dfm}

function IsInt(S: String): Boolean;
var
  I: Integer;
begin
  Result := True;
  for I := 1 to Length(S) - 1 do
  begin
    if ((S[I] <> '0') AND (S[I] <> '1') AND (S[I] <> '2') AND
        (S[I] <> '3') AND (S[I] <> '4') AND (S[I] <> '5') AND
        (S[I] <> '6') AND (S[I] <> '7') AND (S[I] <> '8') AND
        (S[I] <> '9') AND (S[I] <> ',') AND (S[I] <> '.')) then
      Result := False;
  end;
end;

function TfrmMain.Pop: Real;
begin
  if Length(Stack) > 0 then
  begin
    Result := Stack[Length(Stack) - 1];
    SetLength(Stack, Length(Stack) - 1);
  end
  else
    Result := 0;
end;

procedure TfrmMain.Push(N: Real);
begin
  SetLength(Stack, Length(Stack) + 1);
  Stack[Length(Stack) - 1] := N;
end;

procedure TfrmMain.InputKeyPress(Sender: TObject; var Key: Char);
var
  S, T: String;
  J: Real;
  I: Integer;
begin
  if Key = #13 then
  begin
    SetLength(Stack, 0);
    S := Input.Text + ' ';
    repeat
      T := Copy(S, 1, Pos(' ', S) - 1);
      S := Copy(S, Pos(' ', S) + 1, Length(S));
      if T = '+' then
      begin
        Push(Pop + Pop);
      end
      else if T = '-' then
      begin
        J := Pop;
        Push(Pop - J);
      end
      else if T = '/' then
      begin
        J := Pop;
        Push(Pop / J);
      end
      else if T = '*' then
      begin
        Push(Pop * Pop);
      end
      else if T = '!' then
      begin
        J := 1;
        for I := 1 to Round(Pop) do
          J := J * I;
        Push(J);
      end
      else if T = 'sqr' then
      begin
        Push(sqr(Pop));
      end
      else if T = 'dub' then
      begin
        J := Pop;
        Push(J);
        Push(J);
      end
      else if T = 'info' then
      begin
        ShowMessage('(c) 2009 by Patrick Lerner - Released under the terms of the GPL v3');
      end
      else if T = 'exit' then
      begin
        Application.Terminate;
      end
      else if T = 'sqrt' then
      begin
        J := Pop;
        if J < 0 then
        begin
          ShowMessage('Warning: Cannot calculate the squareroot of ''' + FloatToStr(J) + '''!');
          Push(0);
        end
        else
          Push(sqrt(J));
      end
      else if T = '=' then
      begin
        ShowMessage(FloatToStr(Pop));
      end
      else if IsInt(T) then
      begin
        Push(StrToFloat(T));
      end
      else
        ShowMessage('Error: What the hell is ''' + T + ''' supposed to be?');
    until S = '';
    J := Pop;
    while J <> 0 do
    begin
      ShowMessage('Left on Stack: ' + FloatToStr(J));
      J := Pop;
    end;
  end;
end;

end.
