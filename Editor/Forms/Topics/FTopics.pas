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

    procedure mnModeSelect (Sender: TObject);     //����� ������������������ �������
    procedure mnWriteAdditionalData (Sender: TObject);             //��� ������ ���������� � ����������
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

  iIndex, iQuestionIndex : integer; //����� ��������� ����


implementation

uses FProcent, FTeacher, FTime, FAdditilonalInfo, F_Main_form, FAddTopics,
  FRenameTopic, F_Question, F_MoveQuestion;

{$R *.dfm}


procedure TfmTopics.mnProcentClick(Sender: TObject);
begin
  //�������� � ����������� ����� �� ������ ������
  fmProcent:=TfmProcent.Create(Application);
  fmProcent.pResult:=aTopics[iIndex].Parametrs.Result;
  afProcent:=EDIT;
  fmProcent.ShowModal;

  //�������� �������� �����
  if afProcent=EDIT then
    aTopics[iIndex].Parametrs.Result:=fmProcent.pResult;

  //�������� �������
  fmProcent.Free;
  
end;

procedure TfmTopics.FormResize(Sender: TObject);
var
   Width, i : integer; //Width - ����� ������ ��������� ������; i - �������
begin
     //����������� ����� ������ �����
     Width:=fmTopics.Width div 3;

     //���������� ����������
     for i:=0 to 2 do
     begin
          stsbInfo.Panels[i].Width:=Width;
     end;
end;

procedure TfmTopics.mnTeacherClick(Sender: TObject);
begin
  //�������� �����  "���������� � ������������"
  fmTeacher:=TfmTeacher.Create(Application);
  afTeacher:=EDIT;
  fmTeacher.pInfoDeveloper:=aTopics[iIndex].Parametrs.InfoDeveloper;

  //����������� ����
  fmTeacher.ShowModal;

  //������ ����������
  if afTeacher=EDIT then
    aTopics[iIndex].Parametrs.InfoDeveloper:=fmTeacher.pInfoDeveloper;

  //�������� �����
  fmTeacher.Free;

end;

procedure TfmTopics.mnTimeClick(Sender: TObject);
begin
  //�������� ����� "����������� �� �������"
  fmTime:=TfmTime.Create(Application);
  afTime:=EDIT;
  fmTime.pTime:=aTopics[iIndex].Parametrs.Time;

  //��������
  fmTime.ShowModal;

  //������ ��������
  if afTime=EDIT then
    aTopics[iIndex].Parametrs.Time:=fmTime.pTime;

  //�������� �����
  fmTime.Free;

end;

procedure TfmTopics.mnModeSelect(Sender: TObject);
var
  pMode : TMode;
begin
  //��������� ������� ������������
  case (Sender as TMenuItem).MenuIndex of
    0 : pMode:=HARD;
    1 : pMode:=SOFT;
  end;

  //������ ��������
  aTopics[iIndex].Parametrs.Mode:=pMode;

  //����������� �� ������
  stsbInfo.Panels[0].Text:='����� ������������ - '+(Sender as TMenuItem).Caption;

end;

procedure TfmTopics.mnOrderQuestionsSelect(Sender: TObject);
var
  pOrderQuestions : TOrder;
begin
  //��������� ������� ��������
  case (Sender as TMenuItem).MenuIndex of
    0 : pOrderQuestions:=ORD_123N;
    1 : pOrderQuestions:=ORD_RANDOM;
  end;

  //������ �������� ���������
  aTopics[iIndex].Parametrs.OrderQuestion:=pOrderQuestions;

  //����������� �� ������
  stsbInfo.Panels[1].Text:='������� �������� - '+(Sender as TMenuItem).Caption;

end;

procedure TfmTopics.mnWriteAdditionalData(Sender: TObject);
var
  iMenuIndex : byte;
begin
  //�������� �����
  fmAdditionalInfo:=TfmAdditionalInfo.Create(Application);
  fmAdditionalInfo.Caption:=(Sender as TMenuItem).Caption;
  afAdditionalInfo:=EDIT;

  //����������� ����������
  iMenuIndex:=(Sender as TMenuItem).MenuIndex;
  case iMenuIndex of
    1 : fmAdditionalInfo.pData:=aTopics[iIndex].Parametrs.Purpose;
    2 : fmAdditionalInfo.pData:=aTopics[iIndex].Parametrs.Instruction;
  end;

  //�������� ����
  fmAdditionalInfo.ShowModal;

  if afAdditionalInfo=EDIT then
    case iMenuIndex of
      1 : aTopics[iIndex].Parametrs.Purpose:=fmAdditionalInfo.pData;
      2 : aTopics[iIndex].Parametrs.Instruction:=fmAdditionalInfo.pData;
    end;

  //�������� ����� � ������� ����������
  fmAdditionalInfo.Free;

end;

procedure TfmTopics.FormShow(Sender: TObject);
var
   i : integer;
begin
  //������������� ����������
  iIndex:=0;
  iQuestionIndex:=0;
  fmMain.EnabledSaveTest(true);  

  //����������� ������ ���
  Test.Topics.GetList(lstTopics);
  lstQuestions.Clear;

  fmTopics.Caption:='����';

  //���������� ���
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

  //��� ����������� �������
  if lstTopics.Items.Count=1
    then mnQuestionMove.Enabled:=false
    else mnQuestionMove.Enabled:=true;

  //�������� ����������



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
  fmTopics.Caption:='���� - '+sTopic;

  //������ ������ ��������
  if Test.Topics.GetListQuestions(lstQuestions,iIndex)<>0 then
  begin
    EnabledQuestions(true);
    iQuestionIndex:=0;
    lstQuestions.OnSelectItem(lstQuestions,lstQuestions.Items.Item[0],true);
  end
  else
    EnabledQuestions(false);


  //����� ������������
  case Parametrs.Mode of
    HARD : mnuTemp:=mnModeHard;
    SOFT : mnuTemp:=mnModeSoft;
  end;
  mnuTemp.Checked:=true;
  stsbInfo.Panels[0].Text:='����� ������������ - '+mnuTemp.Caption;

  //������� ��������
  case Parametrs.OrderQuestion of
    ORD_123N : mnuTemp:=mnQuestion123N;
    ORD_RANDOM : mnuTemp:=mnQuestionRandom;
  end;
  mnuTemp.Checked:=true;
  stsbInfo.Panels[1].Text:='������� �������� - '+mnuTemp.Caption;

  //������� �������
  case Parametrs.OrderAnswer of
    ORD_123N : mnuTemp:=mnAnswer123N;
    Ord_RANDOM : mnuTemp:=mnAnswerRandom;
  end;
  mnuTemp.Checked:=true;

  //����������� �� �������
  if Parametrs.Time=0
    then sTime:='����'
    else sTime:=IntToStr(Parametrs.Time);
  stsbInfo.Panels[2].Text:='����������� �� ������� - '+sTime;

end;

procedure TfmTopics.lstTopicsClick(Sender: TObject);
begin
     if lstTopics.Selected=nil then exit;

end;



procedure TfmTopics.mnOrderAnswerSelect(Sender: TObject);
var
  pOrderAnswer : TOrder;
begin
  //��������� ������� �������
  case (Sender as TMenuItem).MenuIndex of
    0 : pOrderAnswer:=Ord_123N;
    1 : pOrderAnswer:=Ord_Random;
  end;

  //������ �������� ���������
  aTopics[iIndex].Parametrs.OrderAnswer:=pOrderAnswer;

end;

procedure TfmTopics.mnTopicsAddClick(Sender: TObject);
var
  iCount : integer;
begin
  //�������� �����
  fmAddTopics:=TfmAddTopics.Create(Application);
  afAddTopics:=ADD;
  //�������� ���� ���������� ���
  fmAddTopics.ShowModal;

  if afAddTopics=ADD then
  begin
    Test.Topics.Add(fmAddTopics.pAddTopic);
    lstTopics.Items.Add.Caption:=fmAddTopics.pAddTopic.Name;

    //������ ��������, ���� ���������
    EnabledEdit(true);
    if lstTopics.Items.Count=1 then
    begin
      iIndex:=0;
      lstTopics.ItemIndex:=iIndex;
      lstTopics.OnDblClick(lstTopics);
      fmTopics.Caption:='���� - '+fmAddTopics.pAddTopic.Name;
      sTopic:=fmAddTopics.pAddTopic.Name;
    end;
    EnabledQuestions(false);

    //��������� ��� ������������
    aTopics[lstTopics.Items.Count-1].Parametrs.Enable:=true;
    lstTopics.Items.Item[lstTopics.Items.Count-1].Checked:=true;
        
  end;

  //�������� �����
  fmAddTopics.Free;


end;

procedure TfmTopics.mnTopicsRenameClick(Sender: TObject);
begin
     //�������� � �������� �����
     fmRenameTopic:=TfmRenameTopic.Create(Application);
     fmRenameTopic.ShowModal;

     //��������
     fmRenameTopic.Free;

end;

procedure TfmTopics.mnTopicsDeleteClick(Sender: TObject);
var
   iCount : integer;
begin
     if MessageDlg('�� ������������� ������ ������� ���� "'+sTopic+'"?',mtWarning,[mbYes, mbNo],0)=mrNo then Exit;

     //�������������
     iCount:=lstTopics.Items.Count-1;

     //�������� ����
     Test.Topics.Delete(iIndex);
     lstTopics.Items.Delete(iIndex);


     //�������� �������������� ����
     if iCount=iIndex then iIndex:=iIndex-1;
     if lstTopics.Items.Count<>0 then
     begin
          lstTopics.ItemIndex:=iIndex;
          lstTopics.OnDblClick(lstTopics);
     end
     else
     begin
          fmTopics.Caption:='����';
          EnabledEdit(false);
          iIndex:=-1;
     end;

end;

{**************************���������� ��������� ����������*********************}
procedure TfmTopics.EnabledEdit(bValue: boolean);
begin
     //����
     mnSettings.Enabled:=bValue;
     mnDescription.Enabled:=bValue;
     mnQuestions.Enabled:=bValue;
     mnTopicsDelete.Enabled:=bValue;
     mnTopicsRename.Enabled:=bValue;

     //������ ������
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
  //�������� �����
  fmQuestion:=TfmQuestion.Create(Application);

  fmQuestion.pQuestion:=aTopics[iIndex].Question[iQuestionIndex];
  with aTopics[iIndex].Question[iQuestionIndex] do
  begin
    fmQuestion.pQuestion.sLinkQuestion:=copy(sLinkQuestion);
    fmQuestion.pQuestion.Answer.aswSelect:=copy(Answer.aswSelect);
    fmQuestion.pQuestion.Answer.aswUpDown:=copy(Answer.aswUpDown);
    fmQuestion.pQuestion.Answer.aswLink:=copy(Answer.aswLink);
  end;


  //��������� ��������
  afQuestion:=EDIT;
  fmQuestion.Caption:=aTopics[iIndex].Name+' ['+IntToStr(iQuestionIndex+1)+']';

  fmQuestion.ShowModal;

  //������ ��������
  if afQuestion=EDIT then
  begin
    aTopics[iIndex].Question[iQuestionIndex]:=fmQuestion.pQuestion;
    //���������� ���������� lstQuestions

    Test.Topics.GetListQuestions(lstQuestions, iIndex);

  end;

  //�������� ����������
  fmQuestion.Destroy;

end;

procedure TfmTopics.lstQuestionsSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
  EnabledQuestions(Selected);

  //����� ���������� �������
  iQuestionIndex:=Item.Index;

  //��������� ����
  if Selected=true
    then fmTopics.Caption:='���� - '+sTopic+' ['+IntToStr(iQuestionIndex+1)+']'
    else fmTopics.Caption:='���� - '+sTopic;

  //��� ����������� �������
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
  //�������� ��� �� ��������
  bChecked:=chbAllSelect.Checked;

  //���������� � �����
  for i:=0 to lstTopics.Items.Count-1 do
  begin
    lstTopics.Items.Item[i].Checked:=bChecked;
  end;

end;

procedure TfmTopics.mnQuestionAddClick(Sender: TObject);
begin
  //�������� �����
  fmQuestion:=TfmQuestion.Create(Application);

  //��������� ��������
  afQuestion:=ADD;
  fmQuestion.Caption:=aTopics[iIndex].Name+' ['+IntToStr(lstQuestions.Items.Count+1)+']';

  fmQuestion.ShowModal;

  //������ ��������
  if afQuestion=ADD then
  begin
    //������
    Test.Topics.Questions.Add(iIndex, fmQuestion.pQuestion);

    //���������� ������ ��������
    Test.Topics.GetListQuestions(lstQuestions, iIndex);    
  end;

  //�������� ����������
  fmQuestion.Destroy;
end;

procedure TfmTopics.mnQuestionDeleteClick(Sender: TObject);
var
  i : integer;
begin
  if MessageDlg('������� ��������� ������? ����� �������� ������ �������� ����������',mtWarning,[mbYes,mbNo],0)=mrNo then Exit;

  //�������� �������
  Test.Topics.Questions.Delete(iIndex, iQuestionIndex);

  //������������
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
  //�������� �����
  fmMoveQuestion:=TfmMoveQuestion.Create(application);
  afMoveQuestion:=EDIT;

  //������������ ������ ���
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

  //����������� �����
  fmMoveQuestion.ShowModal;

  //����������� �������
  if afMoveQuestion=EDIT then Test.Topics.GetListQuestions(lstQuestions,iIndex);

  //�������� �����
  fmMoveQuestion.Free;
end;

procedure TfmTopics.lstQuestionsClick(Sender: TObject);
begin
  //��� ����������� �������
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

  //���� ���� �� ��������
  if bTestModified=true then
    mrResult:=MessageDlg('���� "'+Test.Subject+'" ��� �������! ���������?!',mtInformation,[mbYes, mbNo, mbCancel],0);

  case mrResult of
    mrCancel : begin
                  CanClose:=false;
                  exit;
               end;
       mrYes : fmMain.mnSave.Click;
        mrNo : goto JumpCloseTest;
  end;

  JumpCloseTest:
  //�������� �����
  Test.Close(fmMain);

  //���������  (���������� �������)
  fmMain.mnPassword.Enabled:=false;
  fmMain.ElementsTest;
  fmMain.EnabledSaveTest(false);
end;

end.
