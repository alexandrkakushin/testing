unit F_Data_reports_group;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Mask, U_Group, U_reports, ComCtrls;

type
  TData_reports_group = class(TForm)
    l_groups: TLabel;
    combo_groups: TComboBox;
    l_subjects: TLabel;
    l_tema: TLabel;
    l_date: TLabel;
    combo_subjects: TComboBox;
    combo_tema: TComboBox;
    Combo_date: TComboBox;
    btn_ok: TBitBtn;
    btn_cancel: TBitBtn;
    procedure btn_okClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure combo_groupsChange(Sender: TObject);
    procedure combo_subjectsChange(Sender: TObject);
    procedure combo_temaChange(Sender: TObject);
    procedure btn_cancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Data_reports_group: TData_reports_group;
   r5, r4, r3, r2, rN : integer;
   Subject, Tema, Date : TStringList;
   AvgBall, Quality, Progress : real;
   Param : TParam;
   SSubject, STema, STeacher, SDate : string;   

implementation

uses F_Report, F_Main_form;

{$R *.dfm}

procedure Count(var list_view : TListView);
var
   i : integer;
begin
     //�������������
     r5:=0; r4:=0; r3:=0; r2:=0; rN:=0;

     //������������ ���������� ������ ��� ������
     for i:=0 to list_view.Items.Count-1 do
     begin
          case list_view.Items.Item[i].SubItems.Strings[1][1] of
               '5' : inc(r5);
               '4' : inc(r4);
               '3' : inc(r3);
               '2' : inc(r2);
               '�' : inc(rN);
          end;
     end;
end;


procedure SetParametrs(var Param : TParam);
begin
     with Data_reports_group do
     begin
          Param[1,1]:='��.'; Param[1,2]:=combo_groups.Text;
          Param[2,1]:='�� ����������'; Param[2,2]:=combo_subjects.Text;
          Param[3,1]:='�� ����'; Param[3,2]:=combo_tema.Text;
          Param[4,1]:='���� ������������'; Param[4,2]:=combo_date.Text;
          Param[5,1]:='�������������'; Param[5,2]:=STeacher;

          Param[6,1]:='������� ����'; Param[6,2]:=FloatToStrF(AvgBall,ffFixed,18,2);
          Param[7,1]:='��������'; Param[7,2]:=FloatToStrF(Quality,ffFixed,18,2)+'%';
          Param[8,1]:='������������'; Param[8,2]:=FloatToStrF(Progress,ffFixed,18,2)+'%';

          Param[9,1]:='5 (�������)'; Param[9,2]:=IntToStr(r5);
          Param[10,1]:='4 (������)'; Param[10,2]:=IntToStr(r4);
          Param[11,1]:='3 (�����������������)'; Param[11,2]:=IntToStr(r3);
          Param[12,1]:='2 (�������������������)'; Param[12,2]:=IntToStr(r2);
          Param[13,1]:='� (�������������)'; Param[13,2]:=IntToStr(rN);
     end;
end;


procedure TData_reports_group.btn_okClick(Sender: TObject);
var
   res : boolean;
begin
     SSubject:=combo_subjects.Text;
     STema:=combo_tema.Text;
     SDate:=combo_date.Text;

     res:=Reports.ResultOfGroupOnTema(report.list_report,combo_groups.Text,SDate,SSubject,STema, STeacher, AvgBall);
     if res=true then
     begin
          with Report do
          begin
               //���������� ���������� ������, �������� � ������������
               Count(list_report);
               Quality:=((r5+r4)/list_report.Items.Count)*100;
               Progress:=((r5+r4+r3)/list_report.Items.Count)*100;


               //������� �������, ����, ���� � ������������� � ������
               l_subject.Caption:='������� - '+SSubject;
               l_tema.Caption:='���� - '+STema;
               l_teacher.Caption:='������������� - '+STeacher;
               l_date.Caption:='���� ������������ -'+SDate;
               l_AvgBall.Caption:='������� ���� - '+FloatToStrF(AvgBall,ffFixed,18,2);
               Caption:='����� �� ������ - '+combo_groups.Text;

               //������� ���������� ������
               l_5.Caption:='5 (�������) - '+IntToStr(r5);
               l_4.Caption:='4 (������) - '+IntToStr(r4);
               l_3.Caption:='3 (�����������������) - '+IntToStr(r3);
               l_2.Caption:='2 (�������������������) - '+IntToStr(r2);
               l_N.Caption:='� (�������������) - '+IntToStr(rN);

               //������� �������� ������ � ������������
               l_quality.Caption:='�������� - '+FloatToStrF(Quality,ffFixed,18,2)+'%';
               l_progress.Caption:='������������ - '+FloatToStrF(Progress,ffFixed,18,2)+'%';

               //������ ���������
               with Chart.Series[0] do
               begin
                    Clear;
                    Add(r5,'�������',clGreen);
                    Add(r4,'������',clYellow);
                    Add(r3,'�����������������',clRed);
                    Add(r2,'�������������������',clPurple);
                    Add(rN,'�������������',clBlue);
               end;

               SetParametrs(Param);

               ShowModal;
          end;
          close;
     end
     else
         combo_groups.SetFocus;

end;

procedure TData_reports_group.FormShow(Sender: TObject);
begin
     //������ ����� � ������� ���������
     combo_groups.Items:=Groups.ListGroups;

     combo_subjects.Clear;
     combo_tema.Clear;
     combo_date.Clear;

     if Groups.ListGroups.Count-1<>-1 then
     begin
          combo_groups.ItemIndex:=0;
          combo_groups.OnChange(combo_groups);
     end;
     combo_groups.SetFocus;




end;

procedure TData_reports_group.combo_groupsChange(Sender: TObject);

begin
     combo_tema.Clear;
     combo_date.Clear;

     //������������ ������ ��������� ������
     Subject:=TStringList.Create;
     Reports.SubjectOfGroup(Subject,combo_groups.Items[combo_groups.ItemIndex]);
     combo_subjects.Items:=Subject;



end;

procedure TData_reports_group.combo_subjectsChange(Sender: TObject);
begin

     combo_tema.Clear;
     combo_date.Clear;

     //������������ ������ ��� ������
     Tema:=TStringList.Create;
     Reports.TemaOfSubject(Tema,combo_groups.Items[combo_groups.ItemIndex],combo_subjects.Items[combo_subjects.ItemIndex]);
     combo_tema.Items:=Tema;


end;

procedure TData_reports_group.combo_temaChange(Sender: TObject);
begin
     //������������ ������ ��� ��� ���������� �����
     Date:=TStringList.Create;
     Reports.DateOfTema(Date,combo_groups.Items[combo_groups.ItemIndex],combo_subjects.Items[combo_subjects.ItemIndex],combo_tema.Items[combo_tema.ItemIndex]);
     combo_date.Items:=Date;
end;

procedure TData_reports_group.btn_cancelClick(Sender: TObject);
begin
     close;
end;

end.
