unit F_AddEditAnswerSelect;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, U_Test;

type
  TfmAddEditAnswerSelect = class(TForm)
    gbAddVariant: TGroupBox;
    leVariantAnswer: TLabeledEdit;
    chkbCorrect: TCheckBox;
    btnOK: TBitBtn;
    btnCancel: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    pAnswerSelect : TAnswerSelect;
    bClickOK : boolean;
  end;

var
  fmAddEditAnswerSelect: TfmAddEditAnswerSelect;
  afAddEditAnswerSelect : TActionForm;
implementation

uses F_Main_form, FTopics, F_Question;

{$R *.dfm}

procedure TfmAddEditAnswerSelect.FormShow(Sender: TObject);
var
  sCaption : string;
begin
  bClickOK:=false;
  if afAddEditAnswerSelect=ADD
    then sCaption:='Добавление варианта ответа'
    else begin
      sCaption:='Изменение варианта ответа';
      leVariantAnswer.Text:=pAnswerSelect.Text;
      chkbCorrect.Checked:=pAnswerSelect.Correct;
    end;

  fmAddEditAnswerSelect.Caption:=sCaption;

end;

procedure TfmAddEditAnswerSelect.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if bClickOK=false then afAddEditAnswerSelect:=CANCEL;
end;

procedure TfmAddEditAnswerSelect.btnOKClick(Sender: TObject);
label m_exit, m_error;
var
  Answers : TAnswers;
  sText : string;
begin
  //Проверить что за строка
  //Answers:=aTopics[iIndex].Question[iQuestionIndex].Answer;

  sText:=pAnswerSelect.Text;
  pAnswerSelect.Text:=leVariantAnswer.Text;
  pAnswerSelect.Correct:=chkbCorrect.Checked;

  case afAddEditAnswerSelect of
     ADD : begin
              if (Test.Topics.Questions.Answer.CheckAnswerSel(Answers, pAnswerSelect)=false) then
              begin
                MessageDlg('Введенный Вами вариант ответа уже существует!',mtError,[mbOK],0);
                leVariantAnswer.SetFocus;
                exit;
              end;
           end;
    EDIT : begin
              if (Test.Topics.Questions.Answer.CheckAnswerSel(Answers, pAnswerSelect)=false) and
                 (sText<>pAnswerSelect.Text) then
              begin
                MessageDlg('Измененный Вами вариант ответа уже существует!',mtError,[mbOK],0);
                leVariantAnswer.SetFocus;
                exit;
              end;
           end;
  end;

  bClickOK:=true;

  m_exit:
  close;
  
end;

procedure TfmAddEditAnswerSelect.btnCancelClick(Sender: TObject);
begin
  afAddEditAnswerSelect:=CANCEL;
  close;
end;

end.
