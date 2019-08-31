unit FAddTopics;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, ComCtrls, U_Test;

type
  TfmAddTopics = class(TForm)
    btnOK: TBitBtn;
    btnCancel: TBitBtn;
    lbledtName: TLabeledEdit;
    rgMode: TRadioGroup;
    rgOrderQuestions: TRadioGroup;
    pcAddTopics: TPageControl;
    tsMain: TTabSheet;
    tsAdditional: TTabSheet;
    TabSheet3: TTabSheet;
    rgOrderAnswer: TRadioGroup;
    gnPurpose: TGroupBox;
    btnPurpose: TButton;
    gbInstructon: TGroupBox;
    btnInstruction: TButton;
    gbDeveloper: TGroupBox;
    btnDeveloper: TButton;
    lDeveloper: TLabel;
    lPurpose: TLabel;
    lInstruction: TLabel;
    tsSetting: TTabSheet;
    gbTime: TGroupBox;
    lTime: TLabel;
    btnTime: TButton;
    gbProcent: TGroupBox;
    lProcent: TLabel;
    btnProcent: TButton;
    imgDeveloper: TImage;
    imgPurpose: TImage;
    imgInstruction: TImage;
    imgTime: TImage;
    imgProcent: TImage;
    procedure btnDeveloperClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);

    procedure btnWriteAdditionalInfo (Sender: TObject);
    procedure btnTimeClick(Sender: TObject);
    procedure btnProcentClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lbledtNameExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    pAddTopic : TTopic;
    bCloseOK : boolean;
  end;

var
  fmAddTopics: TfmAddTopics;
  afAddTopics: TActionForm;

implementation

uses FTopics, FTeacher, F_Main_form, FAdditilonalInfo, FTime, FProcent;

{$R *.dfm}

procedure TfmAddTopics.btnDeveloperClick(Sender: TObject);
begin
  //�������� � �������� �����
  fmTeacher:=TfmTeacher.Create(Application);
  afTeacher:=ADD;
  fmTeacher.pInfoDeveloper:=pAddTopic.Parametrs.InfoDeveloper;
  fmTeacher.ShowModal;

  if afTeacher=ADD then
    pAddTopic.Parametrs.InfoDeveloper:=fmTeacher.pInfoDeveloper;

  //�������� �����
  fmTeacher.Free;
end;

procedure TfmAddTopics.btnOKClick(Sender: TObject);
begin
     if lbledtName.Text='' then
     begin
          MessageDlg ('��� �������� ���� ���������� ������ � ��������',mtInformation,[mbOk],0);
          lbledtName.SetFocus;
          exit;
     end;

     bCloseOK:=true;
     //��������� ���������� (�����, �������)
     case rgMode.ItemIndex of
          0 : pAddTopic.Parametrs.Mode:=HARD;
          1 : pAddTopic.Parametrs.Mode:=SOFT;
     end;

     case rgOrderQuestions.ItemIndex of
          0 : pAddTopic.Parametrs.OrderQuestion:=Ord_123N;
          1 : pAddTopic.Parametrs.OrderQuestion:=Ord_Random;
     end;

     case rgOrderAnswer.ItemIndex of
          0 : pAddTopic.Parametrs.OrderAnswer:=Ord_123N;
          1 : pAddTopic.Parametrs.OrderAnswer:=Ord_Random;
     end;

     pAddTopic.Name:=lbledtName.Text;

     //��������
     Close;

end;

procedure TfmAddTopics.btnCancelClick(Sender: TObject);
begin
  //�������� ����
  afAddTopics:=CANCEL;
  Close;
end;

procedure TfmAddTopics.btnWriteAdditionalInfo(Sender: TObject);
var
  iBtnTag : byte;
begin
  //�������� �����
  fmAdditionalInfo:=TfmAdditionalInfo.Create(Application);
  fmAdditionalInfo.Caption:=(Sender as TButton).Caption;
  afAdditionalInfo:=ADD;

  //����������� ����������
  iBtnTag:=(Sender as TButton).Tag;
  case iBtnTag of
    0 : fmAdditionalInfo.pData:=pAddTopic.Parametrs.Purpose;
    1 : fmAdditionalInfo.pData:=pAddTopic.Parametrs.Instruction;
  end;

  

  //�������� ����
  fmAdditionalInfo.ShowModal;

  if afAdditionalInfo=ADD then
    case iBtnTag of
      0 : pAddTopic.Parametrs.Purpose:=fmAdditionalInfo.pData;
      1 : pAddTopic.Parametrs.Instruction:=fmAdditionalInfo.pData;
    end;

  //�������� ����� � ������� ����������
  fmAdditionalInfo.Free;
end;

procedure TfmAddTopics.btnTimeClick(Sender: TObject);
begin
  fmTime:=TfmTime.Create(Application);
  afTime:=ADD;
  fmTime.pTime:=pAddTopic.Parametrs.Time;

  //��������
  fmTime.ShowModal;

  //������ ��������
  if afTime=ADD then
    pAddTopic.Parametrs.Time:=fmTime.pTime;

  //�������� �������
  fmTime.Free;
end;

procedure TfmAddTopics.btnProcentClick(Sender: TObject);
begin
  //�������� � ����������� ����� �� ������ ������
  fmProcent:=TfmProcent.Create(Application);
  fmProcent.pResult:=pAddTopic.Parametrs.Result;
  afProcent:=ADD;
  fmProcent.ShowModal;

  //�������� �������� �����
  if afProcent=ADD then
    pAddTopic.Parametrs.Result:=fmProcent.pResult;

  //�������� �������
  fmProcent.Free;
end;

procedure TfmAddTopics.FormShow(Sender: TObject);
begin
  //��������� ������
  lbledtName.SetFocus;

  bCloseOK:=false;
end;

procedure TfmAddTopics.lbledtNameExit(Sender: TObject);
var
   sTemp : string;
   i : integer;
   bFind, bError : boolean;
begin
     //�������������
     bFind:=false;
     bError:=false;

     for i:=0 to fmTopics.lstTopics.Items.Count-1 do
     begin
          sTemp:=Trim(AnsiUpperCase(fmTopics.lstTopics.Items.Item[i].Caption));
          if Trim(AnsiUpperCase(lbledtName.Text))=sTemp then
          begin
               bFind:=true;
               break;
          end;
     end;


     if bFind=true then
     begin
          MessageDlg('��������� ���� ���� ��� ����������',mtInformation,[mbOk],0);
     end;

     if (bError or bFind)=true then
     begin
          lbledtName.SetFocus;
          lbledtName.SelectAll;
     end;




end;

procedure TfmAddTopics.FormCreate(Sender: TObject);
begin
     //����������� �������� ��� �������� � ��������
     with fmTopics.TopicImages do
     begin
          GetBitmap(5,imgDeveloper.Picture.Bitmap);
          GetBitmap(6,imgPurpose.Picture.Bitmap);
          GetBitmap(7,imgInstruction.Picture.Bitmap);
          GetBitmap(4,imgTime.Picture.Bitmap);
          GetBitmap(1,imgProcent.Picture.Bitmap);
     end;

end;

procedure TfmAddTopics.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if bCloseOK=false then afAddTopics:=Cancel;
end;

end.
