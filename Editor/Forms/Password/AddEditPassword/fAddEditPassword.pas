unit fAddEditPassword;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, U_Test, StdCtrls, Buttons, ExtCtrls;

type
  TfmAddEditPassword = class(TForm)
    lbledtPass: TLabeledEdit;
    lbledtPassCheck: TLabeledEdit;
    btnOk: TBitBtn;
    btnCancel: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure lbledtPassCheckKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations}
    pPass : string;
    bCloseOK : boolean;
  end;

var
  fmAddEditPassword: TfmAddEditPassword;
  afAddEditPassword : TActionForm;

implementation

{$R *.dfm}

procedure TfmAddEditPassword.FormShow(Sender: TObject);
var
  sCaption : string;
begin
  bCloseOK:=false;

  if afAddEditPassword=ADD
    then sCaption:='Добавление пароля'
    else sCaption:='Изменение пароля';

  fmAddEditPassword.Caption:=sCaption;
  

end;

procedure TfmAddEditPassword.btnCancelClick(Sender: TObject);
begin
  //Закрытие
  afAddEditPassword:=CANCEL;
  close;
end;

procedure TfmAddEditPassword.btnOkClick(Sender: TObject);
begin

  if lbledtPass.Text<>lbledtPassCheck.Text then
  begin
    MessageDlg('Подтвердите ввод пароля!',mtInformation,[mbOk],0);
    lbledtPassCheck.SetFocus;
    lbledtPassCheck.SelectAll;
    exit;
  end;

  pPass:=lbledtPass.Text;
  bCloseOK:=true;

  close;
end;

procedure TfmAddEditPassword.lbledtPassCheckKeyPress(Sender: TObject;
  var Key: Char);
begin
  if key=#13 then btnOk.OnClick(btnOk);
end;

procedure TfmAddEditPassword.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if bCloseOK=false then afAddEditPassword:=Cancel;
end;

end.
