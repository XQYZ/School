unit Products;

interface

uses
  Windows, MObject;

type
  TProduct = class(TMObject)
  private
  
  public
    constructor Create(Number: Integer);
    destructor Free;
  end;

implementation

constructor TProduct.Create(Number: Integer);
begin
  inherited;
end;

destructor TProduct.Free;
begin
  inherited;
end;

end. 
