unit FRenameGroup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, U_TestServer;

type
  TfmRenameGroup = class(TForm)
    Label1: TLabel;
    lCurrentName: TLabel;
    leNewName: TLabeledEdit;
    btnOk: TBitBtn;
    btnCancel: TBitBtn;
    procedure btnCancelClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    bCloseOK : boolean;
  public
    pNameGroup : string;
  end;

var
  fmRenameGroup : TfmRenameGroup;
  afRenameGroup : TActionForm;

implementation

{$R *.dfm}

procedure TfmRenameGroup.btnCancelClick(Sender: TObject);
begin
  //�������� ����
  afRenameGroup:=Cancel;
  Close;
end;

procedure TfmRenameGroup.btnOkClick(Sender: TObject);
begin
  //�������������
  bCloseOK:=true;
  pNameGroup:=leNewName.Text;

  //��������
  Close;
end;

procedure TfmRenameGroup.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if bCloseOK=false then afRenameGroup:=Cancel;
end;

procedure TfmRenameGroup.FormShow(Sender: TObject);
begin
  //������������ �����
  lCurrentName.Caption:=pNameGroup;
  leNewName.Text:=pNameGroup;
  leNewName.SetFocus;
  leNewName.SelectAll;
end;

end.
