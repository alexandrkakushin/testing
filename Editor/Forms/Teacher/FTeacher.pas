unit FTeacher;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, U_Test;

type
  TfmTeacher = class(TForm)
    btnOk: TBitBtn;
    btnCancel: TBitBtn;
    lbledtName: TLabeledEdit;
    lbledtOrganization: TLabeledEdit;
    lbledtWWW: TLabeledEdit;
    lbledtEMail: TLabeledEdit;
    PCInfo: TPageControl;
    tbsMain: TTabSheet;
    tbsAdditional: TTabSheet;
    Label1: TLabel;
    mTelephone: TMemo;
    Label2: TLabel;
    mAchievement: TMemo;
    Label3: TLabel;
    mMiscInfo: TMemo;
    btnProfiles: TBitBtn;
    procedure btnCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnProfilesClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
     pInfoDeveloper : TInfoDeveloper;

  end;

var
  fmTeacher: TfmTeacher;
  afTeacher : TActionForm;

implementation

uses FTopics, F_Main_form, FListDeveloper;

{$R *.dfm}

procedure TfmTeacher.btnCancelClick(Sender: TObject);
begin
  //Закрытие окна
  afTeacher:=CANCEL;
  Close;
end;

procedure TfmTeacher.FormShow(Sender: TObject);
begin
  //Кнопка профилей (доступна только при редактировании темы)
  if (afTeacher=EDIT) or (afTeacher=ADD)
    then btnProfiles.Visible:=true
    else btnProfiles.Visible:=false;

  //Отображение
  with pInfoDeveloper do
  begin
    lbledtName.Text:=Name;
    lbledtOrganization.Text:=Organization;
    lbledtWWW.Text:=WWW;
    lbledtEMail.Text:=EMail;
    mTelephone.Text:=Telephone;
    mAchievement.Text:=Achievement;
    mMiscInfo.Text:=MiscInfo;
  end;

  //Фокус
  lbledtName.SetFocus;
  lbledtName.SelectAll;

end;

procedure TfmTeacher.btnOkClick(Sender: TObject);
begin
  //Установка значений параметра
  with pInfoDeveloper do
  begin
    Name:=lbledtName.Text;
    Organization:=lbledtOrganization.Text;
    WWW:=lbledtWWW.Text;
    EMail:=lbledtEMail.Text;
    Telephone:=mTelephone.Text;
    Achievement:=mAchievement.Text;
    MiscInfo:=mMiscInfo.Text;
  end;

  //Закрытие окна
  close;
  
end;

procedure TfmTeacher.btnProfilesClick(Sender: TObject);
begin
  //Создание и открытие формы
  fmListDeveloper:=TfmListDeveloper.Create(Application);
  afListDeveloper:=SELECT;
  fmListDeveloper.ShowModal;

  if afListDeveloper=SELECT then
  begin
    with fmListDeveloper.pInfoDeveloper do
    begin
      lbledtName.Text:=Name;
      lbledtOrganization.Text:=Organization;
      lbledtWWW.Text:=WWW;
      lbledtEMail.Text:=EMail;
      mTelephone.Text:=Telephone;
      mAchievement.Text:=Achievement;
      mMiscInfo.Text:=MiscInfo;
    end;
  end;

  //Удаление формы
  fmListDeveloper.Free;
end;

end.
