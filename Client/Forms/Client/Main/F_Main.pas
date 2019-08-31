unit F_Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, XPMan, Buttons, ImgList, U_TestClient;

type
  TfmMain = class(TForm)
    pcInfoTesting: TPageControl;
    tsTopics: TTabSheet;
    tsGroups: TTabSheet;
    gbTopics: TGroupBox;
    XPMan: TXPManifest;
    tvTopics: TTreeView;
    btnNextTopics: TBitBtn;
    ImagesBtn: TImageList;
    gbGroups: TGroupBox;
    tvGroups: TTreeView;
    btnNextGroups: TBitBtn;
    btnBack: TBitBtn;
    ImagesTopics: TImageList;
    ImagesGroups: TImageList;

    //Работа с тестом
    procedure StartTesting;
    procedure btnNextGroupsClick(Sender: TObject);
    procedure btnNextTopicsClick(Sender: TObject);
    procedure btnBackClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmMain: TfmMain;

  Client : TClient;    //Класс Клиента


implementation

uses F_Questions, F_Protocol;

{$R *.dfm}

procedure TfmMain.StartTesting;
begin
  //Создание формы с вопросами
  fmQuestions:=TfmQuestions.Create(application);
  fmMain.Hide;
  fmQuestions.ShowModal;

  //удаление формы и возвращение к начальным параметрам
  pcInfoTesting.TabIndex:=0;
  fmQuestions.Free;
  fmMain.Show;

end;

procedure TfmMain.btnNextGroupsClick(Sender: TObject);
var
  iIndexTopics : integer;
begin
  if (tvTopics.Selected<>nil) and
     (tvGroups.Selected<>nil) and
     (tvTopics.Selected.Level=1) and
     (tvGroups.Selected.Level=1)
  then begin
    iIndexTopics:=tvTopics.Selected.Parent.Index;
    Client.Testing.LoadTest(iIndexTopics);
    StartTesting;    
  end
  else
    MessageDlg('Не полностью выбраны критерии тестирования',mtInformation, [mbOK],0);
end;

procedure TfmMain.btnNextTopicsClick(Sender: TObject);
begin
  //Следущая закладка
  pcInfoTesting.ActivePageIndex:=1;

end;

procedure TfmMain.btnBackClick(Sender: TObject);
begin
  pcInfoTesting.ActivePageIndex:=0;
end;

procedure TfmMain.FormCreate(Sender: TObject);
begin
  //Интерфейс
  ImagesBtn.GetBitmap(1,btnNextTopics.Glyph);
  ImagesBtn.GetBitmap(1,btnNextGroups.Glyph);
  ImagesBtn.GetBitmap(0,btnBack.Glyph);

  //Создание класса Клиент
  Client:=TClient.Create;

end;

procedure TfmMain.FormDestroy(Sender: TObject);
begin
  Client.Destroy;

end;

end.
