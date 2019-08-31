unit FManagerTest;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ImgList, ToolWin, StdCtrls, Buttons;

type
  TfmManagerTest = class(TForm)
    tbManagerTest: TToolBar;
    Images: TImageList;
    tbtnAddTest: TToolButton;
    tbtnDeleteTest: TToolButton;
    tbtnExportTest: TToolButton;
    ToolButton1: TToolButton;
    lstTests: TListView;
    ToolButton2: TToolButton;
    tbtnInfoTest: TToolButton;
    procedure tbtnAddTestClick(Sender: TObject);
    procedure FormShow(Sender: TObject);

    procedure EnabledBtn (bValue : boolean);
    procedure lstTestsSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure tbtnDeleteTestClick(Sender: TObject);
    procedure tbtnExportTestClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmManagerTest: TfmManagerTest;

implementation

uses FMainForm, F_Folder;

{$R *.dfm}

procedure TfmManagerTest.tbtnAddTestClick(Sender: TObject);
var
  dlgOpen : TOpenDialog;

begin
  //Создание диалога
  dlgOpen:=TOpenDialog.Create(Self);
  dlgOpen.Filter:='Файлы тестирования (*.tst)|*.tst;';
  dlgOpen.DefaultExt:='TST';

  //Добавление тестов
  if dlgOpen.Execute then
  begin
    DBTest.Manager.Add(dlgOpen.Files, lstTests);
  end;

  //Удаление теста
  dlgOpen.Free;

end;

procedure TfmManagerTest.FormShow(Sender: TObject);
begin
  DBTest.Manager.GetList(lstTests);
  if lstTests.Selected<>nil
    then EnabledBtn(true)
    else EnabledBtn(false);
end;

procedure TfmManagerTest.EnabledBtn(bValue: boolean);
begin
  tbtnDeleteTest.Enabled:=bValue;
  tbtnExportTest.Enabled:=bValue;
  tbtnInfoTest.Enabled:=bValue;
end;

procedure TfmManagerTest.lstTestsSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
  EnabledBtn(Selected);  
end;

procedure TfmManagerTest.tbtnDeleteTestClick(Sender: TObject);
var
  sFileTest : string;
begin
  if MessageDlg('Удалить тест "'+lstTests.Selected.SubItems.Strings[0]+'"?',mtWarning,[mbYes,mbNo],0)=mrNo then Exit;

  sFileTest:=lstTests.Selected.SubItems[0];
  DBTest.Manager.Delete(sFileTest, lstTests);

  if lstTests.Selected<>nil
    then EnabledBtn(true)
    else EnabledBtn(false);
end;

procedure TfmManagerTest.tbtnExportTestClick(Sender: TObject);
begin
  fmFolder:=TfmFolder.Create(Application);
  fmFolder.sFileTest:=lstTests.Selected.SubItems[0];
  fmFolder.ShowModal;

  fmFolder.Free;

end;

end.
