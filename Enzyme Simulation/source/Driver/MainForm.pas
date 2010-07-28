unit MainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, INIFiles, StdCtrls, XPMan;

type
  TfrmGraphic = class(TForm)
    OpenGL: TRadioButton;
    DirectX: TRadioButton;
    GDI: TRadioButton;
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    XPManifest1: TXPManifest;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmGraphic: TfrmGraphic;
  Path: String;

implementation

{$R *.dfm}

procedure TfrmGraphic.FormCreate(Sender: TObject);
var
  ini: TINIFile;
  GDriver: String;
begin
  Path := ExtractFilePath(Application.ExeName);
  if FileExists(Path + 'config.ini') then
  begin
    ini := TINIFile.Create(Path + 'config.ini');
    GDriver := LowerCase(ini.ReadString('main', 'GraphicSupport', 'OpenGL'));
    OpenGL.Checked := (GDriver = 'opengl');
    DirectX.Checked := (GDriver = 'directx');
    GDI.Checked := (GDriver = 'gdi');
    ini.Free;
  end;
end;

procedure TfrmGraphic.Button1Click(Sender: TObject);
var
  ini: TINIFile;
  GDriver: String;
begin
  ini := TINIFile.Create(Path + 'config.ini');
  if OpenGL.Checked then GDriver := 'OpenGL';
  if DirectX.Checked then GDriver := 'DirectX';
  if GDI.Checked then GDriver := 'GDI';
  ini.WriteString('main', 'GraphicSupport', GDriver);
  ini.Free;
  Close;
end;

end.
