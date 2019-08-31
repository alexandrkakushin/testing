unit F_AddEditFilter;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, U_Test;

type
  TfmAddEditFilter = class(TForm)
    leName: TLabeledEdit;
    lFilter: TLabel;
    mFilter: TMemo;
    btnOK: TBitBtn;
    btnCancel: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    pFilter : record
      Name, Filter : string;
    end;
    bCloseOK : boolean;
  end;

var
  fmAddEditFilter: TfmAddEditFilter;
  afAddEditFilter: TActionForm;

implementation

{$R *.dfm}

procedure TfmAddEditFilter.FormShow(Sender: TObject);
var
  sCaption : string;
begin
  //�������������
  bCloseOK:=false;

  //��������� ����
  case afAddEditFilter of
     ADD : sCaption:='���������� �������';
    EDIT : sCaption:='��������� �������';
  end;
  fmAddEditFilter.Caption:=sCaption;

  //��������� �������
  leName.Text:=pFilter.Name;
  mFilter.Text:=pFilter.Filter;

end;

procedure TfmAddEditFilter.btnOKClick(Sender: TObject);
begin
  //������������� ����������
  bCloseOK:=true;

  //������ ����������
  with pFilter do
  begin
    Name:=leName.Text;
    Filter:=mFilter.Text;
  end;

  //�������� �����
  Close;

end;

procedure TfmAddEditFilter.btnCancelClick(Sender: TObject);
begin
  //�������� ����
  afAddEditFilter:=Cancel;
  close;
end;

procedure TfmAddEditFilter.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if bCloseOK=false then afAddEditFilter:=cancel;
end;

end.
