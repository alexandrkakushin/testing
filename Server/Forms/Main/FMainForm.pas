unit FMainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, Menus, IniFiles, XPMan, ImgList, ToolWin, ExtCtrls, U_TestServer,
  DB, ADODB, ActnMan, ActnColorMaps;
type
  TfmMain = class(TForm)
    tvGroups: TTreeView;
    tcResults: TTabControl;
    Menu: TMainMenu;
    mn_setting: TMenuItem;
    mn_general: TMenuItem;
    Images_tree: TImageList;
    mn_group: TMenuItem;
    mnAddGroup: TMenuItem;
    mnEditGroup: TMenuItem;
    mnDeleteGroup: TMenuItem;
    Images_menu_tool: TImageList;
    mn_file: TMenuItem;
    mn_exit: TMenuItem;
    mn_reserve_copy: TMenuItem;
    mn_reserve_save: TMenuItem;
    mn_reserve_read: TMenuItem;
    dlgOpen: TOpenDialog;
    mn_help: TMenuItem;
    mnAbout: TMenuItem;
    lstResults: TListView;
    mn_reports: TMenuItem;
    mnResultGroupTopic: TMenuItem;
    tbMain: TToolBar;
    tbtnAddGroup: TToolButton;
    tbtnDeleteGroup: TToolButton;
    tbtnEditGroup: TToolButton;
    ToolButton1: TToolButton;
    tb_reports: TToolButton;
    ToolButton3: TToolButton;
    pm_reports: TPopupMenu;
    pm_ResultGroupTema: TMenuItem;
    mn_ResultStudentSubject: TMenuItem;
    pm_ResultStudentSubject: TMenuItem;
    N1: TMenuItem;
    mnStudents: TMenuItem;
    mnAddStudent: TMenuItem;
    mnEditStudent: TMenuItem;
    mnDeleteStudent: TMenuItem;
    tbtnAddStudent: TToolButton;
    tbtnDeleteStudent: TToolButton;
    tbtnEditStudent: TToolButton;
    ToolButton4: TToolButton;
    mnMoveStudent: TMenuItem;
    XPMan: TXPManifest;
    N2: TMenuItem;
    mnTesting: TMenuItem;
    mnManagerTests: TMenuItem;
    sbTesting: TStatusBar;
    procedure mn_exitClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure mnAddGroupClick(Sender: TObject);
    procedure mnDeleteGroupClick(Sender: TObject);
    procedure tvGroupsClick(Sender: TObject);
    procedure mnEditGroupClick(Sender: TObject);

    //Управление интерфейсом
    procedure ManagerElements;
    procedure EnabledGroups (bValue : boolean);
    procedure EnabledStudents (bValue : boolean);
    procedure mnAboutClick(Sender: TObject);
    procedure mnAddStudentClick(Sender: TObject);
    procedure mnEditStudentClick(Sender: TObject);
    function GetCountLevel (level : integer) : integer;
    function GetNodeGroup (sName : string) : TTreeNode;
    procedure mnDeleteStudentClick(Sender: TObject);
    procedure tcResultsChange(Sender: TObject);
    procedure mnMoveStudentClick(Sender: TObject);
    procedure mnResultGroupTopicClick(Sender: TObject);
    procedure mnManagerTestsClick(Sender: TObject);
    procedure mnTestingClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure mn_generalClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


var
  fmMain: TfmMain;
  DBTest : TDBTest;
  nGroup, nStudent : TTreeNode;
  idSubject, idStudent : integer; 

implementation

uses FAddGroup, FRenameGroup, F_About, FAddEditStudent, FMoveStudent,
  FDataReports, FReport, FManagerTest, F_Testing, F_Setting;

{$R *.dfm}



procedure TfmMain.mn_exitClick(Sender: TObject);
begin
  Close;
end;

procedure TfmMain.FormCreate(Sender: TObject);
begin
  DBTest:=TDBTest.Create;
  
end;

procedure TfmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //Уничтожение объекта
  DBTest.Destroy;
end;

procedure TfmMain.FormShow(Sender: TObject);
var
  bTesting : boolean;
  sStatus : string;
begin
  //Отображение дерева групп
  DBTest.Groups.GetTree(tvGroups);

  case DBTest.Testing.CheckTesting of
     true : sStatus:='Проводится тестирование';
    false : sStatus:='Тестирование не проводится';
  end;
  sbTesting.Panels[0].Text:=sStatus;

  ManagerElements;
  EnabledStudents(false);
end;

procedure TfmMain.mnAddGroupClick(Sender: TObject);
var
  sNameGroup : string;
begin
  //Добавление группы
  fmAddGroup:=TfmAddGroup.Create(Application);
  afAddGroup:=ADD;
  fmAddGroup.pNameGroup:='Группа';
  fmAddGroup.ShowModal;

  //Сбор данных
  if afAddGroup=ADD then
  begin
    sNameGroup:=fmAddGroup.pNameGroup;
    DBTest.Groups.Add(sNameGroup);
    tvGroups.Items.Add(tvGroups.FindNextToSelect,sNameGroup);
  end;

  ManagerElements;

  //Удаление формы
  fmAddGroup.Free;

end;

procedure TfmMain.mnDeleteGroupClick(Sender: TObject);
var
  mrResult : TModalResult;
begin
  //Подтверждение
  mrResult:=MessageDlg('Удалить группу "'+nGroup.Text+'"?',mtWarning,[mbYes,mbNo],0);
  case mrResult of
    mrYes : begin
              DBTest.Groups.Delete(nGroup.Index);
              nGroup.Delete;
            end;
     mrNo : exit;
  end;

end;

procedure TfmMain.EnabledGroups(bValue: boolean);
begin
  mnAddStudent.Enabled:=bValue;
  mnDeleteGroup.Enabled:=bValue;
  mnEditGroup.Enabled:=bValue;

  tbtnAddStudent.Enabled:=bValue;
  tbtnDeleteGroup.Enabled:=bValue;
  tbtnEditGroup.Enabled:=bValue;

  mnStudents.Enabled:=bValue;
end;

procedure TfmMain.tvGroupsClick(Sender: TObject);
var
  i : integer;
begin
  if tvGroups.Selected=nil then
  begin
    exit;
  end;

  if tvGroups.Selected.Level=0 then
  begin
    EnabledGroups(true);
    nGroup:=tvGroups.Selected;
    fmMain.Caption:='Тест-сервер|'+nGroup.Text;
    lstResults.Clear;
    tcResults.Tabs.Clear;    
  end
  else
  begin
    EnabledGroups(false);
    nStudent:=tvGroups.Selected;
    nGroup:=nStudent.Parent;
    fmMain.Caption:='Тест-сервер|'+nGroup.Text+'|'+nStudent.Text;

    //Результаты студента
    idStudent:=DBTest.Groups.Students.GetInfo(nStudent).ID;
    DBTest.Reports.ListSubjectST(idStudent,tcResults);

    lstResults.Clear;
    if tcResults.Tabs.Count<>0 then
    begin
      idSubject:=DBTest.Reports.SubjectsST[0];
      DBTest.Reports.ResultSubjectST(idStudent,idSubject,lstResults);
    end;
  end;

  //Интерфейс
  ManagerElements;



end;

procedure TfmMain.mnEditGroupClick(Sender: TObject);
var
  sNameGroup : string;
begin
  //Инициализация и создание
  fmRenameGroup:=TfmRenameGroup.Create(application);
  afRenameGroup:=EDIT;
  fmRenameGroup.pNameGroup:=nGroup.Text;
  fmRenameGroup.ShowModal;

  //Сохранение параметров
  if afRenameGroup=EDIT then
  begin
    sNameGroup:=fmRenameGroup.pNameGroup;
    DBTest.Groups.Rename(nGroup.Index,sNameGroup);
    nGroup.Text:=sNameGroup;
  end;

  //Удаление формы
  fmRenameGroup.Free;

end;

procedure TfmMain.ManagerElements;
begin
  if not ((tvGroups.Selected=nil) or (tvGroups.Items.Count=0)) then
  begin
    EnabledGroups(true);
    if tvGroups.Selected.Level=1
      then EnabledStudents(true)
      else EnabledStudents (false);
  end
  else
    EnabledGroups(false);

end;

procedure TfmMain.EnabledStudents(bValue: boolean);
begin
  mnDeleteStudent.Enabled:=bValue;
  mnEditStudent.Enabled:=bValue;

  if DBTest.Groups.Count<=1
    then mnMoveStudent.Enabled:=false
    else mnMoveStudent.Enabled:=bValue;

  tbtnDeleteStudent.Enabled:=bValue;
  tbtnEditStudent.Enabled:=bValue;
end;

procedure TfmMain.mnAboutClick(Sender: TObject);
begin
  //Создание формы
  fmAbout:=TfmAbout.Create(application);
  fmAbout.ShowModal;

  //Удаление формы
  fmAbout.Free;
end;

procedure TfmMain.mnAddStudentClick(Sender: TObject);
var
  pInfo : TInfoStudent;
begin
  //Создание формы
  fmAddEditStudent:=TfmAddEditStudent.Create(application);
  fmAddEditStudent.pnlGroup.Caption:=nGroup.Text;
  afAddEditStudent:=ADD;

  //Отображение формы
  fmAddEditStudent.ShowModal;

  //Сохранение информации
  if afAddEditStudent=ADD then
  begin
    pInfo:=fmAddEditStudent.pInfoStudent;
    DBTest.Groups.Students.Add(pInfo);
    tvGroups.Items.AddChild(nGroup,pInfo.sName);
  end;  

  //Удаление формы
  fmAddEditStudent.Free;
end;

procedure TfmMain.mnEditStudentClick(Sender: TObject);
begin
  //Создание формы
  fmAddEditStudent:=TfmAddEditStudent.Create(application);
  fmAddEditStudent.pnlGroup.Caption:=nGroup.Text;
  afAddEditStudent:=EDIT;
  //Информация о студенте
  fmAddEditStudent.pInfoStudent:=DBTest.Groups.Students.GetInfo(nStudent);

  //Отображение формы
  fmAddEditStudent.ShowModal;

  //Сохранение информации
  if afAddEditStudent=EDIT then
  begin
    DBTest.Groups.Students.Edit(fmAddEditStudent.pInfoStudent,idStudent);
    nStudent.Text:=fmAddEditStudent.pInfoStudent.sName;
  end;  

  //Удаление формы
  fmAddEditStudent.Free;
end;

function TfmMain.GetCountLevel(level: integer): integer;
var
  Node : TTreeNode;
  i, iCount : integer;
begin
  with tvGroups.Items do
  begin
    iCount:=0;

    for i:=0 to Count-1 do
    begin
      Node:=Item[i];
      if Node.Level=Level then
      begin
        inc(iCount);
      end;
    end;
  end;

  GetCountLevel:=iCount;
end;

procedure TfmMain.mnDeleteStudentClick(Sender: TObject);
var
  mrResult : TModalResult;
begin
  //Подтверждение
  mrResult:=MessageDlg('Будет удален студент "'+nStudent.Text+'". Продолжить?',mtWarning,[mbYes,mbNo],0);
  case mrResult of
    mrYes : begin
              DBTest.Groups.Students.Delete(DBTest.Groups.Students.GetInfo(nStudent).ID);
              nStudent.Delete;
            end;
     mrNo : exit;
  end;
end;

procedure TfmMain.tcResultsChange(Sender: TObject);
begin
  idSubject:=DBTest.Reports.SubjectsST[tcResults.TabIndex];
  DBTest.Reports.ResultSubjectST(idStudent,idSubject,lstResults);
end;

procedure TfmMain.mnMoveStudentClick(Sender: TObject);
var
  nParent : TTreeNode;
  sGroup : string;
begin
  //Создание формы
  fmMoveStudent:=TfmMoveStudent.Create(Application);
  afMoveStudent:=EDIT;
  fmMoveStudent.ShowModal;

  //Перемещение студента
  if afMoveStudent=EDIT then
  begin
    DBTest.Groups.Students.Move(nStudent,fmMoveStudent.pValueID);
    nParent:=GetNodeGroup(fmMoveStudent.sName);
    nStudent.MoveTo(nParent,naAddChild);
  end;

  //Удаление формы
  fmMoveStudent.Free;
end;

function TfmMain.GetNodeGroup(sName: string): TTreeNode;
var
  i : integer;
begin
  with tvGroups.Items do
  begin
    for i:=0 to Count-1 do
    begin
      if Item[i].Text=sName then
      begin
        GetNodeGroup:=Item[i];
        break;
      end;
    end;
  end;

end;

procedure TfmMain.mnResultGroupTopicClick(Sender: TObject);
begin
  //Создание формы
  fmDataReports:=TfmDataReports.Create(Application);
  afDataReports:=EDIT;
  DBTest.Reports.GetTreeDRGroupTopic(fmDataReports.tvDataReports);
  fmDataReports.ShowModal;

  //Создание отчета
  if afDataReports=EDIT then
  begin
    fmReport:=TfmReport.Create(Application);
    DBTest.Reports.ResultsGroupTopic(fmDataReports.tvDataReports, fmReport.lstReport,fmReport.pDataReportGT);

    fmDataReports.Free;
    fmReport.ShowModal;

    fmReport.Free;
  end;



end;

procedure TfmMain.mnManagerTestsClick(Sender: TObject);
begin
  //Создание форрмы
  fmManagerTest:=TfmManagerTest.Create(Application);
  fmManagerTest.ShowModal;

  //Удаление
  fmManagerTest.Free;

end;

procedure TfmMain.mnTestingClick(Sender: TObject);
begin
  fmTesting:=TfmTesting.Create(Application);
  fmTesting.ShowModal;

  fmTesting.Free;

end;

procedure TfmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  If MessageDlg('Завершить работу с программой?',mtInformation,[mbYes,mbNo],0)=mrNo
    then CanClose:=false
    else CanClose:=true;
end;

procedure TfmMain.mn_generalClick(Sender: TObject);
begin
  //Создание формы
  fmSetting:=TfmSetting.Create(Self);
  fmSetting.ShowModal;

  //Удаление формы
  fmSetting.Free;

end;

end.
