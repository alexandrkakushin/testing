unit F_ReserveSave;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, CheckLst, U_Group;

type
  TReserveSave = class(TForm)
    gb_groups: TGroupBox;
    Check_groups: TCheckListBox;
    btn_ok: TBitBtn;
    btn_cancel: TBitBtn;
    dtn_select_all: TBitBtn;
    SaveDlg: TSaveDialog;
    procedure FormShow(Sender: TObject);
    procedure dtn_select_allClick(Sender: TObject);
    procedure btn_okClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ReserveSave: TReserveSave;

implementation

uses F_Main_form;

{$R *.dfm}

procedure TReserveSave.FormShow(Sender: TObject);
begin
     //�������� ������ �����
     check_groups.Items:=groups.ListGroups;
end;

procedure TReserveSave.dtn_select_allClick(Sender: TObject);
var
   i : integer;
begin
     for i:=0 to Check_groups.Count-1 do
         check_groups.Checked[i]:=true;
end;

procedure TReserveSave.btn_okClick(Sender: TObject);
var
   ListSave : TStringList;
   i : integer;
begin
     //���� ��� ���������� �������� � ListSave
     ListSave:=TStringList.Create;
     for i:=0 to check_groups.Items.Count-1 do
     begin
          if Check_Groups.Checked[i]=true then ListSave.Add(Check_Groups.Items[i]);
     end;

     //������ ������� ����������
     if SaveDlg.Execute then
     begin
          Groups.WriteGroups(ListSave,SaveDlg.FileName);
     end;

end;

end.
