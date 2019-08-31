unit F_Data_reports_student;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Mask, U_Group, U_reports, ComCtrls;

type
  TData_reports_student = class(TForm)
    l_groups: TLabel;
    combo_groups: TComboBox;
    l_students: TLabel;
    l_subjects: TLabel;
    combo_students: TComboBox;
    combo_subjects: TComboBox;
    btn_ok: TBitBtn;
    btn_cancel: TBitBtn;
    procedure btn_okClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure combo_groupsChange(Sender: TObject);
    procedure btn_cancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Data_reports_student: TData_reports_student;
   r5, r4, r3, r2, rN : integer;
   Subject, Students: TStringList;
   Param : TParam;
   SSubject : string;

implementation

uses F_Report, F_Main_form, F_Data_reports_group;

{$R *.dfm}


procedure TData_reports_student.btn_okClick(Sender: TObject);
var
   res : boolean;
begin
     SSubject:=combo_subjects.Text;

     res:=Reports.ResultOfGroupOnTema(report.list_report,combo_groups.Text,SDate,SSubject,STema, STeacher, AvgBall);
     if res=true then
     begin
          with Report do
          begin
               ShowModal;
          end;
          close;
     end
     else
         combo_groups.SetFocus;

end;

procedure TData_reports_student.FormShow(Sender: TObject);
begin
     //Список групп и очистка компонент
     combo_groups.Items:=Groups.ListGroups;
     combo_subjects.Clear;
     combo_students.Clear;

     if Groups.ListGroups.Count-1<>-1 then
     begin
          combo_groups.ItemIndex:=0;
          combo_groups.OnChange(combo_groups);
     end;
     combo_groups.SetFocus;

end;

procedure TData_reports_student.combo_groupsChange(Sender: TObject);
begin
     //Формирование списка группы
     Students:=TStringList.Create;
     Reports.FindStudents(combo_groups.Text,Students);
     combo_students.Items:=students;

     //Формирование списка предметов группы
     Subject:=TStringList.Create;
     Reports.SubjectOfGroup(Subject,combo_groups.text);
     combo_subjects.Items:=Subject;

end;

procedure TData_reports_student.btn_cancelClick(Sender: TObject);
begin
     close;
end;

end.
