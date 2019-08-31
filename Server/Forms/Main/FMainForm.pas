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

    //���������� �����������
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
  //����������� �������
  DBTest.Destroy;
end;

procedure TfmMain.FormShow(Sender: TObject);
var
  bTesting : boolean;
  sStatus : string;
begin
  //����������� ������ �����
  DBTest.Groups.GetTree(tvGroups);

  case DBTest.Testing.CheckTesting of
     true : sStatus:='���������� ������������';
    false : sStatus:='������������ �� ����������';
  end;
  sbTesting.Panels[0].Text:=sStatus;

  ManagerElements;
  EnabledStudents(false);
end;

procedure TfmMain.mnAddGroupClick(Sender: TObject);
var
  sNameGroup : string;
begin
  //���������� ������
  fmAddGroup:=TfmAddGroup.Create(Application);
  afAddGroup:=ADD;
  fmAddGroup.pNameGroup:='������';
  fmAddGroup.ShowModal;

  //���� ������
  if afAddGroup=ADD then
  begin
    sNameGroup:=fmAddGroup.pNameGroup;
    DBTest.Groups.Add(sNameGroup);
    tvGroups.Items.Add(tvGroups.FindNextToSelect,sNameGroup);
  end;

  ManagerElements;

  //�������� �����
  fmAddGroup.Free;

end;

procedure TfmMain.mnDeleteGroupClick(Sender: TObject);
var
  mrResult : TModalResult;
begin
  //�������������
  mrResult:=MessageDlg('������� ������ "'+nGroup.Text+'"?',mtWarning,[mbYes,mbNo],0);
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
    fmMain.Caption:='����-������|'+nGroup.Text;
    lstResults.Clear;
    tcResults.Tabs.Clear;    
  end
  else
  begin
    EnabledGroups(false);
    nStudent:=tvGroups.Selected;
    nGroup:=nStudent.Parent;
    fmMain.Caption:='����-������|'+nGroup.Text+'|'+nStudent.Text;

    //���������� ��������
    idStudent:=DBTest.Groups.Students.GetInfo(nStudent).ID;
    DBTest.Reports.ListSubjectST(idStudent,tcResults);

    lstResults.Clear;
    if tcResults.Tabs.Count<>0 then
    begin
      idSubject:=DBTest.Reports.SubjectsST[0];
      DBTest.Reports.ResultSubjectST(idStudent,idSubject,lstResults);
    end;
  end;

  //���������
  ManagerElements;



end;

procedure TfmMain.mnEditGroupClick(Sender: TObject);
var
  sNameGroup : string;
begin
  //������������� � ��������
  fmRenameGroup:=TfmRenameGroup.Create(application);
  afRenameGroup:=EDIT;
  fmRenameGroup.pNameGroup:=nGroup.Text;
  fmRenameGroup.ShowModal;

  //���������� ����������
  if afRenameGroup=EDIT then
  begin
    sNameGroup:=fmRenameGroup.pNameGroup;
    DBTest.Groups.Rename(nGroup.Index,sNameGroup);
    nGroup.Text:=sNameGroup;
  end;

  //�������� �����
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
  //�������� �����
  fmAbout:=TfmAbout.Create(application);
  fmAbout.ShowModal;

  //�������� �����
  fmAbout.Free;
end;

procedure TfmMain.mnAddStudentClick(Sender: TObject);
var
  pInfo : TInfoStudent;
begin
  //�������� �����
  fmAddEditStudent:=TfmAddEditStudent.Create(application);
  fmAddEditStudent.pnlGroup.Caption:=nGroup.Text;
  afAddEditStudent:=ADD;

  //����������� �����
  fmAddEditStudent.ShowModal;

  //���������� ����������
  if afAddEditStudent=ADD then
  begin
    pInfo:=fmAddEditStudent.pInfoStudent;
    DBTest.Groups.Students.Add(pInfo);
    tvGroups.Items.AddChild(nGroup,pInfo.sName);
  end;  

  //�������� �����
  fmAddEditStudent.Free;
end;

procedure TfmMain.mnEditStudentClick(Sender: TObject);
begin
  //�������� �����
  fmAddEditStudent:=TfmAddEditStudent.Create(application);
  fmAddEditStudent.pnlGroup.Caption:=nGroup.Text;
  afAddEditStudent:=EDIT;
  //���������� � ��������
  fmAddEditStudent.pInfoStudent:=DBTest.Groups.Students.GetInfo(nStudent);

  //����������� �����
  fmAddEditStudent.ShowModal;

  //���������� ����������
  if afAddEditStudent=EDIT then
  begin
    DBTest.Groups.Students.Edit(fmAddEditStudent.pInfoStudent,idStudent);
    nStudent.Text:=fmAddEditStudent.pInfoStudent.sName;
  end;  

  //�������� �����
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
  //�������������
  mrResult:=MessageDlg('����� ������ ������� "'+nStudent.Text+'". ����������?',mtWarning,[mbYes,mbNo],0);
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
  //�������� �����
  fmMoveStudent:=TfmMoveStudent.Create(Application);
  afMoveStudent:=EDIT;
  fmMoveStudent.ShowModal;

  //����������� ��������
  if afMoveStudent=EDIT then
  begin
    DBTest.Groups.Students.Move(nStudent,fmMoveStudent.pValueID);
    nParent:=GetNodeGroup(fmMoveStudent.sName);
    nStudent.MoveTo(nParent,naAddChild);
  end;

  //�������� �����
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
  //�������� �����
  fmDataReports:=TfmDataReports.Create(Application);
  afDataReports:=EDIT;
  DBTest.Reports.GetTreeDRGroupTopic(fmDataReports.tvDataReports);
  fmDataReports.ShowModal;

  //�������� ������
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
  //�������� ������
  fmManagerTest:=TfmManagerTest.Create(Application);
  fmManagerTest.ShowModal;

  //��������
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
  If MessageDlg('��������� ������ � ����������?',mtInformation,[mbYes,mbNo],0)=mrNo
    then CanClose:=false
    else CanClose:=true;
end;

procedure TfmMain.mn_generalClick(Sender: TObject);
begin
  //�������� �����
  fmSetting:=TfmSetting.Create(Self);
  fmSetting.ShowModal;

  //�������� �����
  fmSetting.Free;

end;

end.
