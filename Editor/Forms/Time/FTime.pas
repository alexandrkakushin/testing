unit FTime;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, Buttons, U_Test;

type
  TfmTime = class(TForm)
    chkNoTime: TCheckBox;
    gbParametrs: TGroupBox;
    lbledtTime: TLabeledEdit;
    UpDown: TUpDown;
    btnOk: TBitBtn;
    btnCancel: TBitBtn;
    procedure chkNoTimeClick(Sender: TObject);
    procedure lbledtTimeKeyPress(Sender: TObject; var Key: Char);
    procedure btnCancelClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    pTime : integer;
  end;

var
  fmTime: TfmTime;
  afTime : TActionForm;
implementation

uses FTopics, F_Main_form;

{$R *.dfm}

procedure TfmTime.chkNoTimeClick(Sender: TObject);
var
   bEnabled : boolean;
begin
     //�������� ���������
     if chkNoTime.Checked=true then bEnabled:=false else bEnabled:=true;

     //��������� �������� Enabled
     lbledtTime.Enabled:=bEnabled;
     UpDown.Enabled:=bEnabled;
end;

procedure TfmTime.lbledtTimeKeyPress(Sender: TObject; var Key: Char);
begin
     //��������� ������ �����
     if (not(key in ['0'..'9'])) xor (Ord(Key)=8) then key:=#0;

end;

procedure TfmTime.btnCancelClick(Sender: TObject);
begin
     //�������� ����
     afTime:=CANCEL;
     Close;
end;

procedure TfmTime.btnOkClick(Sender: TObject);
var
   sTime : string;
begin
     //���������(������) ����������� �� �������
     if chkNoTime.Checked=true then
     begin
          sTime:='����';
          pTime:=0;
     end
     else
     begin
          sTime:=lbledtTime.Text;
          pTime:=StrToInt(sTime);
     end;

     //����������� �� ������
     if afTime=EDIT then
        fmTopics.stsbInfo.Panels[2].Text:='����������� �� ������� - '+sTime;

     close;

end;

procedure TfmTime.FormShow(Sender: TObject);
begin
     //��������� �������� ���������� �����������
     if pTime=0 then
        fmTime.chkNoTime.Checked:=true
     else
        fmTime.lbledtTime.Text:=IntToStr(pTime);


     //�����
     chkNoTime.SetFocus;
end;

end.
