unit Substate;

interface

uses
  Windows, MObject;

type
  TSubstate = class(TMObject)
  private
  public
    constructor Create(Number: Integer);
    destructor Free;
  end;

implementation

constructor TSubstate.Create(Number: Integer);
begin
  inherited;
  Vec.X := 12;
  Vec.Y := 12;
  if Random(2) = 0 then Vec.X := - Vec.X;
  if Random(2) = 0 then Vec.Y := - Vec.Y;
end;

destructor TSubstate.Free;
begin
  inherited;
end;

end.
 
