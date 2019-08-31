unit F_Folder;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, ShellCtrls, U_TestServer;

type
  TfmFolder = class(TForm)
    stvFolder: TShellTreeView;
    btnOK: TBitBtn;
    btnCancel: TBitBtn;
    gbFolder: TGroupBox;
    procedure btnCancelClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    sFileTest : string;

  end;

var
  fmFolder: TfmFolder;

implementation

uses FMainForm, FManagerTest;

{$R *.dfm}

procedure TfmFolder.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfmFolder.btnOKClick(Sender: TObject);

begin
  DBTest.Manager.ExportTest(sFileTest, stvFolder.Path);
  
  close;
end;

procedure TfmFolder.FormShow(Sender: TObject);
begin
  fmFolder.Caption:='Ёкспорт теста - "'+sFileTest+'"';
end;

end.
