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

unit SudokuClass;

interface

type
  TSuArray = array[0..8] of array[0..8] of Integer;
  TSudoku = class
  private
    function IsAllowed(X, Y: Integer): Boolean;
  public
    Field: TSuArray;
    Solution: TSuArray;
    procedure Generate;
    procedure GenerateField(Difficoulty: Integer);
    constructor Create;
    destructor Free;
  end;

implementation

constructor TSudoku.Create;
begin

end;

destructor TSudoku.Free;
begin

end;

procedure TSudoku.GenerateField(Difficoulty: Integer);
var
  I: Integer;
  X, Y: Integer;
begin
  for I := 0 to Difficoulty do
  begin
    repeat
      X := Random(9);
      Y := Random(9);
    until Field[X, Y] <> 0;
    Field[X, Y] := 0;
  end;
end;

function TSudoku.IsAllowed(X, Y: Integer): Boolean;
var
  BoolArray: array[0..8] of Boolean;
  I, J: Integer;
  OX, OY: Integer;
begin
  // clear
  for I := 0 to 8 do
    BoolArray[I] := False;

  for I := 0 to 8 do
  begin
    // Allowed in Row
    if I <> Y then
      if Field[X, I] <> 0 then
      begin
        BoolArray[Field[X, I] - 1] := True;
      end;
    // Allowed in Row
    if I <> X then
      if Field[I, Y] <> 0 then
      begin
        BoolArray[Field[I, Y] - 1] := True;
      end;
  end;
  // Allowed in 'hood
  OX := (X div 3) * 3;
  OY := (Y div 3) * 3;
  for I := 0 to 2 do
    for J := 0 to 2 do
      if (I <> X - OX) and (J <> Y - OY) then
      begin
        if Field[I + OX, J + OY] <> 0 then
        begin
          BoolArray[Field[I + OX, J + OY] - 1] := True;
        end;
      end;
  Result := not BoolArray[Field[X, Y] - 1];
end;

procedure TSudoku.Generate;
var
  I, J, K, R: Integer;
  B: Boolean;
begin
  // initialize random
  Randomize;
  // do really ugly stuff
  // warning: no comments and it's __really__ hard to get
  for I := 0 to 8 do
    for J := 0 to 8 do
      Field[I, J] := 0;
  I := -1;
  J := -1;
  while I < 8 do
  begin
    R := 0;
    Inc(I);
    J := -1;
    while J < 8 do
    begin
      Inc(J);
      K := 10;
      repeat
        Dec(K);
        Field[J, I] := Random(9) + 1;
      until IsAllowed(J, I) or (K = 0);
      if R > 9 then
      begin
        Generate;
        Exit;
      end;
      if K = 0 then
      begin
        Inc(R);
        B := False;
        for K := 1 to 9 do
        begin
          if not B then
          begin
            Field[J, I] := K;
            if IsAllowed(J, I) then
              B := True;
          end;
        end;
        if not B then
        begin
          for K := 0 to 8 do
            Field[K, I] := 0;
          J := -1;
        end;
      end;
    end;
  end;
  Solution := Field;
end;

end.
