unit F_Main_form;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ToolWin, ActnMan, ActnCtrls, ActnList,
  ActnMenus, ImgList, StdCtrls, ExtCtrls, IniFiles, XPMan, XPStyleActnCtrls,
  Menus, ComCtrls, U_Test, JPEG;


type
  TfmMain = class(TForm)
    XPMan: TXPManifest;
    MainMenu: TMainMenu;
    mnFile: TMenuItem;
    mnCreate: TMenuItem;
    mnOpen: TMenuItem;
    mnSave: TMenuItem;
    mnSaveAs: TMenuItem;
    N6: TMenuItem;
    mnClose: TMenuItem;
    mnService: TMenuItem;
    mnDevelopers: TMenuItem;
    mnPassword: TMenuItem;
    TestImages: TImageList;
    mnHelp: TMenuItem;
    mnAbout: TMenuItem;
    mnAddEditPassword: TMenuItem;
    mnDeletePassword: TMenuItem;
    mnSetting: TMenuItem;
    mnLinks: TMenuItem;
    tbMain: TToolBar;
    tbtnCreate: TToolButton;
    tbtnOpen: TToolButton;
    tbtnSave: TToolButton;
    ToolButton1: TToolButton;
    tbtnDevelopers: TToolButton;
    ToolButton2: TToolButton;
    tbtnLinks: TToolButton;
    tbtnAddEditPassword: TToolButton;
    tbtnDeletePassword: TToolButton;
    tsepPassword: TToolButton;
    tbtnSeparatorNameTest: TToolButton;
    tbtnNameTest: TToolButton;
    mnNameTest: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure mnOpenClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure mnAboutClick(Sender: TObject);
    procedure mnDevelopersClick(Sender: TObject);
    procedure mnDeletePasswordClick(Sender: TObject);

    procedure EnabledNameTest (bValue : boolean);
    procedure EnabledSaveTest (bValue : boolean);
    procedure ElementsTest;

    procedure mnAddEditPasswordClick(Sender: TObject);
    procedure mnLinksClick(Sender: TObject);
    procedure mnNameTestClick(Sender: TObject);
    procedure mnSaveAsClick(Sender: TObject);
    procedure mnSaveClick(Sender: TObject);
    procedure mnCreateClick(Sender: TObject);
    procedure mnCloseClick(Sender: TObject);

  private

  public
    { Public declarations }

  end;

var
  fmMain: TfmMain;

  Test : TTest;


implementation

uses FTopics, F_About, FListDeveloper, fAddEditPassword, F_Links,
  FRenameTest;

{$R *.dfm}




procedure TfmMain.FormCreate(Sender: TObject);
begin
  //�������� ������� TTest
  Test:=TTest.Create(Test);

  ElementsTest;
  EnabledSaveTest(false);


end;

procedure TfmMain.mnOpenClick(Sender: TObject);
var
  FdlgOpen : TOpenDialog;
  mrResult : TModalResult;
begin
  //���� ���� �� ��������
  if bTestModified=true then
    mrResult:=MessageDlg('���� "'+Test.Subject+'" ��� �������! ���������?!',mtInformation,[mbYes, mbNo, mbCancel],0);

  case mrResult of
    mrCancel : exit;
       mrYes : begin
                  mnSave.Click;
                  fmTopics.Close;
               end;
        mrNo : fmTopics.Close;
  end;

  //�������� ������� �������� �����
  FdlgOpen:=TOpenDialog.Create(Self);
  FdlgOpen.Filter:='����� ������������ (*.tst)|*.tst;';
  FdlgOpen.DefaultExt:='TST';

  //������ �������� �����
  if FdlgOpen.Execute then
  begin
    if fmTopics.Showing=true then fmTopics.Close;
      
    Test.Open(FdlgOpen.FileName, fmMain);

    //�������� ����� � ������ (���� �������� ��������)
    if Test.Password.Check=true then
    begin
      mnPassword.Enabled:=true;
      ElementsTest;
      fmTopics.Show;      
    end;
  end;

  //�������� �������
  FDlgOpen.Free;

end;

procedure TfmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //�������� ��������
  Test.Free;
end;

procedure TfmMain.mnAboutClick(Sender: TObject);
begin
  //�������� ����� � �������� �����
  fmAbout:=TfmAbout.Create(Application);
  fmAbout.ShowModal;

  //��������
  fmAbout.Free;

end;

procedure TfmMain.mnDevelopersClick(Sender: TObject);
begin
  //�������� � ����������� �����
  fmListDeveloper:=TfmListDeveloper.Create(Application);
  afListDeveloper:=EDIT;

  //�������� �����
  fmListDeveloper.ShowModal;

  //��������
  fmListDeveloper.Free;

end;

procedure TfmMain.mnDeletePasswordClick(Sender: TObject);
begin
  //�������� ������
  Test.Password.Pass:='';
  ElementsTest;
end;

procedure TfmMain.ElementsTest;
begin
  if Test.Password.Pass=''
  then begin
    mnAddEditPassword.Caption:='�������';
    mnAddEditPassword.ImageIndex:=5;
    mnDeletePassword.Visible:=false;
  end
  else begin
    mnAddEditPassword.Caption:='���������';
    mnAddEditPassword.ImageIndex:=7;
    mnDeletePassword.Visible:=true;
  end;

  //������
  tbtnAddEditPassword.ImageIndex:=mnAddEditPassword.ImageIndex;
  tbtnAddEditPassword.Hint:=mnAddEditPassword.Caption+' ������';
  tbtnAddEditPassword.Visible:=mnPassword.Enabled;
  tbtnDeletePassword.Hint:='�������� ������';
  tbtnDeletePassword.Visible:=mnDeletePassword.Visible;
  tsepPassword.Visible:=tbtnAddEditPassword.Visible;

  EnabledNameTest (mnPassword.Enabled);


end;

procedure TfmMain.mnAddEditPasswordClick(Sender: TObject);
begin
  if (Sender as TMenuItem).Caption='�������'
    then afAddEditPassword:=ADD
    else afAddEditPassword:=EDIT;

  //�������� �����
  fmAddEditPassword:=TfmAddEditPassword.Create(Application);
  fmAddEditPassword.ShowModal;

  if afAddEditPassword<>Cancel then
  begin
    Test.Password.Pass:=fmAddEditPassword.pPass;
    bTestModified:=true;
  end;

  //�������� �����
  fmAddEditPassword.Free;

  ElementsTest;

end;

procedure TfmMain.mnLinksClick(Sender: TObject);
begin
  //�������� �����
  fmLinks:=TfmLinks.Create(application);
  afLinks:=EDIT;
  fmLinks.pTypeOpen:=copy(aTypeOpen);
  fmLinks.pslFilter:=slLinkFiles;
  fmLinks.ShowModal;

  //��������� � ����������
  if afLinks=EDIT then
  begin
    aTypeOpen:=fmLinks.pTypeOpen;
    slLinkFiles:=fmLinks.pslFilter;
    Test.ManagerLinks.Save;
  end;

  //�������� �����
  fmLinks.Free;

end;

procedure TfmMain.mnNameTestClick(Sender: TObject);
begin
  //��������� �������� �����
  fmRenameTest:=TfmRenameTest.Create(application);
  fmRenameTest.ShowModal;

  //�������� �����
  fmRenameTest.Free;

end;

procedure TfmMain.EnabledNameTest(bValue: boolean);
begin
  mnNameTest.Enabled:=bValue;
  tbtnNameTest.Visible:=bValue;
  tbtnSeparatorNameTest.Visible:=bValue;
end;

procedure TfmMain.mnSaveAsClick(Sender: TObject);
var
  FdlgSave : TSaveDialog;
begin
  //�������� ������� �������� �����
  FdlgSave:=TSaveDialog.Create(Self);
  FdlgSave.Filter:='����� ������������ (*.tst)|*.tst;';
  FdlgSave.DefaultExt:='TST';

  //������ �������� �����
  if FdlgSave.Execute then
  begin
    Test.Save(FdlgSave.FileName);
  end;

  //�������� �������
  FDlgSave.Free;
end;

procedure TfmMain.mnSaveClick(Sender: TObject);
begin
  if sFileName<>''
    then Test.Save(sFileName)
    else mnSaveAs.Click;

  

end;

procedure TfmMain.mnCreateClick(Sender: TObject);
var
  mrResult : TModalResult;
begin
  //���� ���� �� ��������
  if bTestModified=true then
    mrResult:=MessageDlg('���� "'+Test.Subject+'" ��� �������! ���������?!',mtInformation,[mbYes, mbNo, mbCancel],0);

  case mrResult of
    mrCancel : exit;
       mrYes : mnSave.Click;
        mrNo : fmTopics.Close;
  end;

  if sFileName<>'' then fmTopics.Close;

  Test.New(fmMain);
  fmTopics.Show;
  mnPassword.Enabled:=true;
  ElementsTest;


end;

procedure TfmMain.EnabledSaveTest(bValue: boolean);
begin
  mnSave.Enabled:=bValue;
  mnSaveAs.Enabled:=bValue;
  tbtnSave.Enabled:=bValue;
end;

procedure TfmMain.mnCloseClick(Sender: TObject);
var
  mrResult : TModalResult;
begin
  //���� ���� �� ��������
  if bTestModified=true then
    mrResult:=MessageDlg('���� "'+Test.Subject+'" ��� �������! ���������?!',mtInformation,[mbYes, mbNo, mbCancel],0);

  case mrResult of
    mrCancel : exit;
       mrYes : mnSave.OnClick(mnSave);
        mrNo : fmTopics.Close;
  end;

  //�������� ����
  close;

end;

end.















