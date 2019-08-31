unit FTopics;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ToolWin, ImgList, ExtCtrls, Menus, U_Test;

type
  TfmTopics = class(TForm)
    gbTopics: TGroupBox;
    lstTopics: TListView;
    gbQuestions: TGroupBox;
    lstQuestions: TListView;
    stsbInfo: TStatusBar;
    TopicImages: TImageList;
    tbarManager: TToolBar;
    tbtnAddTopics: TToolButton;
    tbtnDeleteTopics: TToolButton;
    tbtnRenameTopics: TToolButton;
    ToolButton4: TToolButton;
    tbtnAddQuestion: TToolButton;
    tbtnDeleteQuestion: TToolButton;
    tbtnEditQuestion: TToolButton;
    ToolButton1: TToolButton;
    chbAllSelect: TCheckBox;
    pnlAllSelect: TPanel;
    TopicsMenu: TMainMenu;
    mnTopics: TMenuItem;
    mnTopicsAdd: TMenuItem;
    mnTopicsDelete: TMenuItem;
    mnTopicsRename: TMenuItem;
    mnQuestions: TMenuItem;
    mnQuestionAdd: TMenuItem;
    mnQuestionDelete: TMenuItem;
    mnQuestionEdit: TMenuItem;
    mnSettings: TMenuItem;
    mnProcent: TMenuItem;
    mnTeacher: TMenuItem;
    mnTime: TMenuItem;
    mnModeTesting: TMenuItem;
    mnModeHard: TMenuItem;
    mnModeSoft: TMenuItem;
    mnOrderQuestion: TMenuItem;
    mnQuestion123N: TMenuItem;
    mnQuestionRandom: TMenuItem;
    mnOrderAnswer: TMenuItem;
    mnAnswer123N: TMenuItem;
    mnAnswerRandom: TMenuItem;
    mnDescription: TMenuItem;
    mnPurpose: TMenuItem;
    mnInstruction: TMenuItem;
    N1: TMenuItem;
    mnImportTopics: TMenuItem;
    mnQuestionMove: TMenuItem;
    procedure mnProcentClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure mnTeacherClick(Sender: TObject);
    procedure mnTimeClick(Sender: TObject);

    procedure mnModeSelect (Sender: TObject);     //Выбор последовательности ответов
    procedure mnWriteAdditionalData (Sender: TObject);             //Для записи инструкции и назначения
    procedure mnOrderQuestionsSelect (Sender: TObject);
    procedure mnOrderAnswerSelect (Sender: TObject);

    procedure FormShow(Sender: TObject);
    procedure lstTopicsDblClick(Sender: TObject);
    procedure lstTopicsClick(Sender: TObject);
    procedure mnTopicsAddClick(Sender: TObject);
    procedure mnTopicsRenameClick(Sender: TObject);
    procedure mnTopicsDeleteClick(Sender: TObject);

    procedure EnabledEdit (bValue : boolean);
    procedure EnabledQuestions (bValue : boolean);    

    procedure lstQuestionsDblClick(Sender: TObject);
    procedure lstQuestionsSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure chbAllSelectClick(Sender: TObject);
    procedure mnQuestionAddClick(Sender: TObject);
    procedure mnQuestionDeleteClick(Sender: TObject);
    procedure mnQuestionMoveClick(Sender: TObject);
    procedure lstQuestionsClick(Sender: TObject);
    procedure lstTopicsChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    sTopic : string;
    bAdd : boolean;
  end;



var
  fmTopics: TfmTopics;

  iIndex, iQuestionIndex : integer; //Номер выбранной темы


implementation

uses FProcent, FTeacher, FTime, FAdditilonalInfo, F_Main_form, FAddTopics,
  FRenameTopic, F_Question, F_MoveQuestion;

{$R *.dfm}


procedure TfmTopics.mnProcentClick(Sender: TObject);
begin
  //Создание и отображение формы со шкалой оценок
  fmProcent:=TfmProcent.Create(Application);
  fmProcent.pResult:=aTopics[iIndex].Parametrs.Result;
  afProcent:=EDIT;
  fmProcent.ShowModal;

  //Проверка действия формы
  if afProcent=EDIT then
    aTopics[iIndex].Parametrs.Result:=fmProcent.pResult;

  //Удаление объекта
  fmProcent.Free;
  
end;

procedure TfmTopics.FormResize(Sender: TObject);
var
   Width, i : integer; //Width - Длина частей статусной панели; i - счетчик
begin
     //Определение длины каждой части
     Width:=fmTopics.Width div 3;

     //Применение параметров
     for i:=0 to 2 do
     begin
          stsbInfo.Panels[i].Width:=Width;
     end;
end;

procedure TfmTopics.mnTeacherClick(Sender: TObject);
begin
  //Создание формы  "Информация о разработчике"
  fmTeacher:=TfmTeacher.Create(Application);
  afTeacher:=EDIT;
  fmTeacher.pInfoDeveloper:=aTopics[iIndex].Parametrs.InfoDeveloper;

  //Отображение окна
  fmTeacher.ShowModal;

  //Запись результата
  if afTeacher=EDIT then
    aTopics[iIndex].Parametrs.InfoDeveloper:=fmTeacher.pInfoDeveloper;

  //Удаление формы
  fmTeacher.Free;

end;

procedure TfmTopics.mnTimeClick(Sender: TObject);
begin
  //Создание формы "Ограничение по времени"
  fmTime:=TfmTime.Create(Application);
  afTime:=EDIT;
  fmTime.pTime:=aTopics[iIndex].Parametrs.Time;

  //Открытие
  fmTime.ShowModal;

  //Запись значения
  if afTime=EDIT then
    aTopics[iIndex].Parametrs.Time:=fmTime.pTime;

  //Удаление формы
  fmTime.Free;

end;

procedure TfmTopics.mnModeSelect(Sender: TObject);
var
  pMode : TMode;
begin
  //Установка режимов тестирования
  case (Sender as TMenuItem).MenuIndex of
    0 : pMode:=HARD;
    1 : pMode:=SOFT;
  end;

  //Запись значения
  aTopics[iIndex].Parametrs.Mode:=pMode;

  //Отображение на панели
  stsbInfo.Panels[0].Text:='Режим тестирования - '+(Sender as TMenuItem).Caption;

end;

procedure TfmTopics.mnOrderQuestionsSelect(Sender: TObject);
var
  pOrderQuestions : TOrder;
begin
  //Установка порядка вопросов
  case (Sender as TMenuItem).MenuIndex of
    0 : pOrderQuestions:=ORD_123N;
    1 : pOrderQuestions:=ORD_RANDOM;
  end;

  //Запись значений параметра
  aTopics[iIndex].Parametrs.OrderQuestion:=pOrderQuestions;

  //Отображение на панели
  stsbInfo.Panels[1].Text:='Порядок вопросов - '+(Sender as TMenuItem).Caption;

end;

procedure TfmTopics.mnWriteAdditionalData(Sender: TObject);
var
  iMenuIndex : byte;
begin
  //Создание формы
  fmAdditionalInfo:=TfmAdditionalInfo.Create(Application);
  fmAdditionalInfo.Caption:=(Sender as TMenuItem).Caption;
  afAdditionalInfo:=EDIT;

  //Отображение информации
  iMenuIndex:=(Sender as TMenuItem).MenuIndex;
  case iMenuIndex of
    1 : fmAdditionalInfo.pData:=aTopics[iIndex].Parametrs.Purpose;
    2 : fmAdditionalInfo.pData:=aTopics[iIndex].Parametrs.Instruction;
  end;

  //Открытие окна
  fmAdditionalInfo.ShowModal;

  if afAdditionalInfo=EDIT then
    case iMenuIndex of
      1 : aTopics[iIndex].Parametrs.Purpose:=fmAdditionalInfo.pData;
      2 : aTopics[iIndex].Parametrs.Instruction:=fmAdditionalInfo.pData;
    end;

  //Удаление формы и очистка переменных
  fmAdditionalInfo.Free;

end;

procedure TfmTopics.FormShow(Sender: TObject);
var
   i : integer;
begin
  //Инициализация переменных
  iIndex:=0;
  iQuestionIndex:=0;
  fmMain.EnabledSaveTest(true);  

  //Отображение списка тем
  Test.Topics.GetList(lstTopics);
  lstQuestions.Clear;

  fmTopics.Caption:='Тема';

  //Активность тем
  for i:=0 to lstTopics.Items.Count-1 do
  begin
    lstTopics.Items.Item[i].Checked:=aTopics[i].Parametrs.Enable;
  end;

  if lstTopics.Items.Count<>0 then
  begin
    lstTopics.ItemIndex:=iIndex;
    lstTopics.OnDblClick(lstTopics);
    EnabledEdit(true);
  end
  else
  begin
      EnabledEdit(false);
  end;

  //Для перемещения вопроса
  if lstTopics.Items.Count=1
    then mnQuestionMove.Enabled:=false
    else mnQuestionMove.Enabled:=true;

  //Елементы управления



end;

procedure TfmTopics.lstTopicsDblClick(Sender: TObject);
var
   sTime : string;
   mnuTemp : TMenuItem;
   Parametrs : TParametrs;
begin


  if lstTopics.Selected=nil then exit;

  iIndex:=lstTopics.Selected.Index;
  Parametrs:=aTopics[iIndex].Parametrs;

  sTopic:=lstTopics.Selected.Caption;
  fmTopics.Caption:='Тема - '+sTopic;

  //Чтение списка вопросов
  if Test.Topics.GetListQuestions(lstQuestions,iIndex)<>0 then
  begin
    EnabledQuestions(true);
    iQuestionIndex:=0;
    lstQuestions.OnSelectItem(lstQuestions,lstQuestions.Items.Item[0],true);
  end
  else
    EnabledQuestions(false);


  //Режим тестирования
  case Parametrs.Mode of
    HARD : mnuTemp:=mnModeHard;
    SOFT : mnuTemp:=mnModeSoft;
  end;
  mnuTemp.Checked:=true;
  stsbInfo.Panels[0].Text:='Режим тестирования - '+mnuTemp.Caption;

  //Порядок вопросов
  case Parametrs.OrderQuestion of
    ORD_123N : mnuTemp:=mnQuestion123N;
    ORD_RANDOM : mnuTemp:=mnQuestionRandom;
  end;
  mnuTemp.Checked:=true;
  stsbInfo.Panels[1].Text:='Порядок вопросов - '+mnuTemp.Caption;

  //Порядок ответов
  case Parametrs.OrderAnswer of
    ORD_123N : mnuTemp:=mnAnswer123N;
    Ord_RANDOM : mnuTemp:=mnAnswerRandom;
  end;
  mnuTemp.Checked:=true;

  //Ограничение по времени
  if Parametrs.Time=0
    then sTime:='Откл'
    else sTime:=IntToStr(Parametrs.Time);
  stsbInfo.Panels[2].Text:='Ограничение по времени - '+sTime;

end;

procedure TfmTopics.lstTopicsClick(Sender: TObject);
begin
     if lstTopics.Selected=nil then exit;

end;



procedure TfmTopics.mnOrderAnswerSelect(Sender: TObject);
var
  pOrderAnswer : TOrder;
begin
  //Установка порядка ответок
  case (Sender as TMenuItem).MenuIndex of
    0 : pOrderAnswer:=Ord_123N;
    1 : pOrderAnswer:=Ord_Random;
  end;

  //Запись значений параметра
  aTopics[iIndex].Parametrs.OrderAnswer:=pOrderAnswer;

end;

procedure TfmTopics.mnTopicsAddClick(Sender: TObject);
var
  iCount : integer;
begin
  //Создание формы
  fmAddTopics:=TfmAddTopics.Create(Application);
  afAddTopics:=ADD;
  //Открытие окна добавления тем
  fmAddTopics.ShowModal;

  if afAddTopics=ADD then
  begin
    Test.Topics.Add(fmAddTopics.pAddTopic);
    lstTopics.Items.Add.Caption:=fmAddTopics.pAddTopic.Name;

    //Делаем активной, если добавлена
    EnabledEdit(true);
    if lstTopics.Items.Count=1 then
    begin
      iIndex:=0;
      lstTopics.ItemIndex:=iIndex;
      lstTopics.OnDblClick(lstTopics);
      fmTopics.Caption:='Тема - '+fmAddTopics.pAddTopic.Name;
      sTopic:=fmAddTopics.pAddTopic.Name;
    end;
    EnabledQuestions(false);

    //Доступная для тестирования
    aTopics[lstTopics.Items.Count-1].Parametrs.Enable:=true;
    lstTopics.Items.Item[lstTopics.Items.Count-1].Checked:=true;
        
  end;

  //Удаление формы
  fmAddTopics.Free;


end;

procedure TfmTopics.mnTopicsRenameClick(Sender: TObject);
begin
     //Создание и открытие формы
     fmRenameTopic:=TfmRenameTopic.Create(Application);
     fmRenameTopic.ShowModal;

     //Удаление
     fmRenameTopic.Free;

end;

procedure TfmTopics.mnTopicsDeleteClick(Sender: TObject);
var
   iCount : integer;
begin
     if MessageDlg('Вы действительно хотите удалить тему "'+sTopic+'"?',mtWarning,[mbYes, mbNo],0)=mrNo then Exit;

     //Инициализация
     iCount:=lstTopics.Items.Count-1;

     //Удаление темы
     Test.Topics.Delete(iIndex);
     lstTopics.Items.Delete(iIndex);


     //Открытие предшествующей темы
     if iCount=iIndex then iIndex:=iIndex-1;
     if lstTopics.Items.Count<>0 then
     begin
          lstTopics.ItemIndex:=iIndex;
          lstTopics.OnDblClick(lstTopics);
     end
     else
     begin
          fmTopics.Caption:='Тема';
          EnabledEdit(false);
          iIndex:=-1;
     end;

end;

{**************************Активность элементов управления*********************}
procedure TfmTopics.EnabledEdit(bValue: boolean);
begin
     //Меню
     mnSettings.Enabled:=bValue;
     mnDescription.Enabled:=bValue;
     mnQuestions.Enabled:=bValue;
     mnTopicsDelete.Enabled:=bValue;
     mnTopicsRename.Enabled:=bValue;

     //Кнопки панели
     tbtnDeleteTopics.Enabled:=bValue;
     tbtnRenameTopics.Enabled:=bValue;
     tbtnAddQuestion.Enabled:=bValue;
     tbtnDeleteQuestion.Enabled:=bValue;
     tbtnEditQuestion.Enabled:=bValue;

     stsbInfo.Visible:=bValue;
     chbAllSelect.Enabled:=bValue;

end;

procedure TfmTopics.lstQuestionsDblClick(Sender: TObject);
begin
  //Создание формы
  fmQuestion:=TfmQuestion.Create(Application);

  fmQuestion.pQuestion:=aTopics[iIndex].Question[iQuestionIndex];
  with aTopics[iIndex].Question[iQuestionIndex] do
  begin
    fmQuestion.pQuestion.sLinkQuestion:=copy(sLinkQuestion);
    fmQuestion.pQuestion.Answer.aswSelect:=copy(Answer.aswSelect);
    fmQuestion.pQuestion.Answer.aswUpDown:=copy(Answer.aswUpDown);
    fmQuestion.pQuestion.Answer.aswLink:=copy(Answer.aswLink);
  end;


  //Уставнока значений
  afQuestion:=EDIT;
  fmQuestion.Caption:=aTopics[iIndex].Name+' ['+IntToStr(iQuestionIndex+1)+']';

  fmQuestion.ShowModal;

  //Запись значений
  if afQuestion=EDIT then
  begin
    aTopics[iIndex].Question[iQuestionIndex]:=fmQuestion.pQuestion;
    //Обновление компонента lstQuestions

    Test.Topics.GetListQuestions(lstQuestions, iIndex);

  end;

  //Удаление компонента
  fmQuestion.Destroy;

end;

procedure TfmTopics.lstQuestionsSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
  EnabledQuestions(Selected);

  //Номер выбранного вопроса
  iQuestionIndex:=Item.Index;

  //Заголовок окна
  if Selected=true
    then fmTopics.Caption:='Тема - '+sTopic+' ['+IntToStr(iQuestionIndex+1)+']'
    else fmTopics.Caption:='Тема - '+sTopic;

  //Для перемещения вопроса
  if lstTopics.Items.Count=1
    then mnQuestionMove.Enabled:=false
    else mnQuestionMove.Enabled:=true
    
end;

procedure TfmTopics.EnabledQuestions(bValue: boolean);
begin
     tbtnDeleteQuestion.Enabled:=bValue;
     tbtnEditQuestion.Enabled:=bValue;

     mnQuestionMove.Enabled:=bValue;
     mnQuestionEdit.Enabled:=bValue;
     mnQuestionDelete.Enabled:=bValue;
end;

procedure TfmTopics.chbAllSelectClick(Sender: TObject);
var
  bChecked : boolean;
         i : integer;
begin
  //Выделять или не выделять
  bChecked:=chbAllSelect.Checked;

  //Применение к темам
  for i:=0 to lstTopics.Items.Count-1 do
  begin
    lstTopics.Items.Item[i].Checked:=bChecked;
  end;

end;

procedure TfmTopics.mnQuestionAddClick(Sender: TObject);
begin
  //Создание формы
  fmQuestion:=TfmQuestion.Create(Application);

  //Уставнока значений
  afQuestion:=ADD;
  fmQuestion.Caption:=aTopics[iIndex].Name+' ['+IntToStr(lstQuestions.Items.Count+1)+']';

  fmQuestion.ShowModal;

  //Запись значений
  if afQuestion=ADD then
  begin
    //Запись
    Test.Topics.Questions.Add(iIndex, fmQuestion.pQuestion);

    //Обновление списка вопросов
    Test.Topics.GetListQuestions(lstQuestions, iIndex);    
  end;

  //Удаление компонента
  fmQuestion.Destroy;
end;

procedure TfmTopics.mnQuestionDeleteClick(Sender: TObject);
var
  i : integer;
begin
  if MessageDlg('Удалить выбранный вопрос? После удаление отмена действия невозможна',mtWarning,[mbYes,mbNo],0)=mrNo then Exit;

  //Удаление вопроса
  Test.Topics.Questions.Delete(iIndex, iQuestionIndex);

  //Визуализация
  lstQuestions.Items.Delete(iQuestionIndex);
  for i:=0 to lstQuestions.Items.Count-1 do
  begin
    lstQuestions.Items.Item[i].Caption:=IntToStr(i+1);
  end;

     
end;

procedure TfmTopics.mnQuestionMoveClick(Sender: TObject);
var
  i, j, iCount : integer;
begin
  //Создание формы
  fmMoveQuestion:=TfmMoveQuestion.Create(application);
  afMoveQuestion:=EDIT;

  //Формирование списка тем
  j:=-1;
  iCount:=lstTopics.Items.Count;
  SetLength(fmMoveQuestion.aSelectTopic,iCount-1,2);
  for i:=0 to iCount-1 do
  begin
    if i<>iIndex then
    begin
      Inc(j);
      fmMoveQuestion.aSelectTopic[j,0]:=i;
      fmMoveQuestion.aSelectTopic[j,1]:=aTopics[i].Name;
    end;
  end;

  //Отображение формы
  fmMoveQuestion.ShowModal;

  //Перемещение вопроса
  if afMoveQuestion=EDIT then Test.Topics.GetListQuestions(lstQuestions,iIndex);

  //Удаление формы
  fmMoveQuestion.Free;
end;

procedure TfmTopics.lstQuestionsClick(Sender: TObject);
begin
  //Для перемещения вопроса
  if lstTopics.Items.Count=1
    then mnQuestionMove.Enabled:=false
    else mnQuestionMove.Enabled:=true
end;

procedure TfmTopics.lstTopicsChange(Sender: TObject; Item: TListItem;
  Change: TItemChange);
var
  i : integer;
begin
  if lstTopics.Selected=nil then exit;

  for i:=0 to lstTopics.Items.Count-1 do
  begin
    aTopics[i].Parametrs.Enable:=lstTopics.Items.Item[i].Checked;
  end;
end;

procedure TfmTopics.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
label JumpCloseTest;
var
  mrResult : TModalResult;
begin
  CanClose:=true;

  //Если тест не сохранен
  if bTestModified=true then
    mrResult:=MessageDlg('Тест "'+Test.Subject+'" был изменен! Сохранить?!',mtInformation,[mbYes, mbNo, mbCancel],0);

  case mrResult of
    mrCancel : begin
                  CanClose:=false;
                  exit;
               end;
       mrYes : fmMain.mnSave.Click;
        mrNo : goto JumpCloseTest;
  end;

  JumpCloseTest:
  //Закрытие теста
  Test.Close(fmMain);

  //Интерфейс  (управление паролем)
  fmMain.mnPassword.Enabled:=false;
  fmMain.ElementsTest;
  fmMain.EnabledSaveTest(false);
end;

end.
