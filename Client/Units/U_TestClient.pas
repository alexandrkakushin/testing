unit U_TestClient;

interface

uses
    Windows, ComCtrls, SysUtils, Dialogs, Classes, Forms, DB, ADODB, Controls,
    IniFiles, StdCtrls, ShellApi;

type

{*****************************Описание типов данных****************************}
  //Типы открытия файла
  TTypeOpen = (tfPICTURE, tfSOUND, tfVIDEO, tfBROWSER, tfWINDOWS);

  TTypeFiles = record
    Files : string;
    TypeFiles : TTypeOpen;
  end;

  TArrayTypeFiles = array of TTypeFiles;

  //Тип "Прикрепления"
  TLinks = array of string;

  //Тип "Типы вопросов"
  TTypeQuestion = (tqSELECT_ONE_SEVERAL, tqUP_DOWN, tqTEXT, tqLINK);

  //Различные типы вариантов ответов (т.к. вопрос он всегда один)
  TAnswerSelect = record
    Text : string;
    Correct, Choose : boolean;
    sLinks : TLinks;
  end;

  TAnswerUpDown = record
    Text : string;
    Position : integer;
    sLinks : TLinks;
  end;

  TAnswerText = record
    Text : string;
  end;

  TAnswerLink = record
    Text, Text2 : string;
    sLinks, sLinks2 : TLinks;
  end;

  //Тип "Варианты ответов"
  TAnswers = record
    aswSelect : array of TAnswerSelect;
    aswUpDown : array of TAnswerUpDown;
    aswText : TAnswerText;
    aswLink : array of TAnswerLink;
  end;

  //Тип "Вопрос"
  TQuestion = record
    tpQuestion : TTypeQuestion;
    sQuestion : string;
    sLinkQuestion : TLinks;
    sComment : string;
    Weight : real;
    Ebable : boolean;
    Show : boolean;

    //Виды тестов
    Answer : TAnswers;
  end;

  //Тип "Массив вопросов"
  TArrayQuestions = array of TQuestion;

  //Типы "Описание параметров"
  TOrder = (ORD_123N, ORD_RANDOM);
  TMode = (HARD, SOFT);
  TParam = (ENABLE, MODE, ORDER_QUESTIONS, ORDER_ANSWER, PTIME, PURPOSE, INSTRUCTION, DEVELOPER, PROCENT);
  TResult = array [1..8] of real;
  TInfoDeveloper = record
    Name, Organization, WWW, EMail,
    Telephone, Achievement, MiscInfo : string;
  end;

  //Тип "Параметры темы"
  TParametrs = record
    Enable : boolean;
    Mode : TMode;
    Result : TResult;
    OrderQuestion, OrderAnswer : TOrder;
    Time : integer;
    InfoDeveloper : TInfoDeveloper;
    Purpose, Instruction : string;
  end;

  //Тип "Тема"
  TTopic = record
    Name : string;
    Parametrs : TParametrs;
    Question : TArrayQuestions;
  end;

  TDataTesting = record
    DateTime : TDateTime;
    sFIO, sGroup, sSubject, sTopic : string;
    iSubject : integer;

    iOcenka, iProcent, iCountError, iCount : integer;
    dlCountGood, dlCount : real;
  end;

{*******************************Описание классов*******************************}
  TManagerLinks = class
    private
      procedure ReadTypeOpen (var List: TStringList; var aTypeOpen : TArrayTypeFiles);
    public
      constructor Create;
    published

  end;

  TDBResults = class
    private
      ADOConnection : TADOConnection;
      ADOTable : TADOTable;

      function GetConnectionString: WideString;

      function SearchIndex (TableFirst, TableSec, ValueFirst, ValueSec: string) : integer;
      function SearchTeacher : integer;


    public
      constructor Create;
      destructor Destroy;

      procedure SendData;
    published
  end;

  TResults = class
    private
      fDBResults : TDBResults;
      function Check_SELECT_ONE_SEVERAL (Mode : TMode; Index : integer) : boolean;

      function MaxBalls : real;
      function GetOcenka : integer;
      procedure WriteResults;
    public

      constructor Create;
      destructor Destroy;

      procedure Check;
      procedure ShowProtocol;
    published
      property DBResults : TDBResults read fDBResults write fDBResults;
  end;

  TSettings = class
    private
      cfIniFile : TIniFile;
    public
      constructor Create;

      procedure LoadData (var tvTopics, tvGroups : TTreeView);
    published

  end;

  TAnswer = class
    public
      function CheckAnswerSel (Answers : TAnswers; Answer : TAnswerSelect) : boolean;
      procedure GetListSel (Answers : array of TAnswerSelect; var List : TListView);
    published
  end;


  TLink = class
    private
      function GetTypeFile (FileName : string) : TTypeOpen;
    public
      procedure GetList (var Link : TLinks; var List : TListView);
      procedure OpenFile (FileName : string);
  end;

  TQuestions = class
    private
      iCount : integer;
      fLink : TLink;
      fAnswer : TAnswer;
      function GetCount : integer;
    public
      constructor Create;
      destructor Destroy;

      procedure ShowQuestion;
    published
      property Count : integer read GetCount;
      property Link : TLink read fLink write fLink;
      property Answer : TAnswer read fAnswer write fAnswer;
  end;

  TTopics = class
    private
      fQuestions : TQuestions;
      iCountQuestions : integer;
      function FindParam (Param : TParam; var TempContainer : TStringList) : integer;


    public
      constructor Create;
      destructor Destroy;

      //Чтение/запись параметров и вопросов
      function ReadParametrs(var TempContainer : TStringList) : TParametrs;
      function ReadQuestions (var TempContainer : TStringList) : TArrayQuestions;
    published
      property Questions : TQuestions read fQuestions write fQuestions;
  end;

  TTesting = class
    private
      fTopics : TTopics;
      fResults : TResults;

      //Обработка данных тестирования
      procedure ProcessingContainer;
      procedure Decode (var slList : TStringList);
      procedure WriteDataTesting (var tvTopics, tvGroups : TTreeView);

      procedure ExchangeServer;
      procedure GenerateIndexExchange;

      //Порядок вопрос (вариантов ответа (aswSelect)
      procedure OrderQuestions (Order : TOrder);
      procedure OrderAnswersSelect (iNumber : integer);

    public
      //Создание и удаление класса
      constructor Create;
      destructor Destroy;

      //Загрузка файла
      procedure LoadTest (Index : integer);

      //Сохранение ответов пользователя
      procedure WriteAnswerSelect(var lstAnswers : TListView);
      procedure GetNumberQuestions (var cmbNumber : TComboBox);

      procedure TimeTesting;
      procedure EndTesting;

    published
      property Topics : TTopics read fTopics write fTopics;
      property Results : TResults read fResults write fResults;
  end;

  TClient = class
    private
      fSettings : TSettings;
      fTesting : TTesting;
      fManagerLinks : TManagerLinks;
    public
      //Создание и удаление класса
      constructor Create;
      destructor Destroy;

    published
      property Settings : TSettings read fSettings write fSettings;
      property Testing : TTesting read fTesting write fTesting;
      property ManagerLinks : TManagerLinks read fManagerLinks write fManagerLinks;
  end;

var
  DataTesting : TDataTesting;
  Topic : TTopic;
  aTypeOpen : TArrayTypeFiles;

  sShortFileName : string;
  iNumberQuestion : integer;
  iCountSec, iCountSecMax : LongInt;

  iIndexExchange : integer;

implementation

uses F_Main, F_Questions, F_Picture, F_SoundVideo,
     F_Browser, F_Protocol;

var
  rdDirectory : record
    sApplication, sExchange, sTests, sBase : string
  end;
  
  iSec, iMin, iHour : word;

  fContainer : TStringList;
  slLinkFiles : TStringList;
  sLinkFiles : string;
  
{ TClient }

{***********************Создание клиентского класса****************************}
constructor TClient.Create;
begin
  //Создание вспомогательных классов
  fSettings:=TSettings.Create;
  fTesting:=TTesting.Create;
  fManagerLinks:=TManagerLinks.Create;

end;

{***********************Удаление клиентского класса****************************}
destructor TClient.Destroy;
begin
  //Удаление вспомогательных классов
  fManagerLinks.Free;
  fTesting.Free;
  fSettings.Free;

end;

{ TSettings }
{***********************Создание класса настроек*******************************}
constructor TSettings.Create;
var
  sServer : string;
begin
  //Формирование каталогов
  with rdDirectory do
  begin
    sApplication:=ExtractFileDir(Application.ExeName);

    //Загрузка настроек
    cfIniFile:=TIniFile.Create(sApplication+'\Settings.ini');
    sServer:=cfIniFile.ReadString('Connect','Dir','');
    sExchange:=sServer+'\Exchange';
    sTests:=sServer+'\Tests';
    sBase:=sServer+'\Base\Results.mdb';

    //Удаление переменной
    cfIniFile.Destroy;

    //Проверка наличия каталогов
    if DirectoryExists(sExchange)=false then
    begin
      MessageDlg('Ошибка при загрузке программы! Запустите утилиту настроек клиента',mtError,[mbOK],0);
      Application.Terminate;
    end;
  end;

  //Загрузка данных о группах и предметах тестирования
  with fmMain do
    LoadData(tvTopics, tvGroups);

end;

{**************************Загрузка данных с сервера***************************}
procedure TSettings.LoadData(var tvTopics, tvGroups: TTreeView);
begin
  with rdDirectory do
  begin
    tvTopics.LoadFromFile(sExchange+'\Topics.dat');
    tvGroups.LoadFromFile(sExchange+'\Groups.dat');
  end;
end;

{ TTesting }
{*************************Создание класса тестирования*************************}
constructor TTesting.Create;
begin
  iIndexExchange:=-1;

  Topics:=TTopics.Create;
  Results:=TResults.Create;
  
  //Создание объектов
  fContainer:=TStringList.Create;
end;

{**************************Декодирование файла*********************************}
procedure TTesting.Decode(var slList: TStringList);
var
  i, j, n, iCount : integer;
  sText, sDecode, sNumb : string;
begin
  for i:=0 to slList.Count-1 do
  begin
    sText:=slList[i];
    sDecode:='';
    n:=1;
    iCount:=length(sText);
    for j:=1 to iCount do
    begin
      if (sText[j]=' ') or (j=iCount) then
      begin
        sNumb:=Trim(copy(sText,n,j-n+1));
        n:=j;
        if sNumb<>'' then sDecode:=sDecode+Chr(StrToInt(sNumb));
      end;
    end;
    slList[i]:=sDecode;
  end;
end;

{*************************Удаление класса тестирования*************************}
destructor TTesting.Destroy;
begin
  //Удаление контейнера теста
  fContainer.Free;
  Topics.Destroy;
  Results.Destroy;

end;

{********************Загрузка и декодирование теста****************************}
procedure TTesting.LoadTest(Index: integer);
var
  slIndexSubjects : TStringList;
  sFileName: string;
begin
  //Создание объектов
  slIndexSubjects:=TStringList.Create;
  slIndexSubjects.Clear;
  slIndexSubjects.LoadFromFile(rdDirectory.sExchange+'\IndexSubjects.dat');

  //Загрузка теста
  sFileName:=slIndexSubjects[Index];
  fContainer.LoadFromFile(rdDirectory.sTests+'\'+sFileName);
  sShortFileName:=Copy(sFileName,1,length(sFileName)-4);

  //Декодирование файла
  Decode(fContainer);

  //Запись начальных данных тестирования
  WriteDataTesting(fmMain.tvTopics, fmMain.tvGroups);

  //Обработка контейнера
  ProcessingContainer;

  //Удаление
  slIndexSubjects.Free;

  ExchangeServer;
end;

{****************************Завершение тестирования***************************}
procedure TTesting.EndTesting;
begin
  //Остановка таймера
  fmQuestions.Timer.Enabled:=false;
  fmQuestions.Hide;
  fmQuestions.Close;

  //Проверка
  Results.Check;

  //Отправка на сервер (запись в БД)
  Results.DBResults.SendData;

  DeleteFile(rdDirectory.sExchange+'\'+IntToStr(iIndexExchange)+'.comp');

  //Отображение протокола
  Results.ShowProtocol;
end;

{********************Запись данных о тестировании******************************}
procedure TTesting.WriteDataTesting(var tvTopics, tvGroups : TTreeView);
begin
  //Запись значений переменных
  with DataTesting do
  begin
    DateTime:=GetTime;

    //Запись человека
    with tvGroups.Selected do
    begin
      sFIO:=Text;
      sGroup:=Parent.Text;
    end;

    with tvTopics.Selected do
    begin
      sSubject:=Parent.Text;
      iSubject:=Parent.Index;
      sTopic:=Text;
    end;
  end;

end;

{***********************Запись ответов пользователя****************************}
procedure TTesting.WriteAnswerSelect(var lstAnswers: TListView);
var
  i : integer;
  bChoose : boolean;
  Answers : TAnswers;
begin
  //Инициализация
  Answers:=Topic.Question[iNumberQuestion-1].Answer;

  //Просмотр всех вариантов ответа
  for i:=0 to lstAnswers.Items.Count-1 do
  begin
    Answers.aswSelect[i].Choose:=lstAnswers.Items.Item[i].Checked;
  end;
end;

{*************************Обработка контейнера*********************************}
procedure TTesting.ProcessingContainer;
label Jump;
var
   i, j, z, count, next : integer;
   sFindBegin, sFindEnd : string;
   TopicContainer : TStringList;
begin
  //Инициализация переменных
  count:=0;
  TopicContainer:=TStringList.Create;
	TopicContainer.Clear;

  //Получение нужной темы "DataTesting.sTopic"

  //Определение строк границ тем
  sFindBegin:='<BeginTopic'+Trim(DataTesting.sTopic)+'>';
  sFindEnd:='<EndTopic'+Trim(DataTesting.sTopic)+'>';

  for j:=next to FContainer.Count-1 do
  begin
    //Поиск начала темы
    if FContainer[j]=sFindBegin then
    begin
      for z:=j+1 to FContainer.Count-1 do
      begin
        if FContainer[z]=sFindEnd then
        begin
          next:=z;
          goto Jump;
        end;

        TopicContainer.Add(FContainer[z]);
      end;
    end;
  end;

  Jump:
  //Получение параметров и очистка контейнера
  Topic.Parametrs:=fTopics.ReadParametrs(TopicContainer);
  Topic.Question:=fTopics.ReadQuestions(TopicContainer);

  //Время, отведенное для тестирования
  iCountSecMax:=Topic.Parametrs.Time*60;
  iCountSec:=0;
  iSec:=0;
  iMin:=0;

  //Порядок вопросов и вариантов ответа
  OrderQuestions(Topic.Parametrs.OrderQuestion);
  if Topic.Parametrs.OrderAnswer=ORD_RANDOM then
    for i:=0 to length(Topic.Question)-1 do
      case Topic.Question[i].tpQuestion of
        tqSELECT_ONE_SEVERAL : OrderAnswersSelect(i);
      end;

	//Удаление контейнера с темами
	TopicContainer.Free;

  //Устанавливаем номер вопроса
  if Length(Topic.Question)<>0 then iNumberQuestion:=1;

end;

{****************************Порядок вопросов**********************************}
procedure TTesting.OrderQuestions(Order: TOrder);
var
  slOrder : TStringList;
  i, iCount, iPoz : integer;
  sNumber : string;

  Questions : TArrayQuestions;

begin
  if Order=ORD_123N then exit;

  //Инициализация
  Randomize;
  slOrder:=TStringList.Create;
  iCount:=Topics.Questions.Count;

  //Формирование случайного списка
  while slOrder.Count<>iCount do
  begin
    sNumber:=IntToStr(Random(iCount));
    if slOrder.IndexOf(sNumber)=-1 then
      slOrder.Add(sNumber);
  end;

  //Упорядочивание в соответствии с полученным порядком
  Questions:=Copy(Topic.Question);  
  for i:=0 to length(Topic.Question)-1 do
  begin
    iPoz:=StrToInt(slOrder[i]);
    Questions[i]:=Topic.Question[iPoz];
  end;
  Topic.Question:=Copy(Questions);


  //Удаление объектов
  SetLength(Questions,0);
  slOrder.Free;
end;


{********************Порядок вариантов ответа (aswSelect)**********************}
procedure TTesting.OrderAnswersSelect (iNumber : integer);
var
  slOrder : TStringList;
  Answers : TAnswers;
  iCount, iPoz, i : integer;
  sNumber : string;
begin
  //Инициализация
  slOrder:=TStringList.Create;
  iCount:=length(Topic.Question[iNumber].Answer.aswSelect);

  //Формирование случайного списка
  randomize;
  while slOrder.Count<>iCount do
  begin
    sNumber:=IntToStr(Random(iCount));
    if slOrder.IndexOf(sNumber)=-1 then
      slOrder.Add(sNumber);
  end;

  //Упорядочивание
  Answers.aswSelect:=Copy(Topic.Question[iNumber].Answer.aswSelect);
  for i:=0 to iCount-1 do
  begin
    iPoz:=StrToInt(slOrder[i]);
    Answers.aswSelect[i]:=Topic.Question[iNumber].Answer.aswSelect[iPoz];
  end;
  Topic.Question[iNumber].Answer.aswSelect:=Copy(Answers.aswSelect);

  //Удаление объектов
  SetLength(Answers.aswSelect,0);
  slOrder.Free;

end;

{*********************Получение списка номеров вопроса*************************}
procedure TTesting.GetNumberQuestions(var cmbNumber: TComboBox);
var
  i : integer;
begin
  //Обработка компонента
  with cmbNumber.Items do
  begin
    //Начало обработки
    BeginUpdate;
    Clear;

    for i:=0 to Topics.Questions.GetCount-1 do
    begin
      cmbNumber.Items.Add(IntToStr(i+1));  
    end;

    //Завершение обработки
    EndUpdate;

    if Count<>0 then cmbNumber.ItemIndex:=0;
  end;


end;

{ TTopics }

{************************Чтение параметров темы********************************}
function TTopics.ReadParametrs(var TempContainer : TStringList) : TParametrs;
var
   i, iFind : integer;
  Parametrs : TParametrs;
begin
	//Установка параметров
  iFind:=FindParam(ORDER_QUESTIONS, TempContainer);
  if TempContainer[iFind]='123'
	  then Parametrs.OrderQuestion:=ORD_123N
    else Parametrs.OrderQuestion:=ORD_RANDOM;


	iFind:=FindParam(ORDER_ANSWER, TempContainer);
  if TempContainer[iFind]='123'
    then Parametrs.OrderAnswer:=ORD_123N
    else Parametrs.OrderAnswer:=ORD_RANDOM;

	iFind:=FindParam(ENABLE, TempContainer);

  if TempContainer[iFind]='true'
    then Parametrs.Enable:=true
    else Parametrs.Enable:=false;

	iFind:=FindParam(MODE, TempContainer);
  if TempContainer[iFind]='hard'
    then Parametrs.Mode:=HARD
    else Parametrs.Mode:=SOFT;

	iFind:=FindParam(PTIME, TempContainer);
  Parametrs.Time:=StrToInt(TempContainer[iFind]);

  iFind:=FindParam(PURPOSE, TempContainer);
  Parametrs.Purpose:=TempContainer[iFind];

  iFind:=FindParam(INSTRUCTION, TempContainer);
  Parametrs.Instruction:=TempContainer[iFind];

  iFind:=FindParam(PROCENT, TempContainer);
  for i:=1 to 8 do
    Parametrs.Result[i]:=StrToFloat(TempContainer[iFind+i-1]);

  iFind:=FindParam(DEVELOPER, TempContainer);
  with Parametrs.InfoDeveloper do
  begin
    Name:=TempContainer[iFind];
    Organization:=TempContainer[iFind+1];
    WWW:=TempContainer[iFind+2];
    EMail:=TempContainer[iFind+3];
    Telephone:=TempContainer[iFind+4];
    Achievement:=TempContainer[iFind+5];
    MiscInfo:=TempContainer[iFind+6];
  end;

  //Возврат значений
  ReadParametrs:=Parametrs;

end;

{***************************Чтение вопросов************************************}
function TTopics.ReadQuestions(
  var TempContainer: TStringList): TArrayQuestions;
var
  aQuestions : TArrayQuestions;
  iFind, iEnd,
     i, j, z : integer;
     sNumber : string;
  rCount : record
    iQuestions,
    iAnswer,
    iLink : integer;
  end;

begin
  //Инициализация
  iFind:=TempContainer.IndexOf('<BeginQuestions>');
  rCount.iQuestions:=StrToInt(TempContainer[iFind+1]);

  //Обработка вопросов
  SetLength(aQuestions,rCount.iQuestions);
  for i:=1 to rCount.iQuestions do
  begin
    sNumber:=IntToStr(i);
    iFind:=TempContainer.IndexOf('<BeginQuestion'+sNumber+'>');

    //Доступность вопроса
    if TempContainer[iFind+1]='true'
      then aQuestions[i-1].Ebable:=true
      else aQuestions[i-1].Ebable:=false;

    //Вес вопроса
    aQuestions[i-1].Weight:=StrToFloat(TempContainer[iFind+2]);

    //Вид вопроса (Выбор правильных)
    if TempContainer[iFind+3]='select' then
    begin
      aQuestions[i-1].tpQuestion:=tqSELECT_ONE_SEVERAL;
      //Вопрос
      aQuestions[i-1].sQuestion:=TempContainer[iFind+4];
      //Комментарий
      aQuestions[i-1].sComment:=TempContainer[iFind+5];
      //Кол-во ответов
      rCount.iAnswer:=StrToInt(TempContainer[iFind+6]);
      //Кол-во прикреплений
      rCount.iLink:=StrToInt(TempContainer[iFind+7]);

      //Прикрепления к вопросу
      SetLength(aQuestions[i-1].sLinkQuestion,rCount.iLink);
      for j:=1 to rCount.iLink do
        aQuestions[i-1].sLinkQuestion[j-1]:=(TempContainer[iFind+7+j]);

      //Ответы
      SetLength(aQuestions[i-1].Answer.aswSelect,rCount.iAnswer);

      for j:=1 to rCount.iAnswer do
      begin
        iFind:=TempContainer.IndexOf('<BeginAnswer'+sNumber+IntToStr(j)+'>');
        aQuestions[i-1].Answer.aswSelect[j-1].Text:=TempContainer[iFind+1];

        if TempContainer[iFind+2]='true'
          then aQuestions[i-1].Answer.aswSelect[j-1].Correct:=true
          else aQuestions[i-1].Answer.aswSelect[j-1].Correct:=false;

          aQuestions[i-1].Answer.aswSelect[j-1].Choose:=false;

        rCount.iLink:=StrToInt(TempContainer[iFind+3]);
        SetLength(aQuestions[i-1].Answer.aswSelect[j-1].sLinks,rCount.iLink);
        for z:=1 to rCount.iLink do
          aQuestions[i-1].Answer.aswSelect[j-1].sLinks[z-1]:=(TempContainer[iFind+3+z]);
      end;
    end;
  end;

  //Запись
  ReadQuestions:=aQuestions;

end;

{******************************Поиск параметров темы***************************}
function TTopics.FindParam(Param : TParam; var TempContainer : TStringList) : integer;
var
	sParam : string;
begin
	case Param of
		ORDER_QUESTIONS : sParam:='<BeginOrderQuestions>';
		ORDER_ANSWER : sParam:='<BeginOrderAnswer>';
		ENABLE : sParam:='<BeginEnable>';
		PTIME : sParam:='<BeginTime>';
		PURPOSE : sParam:='<BeginPurpose>';
		INSTRUCTION : sParam:='<BeginInstruction>';
		DEVELOPER : sParam:='<BeginDeveloper>';
		PROCENT : sParam:='<BeginProcent>';
		MODE : sParam:='<BeginMode>';
	end;

    FindParam:=TempContainer.IndexOf(sParam)+1;
end;

{************************Создание класса тем***********************************}
constructor TTopics.Create;
begin
  Questions:=TQuestions.Create;
end;

{ TQuestions }

{*************************Создание класса "Вопросы"****************************}
constructor TQuestions.Create;
begin
  //Создание объектов классов
  Answer:=TAnswer.Create;
  Link:=TLink.Create;
end;


{************************Получение кол-ва вопросов*****************************}
destructor TQuestions.Destroy;
begin
  Answer.Destroy;
  Link.Destroy;
end;

function TQuestions.GetCount: integer;
begin
  GetCount:=Length(Topic.Question);
end;

{**************************Отображение вопроса*********************************}
procedure TQuestions.ShowQuestion;
var
  lTemp : TLinks;
  Question : TQuestion;
begin

  //Инициализация
  Question:=Topic.Question[iNumberQuestion-1];

  with fmQuestions do
  begin
    pnlNumbCount.Caption:=IntToStr(iNumberQuestion)+'/'+IntToStr(Count);

    //Вопрос
    mQuestion.Text:=Question.sQuestion;
    lTemp:=Question.sLinkQuestion;
    if length(lTemp)<>0
      then begin
        Link.GetList(lTemp,lstLinkQuestion);
        lstLinkQuestion.Visible:=true;
      end
      else lstLinkQuestion.Visible:=false;




    Answer.GetListSel(Question.Answer.aswSelect,lstAnswerSelect);
    with lstLinkAnswerSelect.Items do
    begin
      BeginUpdate;
      Clear;
      EndUpdate;
    end;

  end;

end;

{ TLink }

{***************************Список прикреплений********************************}
procedure TLink.GetList (var Link : TLinks; var List: TListView);
var
  TempItem : TListItems;
         i : integer;
begin
  //Инициализация переменных
  with List.Items do
  begin
    BeginUpdate;
    Clear;
    EndUpdate;
  end;
  TempItem:=List.Items;

  for i:=0 to length(Link)-1 do
  begin
    TempItem.Add.Caption:=Link[i];

  end;
end;

{************************Вариант открытия файла********************************}
function TLink.GetTypeFile(FileName: string): TTypeOpen;
var
  sExt : string;
     i : integer;
  bRes : boolean;
begin
  bRes:=false;
  sExt:=ExtractFileExt(FileName);
  for i:=0 to length(aTypeOpen)-1 do
  begin
    if pos(sExt,aTypeOpen[i].Files)<>0 then
    begin
      GetTypeFile:=aTypeOpen[i].TypeFiles;
      bRes:=true;
      break;
    end;
  end;

  if bRes=false then
    GetTypeFile:=tfWINDOWS;

end;

procedure TLink.OpenFile(FileName: string);
var
  sFile : string;
  tfOpen : TTypeOpen;
begin
  tfOpen:=GetTypeFile(FileName);
  sFile:=rdDirectory.sTests+'\'+sShortFileName+'_files\'+FileName;
  case tfOpen of
    tfPICTURE : begin
                  fmLinkPicture:=TfmLinkPicture.Create(application);
                  with fmLinkPicture do
                  begin
                    pLinkFileName:=sFile;
                    Caption:=FileName;
                    ShowModal;
                    Free;
                  end;
                end;

      tfVIDEO,
      tfSound : begin
                  fmLinkSoundVideo:=TfmLinkSoundVideo.Create(Application);
                  with fmLinkSoundVideo do
                  begin
                    pLinkFileName:=sFile;
                    Caption:=FileName;
                    ShowModal;
                    Free;
                  end;

                end;
    tfBROWSER : begin
                  fmLinkBrowser:=TfmLinkBrowser.Create(Application);
                  with fmLinkBrowser do
                  begin
                    pLinkFileName:=sFile;
                    Caption:=FileName;
                    ShowModal;
                    Free;
                  end;
                end;

    tfWINDOWS : begin
                  ShellExecute(Application.Handle,PChar('open'),PChar(FileName),nil,PChar(rdDirectory.sTests+'\'+sShortFileName+'_files'),Sw_ShowNormal);
                end;
  end;
end;




{ TAnswer }

function TAnswer.CheckAnswerSel(Answers: TAnswers;
  Answer: TAnswerSelect): boolean;
var
  i : integer;
begin
  result:=true;
  for i:=0 to length(Answers.aswSelect)-1 do
  begin
    if (Answers.aswSelect[i].Text=Answer.Text) then
    begin
      result:=false;
      break;
    end;
  end;
end;

procedure TAnswer.GetListSel(Answers: array of TAnswerSelect;
  var List: TListView);
var
  TempItem : TListItems;
         i : integer;
begin
  //Инициализация переменных
  with List.Items do
  begin
    BeginUpdate;
    Clear;
    EndUpdate;
  end;
  TempItem:=List.Items;

  for i:=0 to length(Answers)-1 do
  begin
    TempItem.Add.Caption:=Answers[i].Text;
    TempItem.Item[TempItem.Count-1].Checked:=Answers[i].Choose;
    if length(Answers[i].sLinks)<>0
      then TempItem.Item[TempItem.Count-1].ImageIndex:=0
      else TempItem.Item[Tempitem.Count-1].ImageIndex:=-1;
  end;
end;




procedure TTesting.TimeTesting;
begin
  //"прогресс-бар"
  Inc(iCountSec);
  fmQuestions.pbTime.Position:=round((iCountSec/iCountSecMax)*100);

  //Часы
  Inc(iSec);
  if iSec=60 then
  begin
    Inc(iMin); iSec:=0;
  end;
  if iMin=60 then
  begin
    Inc(iHour); iMin:=0;
  end;
  fmQuestions.lblTime.Caption:='Время тестирования - '+TimeToStr(EncodeTime(iHour,iMin,iSec,0));

  //Проверка
  if iCountSec=iCountSecMax then
  begin
    //Завершение тестирования
    EndTesting;

  end;
  
end;


{TManagerLinks}

{*****************Создание класс, загрузка данных из файлов********************}
constructor TManagerLinks.Create;
var
          lTemp : TStringList;
           n, i : integer;
         tfTemp : TTypeOpen;
begin
  //Инициализация переменных
  lTemp:=TStringList.Create;
  slLinkFiles:=TStringList.Create;
  sLinkFiles:='';

  //Файлы для прикрепления
  slLinkFiles.LoadFromFile(rdDirectory.sApplication+'\Data\LinkFiles.dat');
  for i:=0 to slLinkFiles.Count-1 do
    sLinkFiles:=sLinkFiles+slLinkFiles[i];

  //Соответствие файлов и средст открытия
  lTemp.LoadFromFile(rdDirectory.sApplication+'\Data\TypeOpen.dat');
  //Чтение способов
  ReadTypeOpen (lTemp, aTypeOpen);
  lTemp.Free;
end;

{***********************Чтение способов открытия*******************************}
procedure TManagerLinks.ReadTypeOpen(var List: TStringList; var aTypeOpen : TArrayTypeFiles);
var
  i, n : integer;
  sType, sFiles : string;
  tfTemp : TTypeOpen;
begin
  for i:=0 to List.Count-1 do
  begin
    n:=pos('|',List[i]);
    sType:=copy(List[i],1,n-1);
    sFiles:=copy(List[i],n+1,length(List[i])-n);

    SetLength(aTypeOpen,i+1);
    if sType='picture' then  tfTemp:=tfPICTURE;
    if sType='sound' then  tfTemp:=tfSOUND;
    if sType='video' then  tfTemp:=tfVIDEO;
    if sType='browser' then  tfTemp:=tfBROWSER;
    if sType='windows' then  tfTemp:=tfWINDOWS;

    aTypeOpen[i].Files:=sFiles;
    aTypeOpen[i].TypeFiles:=tfTemp;
  end;
end;

{ TResults }

{*******************************Создание класса********************************}
constructor TResults.Create;
begin
  fDBResults:=TDBResults.Create;
end;

{*********************************Удаление класса******************************}
destructor TResults.Destroy;
begin
  fDBResults.Free;
end;


{*******************************Проверка ответов*******************************}
procedure TResults.Check;
var
  Mode : TMode;
  i : integer;
  bResult : boolean;
begin
  with DataTesting do
  begin
    //Инициализация
    Mode:=Topic.Parametrs.Mode;
    iCountError:=0;
    dlCountGood:=0;

    //Перебор вопросов
    for i:=0 to length(Topic.Question)-1 do
    begin
      case Topic.Question[i].tpQuestion of
        tqSELECT_ONE_SEVERAL : bResult:=Check_SELECT_ONE_SEVERAL (Mode, i);
      end;

      if bResult=false then Inc(iCountError);

    end;
      
  end;

  //Запись результатов
  WriteResults;


end;

{**************************Проверка "Выбор нескольких"*************************}
function TResults.Check_SELECT_ONE_SEVERAL(Mode: TMode; Index : integer): boolean;
var
  Answer : TAnswers;
  i, iTemp : integer;
  bResult : boolean;
  dlBallAnswer, dlSum : real;
begin
  //Инициализация
  Answer:=Topic.Question[Index].Answer;
  bResult:=true;

  //Проверка режим тестирования "ЖЕСТКИЙ"
  if Mode=HARD then
  begin
    //Перебор всех ответов
    for i:=0 to length(Answer.aswSelect)-1 do
    begin
      if Answer.aswSelect[i].Correct<>Answer.aswSelect[i].Choose then
      begin
        bResult:=false;
        break;
      end;
    end;

    //Прибавляем вес вопроса
    if bResult=true then
      DataTesting.dlCountGood:=DataTesting.dlCountGood+Topic.Question[index].Weight;
  end;

  //Проверка режим тестирования "МЯГКИЙ"
  if Mode=SOFT then
  begin
    dlSum:=0;

    //Баллы для каждого ответа
    iTemp:=0;    
    for i:=0 to length(Answer.aswSelect)-1 do
    begin
      if Answer.aswSelect[i].Correct=true then
        Inc(iTemp);
    end;
    dlBallAnswer:=Topic.Question[index].Weight/iTemp;

    //Перебор всех ответов
    iTemp:=0;
    for i:=0 to length(Answer.aswSelect)-1 do
    begin
      if Answer.aswSelect[i].Choose=true then
      begin
        Inc(iTemp);
        if Answer.aswSelect[i].Correct=true then
        begin
          dlSum:=dlSum+dlBallAnswer
        end
        else begin
          bResult:=false;
          break;
        end;
      end;
    end;

    if (dlSum/Topic.Question[Index].Weight>=0.5)
      then DataTesting.dlCountGood:=DataTesting.dlCountGood+dlSum
      else bResult:=false;

  end;

  Result:=bResult;


end;


{****************************Получение оценки**********************************}
function TResults.GetOcenka: integer;
var
  i, j : integer;
begin
  //Определение процентного интервала
  for i:=1 to 8 do
  begin
    if DataTesting.iProcent<=Topic.Parametrs.Result[i] then
    begin
      j:=i;
      break;
    end;
  end;

  //Выставление оценки
  if j mod 2=0
    then GetOcenka:=j div 2 + 1
    else GetOcenka:=j div 2 + 2;

end;


{**************************Отображение протокола*******************************}
procedure TResults.ShowProtocol;
var
  sTemp : string;
begin
  //Создание формы
  fmProtocol:=TfmProtocol.Create(Application);

  //Сбор данных
  with fmProtocol do
  begin
    with DataTesting do
    begin
      lblGroup.Caption:=sGroup;
      lblFIO.Caption:=sFIO;
      lblSubject.Caption:=sSubject;
      lblTopic.Caption:=sTopic;

      with lstDetail.Items do
      begin
        Item[0].SubItems.Add(IntToStr(iCount));
        Item[1].SubItems.Add(IntToStr(iCount-iCountError));
        Item[2].SubItems.Add(IntToStr(iCountError));
        Item[3].SubItems.Add(IntToStr(GetOcenka));
        Item[4].SubItems.Add(IntToStr(iProcent)+'%');
        if Topic.Parametrs.Mode=HARD
          then sTemp:='Жесткий'
          else sTemp:='Мягкий';
        Item[5].SubItems.Add(sTemp);

        if Topic.Parametrs.OrderQuestion=ORD_123N
          then sTemp:='Последовательный'
          else sTemp:='Произвольный';
        Item[6].SubItems.Add(sTemp);

        if Topic.Parametrs.OrderAnswer=ORD_123N
          then sTemp:='Последовательный'
          else sTemp:='Произвольный';
        Item[7].SubItems.Add(sTemp);

      end;
      lstDetail.ReadOnly:=true;
    end;
  end;



  //Отображение
  fmProtocol.ShowModal;

  //Удаление окна
  fmProtocol.Free;


//  Application.Terminate;
  fmMain.pcInfoTesting.ActivePageIndex:=0;
  fmMain.Show;


end;

{******************************Запись результатов******************************} 
procedure TResults.WriteResults;
begin
  with DataTesting do
  begin
    //Инициализация
    iCount:=Length(Topic.Question);

    try
      //Анализ результата
      iProcent:=round((dlCountGood/MaxBalls*100));
    except

    end;
  end;
  

end;

{ TDBResults }

{****************************Создание класса***********************************}
constructor TDBResults.Create;
begin
  //Получение доступа к БД (технология ADO)
  ADOConnection:=TADOConnection.Create(Application);
  ADOConnection.ConnectionString:=GetConnectionString;
  ADOConnection.Connected:=true;

  //Создание таблицы
  ADOTable:=TADOTable.Create(Application);
  ADOTable.Connection:=ADOConnection;

end;

{***************************Удаление класса************************************}
destructor TDBResults.Destroy;
begin
  //Удаление объектов
  ADOTable.Free;  
  ADOConnection.Free;

end;

{**************************Получение индекса***********************************}
function TDBResults.SearchIndex(TableFirst, TableSec, ValueFirst, ValueSec: string): integer;
var
  Index, IndexRes : integer;
begin
  //Поиск первичного ключа
  ADOTable.Active:=false;
  ADOTable.TableName:=TableFirst;
  ADOTable.Active:=true;
  index:=-1;

  //Начало поиска
  ADOTable.First;
  while not ADOTable.Eof do
  begin
    if ADOTable.Fields[1].Value=ValueFirst then
    begin
      Index:=ADOTable.Fields[0].Value;
      break;
    end;
    ADOTable.Next;
  end;

  if index=-1 then
  begin
    ADOTable.Append;
    ADOTable.Fields[1].Value:=ValueFirst;
    ADOTable.Post;
    index:=ADOTable.Fields[0].Value;
  end;

  //Поиск вторичного ключа
  IndexRes:=-1;
  ADOTable.Active:=false;
  ADOTable.TableName:=TableSec;
  ADOTable.Active:=true;

  //Начало поиска
  ADOTable.First;
  while not ADOTable.Eof do
  begin
    if (ADOTable.Fields[1].Value=Index) and
       (ADOTable.Fields[2].Value=ValueSec)
    then
    begin
      IndexRes:=ADOTable.Fields[0].Value;
      break;
    end;
    ADOTable.Next;
  end;
  if IndexRes=-1 then
  begin
    ADOTable.Append;
    ADOTable.Fields[1].Value:=index;
    ADOTable.Fields[2].Value:=ValueSec;
    if ADOTable.State in [dsEdit, dsInsert] then ADOTable.Post;
    indexRes:=ADOTable.Fields[0].Value;
  end;

  SearchIndex:=IndexRes;

end;

procedure TDBResults.SendData;
var
  id_student, id_topic, id_teacher, iValue : integer;
begin

  with DataTesting do
  begin
    //Поиск преподавателя
    id_teacher:=SearchTeacher;
    id_student:=SearchIndex('Groups','Students',sGroup,sFIO);
    id_topic:=SearchIndex('Subjects', 'Topics',sSubject, sTopic);



    //Подключение к таблице
    ADOTable.Active:=false;
    ADOTable.TableName:='Results';
    ADOTable.Active:=true;


    //Добавление данных
    ADOTable.Append;
    ADOTable.Fields[1].Value:=id_student;
    ADOTable.Fields[2].Value:=id_topic;

    if Topic.Parametrs.OrderQuestion=ORD_123N
      then iValue:=2
      else iValue:=1;
    ADOTable.Fields[3].Value:=iValue;

    if Topic.Parametrs.Mode=HARD
      then iValue:=1
      else iValue:=2;
    ADOTable.Fields[4].Value:=iValue;

    ADOTable.Fields[5].Value:=iProcent;
    ADOTable.Fields[6].Value:=Client.Testing.Results.GetOcenka;
    ADOTable.Fields[7].Value:=id_teacher;    
    ADOTable.Fields[8].Value:=Date;

    ADOTable.Post;
  end;

end;

function TDBResults.SearchTeacher : integer;
var
  index : integer;
  sTeacher : string;
begin
  //Инициализация
  index:=-1;
  sTeacher:=Topic.Parametrs.InfoDeveloper.Name;

  ADOTable.Active:=false;
  ADOTable.TableName:='Teachers';
  ADOTable.Active:=true;

  //Начало поиска
  ADOTable.First;
  while not ADOTable.Eof do
  begin
    if ADOTable.Fields[1].Value=sTeacher then
    begin
      Index:=ADOTable.Fields[0].Value;
      break;
    end;
    ADOTable.Next;
  end;

  //Если запись отсутсвует, то добавить
  if index=-1 then
  begin
    ADOTable.Append;
    ADOTable.Fields[1].Value:=sTeacher;
    ADOTable.Post;
    index:=ADOTable.Fields[0].Value;
  end;

  SearchTeacher:=index;

end;

{****************************Чтение ConnectionString***************************}
function TDBResults.GetConnectionString: WideString;
var
  slRead : TStringList;
  sConn : String;
  i, iBegin, iEnd : integer;
begin
  //Создание объекта для загрузки параметра
  slRead:=TStringList.Create;
  slRead.LoadFromFile(rdDirectory.sApplication+'\Data\ConnectionString.dat');
  sConn:=slRead.Text;

  //Изменение DataSource
  iBegin:=pos('Data Source=',sConn);
  iEnd:=pos('.mdb',sConn);

  Delete(sConn,iBegin,iEnd-iBegin+4);
  Insert('Data Source='+rdDirectory.sBase,sConn,iBegin);

  //Возвращение результата и удаление
  GetConnectionString:=sConn;
  slRead.Free;
end;

{***********************Максимальное кол-во баллов*****************************}
function TResults.MaxBalls: real;
var
  i : integer;
  dlTemp : real;
begin
  dlTemp:=0;

  for i:=0 to length(Topic.Question)-1 do
  begin
    dlTemp:=dlTemp+Topic.Question[i].Weight;
  end;

  MaxBalls:=dlTemp;
end;

{*************************Запись данные на сервер******************************}
procedure TTesting.ExchangeServer;
var
  slComp : TStringList;
  Size : cardinal;
  PRes : PChar;
  BRes : boolean;
begin
  //Инициализация
  slComp:=TStringList.Create;
  slComp.Clear;


  //Запись значений
  with slComp do
  begin
    //Имя компьютера
    Size:=MAX_COMPUTERNAME_LENGTH + 1;
    PRes:=StrAlloc(Size);
    BRes:=GetComputerName(PRes, Size);
    if BRes then Add(StrPas(PRes)) else Add('-');

    with DataTesting do
    begin
      Add(sGroup);
      Add(sFIO);
      Add(sSubject);
      Add(sTopic);
    end;
  end;

  //Сохранение файла
  GenerateIndexExchange;
  slComp.SaveToFile(rdDirectory.sExchange+'\'+IntToStr(iIndexExchange)+'.comp');

  slComp.Free;
end;

procedure TTesting.GenerateIndexExchange;
var
  i : integer;
  sTemp : string;
begin
  if iIndexExchange<>-1 then exit;

  for i:=0 to High(Integer) do
  begin
    sTemp:=IntToStr(i)+'.comp';
    if FileExists(rdDirectory.sExchange+'\'+sTemp)=false then
    begin
      iIndexExchange:=i;
      break;
    end;
  end;

end;

destructor TTopics.Destroy;
begin
  Questions.Destroy;
end;

end.
