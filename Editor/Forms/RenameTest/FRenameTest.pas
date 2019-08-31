unit FRenameTest;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, U_Test;

type
  TfmRenameTest = class(TForm)
    Label1: TLabel;
    lCurrentName: TLabel;
    lbledtNewName: TLabeledEdit;
    btnOk: TBitBtn;
    btnCancel: TBitBtn;
    procedure btnCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure lbledtNewNameExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmRenameTest: TfmRenameTest;

implementation

uses FTopics, F_Main_form;

{$R *.dfm}

procedure TfmRenameTest.btnCancelClick(Sender: TObject);
begin
  //Закрытие окна
  Close;
end;

procedure TfmRenameTest.FormShow(Sender: TObject);
begin
  //Отображение текущего названия
  lCurrentName.Caption:=Test.Subject;
  lbledtNewName.Text:=lCurrentName.Caption;
  lbledtNewName.SetFocus;
  lbledtNewName.SelectAll;
end;

procedure TfmRenameTest.btnOkClick(Sender: TObject);
begin
  //Переименовывание
  Test.Subject:=lbledtNewName.Text;
  fmMain.Caption:='Редактор тестов - '+lbledtNewName.Text;
  bTestModified:=true;

  //Выход
  Close;

end;

procedure TfmRenameTest.lbledtNewNameExit(Sender: TObject);
var
   bError : boolean;
begin
  //Инициализация
  bError:=false;

  if lbledtNewName.Text='' then
  begin
    bError:=true;
    MessageDlg ('Введите назваание теста!',mtInformation,[mbOk],0);
  end;

  if bError=true then
  begin
    lbledtNewName.SetFocus;
    lbledtNewName.SelectAll;
  end;
  
end;

end.
