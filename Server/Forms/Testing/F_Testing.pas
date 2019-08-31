unit F_Testing;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, ImgList, ShellCtrls;

type
  TfmTesting = class(TForm)
    pcTesting: TPageControl;
    btnOK: TBitBtn;
    tsParameters: TTabSheet;
    tsTesting: TTabSheet;
    btnStartStop: TBitBtn;
    gbGroups: TGroupBox;
    lstGroups: TListView;
    gbTesting: TGroupBox;
    lstComps: TListView;
    sbInfo: TStatusBar;
    Images: TImageList;
    pbTime: TProgressBar;
    procedure FormShow(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure scnListCompChange;

    procedure ElementsTesting (bValue : boolean);
    procedure EnabledTesting (bValue : boolean);
    
    procedure btnStartStopClick(Sender: TObject);
    procedure lstGroupsChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure lstGroupsClick(Sender: TObject);
    procedure lstCompsClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure lstCompsChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmTesting: TfmTesting;

implementation

uses FMainForm;

{$R *.dfm}

procedure TfmTesting.FormShow(Sender: TObject);
var
  bTesting : boolean;
begin
  DBTest.Groups.GetList(lstGroups);
  DBTest.Testing.GetListComp(lstComps);

  bTesting:=DBTest.Testing.CheckTesting;
  ElementsTesting(bTesting);
  if bTesting=true then DBTest.Testing.GetCurrentListGroups(lstGroups);

end;

procedure TfmTesting.btnOKClick(Sender: TObject);
begin
  Close;  
end;

procedure TfmTesting.FormCreate(Sender: TObject);
begin

  //scnListComp.Root:=ExtractFilePath(Application.ExeName)+'Exchange';
end;

procedure TfmTesting.scnListCompChange;
begin
  DBTest.Testing.GetListComp(lstComps);
end;

procedure TfmTesting.ElementsTesting(bValue: boolean);
var
  sStatus : string;
begin
  if bValue=true
    then btnStartStop.Caption:='Остановить'
    else btnStartStop.Caption:='Начать';

  lstGroups.Enabled:=not bValue;

  case bValue of
     true : sStatus:='Проводится тестирование';
    false : sStatus:='Тестирование не проводится';
  end;
  fmMain.sbTesting.Panels[0].Text:=sStatus;

end;

procedure TfmTesting.btnStartStopClick(Sender: TObject);
begin
  if btnStartStop.Caption='Начать'
    then DBTest.Testing.Start(lstGroups)
    else DBTest.Testing.Stop(lstGroups);

  ElementsTesting(DBTest.Testing.CheckTesting);

end;

procedure TfmTesting.EnabledTesting(bValue: boolean);
begin
  btnStartStop.Enabled:=bValue;
end;

procedure TfmTesting.lstGroupsChange(Sender: TObject; Item: TListItem;
  Change: TItemChange);
var
  i : integer;
  bValue : boolean;
begin
  bValue:=false;
  EnabledTesting(false);

  for i:=0 to lstGroups.Items.Count-1 do
  begin
    if lstGroups.Items.Item[i].Checked=true then
    begin
      bValue:=true;
      EnabledTesting(bValue);
      exit;
    end;
  end;
end;

procedure TfmTesting.lstGroupsClick(Sender: TObject);
begin
  if lstGroups.Selected=nil then exit;
end;

procedure TfmTesting.lstCompsClick(Sender: TObject);
begin
  //Получение информации
  DBTest.Testing.GetInfoTesting(lstComps);
end;

procedure TfmTesting.FormResize(Sender: TObject);
var
  i, iValue : integer;
begin
  iValue:=gbTesting.Width div 4;

  for i:=0 to sbInfo.Panels.Count-1 do
  begin
    sbInfo.Panels[i].Width:=iValue;
  end;
  
end;

procedure TfmTesting.lstCompsChange(Sender: TObject; Item: TListItem;
  Change: TItemChange);
begin


  DBTest.Testing.GetInfoTesting(lstComps);
end;

end.
