unit FAddEditStudent;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, ExtCtrls, Mask, U_TestServer;

type
  TfmAddEditStudent = class(TForm)
    pnlGroup: TPanel;
    gbInfoStudent: TGroupBox;
    leName: TLabeledEdit;
    Label1: TLabel;
    meDate: TMaskEdit;
    leNumber: TLabeledEdit;
    btnOK: TBitBtn;
    btnCancel: TBitBtn;
    procedure btnCancelClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure leNameExit(Sender: TObject);
    procedure meDateExit(Sender: TObject);
  private
    bCloseOK, bErrorName, bErrorDate : boolean;
  public
    pInfoStudent : TInfoStudent;
  end;

var
  fmAddEditStudent: TfmAddEditStudent;
  afAddEditStudent : TActionForm;

implementation

uses FMainform;

{$R *.dfm}

procedure TfmAddEditStudent.btnCancelClick(Sender: TObject);
begin
  afAddEditStudent:=Cancel;
  Close;
end;

procedure TfmAddEditStudent.btnOKClick(Sender: TObject);
begin
  //�������� ������������
  if (bErrorDate or bErrorName)=true then
  begin
    MessageDlg('��������� ������ �����������!',mtError,[mbOK],0);
    exit;
  end;

  //������
  with pInfoStudent do
  begin
    sName:=leName.Text;
    sNumber:=leNumber.Text;
    dDate:=StrToDate(meDate.Text);
  end;

  //�����
  bCloseOK:=true;
  Close;
end;

procedure TfmAddEditStudent.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if bCloseOK=false then afAddEditStudent:=Cancel;
end;

procedure TfmAddEditStudent.FormShow(Sender: TObject);
begin
  //�������������
  pInfoStudent.idGroup:=DBTest.Groups.GetInfo(nGroup.Index).ID;

  //������������
  if afAddEditStudent=ADD then
  begin
    pInfoStudent.dDate:=Date;
    fmAddEditStudent.Caption:='���������� ��������';
  end
  else
    fmAddEditStudent.Caption:='��������� ����������';


  with pInfoStudent do
  begin
    leName.Text:=sName;
    leNumber.Text:=sNumber;
    meDate.Text:=DateToStr(dDate);
  end;

end;

procedure TfmAddEditStudent.leNameExit(Sender: TObject);
begin
  //�������� �� ����
  if length(leName.Text)=0
    then bErrorName:=true
    else bErrorName:=false;

end;

procedure TfmAddEditStudent.meDateExit(Sender: TObject);
begin
  bErrorDate:=false;
  try
    StrToDate(meDate.Text);
  except
    bErrorDate:=true;
  end;
end;

end.
