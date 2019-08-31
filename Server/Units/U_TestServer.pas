unit U_TestServer;

interface

uses
    Windows, ComCtrls, SysUtils, Dialogs, Classes, Forms, DB, ADODB, Controls,
    ComObj;

type
  TActionForm = (ADD, EDIT, CANCEL, SELECT);
  TTypeReport = (trGroupTopic);

  //Для отчета
  TResultStudent = record
    iOcenka, iProcent : integer;
    Date : TDate;
    sTeacher : string;
  end;
  TListResultStudents = record
    Name : string;
    Results : array of TResultStudent;
  end;
  TListStudents = array of TListResultStudents;

  //Информация о студенте
  TInfoStudent = record
    sName, sNumber : string;
    ID, idGroup : integer;
    dDate : TDate;
  end;

  //Информация о группе
  TInfoGroup = record
    ID : integer;
    sName : string;
  end;

  TIntVector = array of integer;

  //Данные отчета "Результаты группы по теме"
  TDataReportGT = record
    sGroup, sSubject,
    sTopic, sTeachers : string;
  end;

  TInfoTesting = record
    sComp, sGroup, sStudent,
    sSubject, sTopic : string;
    iMinPoz, iMinMax : integer;
  end;

  TTesting = class
    private
      aInfoTesting : array of TInfoTesting;
      procedure GetTreeGroups (var slGroups: TStringList);
      procedure GetTreeTopics;
      procedure ClearFile (sFileName : string);
      procedure GetListTests (var slList : TStringList);
    public
      procedure GetInfoTesting (var List : TListView);

      procedure GetListComp (var List : TListView);
      procedure GetCurrentListGroups (var List : TListView);

      function CheckTesting: boolean;

      procedure Start (var List : TListView);
      procedure Stop (var List : TListView);

      constructor Create;

    published

  end;

  TReports = class
    private
      slQuerys : TStringList;
      aSubjectsST : TIntVector;
      fListStudents : TListStudents;      

      procedure GetList (var List : TListView);
      function PrepareParameter (sName : string; vValue : variant) : TParameter;
      function GetSQLText (NameQuery : string) : AnsiString;

      procedure PrepareColumn (var List : TListView; sCaption : string; bAutoSize : boolean; iWidth : integer; alAlignment : TAlignment);
    public
      constructor Create;
      destructor Destroy;

      //Отчеты по результатам студента
      procedure ListSubjectST (idStudent : integer; var TabControl : TTabControl);
      procedure ResultSubjectST (idStudent, idSubject : integer; var List : TListView);

      //Отчет "Результаты группы по теме"
      procedure GetTreeDRGroupTopic (var TreeView : TTreeView);
      procedure ResultsGroupTopic (var TreeView : TTreeView; var List : TListView; var DataReport : TDataReportGT);

      //Выбор оптимального варианта
      procedure GetListResults (Student : string; var List : TListView);

      //Экспорт в Excel
      procedure ExcelGroupTopic (var List : TListView; var DataReport : TDataReportGT; bPrint : boolean);


      
    published
      property SubjectsST : TIntVector read aSubjectsST write aSubjectsST;
      property ListStudents : TListStudents read fListStudents write fListStudents;      
  end;

  //Управление студентами
  TStudents = class
    private
      procedure Write (var InfoStudent : TInfoStudent);
    public
      function GetInfo (var nStudent : TTreeNode) : TInfoStudent;

      procedure Move (var nStudent : TTreeNode; NewIdGroup : integer);
      procedure Edit (var InfoStudent : TInfoStudent; Index : integer);
      procedure Add (var InfoStudent : TInfoStudent);
      procedure Delete (Index : integer);
    published
  end;

  //Управление группами
  TGroups = class
    private
      fStudents : TStudents;

      function GetCount : integer;
    public
      constructor Create;
      destructor Destroy;

      function GetInfo (iGroup : integer) : TInfoGroup;

      function GetListMove(var List: TListView; CurrentGroup : string) : TIntVector;
      procedure GetTree (var TreeView : TTreeView);
      procedure GetList (var List : TListView);

      procedure Add (Name : string);
      procedure Delete (Index : integer);
      procedure Rename (Index : integer; NewName : string);
    published
      property Students : TStudents read fStudents write fStudents;
      property Count : integer read GetCount;
  end;

  TManager = class
    private
      procedure AddInfoDB (FileTest : string); {No release}
      procedure CopyTest (FileTest : string; sWhereDir : string);

    public
      constructor Create;

      procedure Add (Files : TStrings; var List : TListView);
      procedure Delete (FileTest : string; var List : TListView);
      procedure ExportTest (FileTest : string; sWhereDir : string);

      procedure GetList (var List : TListView);

    published
  end;

  //Общее управление базой данных
  TDBTest = class
    private
      fGroups : TGroups;
      fReports : TReports;
      fManager : TManager;
      fTesting : TTesting;

      function GetConnectionString : WideString;
      procedure PrepareTable (var ADOTable : TADOTable; TableName : string);
    public
      constructor Create;
      destructor Destroy;
    published
      property Groups : TGroups read fGroups write fGroups;
      property Reports : TReports read fReports write fReports;
      property Manager : TManager read fManager write fManager;
      property Testing : TTesting read fTesting write fTesting;

  end;

implementation

uses F_Testing;

var
  //Элементы управления БД
  ADOGroups, ADOStudents,
  ADOTeachers, ADOResults,
  ADOMode, ADOOrderQuestions : TADOTable;
               ADOConnection : TADOConnection;

  //Элементы управления запросами
  ADOQuery : TADOQuery;

  //Переменные модуля
  sDataDir, sTestsDir, sExchangeDir,
  sTemplateDir : string;


{************************Декодирование файлов теста****************************}
procedure Decode(var slList: TStringList);
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

{ TDBTest }

{******************************Создание класса*********************************}
constructor TDBTest.Create;
begin
  //Инициализация начальных переменных
  sDataDir:=ExtractFilePath(Application.ExeName)+'Data';
  sTemplateDir:=ExtractFilePath(Application.ExeName)+'Template';
  fGroups:=TGroups.Create;
  fReports:=TReports.Create;
  fManager:=TManager.Create;
  fTesting:=TTesting.Create;


  //Получение доступа к БД (технология ADO)
  ADOConnection:=TADOConnection.Create(Application);
  ADOConnection.ConnectionString:=GetConnectionString;
  ADOConnection.Connected:=true;

  //Таблицы
  PrepareTable (ADOGroups, 'Groups');
  PrepareTable (ADOStudents, 'Students');
  PrepareTable (ADOMode, 'Mode');
  PrepareTable (ADOOrderQuestions, 'OrderQuestions');
  PrepareTable (ADOResults, 'Results');
  PrepareTable (ADOTeachers, 'Teachers');

  //Сортировки
  ADOStudents.Sort:='Name';  

  //Элементы запросов
  ADOQuery:=TADOQuery.Create(application);
  ADOQuery.Connection:=ADOConnection;

end;

{****************************Уничтожение класса********************************}
destructor TDBTest.Destroy;
begin
  //Различные переменные
  fGroups.Free;
  fReports.Free;
  fManager.Free;
  fTesting.Free;

  //Запросы
  ADOQuery.Free;

  //Таблицы
  ADOGroups.Free;
  ADOStudents.Free;
  ADOTeachers.Free;
  ADOResults.Free;
  ADOOrderQuestions.Free;
  ADOMode.Free;

  //Соединение
  ADOConnection.Free;

end;

{****************************Чтение ConnectionString***************************}
function TDBTest.GetConnectionString: WideString;
var
  slRead : TStringList;
begin
  //Создание объекта для загрузки параметра
  slRead:=TStringList.Create;
  slRead.LoadFromFile(sDataDir+'\ConnectionString.dat');

  //Возвращение результата и удаление
  GetConnectionString:=slRead.Text;
  slRead.Free;
end;

{**************************Подготовка таблиц***********************************}
procedure TDBTest.PrepareTable(var ADOTable: TADOTable; TableName : string);
begin
  //Создание компонента
  ADOTable:=TADOTable.Create(Application);

  //Настройка компонента и начальные значения
  ADOTable.Connection:=ADOConnection;
  ADOTable.TableName:=TableName;
  ADOTable.Active:=true;
  
end;

{ TGroups }

{*****************************Создание класса**********************************}
constructor TGroups.Create;
begin
  fStudents:=TStudents.Create;
end;

{***************************Уничтожение класса*********************************}
destructor TGroups.Destroy;
begin
  fStudents.Destroy;
end;

{*************************Получение списка групп*******************************}
function TGroups.GetCount: integer;
begin
  GetCount:=ADOGroups.RecordCount;
end;

{*************************Информация о группе**********************************}
function TGroups.GetInfo(iGroup: integer): TInfoGroup;
begin
  with ADOGroups do
  begin
    //Переход по записям
    First;
    MoveBy(iGroup);

    //Чтение записи
    GetInfo.id:=FieldValues['ID'];
    GetInfo.sName:=FieldValues['Name'];
  end;
end;


{**********************Создание новой группы***********************************}
procedure TGroups.Add(Name: string);
begin
  //Добавление новой записи
  ADOGroups.Append;
  ADOGroups.FieldValues['Name']:=Name;
  ADOGroups.Post;
end;

{**********************Удаление выбранной группы*******************************}
procedure TGroups.Delete(Index: integer);
begin
  //Перемещение по набору
  ADOGroups.First;
  ADOGroups.MoveBy(Index);

  //Удаление записи
  ADOGroups.Delete;
  if ADOGroups.State in [dsEdit, dsInsert] then ADOGroups.Post;
  
end;

{**************************Переименование группы*******************************}
procedure TGroups.Rename(Index: integer; NewName: string);
begin
  //Перемещение по набору
  ADOGroups.First;
  ADOGroups.MoveBy(Index);

  //Изменение названия группы
  ADOGroups.Edit;
  ADOGroups.FieldByName('Name').AsString:=NewName;

  if ADOGroups.State in [dsEdit, dsInsert] then ADOGroups.Post;
  
end;

{******************Получение списка групп для перевода студента****************}
function TGroups.GetListMove(var List: TListView; CurrentGroup : string) : TIntVector;
var
  i, j : integer;
  sName : string;
begin
  with ADOGroups do
  begin
    with List.Items do
    begin
      BeginUpdate;
      Clear;
      First;
      for i:=1 to RecordCount do
      begin
        sName:=FieldValues['Name'];
        if sName<>CurrentGroup then
        begin
          Add.Caption:=sName;        
          SetLength(result,Count);
          result[count-1]:=FieldValues['ID'];
        end;
        Next;
      end;
      EndUpdate;
    end;
  end;

end;


{**************************Получение списка групп******************************}
procedure TGroups.GetList(var List: TListView);
var
  i : integer;
begin
  with ADOGroups do
  begin
    with List.Items do
    begin
      BeginUpdate;
      Clear;
      First;
      for i:=1 to RecordCount do
      begin
        Add.Caption:=FieldValues['Name'];
        Next;
      end;
      EndUpdate;
    end;
  end;
end;

{**********************Получение дерева групп**********************************}
procedure TGroups.GetTree(var TreeView: TTreeView);
var
  i, j, idGroup : integer;
  sNameGroup, sNameStudent : string;
  trGroup : TTreeNode;
begin
  //Начало обновления
  TreeView.Items.BeginUpdate;
  TreeView.Items.Clear;

  //Чтение данных из БД
  ADOGroups.First;
  for i:=1 to ADOGroups.RecordCount do
  begin
    idGroup:=ADOGroups.FieldValues['ID'];
    sNameGroup:=ADOGroups.FieldValues['Name'];
    trGroup:=TreeView.Items.Add(TreeView.FindNextToSelect,sNameGroup);

    //Поиск студентов группы
    ADOStudents.First;
    for j:=1 to ADOStudents.RecordCount do
    begin
      if idGroup=ADOStudents.FieldValues['ID_Groups'] then
      begin
        sNameStudent:=ADOStudents.FieldValues['Name'];
        TreeView.Items.AddChild(trGroup,sNameStudent);
      end;
      ADOStudents.Next;
    end;

    ADOGroups.Next;
  end;

  //Конец обновления
  TreeView.Items.EndUpdate;
end;

{ TStudents }

{**************************Добавление студента*********************************}
procedure TStudents.Add(var InfoStudent: TInfoStudent);
begin
  with ADOStudents do
  begin
    ADOStudents.Append;
    Write(InfoStudent);
  end;
end;

{****************************Удаление студента*********************************}
procedure TStudents.Delete(Index: integer);
begin
  with ADOStudents do
  begin
    First;
    MoveBy(Index);

    Delete;
    if State in [dsEdit, dsInsert] then Post;
  end;
end;

{**************************Редактирование информации***************************}
procedure TStudents.Edit(var InfoStudent: TInfoStudent; Index: integer);
begin
  with ADOStudents do
  begin
    //Переход по записям
    First;
    MoveBy(Index);

    //Чтение записи
    Edit;
    Write(InfoStudent);
  end;

end;

{****************************Информация о студенте*****************************}
function TStudents.GetInfo(var nStudent : TTreeNode): TInfoStudent;
var
  i, idGroup : integer;
  fGroups : TGroups;
begin
  //Определение группы
  fGroups:=TGroups.Create;
  idGroup:=fGroups.GetInfo(nStudent.Parent.Index).ID;
  fGroups.Free;

  with ADOStudents do
  begin
    //Переход по записям
    First;
    for i:=1 to RecordCount do
    begin
      if (FieldValues['Name']=nStudent.Text) and
         (FieldValues['ID_Groups']=idGroup) then
      begin
        GetInfo.ID:=FieldValues['ID'];
        GetInfo.idGroup:=FieldValues['ID_Groups'];
        GetInfo.sName:=FieldValues['Name'];
        GetInfo.sNumber:=FieldValues['Number_zachetki'];
        GetInfo.dDate:=FieldValues['Date'];

        break;
      end;
      Next;
    end;
    
  end;

end;

{***************************Перевод в другую группу****************************}
procedure TStudents.Move(var nStudent : TTreeNode; NewIdGroup : integer);
var
  iValueID, idStudent, i : integer;
begin
  with ADOStudents do
  begin
    idStudent:=GetInfo(nStudent).ID;
    
    First;
    for i:=1 to RecordCount do
    begin
      iValueID:=FieldValues['ID'];
      if iValueID=idStudent then
      begin
        Edit;
        FieldValues['ID_Groups']:=NewIdGroup;
        break;          
      end;
      Next;
    end;

    if State in [dsEdit, dsInsert] then Post;
  end;

end;

{****************************Информация о студенте*****************************}
procedure TStudents.Write(var InfoStudent: TInfoStudent);
begin
  with ADOStudents do
  begin
    FieldValues['ID_Groups']:=InfoStudent.idGroup;
    FieldValues['Name']:=InfoStudent.sName;
    FieldValues['Date']:=InfoStudent.dDate;
    FieldValues['Number_zachetki']:=InfoStudent.sNumber;

    if State in [dsEdit, dsInsert] then Post;
  end;

end;


{ TReports }

{******************************Создание класса*********************************}
constructor TReports.Create;
begin
  //Инициализация
  slQuerys:=TStringList.Create;
  slQuerys.Clear;

  //Загрузка данных
  slQuerys.LoadFromFile(sDataDir+'\Querys.dat');
end;

{******************************Удаление класса*********************************}
destructor TReports.Destroy;
begin
  slQuerys.Free;
end;

{********************EXCEL (Результаты группы по теме)*************************}
procedure TReports.ExcelGroupTopic(var List: TListView;
  var DataReport: TDataReportGT; bPrint : boolean);
var
          Excel : Variant;
         sIndex : string;
  iSA, iPerfomance,
  iQuality, iOcenka,
      i, iCount : integer;
begin
  //Инициализация
  iSA:=0;
  iPerfomance:=0;
  iQuality:=0;
  iCount:=0;

  //Параметры страницы
  Excel:=CreateOleObject('Excel.Application');
  Excel.Workbooks.Add(sTemplateDir+'\ResultsTopicsGroups.xlt');
  Excel.ActiveSheet.PageSetup.LeftMargin:= Excel.Application.InchesToPoints(0.44);
  Excel.ActiveSheet.PageSetup.RightMargin:= Excel.Application.InchesToPoints(0.44);
  Excel.ActiveSheet.PageSetup.TopMargin:= Excel.Application.InchesToPoints(0.44);
  Excel.ActiveSheet.PageSetup.BottomMargin:= Excel.Application.InchesToPoints(0.44);
  Excel.ActiveSheet.PageSetup.Orientation:= 1;
  Excel.ActiveSheet.PageSetup.CenterFooter:='Протокол подготовлен с использованием программы "Система тестирования"';

  //Основные данные
  for i:=0 to List.Items.Count-1 do
  begin
    with List.Items.Item[i] do
    begin
      sIndex:=IntToStr(13+i);
      Excel.Range['A'+sIndex].Value:=i+1;
      Excel.Range['B'+sIndex].Value:=SubItems[0];
      Excel.Range['C'+sIndex].Value:=SubItems[1];
      Excel.Range['D'+sIndex].Value:=SubItems[2];
      Excel.Range['E'+sIndex].Value:=SubItems[3];
      Excel.Range['F'+sIndex].Value:=SubItems[4];

      if SubItems[1]<>'-' then
      begin
        Inc(iCount);

        iOcenka:=StrToInt(SubItems[1]);
        if iOcenka in [3,4,5] then Inc(iQuality);
        if iOcenka in [4,5] then Inc(iPerfomance);
        if iOcenka in [2,3,4,5] then iSA:=iSa+iOcenka;
      end;

    end;
    
  end;
  Excel.Range['A12:F'+sIndex].Select;
  Excel.Selection.Borders.LineStyle:=1;
  Excel.Range['A1'].Select;

  //Дополнительные параметры
  with DataReport do
  begin
    Excel.Range['A2'].Value:='тестирования студентов гр. "'+sGroup+'"';
    Excel.Range['A4'].Value:='Дисциплина: "'+sSubject+'"';
    Excel.Range['A5'].Value:='Тема: "'+sTopic+'"';
    Excel.Range['A6'].Value:='Дата отчета: "'+DateToStr(Date)+'"';
    Excel.Range['A7'].Value:='Средний балл: "'+IntToStr(round(iSA/iCount))+'"';
    Excel.Range['A8'].Value:='Качество: "'+IntToStr(round(iQuality/iCount)*100)+'%"';
    Excel.Range['A9'].Value:='Успеваемость: "'+IntToStr(round(iPerfomance/iCount)*100)+'%"';
  end;

  //Место для подписи
  sIndex:=IntToStr(StrToInt(sIndex)+4);
  Excel.Range['B'+sIndex].Value:='Преподаватель';
  Excel.Range['D'+sIndex].Value:=DataReport.sTeachers;

  //Признак печати
  if bPrint=true
    then Excel.ActiveSheet.PrintOut
    else Excel.Visible:=True;

end;

{*************************Получение текста запроса*****************************}
function TReports.GetSQLText(NameQuery: string): AnsiString;
var
  i : integer;
begin
  //Инициализация
  i:=slQuerys.IndexOf(NameQuery);
  Result:='';

  //Загрузка запроса
  while slQuerys[i+1]<>'[EndQuery]' do
  begin
    Inc(i);
    Result:=Result+slQuerys[i]+' ';
  end;

end;

{**************************Подготовка параметра********************************}
function TReports.PrepareParameter(sName: string; vValue: variant): TParameter;
begin
  with ADOQuery do
  begin
    Result:=Parameters.AddParameter;
    with Result do
    begin
      Name:=sName;
      Value:=vValue;
    end;
  end;

end;

{************************Список предметов студента*****************************}
procedure TReports.ListSubjectST(idStudent : integer; var TabControl: TTabControl);
var
  i, j : integer;
  prmStudent : TParameter;
  sName : string;
begin
  //Список предметов
  with ADOQuery do
  begin
    //Формирование запроса
    Close;
    Parameters.Clear;
    prmStudent:=PrepareParameter('prmStudent',idStudent);
    SQL.Text:=GetSQLText('[SubjectsStudent]');
    Open;

    //Перебор записей
    First;
    j:=0;
    with TabControl  do
    begin
      Tabs.BeginUpdate;
      Tabs.Clear;
      for i:=1 to RecordCount do
      begin
        sName:=FieldValues['Name'];
        if Tabs.IndexOf(sName)=-1 then
        begin
          Tabs.Add(sName);
          Inc(j);
          SetLength(aSubjectsST,j);
          aSubjectsST[j-1]:=FieldValues['ID'];
        end;
        Next;
      end;
      Tabs.EndUpdate;
    end;
  end;

end;

{****************Дервево для запроса "Результаты группы по теме"***************}
procedure TReports.GetTreeDRGroupTopic(var TreeView: TTreeView);
var
  aData : array [0..4] of string;
  aNode : array [0..4] of TTreeNode;
  i : integer;
begin
  //Инициализация
  aNode[0]:=TreeView.FindNextToSelect;

  with ADOQuery do
  begin
    Close;
    SQL.Text:=GetSQLText('[TreeTopicsGroups]');
    Open;

    First;
    with TreeView.Items do
    begin
      BeginUpdate;
      Clear;
      while not Eof do
      begin
        for i:=0 to 3 do
        begin
          if i=3
            then aData[4]:=DateToStr(Fields[i].Value)
            else aData[4]:=Fields[i].Value;
            
          if aData[4]<>aData[i] then
          begin
              aNode[i+1]:=AddChild(aNode[i],Fields[i].Value);
          end;

          aData[i]:=Fields.Fields[i].Value;
        end;

        Next;
      end;
      EndUpdate;
    end;
    
  end;
end;

{***********************Результаты группы по теме******************************}
procedure TReports.ResultsGroupTopic(var TreeView: TTreeView;
  var List : TListView; var DataReport : TDataReportGT);
var
  aData : array [0..3] of string;
  Node : TTreeNode;
  bDate, bFlag : boolean;
  i, j, iLength : integer;
  liAdd : TListItem;
begin
  //Инициализация
  Node:=TreeView.Selected;
  if Node.Level=3 then bDate:=true else bDate:=false;

  while node<>nil do
  begin
    aData[Node.Level]:=Node.Text;
    Node:=Node.Parent;
  end;

  with ADOQuery do
  begin
    //Список студентов
    Close;
    Parameters.Clear;
    PrepareParameter('prmGroup',aData[0]);
    SQL.Text:=GetSQLText('[ListGroup]');
    Open;

    SetLength(fListStudents,RecordCount);
    First;
    for i:=1 to RecordCount do
    begin
      fListStudents[i-1].Name:=FieldValues['Name'];
      SetLength(fListStudents[i-1].Results,0);
      Next;
    end;

    //Обработка запроса
    Close;
    Parameters.Clear;
    PrepareParameter('prmGroup',aData[0]);    DataReport.sGroup:=aData[0];
    PrepareParameter('prmSubject',aData[1]);  DataReport.sSubject:=aData[1];
    PrepareParameter('prmTopic',aData[2]);    DataReport.sTopic:=aData[2];

    if bDate=true then
    begin
      PrepareParameter('prmDate',StrToDate(aData[3]));
      SQL.Text:=GetSQLText('[ResultsTopicsGroupsWithDate]');
    end
    else
      SQL.Text:=GetSQLText('[ResultsTopicsGroups]');

    Open;

    //Обработка результатов
    for i:=0 to length(fListStudents)-1 do
    begin
      First;
      for j:=1 to RecordCount do
      begin
        if FieldValues['ST.Name']=fListStudents[i].Name then
        begin

          iLength:=Length(fListStudents[i].Results);
          SetLength(fListStudents[i].Results,iLength+1);

          with fListStudents[i].Results[iLength] do
          begin
            iOcenka:=FieldValues['Ocenka'];
            iProcent:=FieldValues['Procent'];
            Date:=FieldValues['DateTime'];
            sTeacher:=FieldValues['TE.Name'];

            if pos(sTeacher,DataReport.sTeachers)=0 then
              DataReport.sTeachers:=DataReport.sTeachers+sTeacher+'; '
          end;
        end;

        Next;          
      end;
    end;

    //Колонки
    PrepareColumn(List, '№', false, 30, taLeftJustify);
    PrepareColumn(List, 'ФИО', true, 150, taLeftJustify);
    PrepareColumn(List, 'Оценка', false, 75, taCenter);
    PrepareColumn(List, 'Процент', false, 75, taCenter);
    PrepareColumn(List, 'Дата', false, 75, taCenter);
    PrepareColumn(List, 'Пересдача', false, 75, taCenter);
    

    //Отображение
    with List do
    begin
      Items.BeginUpdate;
      Clear;
      for i:=0 to length(fListStudents)-1 do
      begin
        liAdd:=Items.Add;
        with liAdd do
        begin
          Caption:=IntToStr(i+1);

          //ФИО
          SubItems.Add(fListStudents[i].Name);
          if Length(fListStudents[i].Results)=0 then
          begin
            SubItems.Add('-');
            SubItems.Add('-');
            SubItems.Add('-');
            SubItems.Add('-');
          end
          else
          begin
            SubItems.Add(IntToStr(fListStudents[i].Results[0].iOcenka));
            SubItems.Add(IntToStr(fListStudents[i].Results[0].iProcent));
            SubItems.Add(DateToStr(fListStudents[i].Results[0].Date));
            if Length(fListStudents[i].Results)>1 then
              SubItems.Add('Да')
            else
              SubItems.Add('Нет');
          end;

        end;
        next;
      end;

      Items.EndUpdate;
    end;
    
  end;
end;

{********************Результаты студента по предмету***************************}
procedure TReports.ResultSubjectST(idStudent, idSubject: integer;
  var List: TListView);
begin
  with ADOQuery do
  begin
    Close;

    //Подготовка параметров
    Parameters.Clear;
    PrepareParameter('prmStudent',idStudent);
    PrepareParameter('prmSubject',idSubject);

    //Формирование запроса
    SQL.Text:=GetSQLText('[ResultsStudent]');
    Open;

    GetList(List);

  end;
end;

{***********************Отображение таблицы запроса****************************}
procedure TReports.GetList(var List: TListView);
var
  i, j : integer;
  liAdd : TListItem;  
begin
  with ADOQuery do
  begin
    //Перебор записей
    First;
    with List do
    begin
      Items.BeginUpdate;
      Clear;
      for i:=1 to RecordCount do
      begin
        liAdd:=Items.Add;
        with liAdd do
        begin
          Caption:=IntToStr(i);
          for j:=0 to FieldCount-1 do SubItems.Add(Fields[j].Value);
        end;
        next;
      end;

      Items.EndUpdate;
    end;
  end;

end;

{**********************Подготовка колонок таблицы******************************}
procedure TReports.PrepareColumn(var List: TListView; sCaption: string;
  bAutoSize: boolean; iWidth: integer; alAlignment : TAlignment);
begin
  With List.Columns.Add do
  begin
    Caption:=sCaption;
    AutoSize:=bAutoSize;
    Alignment:=alAlignment;
    Width:=iWidth;
  end;
end;

{**************Получение результатов студента по одной теме********************}
procedure TReports.GetListResults(Student: string; var List: TListView);
var
  i, j : integer;
begin
  for i:=0 to length(fListStudents)-1 do
  begin
    if fListStudents[i].Name=Student then
    begin
      with List.Items do
      begin
        BeginUpdate;
        Clear;

        for j:=0 to length(fListStudents[i].Results)-1 do
        begin
          with Add do
          begin
            Caption:=IntToStr(j+1);
            with fListStudents[i].Results[j] do
            begin
              SubItems.Add(IntToStr(iOcenka));
              SubItems.Add(IntToStr(iProcent));
              SubItems.Add(DateTimeToStr(Date));
            end;
          end;
        end;

        EndUpdate;
      end;

      break;
    end;
  end;  
end;

{ TManager }

{**************************Добавление теста************************************}
procedure TManager.Add(Files: TStrings; var List: TListView);
var
  i : integer;
begin
  //Перебор всех файлов
  for i:=0 to Files.Count-1 do
  begin
    CopyTest(Files[i], sTestsDir);
    with List.Items.Add do
    begin
      Caption:=IntToStr(List.Items.Count);
      SubItems.Add(ExtractFileName(Files[i]));
    end;
  end;

end;

{***********************Создание класса управления тестами*********************}
constructor TManager.Create;
begin
  sTestsDir:=ExtractFilePath(Application.ExeName)+'Tests';
end;

procedure TManager.AddInfoDB(FileTest: string);
begin

end;

{**************************Получение списка тестов*****************************}
procedure TManager.GetList(var List: TListView);
var
  SR : TSearchRec;
begin
  //Обновление списка
  with List.Items do
  begin
    BeginUpdate;
    Clear;

    if FindFirst(sTestsDir+'\*.tst',faAnyFile,SR) = 0 then
    begin
      with Add do
      begin
        Caption:=IntToStr(Count);
        SubItems.Add(SR.Name)
      end;

      while FindNext(SR)=0 do
        with Add do
        begin
          Caption:=IntToStr(Count);
          SubItems.Add(SR.Name)
        end;
    end;

    FindClose(SR);

    EndUpdate;
  end;
end;

{********************************Копирование теста*****************************}
procedure TManager.CopyTest(FileTest: string; sWhereDir : string);
var
  sShortName, sFromPath, sPathLink : string;
  SR : TSearchRec;
begin
  sShortName:=Copy(ExtractFileName(FileTest),1,length(ExtractFileName(FileTest))-4);

  if FileExists(sWhereDir+'\'+sShortName+'.tst')=true then
  begin
    if MessageDlg('Данный тест уже существует! Заменить?',mtWarning,[mbYes,mbNo],0)=mrNo
      then exit;
  end;

  sFromPath:=ExtractFileDir(FileTest)+'\'+sShortName+'_files\';
  CreateDir(sWhereDir+'\'+sShortName+'_files');

  CopyFile(PChar(FileTest),PChar(sWhereDir+'\'+sShortName+'.tst'),false);


  if FindFirst(sFromPath+'*.*',faAnyFile, SR) = 0 then
  begin
    sPathLink:=sWhereDir+'\'+sShortName+'_files\';
    CopyFile(PChar(sFromPath+SR.Name),PChar(sPathLink+SR.Name),false);

    while FindNext(SR)=0 do
      CopyFile(PChar(sFromPath+SR.Name),PChar(sPathLink+SR.Name),false);
  end;

  FindClose(SR);
end;

{**************************Удаление теста**************************************}
procedure TManager.Delete(FileTest: string; var List: TListView);
var
  sShortName, sDirLink : string;
  SR : TSearchRec;
  i : integer;
begin
  sShortName:=Copy(FileTest,1,length(FileTest)-4);
  sDirLink:=sTestsDir+'\'+sShortName+'_files';

  List.Items.Delete(List.ItemIndex);
  DeleteFile(sTestsDir+'\'+FileTest);

  if FindFirst(sDirLink+'\*.*',faAnyFile, SR) = 0 then
  begin
    DeleteFile(sDirLink+'\'+SR.Name);

    while FindNext(SR)=0 do
      DeleteFile(sDirLink+'\'+SR.Name);
  end;

  FindClose(SR);

  RemoveDir(sDirLink);

  //Изменение порядковых номеров
  for i:=0 to List.Items.Count-1 do
  begin
    List.Items.Item[i].Caption:=IntToStr(i+1);
  end;
end;

{*****************************Экспорт теста************************************} 
procedure TManager.ExportTest(FileTest, sWhereDir: string);
begin
  CopyTest(sTestsDir+'\'+FileTest, sWhereDir);
end;

{ TTesting }

{**************************Создание класса*************************************}
constructor TTesting.Create;
begin
  sExchangeDir:=ExtractFilePath(Application.ExeName)+'Exchange';
end;

{*************************Проверка тестирования********************************}
function TTesting.CheckTesting: boolean;
var
  slTesting : TStringList;
begin
  slTesting:=TStringList.Create;
  slTesting.LoadFromFile(sExchangeDir+'\Testing.dat');

  if slTesting[0]='true'
    then CheckTesting:=true
    else CheckTesting:=false;

  slTesting.Free;
end;

{***************************Список тестируемых*********************************}
procedure TTesting.GetListComp(var List: TListView);
label Jump;
var
  slComp, slListComp : TStringList;
  i, iCount : integer;
  SR : TSearchRec;
begin
  //Инициализация
  iCount:=0;
  slListComp:=TStringList.Create;
  slComp:=TStringList.Create;

  if CheckTesting=false then goto Jump;

  //Поиск файлов
  if FindFirst(sExchangeDir+'\*.comp',faAnyFile,SR) = 0 then
  begin
    slListComp.Add(sExchangeDir+'\'+SR.Name);

    while FindNext(SR)=0 do
      slListComp.Add(sExchangeDir+'\'+SR.Name);
  end;
  FindClose(SR);

  //Обработка каждого файла
  SetLength(aInfoTesting,slListComp.Count);
  List.Items.BeginUpdate;
  List.Items.Clear;

  for i:=0 to slListComp.Count-1 do
  begin
    try
      slComp.LoadFromFile(slListComp[i]);
    except
      exit;
    end;

    //Запись
    with aInfoTesting[i] do
    begin
      sComp:=slComp[0];
      sGroup:=slComp[1];
      sStudent:=slComp[2];
      sSubject:=slComp[3];
      sTopic:=slComp[4];
      
      List.Items.Add.Caption:=sStudent;
    end;
  end;

  Jump:
  List.Items.EndUpdate;

  //Удаление объектов
  slComp.Free;
  slListComp.Free;


{  SetLength(aInfoTesting,iCount);
  with List.Items do
  begin
    BeginUpdate;
    Clear;

    if CheckTesting=false then goto Jump;

    i:=0;
    while i<slListComp.Count-1 do
    begin
      if slListComp[i]='[COMP]' then
      begin
        inc(iCount);
        SetLength(aInfoTesting,iCount);
        with aInfoTesting[iCount-1] do
        begin
          sComp:=slListComp[i+1];
          sStudent:=slListComp[i+2];
          sSubject:=slListComp[i+3];
          sTopic:=slListComp[i+4];
          iMinPoz:=StrToInt(slListComp[i+5]);
          iMinMax:=StrToInt(slListComp[i+6]);
        end;
        Add.Caption:=slListComp[i+2];
        i:=i+5;
      end;
      inc(i);
    end;

    Jump:
    EndUpdate;
  end;          }


end;

{*****************************Начало тестирования******************************}
procedure TTesting.Start(var List : TListView);
var
  slTesting, slListComp : TStringList;
  i : integer;
begin
  slTesting:=TStringList.Create;
  slTesting.Clear;

  with List.Items do
  begin
    for i:=0 to Count-1 do
      if Item[i].Checked=true then slTesting.Add(Item[i].Caption);
  end;

  //Сохранение деревьей групп и тем
  GetTreeGroups(slTesting);
  GetTreeTopics;


  slTesting.Insert(0, 'true');
  slTesting.SaveToFile(sExchangeDir+'\Testing.dat');
  slTesting.Free;

  //Очистка списка компьютеров
//  ClearFile(sExchangeDir+'\ListComp.dat');

end;

{****************************Остановка тестирования****************************}
procedure TTesting.Stop (var List : TListView);
var
  slTesting, slTemp : TStringList;
  i : integer;
begin
  slTesting:=TStringList.Create;
  slTesting.Clear;

  slTesting.Add('false');
  with List.Items do
  begin
    for i:=0 to Count-1 do
      Item[i].Checked:=false;
  end;

  slTesting.SaveToFile(sExchangeDir+'\Testing.dat');
  slTesting.Free;

  //Очистка списка компьютеров, деревьев групп и предметов
//  ClearFile(sExchangeDir+'\ListComp.dat');
  ClearFile(sExchangeDir+'\Groups.dat');
  ClearFile(sExchangeDir+'\Topics.dat');
  ClearFile(sExchangeDir+'\IndexSubjects.dat');

end;

{************************Получение списка тестируемых групп********************}
procedure TTesting.GetCurrentListGroups(var List: TListView);
var
  slTesting : TStringList;
  i, j, iCount : integer;
begin
  slTesting:=TStringList.Create;
  slTesting.LoadFromFile(sExchangeDir+'\Testing.dat');
  iCount:=List.Items.Count;

  for i:=1 to slTesting.Count-1 do
  begin
    for j:=0 to iCount-1 do
    begin
      if slTesting[i]=List.Items.Item[j].Caption then
        List.Items.Item[j].Checked:=true;
    end;
  end;

  slTesting.Free;


end;

{*************************Дерево групп для клиента*****************************}
procedure TTesting.GetTreeGroups(var slGroups: TStringList);
label Jump;
var
  slTreeGroups : TStringList;
  i, j, idGroup : integer;
  sNameGroup, sNameStudent : string;
begin
  //Создание переменных
  slTreeGroups:=TStringList.Create;

  //Построение дерева групп
  ADOGroups.First;
  for i:=1 to ADOGroups.RecordCount do
  begin
    idGroup:=ADOGroups.FieldValues['ID'];
    sNameGroup:=ADOGroups.FieldValues['Name'];

    if slGroups.IndexOf(sNameGroup)<>-1 then
    begin
      slTreeGroups.Add(sNameGroup);

      //Поиск студентов группы
      ADOStudents.First;
      for j:=1 to ADOStudents.RecordCount do
      begin
        if idGroup=ADOStudents.FieldValues['ID_Groups'] then
        begin
          sNameStudent:=ADOStudents.FieldValues['Name'];
          slTreeGroups.Add(' '+sNameStudent);
        end;
        ADOStudents.Next;
      end;
    end;
    
    ADOGroups.Next;

  end;
  slTreeGroups.SaveToFile(sExchangeDir+'\Groups.dat');

  //Удаление
  slTreeGroups.Free;


end;

{******************************Чистка файла************************************}
procedure TTesting.ClearFile(sFileName: string);
var
  slTemp : TStringList;
begin
  slTemp:=TStringList.Create;
  slTemp.Clear;
  slTemp.SaveToFile(sFileName);
  slTemp.Free;
end;

{****************************Построение дерева тем*****************************}
procedure TTesting.GetTreeTopics;
var
  slTests, slContainer, slTreeTests, slTreeIndex : TStringList;
  i, j: integer;
begin
  //Создание компонент
  slTests:=TStringList.Create;
  slContainer:=TStringList.Create;
  slTreeTests:=TStringList.Create;
  slTreeIndex:=TStringList.Create;

  //Получение списка файлов тестирования
  GetListTests(slTests);
  for i:=0 to slTests.Count-1 do
  begin
    //Загрузка файла тестирования
    slContainer.LoadFromFile(slTests[i]);
    Decode(slContainer);

    //Чтение названия предмета
    j:=slContainer.IndexOf('<BeginSubject>');
    slTreeTests.Add(slContainer[j+1]);
    slTreeIndex.Add(ExtractFileName(slTests[i]));

    //Чтение тем
    j:=slContainer.IndexOf('<BeginTopics>');
    while slContainer[j+1]<>'<EndTopics>' do
    begin
      inc(j);
      slTreeTests.Add(' '+slContainer[j]);
    end;

  end;

  //Запись дерева
  slTreeTests.SaveToFile(sExchangeDir+'\Topics.dat');
  slTreeIndex.SaveToFile(sExchangeDir+'\IndexSubjects.dat');

  //Удаление
  slTests.Free;
  slContainer.Free;
  slTreeTests.Free;

end;

{*********************Получение списка файлов тестирования*********************}
procedure TTesting.GetListTests(var slList: TStringList);
var
  SR : TSearchRec;
begin
  //Обновление списка
  with slList do
  begin
    BeginUpdate;
    Clear;

    if FindFirst(sTestsDir+'\*.tst',faAnyFile,SR) = 0 then
    begin
      Add(sTestsDir+'\'+SR.Name);

      while FindNext(SR)=0 do
        Add(sTestsDir+'\'+SR.Name);
    end;
    FindClose(SR);

    EndUpdate;
  end;
end;

procedure TTesting.GetInfoTesting(var List: TListView);
var
  iIndex : integer;
begin
  //Если нет фокуса
  if List.Selected=nil then
  begin
    with fmTesting do
    begin
      sbInfo.Visible:=false;
      pbTime.Visible:=false;
    end;
    exit;
  end;

  //Инициализация
  iIndex:=List.Selected.Index;

  //Получение дополнительной информации
  with fmTesting do
  begin
    //Строка состояния
    with aInfoTesting[iIndex] do
    begin
      sbInfo.Visible:=true;
      sbInfo.Panels[0].Text:=sComp;
      sbInfo.Panels[1].Text:=sGroup;
      sbInfo.Panels[2].Text:=sSubject;
      sbInfo.Panels[3].Text:=sTopic;

{      //Прогресс-бар
      if iMinMax=0
        then pbTime.Visible:=false
        else pbTime.Visible:=true;

      pbTime.Max:=iMinMax;
      pbTime.Position:=iMinPoz;}

    end;
  end;

end;

end.
