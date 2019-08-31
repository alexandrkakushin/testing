unit FEnterPassword;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TfmEnterPassword = class(TForm)
    lbledtPass: TLabeledEdit;
    btnOk: TBitBtn;
    btnCancel: TBitBtn;
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure lbledtPassKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmEnterPassword: TfmEnterPassword;

implementation

uses F_Main_form;

{$R *.dfm}

procedure TfmEnterPassword.btnOkClick(Sender: TObject);
begin
  //Проверка пароля
  if Test.Password.CheckPass(lbledtPass.Text)=false then
  begin
    MessageDlg('Неверный пароль!',mtError,[mbOk],0);
    lbledtPass.SetFocus;
    lbledtPass.SelectAll;
    exit;
  end;

  //Закрытие формы
  Test.Password.Check:=true;
  close;

end;

procedure TfmEnterPassword.btnCancelClick(Sender: TObject);
begin
  Test.Password.Check:=false;
  close;
end;

procedure TfmEnterPassword.lbledtPassKeyPress(Sender: TObject;
  var Key: Char);
begin
  //При нажатии Enter проверка
  if key=#13 then
  begin
    //Проверка пароля
    if Test.Password.CheckPass(lbledtPass.Text)=false then
    begin
      MessageDlg('Неверный пароль!',mtError,[mbOk],0);
      lbledtPass.SetFocus;
      lbledtPass.SelectAll;
      exit;
    end;

    //Закрытие формы
    Test.Password.Check:=true;
    close;
  end;
  
end;

end.
