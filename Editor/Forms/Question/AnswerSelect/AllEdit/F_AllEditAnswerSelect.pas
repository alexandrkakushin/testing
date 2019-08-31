unit F_AllEditAnswerSelect;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, U_Test;

type
  TfmAllEditAnswerSelect = class(TForm)
    GbAnswer: TGroupBox;
    mListAnswers: TMemo;
    btnOk: TBitBtn;
    btnCancel: TBitBtn;
    procedure btnCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    pAllEditAnswerSelect : TAnswers;
    pListAnswers, pListResult : TStringList;
    bCloseOK : boolean;

  end;

var
  fmAllEditAnswerSelect: TfmAllEditAnswerSelect;
  afAllEditAnswerSelect : TActionForm;

implementation

uses F_Main_form;

{$R *.dfm}

procedure TfmAllEditAnswerSelect.btnCancelClick(Sender: TObject);
begin
  afAllEditAnswerSelect:=Cancel;
  close;
end;

procedure TfmAllEditAnswerSelect.FormShow(Sender: TObject);
var
  i :integer;
begin
  //������������� ����������
  bCloseOK:=false;

  //������� ������
  pListAnswers:=TStringList.Create;

  //�������� �������
  for i:=0 to length(pAllEditAnswerSelect.aswSelect)-1 do
  begin
    pListAnswers.Add(pAllEditAnswerSelect.aswSelect[i].Text);
  end;

  //������������
  mListAnswers.Lines:=pListAnswers;

end;

procedure TfmAllEditAnswerSelect.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if bCloseOK=false then afAllEditAnswerSelect:=CANCEL;
end;

procedure TfmAllEditAnswerSelect.btnOkClick(Sender: TObject);
var
  i, index : integer;
  Answer : TAnswerSelect;
begin
  //�������� ���������
  if pListAnswers=mListAnswers.Lines then
  begin
    exit;
  end;

  //�������������
  pListResult:=TStringList.Create;

  //���������
  bCloseOK:=true;
  pListResult.Assign(mListAnswers.Lines);
  //�������� ���� ���������, �� ��������� � �������������� ������
  for i:=0 to pListAnswers.Count-1 do
  begin
    if (pListResult.IndexOf(pListAnswers[i])=-1) and (pListAnswers[i]<>'')
      then Test.Topics.Questions.Answer.DeleteSel(pAllEditAnswerSelect,i);
  end;

  //�������
  for i:=0 to pListResult.Count-1 do
  begin
    if (pListAnswers.IndexOf(pListResult[i])=-1) and (pListResult[i]<>'') then
    begin
      Answer.Text:=pListResult[i];
      Answer.Correct:=false;
      Test.Topics.Questions.Answer.InsertSel(pAllEditAnswerSelect,Answer,i);
    end;
  end;

  //����� �������
  for i:=0 to length(pAllEditAnswerSelect.aswSelect)-1 do
  begin
    index:=pListResult.IndexOf(pAllEditAnswerSelect.aswSelect[i].Text);
    Answer:=pAllEditAnswerSelect.aswSelect[index];

    pAllEditAnswerSelect.aswSelect[index]:=pAllEditAnswerSelect.aswSelect[i];
    pAllEditAnswerSelect.aswSelect[i]:=Answer;
  end;

  //�������� ����
  close;

end;

end.
