unit F_Questions;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ToolWin, ComCtrls, ExtCtrls, ImgList, U_TestClient, StdCtrls,
  Buttons;

type
  TfmQuestions = class(TForm)
    cbTime: TCoolBar;
    pbTime: TProgressBar;
    sbInfo: TStatusBar;
    pcQuestion: TPageControl;
    tsSelectAnswers: TTabSheet;
    gbTextQuestion: TGroupBox;
    mQuestion: TMemo;
    gbComment: TGroupBox;
    mComment: TMemo;
    pnlMoveQuestions: TPanel;
    pnlNavigate: TPanel;
    btnBack: TSpeedButton;
    btnOK: TSpeedButton;
    btnNext: TSpeedButton;
    ImagesNavigate: TImageList;
    cmbNumber: TComboBox;
    lstLinkQuestion: TListView;
    gbAnswer: TGroupBox;
    lstAnswerSelect: TListView;
    lstLinkAnswerSelect: TListView;
    pnlNumbCount: TPanel;
    btnResults: TSpeedButton;
    ImagesAnswers: TImageList;
    Timer: TTimer;
    lblTime: TLabel;

    procedure NumberCurrentQuestion;
    procedure ElementsNavigate;
    procedure OpenLink (Sender : TObject);

    procedure FormResize(Sender: TObject);
    procedure ShowDataTesting;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure lstAnswerSelectClick(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure btnBackClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure cmbNumberChange(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure btnResultsClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmQuestions: TfmQuestions;

implementation

uses F_Main;

{$R *.dfm}

var
  bClose : boolean;

procedure TfmQuestions.FormResize(Sender: TObject);
var
  iValue, i : integer;
begin
  //Строка состояния sbInfo
  iValue:=fmQuestions.Width div 4;
  for i:=0 to sbInfo.Panels.Count-1 do
    sbInfo.Panels.Items[i].Width:=iValue;

  //Панель pnlmovequestions
  iValue:=(fmQuestions.Width-pnlNumbCount.Width) div 2;
  pnlNumbCount.Left:=iValue;


end;

procedure TfmQuestions.ShowDataTesting;
begin
  //Строка состояния sbInfo
  with DataTesting do
  begin
    with sbInfo do
    begin
      Panels[0].Text:=sGroup;
      Panels[1].Text:=sFIO;
      Panels[2].Text:=sSubject;
      Panels[3].Text:=sTopic;
    end;
  end;

  //Обработка непосредственно темы
  

end;

procedure TfmQuestions.FormShow(Sender: TObject);
var
  bTime : boolean;
begin

  //Отображение списка вопросов
  Client.Testing.GetNumberQuestions(cmbNumber);

  //Отображение данных тестирования
  ShowDataTesting;

  //Отображение панели "Время" и старт/останов таймера
  if Topic.Parametrs.Time=0
    then bTime:=false
    else bTime:=true;

  cbTime.Visible:=bTime;
  Timer.Enabled:=bTime;

  //Отображение первого вопроса
  Client.Testing.Topics.Questions.ShowQuestion;

  //Кнопки перемещения между вопросами
  if Client.Testing.Topics.Questions.Count=1 then
  begin
    btnNext.Enabled:=false;
    btnBack.Enabled:=false;
  end;

end;

procedure TfmQuestions.FormCreate(Sender: TObject);
begin
  bClose:=true;
  //Интерфейс
  with ImagesNavigate do
  begin
    GetBitmap(0,btnBack.Glyph);
    GetBitmap(1,btnOK.Glyph);
    GetBitmap(2,btnNext.Glyph);
    GetBitmap(3,btnResults.Glyph);
  end;

end;

procedure TfmQuestions.lstAnswerSelectClick(Sender: TObject);
var
  lTemp : TLinks;
  iAnswer : integer;
begin
  //Очистка списка прикреплений
  with lstLinkAnswerSelect.Items do
  begin
    BeginUpdate;
    Clear;
    EndUpdate;
  end;

  //Отображение прикреплений
  if lstAnswerSelect.Selected=nil then exit;

  iAnswer:=lstAnswerSelect.ItemIndex;
  lTemp:=Topic.Question[iNumberQuestion-1].Answer.aswSelect[iAnswer].sLinks;
  Client.Testing.Topics.Questions.Link.GetList(lTemp,lstLinkAnswerSelect);

end;

procedure TfmQuestions.btnNextClick(Sender: TObject);
begin
  //Переход к следующему вопросу
  Inc(iNumberQuestion);
  Client.Testing.Topics.Questions.ShowQuestion;

  ElementsNavigate;  
  NumberCurrentQuestion;
end;

procedure TfmQuestions.btnBackClick(Sender: TObject);
begin
  //Переход к следующему вопросу
  Dec(iNumberQuestion);
  Client.Testing.Topics.Questions.ShowQuestion;

  ElementsNavigate;
  NumberCurrentQuestion;  
end;

procedure TfmQuestions.btnOKClick(Sender: TObject);
begin
  case Topic.Question[iNumberQuestion-1].tpQuestion of
    tqSELECT_ONE_SEVERAL : Client.Testing.WriteAnswerSelect(lstAnswerSelect);
  end;

end;

procedure TfmQuestions.NumberCurrentQuestion;
begin
  if cmbNumber.Items.Count<>0
    then cmbNumber.ItemIndex:=iNumberQuestion-1;
end;

procedure TfmQuestions.cmbNumberChange(Sender: TObject);
begin
  //Переход к следующему вопросу
  iNumberQuestion:=StrToInt(cmbNumber.Items[cmbNumber.ItemIndex]);
  Client.Testing.Topics.Questions.ShowQuestion;

  ElementsNavigate;
end;

procedure TfmQuestions.ElementsNavigate;
begin
  if iNumberQuestion=Client.Testing.Topics.Questions.Count then
  begin
    btnNext.Enabled:=false;
    btnBack.Enabled:=true;
  end
  else
    if iNumberQuestion=1 then
    begin
      btnBack.Enabled:=false;
      btnNext.Enabled:=true;
    end
    else
    begin
      btnBack.Enabled:=true;
      btnNext.Enabled:=true;
    end;

end;

procedure TfmQuestions.TimerTimer(Sender: TObject);
begin
  Client.Testing.TimeTesting;
end;

procedure TfmQuestions.OpenLink(Sender: TObject);
var
  sFileName : string;
begin
  if (Sender as TListView).Selected=nil then exit;

  //Открытие прикрепленного файла
  sFileName:=(Sender as TListView).Selected.Caption;
  Client.Testing.Topics.Questions.Link.OpenFile(sFileName);
end;

procedure TfmQuestions.btnResultsClick(Sender: TObject);
begin
  if MessageDlg('Завершить тестирование?',mtWarning,[mbYes,mbNo],0)=mrYes then
  begin
     Client.Testing.EndTesting;
     bClose:=true;
  end;
end;

procedure TfmQuestions.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose:=not bClose; 
end;

end.
