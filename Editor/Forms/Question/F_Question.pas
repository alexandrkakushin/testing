unit F_Question;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ImgList, ToolWin, StdCtrls, U_Test, Buttons;

type
  TfmQuestion = class(TForm)
    pcQuestion: TPageControl;
    tsQuestion: TTabSheet;
    tsAnswerSelect: TTabSheet;
    gbTextQuestion: TGroupBox;
    mText: TMemo;
    lblTypeQuestion: TLabel;
    cbType: TComboBox;
    lblWeightQuestion: TLabel;
    eWeight: TEdit;
    gbLinkQuestion: TGroupBox;
    lstLinkQuestion: TListView;
    tbLinkQuestion: TToolBar;
    ImagesQuestion: TImageList;
    tbtnAddQuestionLink: TToolButton;
    tbtnDeleteQuestionLink: TToolButton;
    tbtnViewQuestionLink: TToolButton;
    gbComment: TGroupBox;
    mComment: TMemo;
    btnOk: TBitBtn;
    btnCancel: TBitBtn;
    gbAnswer: TGroupBox;
    tbAnswerSelect: TToolBar;
    tbtnAnswerSelAdd: TToolButton;
    tbtnAnswerSelDelete: TToolButton;
    tbtnAnswerSelEdit: TToolButton;
    tbtnAnswerSelAllEdit: TToolButton;
    ImagesAnswer: TImageList;
    lstAnswerSelect: TListView;
    gbLinkAnswerSelect: TGroupBox;
    lstLinkAnswerSelect: TListView;
    tbLinkAnswerSelect: TToolBar;
    tbtnAddAnswerSelectLink: TToolButton;
    tbtnDeleteAnswerSelectLink: TToolButton;
    tbtnViewAnswerSelectLink: TToolButton;
    tsAnswerUp_Down: TTabSheet;
    tsAnswerText: TTabSheet;
    tsAnswerLink: TTabSheet;
    procedure FormShow(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);

    procedure EnableLink(bValue: boolean; iTabIndex : byte);
    procedure EnableAnswerSelect (bValue : boolean);

    procedure lstLinkQuestionSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

    procedure EditTypeQuestion (iValue : byte);
    procedure lstAnswerSelectClick(Sender: TObject);

    procedure ActBtnQuestion (Sender : TObject);
    procedure ActBtnAswSelect (Sender : TObject);

    procedure AddLink (var List : TListView; var Link : TLinks);
    procedure DeleteLink (var List : TListView; var Link : TLinks);
    procedure ViewLink (var List : TListView);

    procedure lstLinkAnswerSelectSelectItem(Sender: TObject;
      Item: TListItem; Selected: Boolean);
    procedure lstAnswerSelectSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure tsAnswerSelectShow(Sender: TObject);
    procedure tbtnAnswerSelAddClick(Sender: TObject);
    procedure tbtnAnswerSelEditClick(Sender: TObject);
    procedure tbtnAnswerSelDeleteClick(Sender: TObject);
    procedure tbtnAnswerSelAllEditClick(Sender: TObject);
    procedure lstAnswerSelectChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure cbTypeChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    
    //pQuestion : TQuestion;
    bCloseOK : boolean;
    iType : byte;

    pQuestion : TQuestion;
  end;

var
  fmQuestion: TfmQuestion;
  afQuestion : TActionForm;
  iAnswer : integer;

implementation

uses F_Main_form, FTopics, F_AddEditAnswerSelect, F_AllEditAnswerSelect;

{$R *.dfm}

procedure TfmQuestion.FormShow(Sender: TObject);
begin
  bCloseOK:=false;

  //Отображение данных (Вопрос)
  mText.Text:=pQuestion.sQuestion;
  mComment.Text:=pQuestion.sComment;

  //Действие формы
  if afQuestion=EDIT
    then cbType.Enabled:=false
    else cbType.Enabled:=true;

  //Тип вопроса
  case pQuestion.tpQuestion of
    tqSELECT_ONE_SEVERAL :
        begin
            iType:=0;
            Test.Topics.Questions.Answer.GetListSel(pQuestion.Answer.aswSelect,lstAnswerSelect);
        end;

    tqUP_DOWN : iType:=1;
    tqTEXT : iType:=2;
    tqLINK : iType:=3;
  end;

  EditTypeQuestion(iType+1);


  cbType.ItemIndex:=iType;

  //Вес вопроса
  eWeight.Text:=FloatToStr(pQuestion.Weight);

  //Прикрепления
  Test.Topics.Questions.Link.GetList(pQuestion.sLinkQuestion, lstLinkQuestion);
  EnableLink(false,0);

  //Фокус
  mText.SetFocus;

end;

procedure TfmQuestion.btnCancelClick(Sender: TObject);
begin
  afQuestion:=CANCEL;
  close;
end;

procedure TfmQuestion.btnOkClick(Sender: TObject);
var
  i : integer;
begin
  //Подтверждение дальнейшей записи в вызывающей процедуре
  bCloseOK:=true;

  //Запись параметров
  pQuestion.sQuestion:=mText.Text;
  pQuestion.sComment:=mComment.Text;
  pQuestion.Weight:=StrToFloat(eWeight.text);
  pQuestion.Ebable:=true;
  if pQuestion.tpQuestion=tqSelect_one_several then
  begin
    for i:=0 to lstAnswerSelect.Items.Count-1 do
    begin
      pQuestion.Answer.aswSelect[i].Correct:=lstAnswerSelect.Items.Item[i].Checked;
    end;
  end;

  bTestModified:=true;

  //Закрытие окна
  Close;
end;


procedure TfmQuestion.EnableLink(bValue: boolean; iTabIndex : byte);
begin
  case iTabIndex of
    0 : begin
          tbtnDeleteQuestionLink.Enabled:=bValue;
          tbtnViewQuestionLink.Enabled:=bValue;
        end;
    1 : begin
          tbtnDeleteAnswerSelectLink.Enabled:=bValue;
          tbtnViewAnswerSelectLink.Enabled:=bValue;
        end;
  end;
end;

procedure TfmQuestion.lstLinkQuestionSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
  EnableLink(Selected,0);
end;

procedure TfmQuestion.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if bCloseOK=false then afQuestion:=CANCEL;
end;

procedure TfmQuestion.EditTypeQuestion(iValue: byte);
var
  i : integer;
begin
  for i:=1 to 4 do
  begin
    if i<>iValue
      then pcQuestion.Pages[i].TabVisible:=false
      else pcQuestion.Pages[i].TabVisible:=true;
  end;
end;

procedure TfmQuestion.lstAnswerSelectClick(Sender: TObject);
var
  lTemp : TLinks;
begin
  if lstAnswerSelect.Selected=nil then exit;

  iAnswer:=lstAnswerSelect.ItemIndex;
  lTemp:=pQuestion.Answer.aswSelect[iAnswer].sLinks;
  Test.Topics.Questions.Link.GetList(lTemp,lstLinkAnswerSelect);
end;

procedure TfmQuestion.AddLink(var List : TListView; var Link : TLinks);
var
  fdlgOpen : TOpenDialog;
begin
  //Создание диалога открытия файла
  fdlgOpen:=TOpenDialog.Create(Self);
  fdlgOpen.Filter:=sLinkFiles;

  //Диалог открытия файла
  if fdlgOpen.Execute then
  begin
    if Test.Topics.Questions.Link.Add(Link,fdlgOpen.FileName)=true
      then List.Items.Add.Caption:=ExtractFileName(fdlgOpen.FileName);
  end;

  //Удаление объекта
  fDlgOpen.Free;
end;

procedure TfmQuestion.lstLinkAnswerSelectSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
  EnableLink(Selected,1);
end;

procedure TfmQuestion.lstAnswerSelectSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin

  EnableAnswerSelect(selected);

  tbLinkAnswerSelect.Enabled:=Selected;
  EnableLink(not selected,1);
  if selected=false then lstLinkAnswerSelect.Clear;
end;

procedure TfmQuestion.DeleteLink(var List : TListView; var Link : TLinks);
var
  index : integer;
begin
  if MessageDlg('Удалить выбранное прикрепление к вопросу?',mtWarning,[mbYes,mbNo],0)=mrNo then exit;
  index:=List.ItemIndex;
  Test.Topics.Questions.Link.Delete(Link,index);
  List.Items.Delete(index);
end;

procedure TfmQuestion.ViewLink(var List : TListView);
var
  sFile : string;
begin
  if List.Selected=nil then exit;

  //Просмотр прикрпеленного файла
  sFile:=List.Selected.Caption;
  Test.Topics.Questions.Link.OpenFile(sFile);
end;



procedure TfmQuestion.ActBtnQuestion(Sender: TObject);
begin
  case (Sender as TToolButton).Tag of
    0 : AddLink(lstLinkQuestion,pQuestion.sLinkQuestion);
    1 : DeleteLink(lstLinkQuestion,pQuestion.sLinkQuestion);
    2 : ViewLink(lstLinkQuestion);
  end;
end;

procedure TfmQuestion.ActBtnAswSelect (Sender : TObject);
begin
  case (Sender as TToolButton).Tag of
    0 : AddLink(lstLinkAnswerSelect,pQuestion.Answer.aswSelect[iAnswer].sLinks);
    1 : DeleteLink(lstLinkAnswerSelect,pQuestion.Answer.aswSelect[iAnswer].sLinks);
    2 : ViewLink(lstLinkAnswerSelect);
  end;
end;

procedure TfmQuestion.tsAnswerSelectShow(Sender: TObject);
begin
  tbLinkAnswerSelect.Enabled:=false;
  lstAnswerSelect.ItemIndex:=-1;

end;

procedure TfmQuestion.tbtnAnswerSelAddClick(Sender: TObject);
var
  lItem : TListItem;
begin
  //Создание формы
  fmAddEditAnswerSelect:=TfmAddEditAnswerSelect.Create(application);
  afAddEditAnswerSelect:=ADD;
  fmAddEditAnswerSelect.ShowModal;

  //Добавление варианта ответа
  if afAddEditAnswerSelect=ADD then
  begin
    Test.Topics.Questions.Answer.AddSel(pQuestion.Answer,fmAddEditAnswerSelect.pAnswerSelect);
    
    lItem:=lstAnswerSelect.Items.Add;    
    with lItem do
    begin
      Caption:=fmAddEditAnswerSelect.pAnswerSelect.Text;
      Checked:=fmAddEditAnswerSelect.pAnswerSelect.Correct;
    end;
  end;

  EnableAnswerSelect(true);

  //Удаление формы
  fmAddEditAnswerSelect.Free;

end;

procedure TfmQuestion.tbtnAnswerSelEditClick(Sender: TObject);
var
  lItem : TListItem;
begin
  //Инициализация
  iAnswer:=lstAnswerSelect.ItemIndex;

  //Создание формы
  fmAddEditAnswerSelect:=TfmAddEditAnswerSelect.Create(application);
  afAddEditAnswerSelect:=EDIT;
  fmAddEditAnswerSelect.pAnswerSelect:=pQuestion.Answer.aswSelect[iAnswer];
  fmAddEditAnswerSelect.ShowModal;

  //Добавление варианта ответа
  if afAddEditAnswerSelect=EDIT then
  begin
    pQuestion.Answer.aswSelect[iAnswer]:=fmAddEditAnswerSelect.pAnswerSelect;

    lItem:=lstAnswerSelect.Items.Item[iAnswer];
    with lItem do
    begin
      Caption:=fmAddEditAnswerSelect.pAnswerSelect.Text;
      Checked:=fmAddEditAnswerSelect.pAnswerSelect.Correct;
    end;
  end;

  //Удаление формы
  fmAddEditAnswerSelect.Free;
  
end;

procedure TfmQuestion.tbtnAnswerSelDeleteClick(Sender: TObject);
var
  index : integer;
begin
  if MessageDlg('Удалить выбранный вариант ответа?',mtWarning,[mbYes,mbNo],0)=mrNo then exit;

  index:=lstAnswerSelect.ItemIndex;
  Test.Topics.Questions.Answer.DeleteSel(pQuestion.Answer,index);
  lstAnswerSelect.Items.Delete(index);

  if lstAnswerSelect.Items.Count=0 then
    EnableAnswerSelect(false);


end;

procedure TfmQuestion.tbtnAnswerSelAllEditClick(Sender: TObject);
begin
  fmAllEditAnswerSelect:=TfmAllEditAnswerSelect.Create(application);
  afAllEditAnswerSelect:=EDIT;
  fmAllEditanswerSelect.pAllEditAnswerSelect:=pQuestion.Answer;
  fmAllEditAnswerSelect.ShowModal;

  if afAllEditAnswerSelect=EDIT then
  begin
    pQuestion.Answer:=fmAllEditAnswerSelect.pAllEditAnswerSelect;
    Test.Topics.Questions.Answer.GetListSel(pQuestion.Answer.aswSelect,lstAnswerSelect);

    if lstAnswerSelect.Selected=nil
      then EnableAnswerSelect(false)
      else EnableAnswerSelect(true);

  end;

  fmAllEditAnswerSelect.Free;
end;

procedure TfmQuestion.lstAnswerSelectChange(Sender: TObject;
  Item: TListItem; Change: TItemChange);
begin
  if lstAnswerSelect.Selected=nil then exit;
  pQuestion.Answer.aswSelect[Item.Index].Correct:=Item.Checked;
end;

procedure TfmQuestion.EnableAnswerSelect(bValue: boolean);
begin
  tbtnAnswerSelDelete.Enabled:=bValue;
  tbtnAnswerSelEdit.Enabled:=bValue;
end;

procedure TfmQuestion.cbTypeChange(Sender: TObject);
begin
  //Тип устанавливаем тип вопрос
  if afQuestion=ADD then
    case cbType.ItemIndex of
      0 : pQuestion.tpQuestion:=tqSELECT_ONE_SEVERAL;
      1 : pQuestion.tpQuestion:=tqUP_DOWN;
      2 : pQuestion.tpQuestion:=tqTEXT;
      3 : pQuestion.tpQuestion:=tqLINK;
  end;

  //Номер типа
  iType:=cbType.ItemIndex;

end;

end.
