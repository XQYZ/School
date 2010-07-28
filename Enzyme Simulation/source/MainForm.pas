unit MainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin, ExtCtrls, XPMan, AdDraws, AdClasses, AdPNG, Enzyme,
  Substate, Products, AdTypes, ComCtrls, Menus, Buttons, ImgList, INIFiles, PNGImage;

type
  TfrmMain = class(TForm)
    Display: TPanel;
    XPManifest1: TXPManifest;
    grbSettings: TGroupBox;
    lblEnzymesCount: TLabel;
    lblSubstatesCount: TLabel;
    speEnzymes: TSpinEdit;
    speSubstates: TSpinEdit;
    grbOverview: TGroupBox;
    lblEnzymesDesc: TLabel;
    lblSubstratesDesc: TLabel;
    lblProductsDesc: TLabel;
    lblEnzymes: TLabel;
    lblSubstates: TLabel;
    lblProducts: TLabel;
    grbControls: TGroupBox;
    MoveTimer: TTimer;
    MainMenu: TMainMenu;
    Simulation1: TMenuItem;
    Start1: TMenuItem;
    Pause1: TMenuItem;
    Stop1: TMenuItem;
    Hilfe1: TMenuItem;
    Info1: TMenuItem;
    btnStart: TBitBtn;
    btnPause: TBitBtn;
    btnStop: TBitBtn;
    ImageList1: TImageList;
    Programm1: TMenuItem;
    Beenden1: TMenuItem;
    lblRunTimeDesc: TLabel;
    lblRunTime: TLabel;
    TimeTimer: TTimer;
    GDIDraw: TTimer;
    DisplayPaint: TPaintBox;
    StopCheck: TCheckBox;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure MoveTimerTimer(Sender: TObject);
    procedure btnPauseClick(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
    procedure Beenden1Click(Sender: TObject);
    procedure Info1Click(Sender: TObject);
    procedure TimeTimerTimer(Sender: TObject);
    procedure GDIDrawTimer(Sender: TObject);
  private
    { Private declarations }
    AdDraw: TAdDraw;
    AdImageList: TAdImageList;
    Enzymes: array of TEnzyme;
    Substates: array of TSubstate;
    Products: array of TProduct;
    GDriver: String;
    EnzImg: TPNGObject;
    SubImg: TPNGObject;
    ProImg: TPNGObject;
    procedure DrawStuff(Sender: TObject; var Done: Boolean);
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;
  Path: String;

implementation

uses About;

{$R *.dfm}

function RectToTAdRect(R: TRect): TAdRect;
begin
  Result.Left := R.Left;
  Result.Right := R.Right;
  Result.Bottom := R.Bottom;
  Result.Top := R.Top;
  Result.TopLeft.X := R.TopLeft.X;
  Result.TopLeft.Y := R.TopLeft.Y;
  Result.BottomRight.X := R.BottomRight.X;
  Result.BottomRight.Y := R.BottomRight.Y;
end;

function CheckCollision(E: TEnzyme; S: TSubstate): Boolean;
var
  C: TPoint;
const
  R: Integer = 30;
begin
  C := Point(S.Position.X + 8, S.Position.Y + 8);
  Result := (C.X > E.Position.X - R) AND (C.X < E.Position.X + R + 32) AND
            (C.Y > E.Position.Y - R) AND (C.Y < E.Position.Y + R + 32);
end;

procedure TfrmMain.DrawStuff(Sender: TObject; var Done: Boolean);
var
  I: Integer;
begin
  Done := False;
  with self.AdDraw do
  begin
    if CanDraw then
    begin
      ClearSurface(clWhite);
      BeginScene;
      for I := 0 to High(self.Products) do
        self.AdImageList.Items[1].Draw(self.AdDraw, self.Products[I].Position.X DIV 2, self.Products[I].Position.Y DIV 2, 0);
      for I := 0 to High(self.Substates) do
        if not self.Substates[I].Hidden then
          self.AdImageList.Items[2].Draw(self.AdDraw, self.Substates[I].Position.X DIV 2, self.Substates[I].Position.Y DIV 2, 0);
      for I := 0 to High(self.Enzymes) do
      begin
        self.AdImageList.Items[0].Draw(self.AdDraw, self.Enzymes[I].Position.X DIV 2, self.Enzymes[I].Position.Y DIV 2, 0);

        if self.Enzymes[I].Attachment <> -1 then
          self.AdImageList.Items[2].Draw(self.AdDraw, self.Enzymes[I].Position.X DIV 2 + 8, self.Enzymes[I].Position.Y DIV 2 + 8, 0);
      end;
      EndScene;
      Flip;
    end;
  end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
var
  ini: TINIFile;
begin
  Path := ExtractFilePath(Application.ExeName);

  if (not FileExists(Path + 'data\Enzyme.png')) or (not FileExists(Path + 'data\Product.png')) or
     (not FileExists(Path + 'data\Substate.png')) then
  begin
    MessageDlg('Image File missing.', mtError, [mbOk], 0);
    Application.Terminate;
  end;

  ini := TINIFile.Create(Path + 'config.ini');
  GDriver := ini.ReadString('main', 'GraphicSupport', 'OpenGL');
  ini.Free;

  DecimalSeparator := '.';
  MainMenu.Images := ImageList1;
  Start1.ImageIndex := 0;
  Pause1.ImageIndex := 1;
  Stop1.ImageIndex := 2;
  Beenden1.ImageIndex := 3;

  SetLength(Enzymes, 0);

  if (LowerCase(GDriver) = 'opengl') or (LowerCase(GDriver) = 'directx') then
  begin
    DisplayPaint.Visible := False;
    self.AdDraw := TAdDraw.Create(Display);
    self.AdDraw.DllName := Path + 'Andorra' + GDriver + '.dll';
    if (not self.AdDraw.Initialize) then
    begin
      MessageDlg('Couldn''t create Andorra2D Interface. Maybe you deleted ' +
                 'the ''' + self.AdDraw.DllName + ''' or your Graphic Card is not supported.',
                 mtError, [mbOk], 0);
      Application.Terminate;
    end;
    self.AdImageList := TAdImageList.Create(self.AdDraw);
    self.AdImageList.Add('Enzyme').Texture.LoadGraphicFromFile(Path + 'data\Enzyme.png');
    self.AdImageList.Add('Product').Texture.LoadGraphicFromFile(Path + 'data\Product.png');
    self.AdImageList.Add('Substate').Texture.LoadGraphicFromFile(Path + 'data\Substate.png');
    self.AdImageList.Restore;

    Application.OnIdle := DrawStuff;
  end
  else if (LowerCase(GDriver) = 'gdi') then
  begin
    Display.Visible := False;
    EnzImg := TPNGObject.Create;
    EnzImg.LoadFromFile(Path + 'data\Enzyme.png');
    SubImg := TPNGObject.Create;
    SubImg.LoadFromFile(Path + 'data\Substate.png');
    ProImg := TPNGObject.Create;
    ProImg.LoadFromFile(Path + 'data\Product.png');
    GDIDraw.Enabled := True;
  end
  else
  begin
    MessageDlg('Don''t know a graphic driver named ' + GDriver + '!', mtError, [mbOk], 0);
    Application.Terminate;
  end;
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  if (LowerCase(GDriver) = 'gdi') then
  begin
    EnzImg.Free;
    SubImg.Free;
    ProImg.Free;
  end
  else if (LowerCase(GDriver) = 'opengl') or (LowerCase(GDriver) = 'directx') then
  begin
    self.AdImageList.Free;
    self.AdDraw.Free;
  end;
end;

procedure TfrmMain.btnStartClick(Sender: TObject);
var
  I: Integer;
begin
  if TimeTimer.Tag = 0 then
  begin
    SetLength(self.Enzymes, self.speEnzymes.Value);
    for I := 0 to High(self.Enzymes) do
      self.Enzymes[I] := TEnzyme.Create(I);
    SetLength(self.Substates, self.speSubstates.Value);
    for I := 0 to High(self.Substates) do
      self.Substates[I] := TSubstate.Create(I);

    SetLength(self.Products, 0);
    for I := 0 to High(self.Products) do
      self.Products[I] := TProduct.Create(I);
  end;
  MoveTimer.Enabled := True;
  TimeTimer.Enabled := True;
end;

procedure TfrmMain.MoveTimerTimer(Sender: TObject);
var
  I, J: Integer;
begin
  MoveTimer.Enabled := False;
  for I := 0 to High(self.Substates) do
    self.Substates[I].Move;
  for I := 0 to High(self.Products) do
    self.Products[I].Move;
  for I := 0 to High(self.Enzymes) do
  begin
    self.Enzymes[I].Move;
    if self.Enzymes[I].Attachment <> -1 then
      self.Substates[self.Enzymes[I].Attachment].Position := Point(self.Enzymes[I].Position.X + 16, self.Enzymes[I].Position.Y + 16);
  end;
  for I := 0 to High(self.Enzymes) do
    for J := 0 to High(self.Substates) do
      if (not self.Substates[J].Hidden) and (CheckCollision(self.Enzymes[I], self.Substates[J])) then
      begin
        if self.Enzymes[I].Attachment = -1 then
        begin
          self.Enzymes[I].Attachment := J;
          self.Substates[J].Hidden := True;
          self.Enzymes[I].Cycle := 33;
        end;
      end;
  for I := 0 to High(self.Enzymes) do
  begin
    if self.Enzymes[I].Attachment <> -1 then
    begin
      Dec(self.Enzymes[I].Cycle);
      if self.Enzymes[I].Cycle = 0 then
      begin
        SetLength(self.Products, Length(self.Products) + 1);
        self.Products[High(self.Products)] := TProduct.Create(High(self.Products));
        self.Products[High(self.Products)].Position := self.Substates[self.Enzymes[I].Attachment].Position;
        self.Enzymes[I].Attachment := -1;
        self.speEnzymes.Tag := self.speEnzymes.Tag + 1;
      end;
    end;
  end;

  self.lblEnzymes.Caption := IntToStr(Length(self.Enzymes));
  self.lblSubstates.Caption := IntToStr(Length(self.Substates) - self.speEnzymes.Tag);
  self.lblProducts.Caption := IntToStr(Length(self.Products));
  MoveTimer.Enabled := True;
end;

procedure TfrmMain.btnPauseClick(Sender: TObject);
begin
  MoveTimer.Enabled := False;
  TimeTimer.Enabled := False;
end;

procedure TfrmMain.btnStopClick(Sender: TObject);
var
  I: Integer;
begin
  self.speEnzymes.Tag := 0;
  MoveTimer.Enabled := False;
  TimeTimer.Enabled := False;
  Sleep(100);
  TimeTimer.Tag := 0;
  lblRunTime.Caption := '0.0s';
  MoveTimer.Tag := 0;
  for I := 0 to high(self.Enzymes) do
    self.Enzymes[I].Free;
  for I := 0 to high(self.Substates) do
    self.Substates[I].Free;
  for I := 0 to high(self.Products) do
    self.Products[I].Free;
  SetLength(self.Enzymes, 0);
  SetLength(self.Substates, 0);
  SetLength(self.Products, 0);
end;

procedure TfrmMain.Beenden1Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmMain.Info1Click(Sender: TObject);
begin
  frmAbout.ShowModal;
end;

procedure TfrmMain.TimeTimerTimer(Sender: TObject);
begin
  TimeTimer.Tag := TimeTimer.Tag + 1;
  lblRunTime.Caption := FormatFloat('0.0', TimeTimer.Tag / 10) + 's';
  if StopCheck.Checked then
    if TimeTimer.Tag = 200 then
      btnPause.OnClick(nil);
end;

procedure TfrmMain.GDIDrawTimer(Sender: TObject);
var
  I: Integer;
begin
  DisplayPaint.Canvas.Brush.Color := clWhite;
  DisplayPaint.Canvas.Rectangle(-1, -1, Display.Width + 1, Display.Height + 1);

  for I := 0 to High(self.Products) do
    DisplayPaint.Canvas.Draw(self.Products[I].Position.X DIV 2, self.Products[I].Position.Y DIV 2, ProImg);

  for I := 0 to High(self.Substates) do
    if not self.Substates[I].Hidden then
      DisplayPaint.Canvas.Draw(self.Substates[I].Position.X DIV 2, self.Substates[I].Position.Y DIV 2, SubImg);



  for I := 0 to High(self.Enzymes) do
  begin
    DisplayPaint.Canvas.Draw(self.Enzymes[I].Position.X DIV 2, self.Enzymes[I].Position.Y DIV 2, EnzImg);

    if self.Enzymes[I].Attachment <> -1 then
      DisplayPaint.Canvas.Draw(self.Enzymes[I].Position.X DIV 2 + 8, self.Enzymes[I].Position.Y DIV 2 + 8, SubImg);
  end;
end;

end.
