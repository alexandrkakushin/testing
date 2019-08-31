unit F_main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, XPMan, StdCtrls, Buttons, ComCtrls, ExtCtrls, IniFiles, FileCtrl,
  ShellCtrls;

type
  TfmMain = class(TForm)
    pcSettings: TPageControl;
    tsConnect: TTabSheet;
    btnOK: TBitBtn;
    btnCancel: TBitBtn;
    XPManifest: TXPManifest;
    leHost: TLabeledEdit;
    btnConnect: TBitBtn;
    pbFind: TProgressBar;
    procedure btnCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnConnectClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmMain: TfmMain;
  
  cfg : TIniFile;
  sDir : string;

implementation

{$R *.dfm}

procedure TfmMain.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfmMain.FormCreate(Sender: TObject);
begin

  cfg:=TIniFile.Create(ExtractFilePath(Application.ExeName)+'Settings.ini');
  leHost.Text:=cfg.ReadString('Connect','Host','127.0.0.1');

end;

procedure TfmMain.btnOKClick(Sender: TObject);
begin
  cfg.WriteString('Connect','Host',leHost.Text);
  Close;
end;

procedure TfmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  cfg.WriteString('Connect','Dir',sDir);
  cfg.Free;
end;

procedure TfmMain.btnConnectClick(Sender: TObject);
label Jump;
var
  slShara : TShellComboBox;
  i : integer;
  sFind : string;
  bResult : boolean;
begin
  //Создание
  bResult:=false;
  slShara:=TShellComboBox.Create(Self);
  slShara.Parent:=fmMain;
  slShara.Items.BeginUpdate;
  slShara.Visible:=false;
  slShara.Root:='\\'+leHost.Text;

  pbFind.Position:=1;
  pbFind.Min:=1;
  pbFind.Max:=slShara.Items.Count-1;

  //Просмотр каждого ресурса
  for i:=1 to slShara.Items.Count-1 do
  begin
    pbFind.Position:=i;

    sFind:='\\'+leHost.Text+'\'+slShara.Items.Strings[i];

    if FileExists(sFind+'\connect.dat') = true then
    begin
      sDir:=sFind;
      bResult:=true;
      goto Jump;
    end;

  end;

  Jump:
  pbFind.Position:=1;
  if bResult = true
    then MessageDlg('Подключение выполнено успешно',mtInformation,[mbOK],0)
    else MessageDlg('Ошибка подключения',mtError,[mbOK],0);

  //Удаление
  slShara.Items.EndUpdate;
  slShara.Free;


end;

end.
