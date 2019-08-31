unit FRenameTopic;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TfmRenameTopic = class(TForm)
    Label1: TLabel;
    lCurrentName: TLabel;
    lbledtNewName: TLabeledEdit;
    btnOk: TBitBtn;
    btnCancel: TBitBtn;
    procedure btnCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure lbledtNewNameExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmRenameTopic: TfmRenameTopic;

implementation

uses FTopics, F_Main_form;

{$R *.dfm}

procedure TfmRenameTopic.btnCancelClick(Sender: TObject);
begin
     //Закрытие окна
     Close;
end;

procedure TfmRenameTopic.FormShow(Sender: TObject);
begin
     //Отображение текущего названия
     lCurrentName.Caption:=fmTopics.lstTopics.Items.Item[iIndex].Caption;
     lbledtNewName.Text:=lCurrentName.Caption;
     lbledtNewName.SetFocus;
     lbledtNewName.SelectAll;
end;

procedure TfmRenameTopic.btnOkClick(Sender: TObject);
begin
     //Переименовывание
     Test.Topics.Rename(iIndex,lbledtNewName.Text);
     fmTopics.lstTopics.Items.Item[iIndex].Caption:=lbledtNewName.Text;
     fmTopics.Caption:='Темы - '+lbledtNewName.Text;

     //Выход
     Close;

end;

procedure TfmRenameTopic.lbledtNewNameExit(Sender: TObject);
var
   sTemp : string;
   i : integer;
   bFind, bError : boolean;
begin
     //Инициализация
     bFind:=false;
     bError:=false;

     for i:=0 to fmTopics.lstTopics.Items.Count-1 do
     begin
          sTemp:=Trim(AnsiUpperCase(fmTopics.lstTopics.Items.Item[i].Caption));
          if (Trim(AnsiUpperCase(lbledtNewName.Text))=sTemp) and (iIndex<>i) then
          begin
               bFind:=true;
               break;
          end;
     end;


     if lbledtNewName.Text='' then
     begin
          bError:=true;
          MessageDlg ('Для переименования темы необходимо ввести её название',mtInformation,[mbOk],0);
     end;

     if bFind=true then
     begin
          MessageDlg('Введенная Вами тема уже существует',mtInformation,[mbOk],0);
     end;

     if (bError or bFind)=true then
     begin
          lbledtNewName.SetFocus;
          lbledtNewName.SelectAll;
     end;
end;

end.
