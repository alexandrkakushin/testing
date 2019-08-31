unit FReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Buttons, U_TestServer, ImgList, ToolWin, Chart,
  Menus;

type
  TfmReport = class(TForm)
    gbReport: TGroupBox;
    lstReport: TListView;
    tbReport: TToolBar;
    Images: TImageList;
    tbtnPrint: TToolButton;
    tbtnData: TToolButton;
    tbtnExport: TToolButton;
    ToolButton1: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    tbtnSelectResult: TToolButton;
    ToolButton6: TToolButton;
    MenuExport: TPopupMenu;
    mnuExcel: TMenuItem;
    MenuSelectResult: TPopupMenu;
    mnuHighResult: TMenuItem;
    mnuLowResult: TMenuItem;
    mnuSelectResult: TMenuItem;
    procedure btnOKClick(Sender: TObject);
    procedure EnableSelectResult (bValue : boolean);
    procedure FormShow(Sender: TObject);
    procedure lstReportSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure lstReportDblClick(Sender: TObject);
    procedure tbtnDataClick(Sender: TObject);

    procedure PrepareDRGroupTopic(var List : TListView);
    procedure AddItem (var List : TListView; sCaption, sValue : string);
    procedure mnuExcelClick(Sender: TObject);
    procedure tbtnPrintClick(Sender: TObject);
    procedure mnuSelectResultClick(Sender: TObject);
    procedure mnuHighLowResultClick(Sender: TObject);

  private
    { Private declarations }
    bSelectResults : boolean;
  public
    { Public declarations }
    trReport : TTypeReport;
    pDataReportGT : TDataReportGT;
  end;

var
  fmReport: TfmReport;

implementation

uses FSelectResult, FMainForm, FAdditionalInfoReport;

{$R *.dfm}

procedure TfmReport.btnOKClick(Sender: TObject);
begin
  close;
end;

procedure TfmReport.EnableSelectResult(bValue: boolean);
begin
  mnuSelectResult.Enabled:=bValue;
end;

procedure TfmReport.FormShow(Sender: TObject);
begin
  EnableSelectResult(false);

  //Результат группы по теме
  if trReport=trGroupTopic then
  begin
    with pDataReportGT do
    begin
      fmReport.Caption:='Результаты группы по теме |'+sGroup+'|'+sSubject+'|'+sTopic+'|';
    end;
    tbtnSelectResult.Visible:=true;
  end
  else
    tbtnSelectResult.Visible:=false;

  

end;

procedure TfmReport.lstReportSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
begin
  if Selected=false then
  begin
    EnableSelectResult(false);    
    exit;
  end;

  if Item.SubItems.Strings[4]='Да'
    then bSelectResults:=true
    else bSelectResults:=false;

  EnableSelectResult(bSelectResults);
end;

procedure TfmReport.mnuExcelClick(Sender: TObject);
begin
  case trReport of
      trGroupTopic : DBTest.Reports.ExcelGroupTopic(lstReport, pDataReportGT, false);
  end;
end;

procedure TfmReport.mnuHighLowResultClick(Sender: TObject);
var
  i, j, iIndex, iResult, iValue : integer;
  sName : string;
  liEdit : TListItem;
begin
  //Создание формы
  fmSelectResult:=TfmSelectResult.Create(Application);
  lstReport.Items.BeginUpdate;

  for i:=0 to lstReport.Items.Count-1 do
  begin
    liEdit:=lstReport.Items.Item[i];

    if liEdit.SubItems.Strings[4]='-' then continue;

    //Инициализация переменных
    sName:=liEdit.SubItems.Strings[0];
    DBTest.Reports.GetListResults(sName, fmSelectResult.lstResults);
    j:=0;
    iResult:=StrToInt(fmSelectResult.lstResults.Items.Item[0].SubItems[1]);
    iIndex:=0;

    //Поиск наилучшего/наихудшего результата
    for j:=1 to fmSelectResult.lstResults.Items.Count-1 do
    begin
      iValue:=StrToInt(fmSelectResult.lstResults.Items.Item[j].SubItems[1]);

      if (Sender as TMenuItem).MenuIndex=0 then
      begin
        if iResult<=iValue then
        begin
          iIndex:=j;
          iResult:=iValue;
        end
      end
      else begin
        if iResult>=iValue then
        begin
          iIndex:=j;
          iResult:=iValue;
        end
      end;
    end;

    //Изменение результатов
    for j:=1 to 3 do
      liEdit.SubItems[j]:=fmSelectResult.lstResults.Items.Item[iIndex].SubItems[j-1];
  end;

  //Удаление
  fmSelectResult.Free;
  lstReport.Items.EndUpdate;
end;

procedure TfmReport.mnuSelectResultClick(Sender: TObject);
var
  liEdit : TListItem;
  sName : string;
  i : integer;
begin
  //Инициализация
  liEdit:=lstReport.Selected;
  sName:=liEdit.SubItems.Strings[0];

  //Создание формы
  fmSelectResult:=TfmSelectResult.Create(Application);
  afSelectResult:=EDIT;
  DBTest.Reports.GetListResults(sName, fmSelectResult.lstResults);
  fmSelectResult.ShowModal;

  //При изменении
  if afSelectResult=EDIT then
  begin
    for i:=1 to 3 do
      liEdit.SubItems.Strings[i]:=fmSelectResult.liSelected.SubItems.Strings[i-1];
  end;

  //Удаление формы
  fmSelectResult.Free;
end;

procedure TfmReport.lstReportDblClick(Sender: TObject);
begin
  if bSelectResults=true then tbtnSelectResult.Click;
end;

procedure TfmReport.tbtnDataClick(Sender: TObject);
begin
  //Создание формы
  fmAdditionalInfoReport:=TfmAdditionalInfoReport.Create(Application);
  with fmAdditionalInfoReport do
  begin
    //Формирование данных
    case trReport of
      trGroupTopic : PrepareDRGroupTopic(lstDataReport);
    end;

    //Отображение
    fmAdditionalInfoReport.ShowModal;

    //Удаление
    Free;
  end;
end;

procedure TfmReport.tbtnPrintClick(Sender: TObject);
begin
  case trReport of
      trGroupTopic : DBTest.Reports.ExcelGroupTopic(lstReport, pDataReportGT, true);
  end;
end;

procedure TfmReport.PrepareDRGroupTopic(var List: TListView);
var
  aValues : array [1..8] of integer;
  i, iOcenka, j : integer;
begin
  //Инициализация
  for i:=1 to 8 do aValues[i]:=0;

  List.Items.BeginUpdate;
  List.Items.Clear;

  AddItem (List,'Группа',pDataReportGT.sGroup);
  AddItem (List,'Предмет',pDataReportGT.sSubject);
  AddItem (List,'Тема',pDataReportGT.sTopic);
  AddItem (List,'Преподаватели',pDataReportGT.sTeachers);
  AddItem (List, '', '');

  //Качество и успеваемость и оценки
  for i:=0 to lstReport.Items.Count-1 do
  begin
    if lstReport.Items.Item[i].SubItems.Strings[1]<>'-' then
    begin
      iOcenka:=StrToInt(lstReport.Items.Item[i].SubItems.Strings[1]);

      for j:=2 to 5 do
      begin
        if iOcenka=j then Inc(aValues[j]);
      end;

      if iOcenka in [3,4,5] then Inc(aValues[6]);
      if iOcenka in [4,5] then Inc(aValues[7]);
      Inc(aValues[8]);
    end;
  end;
  aValues[1]:=lstReport.Items.Count-aValues[8];  
  aValues[6]:=Round((aValues[6]/aValues[8])*100);
  aValues[7]:=Round((aValues[7]/aValues[8])*100);



  AddItem (List, 'Качество знаний', IntToStr(aValues[6])+'%');
  AddItem (List, 'Успеваемость', IntToStr(aValues[7])+'%');
  AddItem (List, '', '');
  AddItem (List, 'Количество:','');
  AddItem (List, 'Н', IntToStr(aValues[1]));
  for i:=2 to 5 do
    AddItem (List, IntToStr(i), IntToStr(aValues[i]));

  List.Items.EndUpdate;

end;

procedure TfmReport.AddItem(var List: TListView; sCaption,
  sValue: string);
begin
  with List.Items.Add do
  begin
    Caption:=sCaption;
    SubItems.Add(sValue);
  end;
end;

end.
