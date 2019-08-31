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
  //Инициализация переменных
  bCloseOK:=false;

  //Создаем список
  pListAnswers:=TStringList.Create;

  //Варианты ответов
  for i:=0 to length(pAllEditAnswerSelect.aswSelect)-1 do
  begin
    pListAnswers.Add(pAllEditAnswerSelect.aswSelect[i].Text);
  end;

  //Визуализация
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
  //Проверка изменений
  if pListAnswers=mListAnswers.Lines then
  begin
    exit;
  end;

  //Инициализация
  pListResult:=TStringList.Create;

  //Обработка
  bCloseOK:=true;
  pListResult.Assign(mListAnswers.Lines);
  //Удаление всех вариантов, не найденных в результирующем списке
  for i:=0 to pListAnswers.Count-1 do
  begin
    if (pListResult.IndexOf(pListAnswers[i])=-1) and (pListAnswers[i]<>'')
      then Test.Topics.Questions.Answer.DeleteSel(pAllEditAnswerSelect,i);
  end;

  //Вставка
  for i:=0 to pListResult.Count-1 do
  begin
    if (pListAnswers.IndexOf(pListResult[i])=-1) and (pListResult[i]<>'') then
    begin
      Answer.Text:=pListResult[i];
      Answer.Correct:=false;
      Test.Topics.Questions.Answer.InsertSel(pAllEditAnswerSelect,Answer,i);
    end;
  end;

  //Смена позиций
  for i:=0 to length(pAllEditAnswerSelect.aswSelect)-1 do
  begin
    index:=pListResult.IndexOf(pAllEditAnswerSelect.aswSelect[i].Text);
    Answer:=pAllEditAnswerSelect.aswSelect[index];

    pAllEditAnswerSelect.aswSelect[index]:=pAllEditAnswerSelect.aswSelect[i];
    pAllEditAnswerSelect.aswSelect[i]:=Answer;
  end;

  //Закрытие окна
  close;

end;

end.
