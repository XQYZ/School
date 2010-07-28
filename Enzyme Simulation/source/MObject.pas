unit MObject;

interface

uses
  Windows, Classes;

type
  TMObject = class
  private
    moPosition: TPoint;
  protected
    moWidth: Integer;
    moHeight: Integer;
    Vec: TPoint;
  public
    Number: Integer;
    Hidden: Boolean;
    constructor Create(Number: Integer);
    destructor Free;
    procedure Move;
    property Position: TPoint read moPosition write moPosition;
  end;

implementation

constructor TMObject.Create(Number: Integer);
begin
  self.Number := Number;
  Randomize;
  self.moPosition.X :=  Random(800);
  self.moPosition.Y :=  Random(600);
  Vec.X := 6;
  Vec.Y := 6;
  if Random(2) = 0 then Vec.X := - Vec.X;
  if Random(2) = 0 then Vec.Y := - Vec.Y;

  self.moHeight := 16;
  self.moWidth := 16;
  self.Hidden := False;
end;

destructor TMObject.Free;
begin

end;

procedure TMObject.Move;
var
  Vadd: TPoint;
begin
  self.moPosition.X := self.moPosition.X + Round(Vec.X);
  self.moPosition.Y := self.moPosition.Y + Round(Vec.Y);

  if (self.moPosition.X < 0) then
  begin
    Vec.X := - Vec.X;
    Vec.Y := Vec.Y + Random(4) - 2;
    self.moPosition.X := 0;
  end
  else if (self.moPosition.X > 800 - self.moWidth*2) then
  begin
    Vec.X := - Vec.X;
    Vec.Y := Vec.Y + Random(4) - 2;
    self.moPosition.X := 800 - self.moWidth*2;
  end
  else if (self.moPosition.Y < 0) then
  begin
    Vec.Y := - Vec.Y;
    Vec.X := Vec.X + Random(4) - 2;
    self.moPosition.Y := 0;
  end
  else if (self.moPosition.Y > 600 - self.moHeight*2) then
  begin
    Vec.Y := - Vec.Y;
    Vec.X := Vec.X + Random(4) - 2;
    self.moPosition.Y := 600 - self.moHeight*2;
  end;
end;

end.
 
