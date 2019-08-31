unit F_MoveQuestion;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, U_Test;

type
  TfmMoveQuestion = class(TForm)
    gbTopics: TGroupBox;
    lstTopics: TListBox;
    btnOk: TBitBtn;
    btnCancel: TBitBtn;
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    bCloseOK : boolean;

    aSelectTopic : array of array of variant;
  end;

var
  fmMoveQuestion: TfmMoveQuestion;
  afMoveQuestion : TActionForm;

implementation

uses F_Main_form, FTopics;

{$R *.dfm}

procedure TfmMoveQuestion.btnOkClick(Sender: TObject);
var
  iIndexIn : integer;
begin
  //Инициализация переменных
  bCloseOk:=true;
  iIndexIn:=aSelectTopic[lstTopics.ItemIndex,0];

  //Перемещение
  Test.Topics.Questions.Move(iIndex, iIndexIn, iQuestionIndex);

  //Закрытие окна
  Close;
end;

procedure TfmMoveQuestion.btnCancelClick(Sender: TObject);
begin
  afMoveQuestion:=Cancel;
  close;
end;

procedure TfmMoveQuestion.FormShow(Sender: TObject);
var
  i : integer;
begin
  bCloseOK:=false;

  //Отображение тем
  for i:=0 to length(aSelectTopic)-1 do
  begin
    lstTopics.Items.Add(aSelectTopic[i,1]);
  end;

  //Фокус
  lstTopics.SetFocus;

end;

procedure TfmMoveQuestion.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if bCloseOK=false then afMoveQuestion:=Cancel;
end;

end.
