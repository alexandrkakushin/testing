unit FAdditilonalInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, U_Test;

type
  TfmAdditionalInfo = class(TForm)
    gbData: TGroupBox;
    mData: TMemo;
    btnOk: TBitBtn;
    btnCancel: TBitBtn;
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    pData : string;
  end;

var
  fmAdditionalInfo: TfmAdditionalInfo;
  afAdditionalInfo: TActionForm;

implementation

uses F_Main_form, FTopics;

{$R *.dfm}

procedure TfmAdditionalInfo.btnOkClick(Sender: TObject);
begin
  //������ ��������
  pData:=mData.Text;

  //�������� ����
  Close;
  
end;

procedure TfmAdditionalInfo.btnCancelClick(Sender: TObject);
begin
     //�������� ����
     afAdditionalInfo:=CANCEL;
     Close;
end;

procedure TfmAdditionalInfo.FormShow(Sender: TObject);
begin
  //����������� ������
  mData.Text:=pData;
end;

end.
