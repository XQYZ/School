program SimEnz;

uses
  Forms,
  MainForm in 'MainForm.pas' {frmMain},
  Enzyme in 'Enzyme.pas',
  Substate in 'Substate.pas',
  MObject in 'MObject.pas',
  Products in 'Products.pas',
  About in 'About.pas' {frmAbout};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Enzyme Simulation';
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmAbout, frmAbout);
  Application.Run;
end.
