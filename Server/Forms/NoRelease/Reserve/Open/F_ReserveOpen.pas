unit F_ReserveOpen;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, CheckLst, U_Group;

type
  TReserveOpen = class(TForm)
    gb_groups: TGroupBox;
    Check_groups: TCheckListBox;
    btn_ok: TBitBtn;
    btn_cancel: TBitBtn;
    dtn_select_all: TBitBtn;
    SaveDlg: TSaveDialog;
    procedure dtn_select_allClick(Sender: TObject);
    procedure btn_okClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ReserveOpen: TReserveOpen;

implementation

uses F_Main_form;

{$R *.dfm}

procedure TReserveOpen.dtn_select_allClick(Sender: TObject);
var
   i : integer;
begin
     for i:=0 to Check_groups.Count-1 do
         check_groups.Checked[i]:=true;
end;

procedure TReserveOpen.btn_okClick(Sender: TObject);
var
   ListOpen : TStringList;
   i : integer;
begin
     //Темы для восстановления помещаем в ListSave
     ListOpen:=TStringList.Create;
     for i:=0 to check_groups.Items.Count-1 do
     begin
          if Check_Groups.Checked[i]=true then ListOpen.Add(Check_Groups.Items[i]);
     end;

     //Восстановление
     Groups.ReadGroups(ListOpen,main_form.OpenDlg.FileName);
     Groups.Show(main_form.tree_groups);

end;

end.
