unit Enzyme;

interface

uses
  Windows, Classes, MObject, Substate;

type
  TEnzyme = class(TMObject)
  private
  
  public
    Attachment: Integer;
    Cycle: Integer;
    constructor Create(Number: Integer);
    destructor Free;
    procedure Move;
  end;

implementation

constructor TEnzyme.Create(Number: Integer);
begin
  inherited;
  self.moHeight := 32;
  self.moWidth := 32;
  self.Attachment := -1;
  self.Cycle := 0;
end;

destructor TEnzyme.Free;
begin
  inherited;
end;

procedure TEnzyme.Move;
begin
  inherited;
end;

end.
