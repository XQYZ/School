program ChangeDriver;

uses
  Forms,
  MainForm in 'MainForm.pas' {frmGraphic};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Driver Config';
  Application.CreateForm(TfrmGraphic, frmGraphic);
  Application.Run;
end.
