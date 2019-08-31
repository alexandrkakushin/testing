unit FListDeveloper;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Buttons, U_Test, ToolWin, ImgList;

type
  TfmListDeveloper = class(TForm)
    lstDevelopers: TListView;
    btnOk: TBitBtn;
    btnCancel: TBitBtn;
    DevelopersImage: TImageList;
    tbDevelopers: TToolBar;
    tbtnAdd: TToolButton;
    tbtnDelete: TToolButton;
    tbtnEdit: TToolButton;
    procedure btnCancelClick(Sender: TObject);
    procedure lstDevelopersDblClick(Sender: TObject);

    procedure EnabledElements (bValue : boolean);
    procedure VisibleElements (bValue : boolean);    

    procedure lstDevelopersSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure FormShow(Sender: TObject);
    procedure tbtnAddClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    Index : integer;
    pInfoDeveloper : TInfoDeveloper;
  end;

var
  fmListDeveloper: TfmListDeveloper;
  afListDeveloper : TActionForm;

implementation

uses FTopics, F_Main_form, FTeacher;

{$R *.dfm}

procedure TfmListDeveloper.btnCancelClick(Sender: TObject);
begin
  //Закрытие окна
  afListDeveloper:=CANCEL;
  Close;
end;

procedure TfmListDeveloper.EnabledElements(bValue: boolean);
begin
  tbtnDelete.Enabled:=bValue;
  tbtnEdit.Enabled:=bValue;
end;

procedure TfmListDeveloper.lstDevelopersDblClick(Sender: TObject);
begin
  if lstDevelopers.Selected=nil then exit;

  //Инициализация
  Index:=lstDevelopers.Selected.Index;

  //Выбор профиля
  if afListDeveloper=SELECT then
  begin
    pInfoDeveloper:=Test.Developers.LoadProfile(Index);
    close;
    exit;
  end;

  //Изменение профиля
  fmTeacher:=TfmTeacher.Create(Application);
  fmTeacher.pInfoDeveloper:=Test.Developers.LoadProfile(Index);
  afTeacher:=SELECT;
  fmTeacher.ShowModal;

  if afTeacher=SELECT then
  begin
    Test.Developers.Edit(Index,fmTeacher.pInfoDeveloper);
    lstDevelopers.Items.Item[Index].SubItems.Strings[0]:=fmTeacher.pInfoDeveloper.Name;
  end;

end;

procedure TfmListDeveloper.lstDevelopersSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
  //Доступность элементов
  EnabledElements(Selected);
end;

procedure TfmListDeveloper.FormShow(Sender: TObject);
begin
  //Предназначение формы
  if afListDeveloper=SELECT
    then VisibleElements(false)
    else VisibleElements(true);

  //Получение списка разработчиков
  Test.Developers.ProcessingFile;
  Test.Developers.GetList(fmListDeveloper.lstDevelopers);

  if lstDevelopers.Items.Count<>0 then
  begin
    lstDevelopers.ItemIndex:=0;
    EnabledElements(true);
  end
  else
    EnabledElements(false);
end;

procedure TfmListDeveloper.tbtnAddClick(Sender: TObject);
begin
  //Создание и открытие формы
  fmTeacher:=TfmTeacher.Create(Application);
  afTeacher:=SELECT;
  fmTeacher.ShowModal;

  //Запись значения
  if afTeacher=SELECT then
  begin
    Test.Developers.Add(fmTeacher.pInfoDeveloper);
    with lstDevelopers.Items.Add do
    begin
      Caption:=IntToStr(lstDevelopers.Items.Count);
      SubItems.Add(fmTeacher.pInfoDeveloper.Name);
    end;
  end;

  //Удаление формы
  fmTeacher.Free;

end;

procedure TfmListDeveloper.btnOkClick(Sender: TObject);
begin
  if (lstDevelopers.Selected = nil) and (afListDeveloper=SELECT)
  then begin
    MessageDlg('Выберите профиль из спика',mtInformation,[mbOk],0);
    lstDevelopers.SetFocus;
    exit;
  end;

  //Выбор профиля
  if afListDeveloper=SELECT then
  begin
    pInfoDeveloper:=Test.Developers.LoadProfile(lstDevelopers.ItemIndex);
    close;
    exit;
  end;

  Test.Developers.SaveProfiles;

  //Закрытие окна
  Close;
end;

procedure TfmListDeveloper.VisibleElements(bValue: boolean);
begin
  tbtnAdd.Visible:=bValue;
  tbtnDelete.Visible:=bValue;
end;

procedure TfmListDeveloper.tbtnDeleteClick(Sender: TObject);
var
   i : integer;
begin
     if MessageDlg('Вы действительно хотите удалить выбранный профиль?',mtWarning,[mbYes,mbNo],0)=mrNo then exit;

     i:=lstDevelopers.Selected.Index;
     Test.Developers.Delete(i);
     lstDevelopers.Items.Delete(i);

     //Обновление номеров профилей
     lstDevelopers.Items.BeginUpdate;
     for i:=0 to lstDevelopers.Items.Count-1 do
      lstDevelopers.Items.Item[i].Caption:=IntToStr(i+1);
     lstDevelopers.Items.EndUpdate;
          
end;

end.
