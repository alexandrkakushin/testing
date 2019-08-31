unit FMoveStudent;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, U_TestServer, StdCtrls, ComCtrls, Buttons;

type
  TfmMoveStudent = class(TForm)
    Label1: TLabel;
    lCurrentGroup: TLabel;
    gbMoveStudent: TGroupBox;
    lstGroups: TListView;
    btnOK: TBitBtn;
    btnCancel: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure lstGroupsClick(Sender: TObject);
  private
    { Private declarations }
    bCloseOK : boolean;
    aValuesID : TIntVector;
  public
    { Public declarations }
    pValueID : integer;
    sName : string;
  end;

var
  fmMoveStudent : TfmMoveStudent;
  afMoveStudent : TActionForm;

implementation

uses FMainForm;

{$R *.dfm}

procedure TfmMoveStudent.FormShow(Sender: TObject);
begin
  //Инициализация
  bCloseOK:=false;
  lCurrentGroup.Caption:=nGroup.Text;

  //Получение списка групп
  aValuesID:=copy(DBTest.Groups.GetListMove(lstGroups, nGroup.Text));
  if lstGroups.Items.Count>0 then lstGroups.ItemIndex:=0;
  
end;

procedure TfmMoveStudent.btnCancelClick(Sender: TObject);
begin
  afMoveStudent:=Cancel;
  Close;
end;

procedure TfmMoveStudent.btnOKClick(Sender: TObject);
begin
  if lstGroups.Selected=nil then
  begin
    MessageDlg('Выберите группу!',mtInformation,[mbOK],0);
    exit;
  end;
  
  bCloseOK:=true;
  pValueID:=aValuesID[lstGroups.ItemIndex];
  sName:=lstGroups.Selected.Caption;

  Close;
end;

procedure TfmMoveStudent.lstGroupsClick(Sender: TObject);
begin
  if lstGroups.Selected=nil then exit;
end;

end.
