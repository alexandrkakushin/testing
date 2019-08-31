unit F_Delete_Student;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls;

type
  TDelete_Student = class(TForm)
    l_student: TLabel;
    tv_student: TTreeView;
    btn_ok: TBitBtn;
    btn_cancel: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tv_studentClick(Sender: TObject);
    procedure btn_okClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Delete_Student: TDelete_Student;
  TNode : TTreeNode;
implementation

uses F_Main_form;

{$R *.dfm}

procedure TDelete_Student.FormCreate(Sender: TObject);
begin
     //����������� � ������
     tv_student.Images:=main_form.Images_tree;
end;

procedure TDelete_Student.FormShow(Sender: TObject);
begin
     //����������� ������ �����
     groups.Show(tv_student);
end;

procedure TDelete_Student.tv_studentClick(Sender: TObject);
begin
     //�������� ������� ������
     TNode:= tv_student.Selected;
end;

procedure TDelete_Student.btn_okClick(Sender: TObject);
label 10;
var
   NameGroup, NameStudent : string;
   res : boolean;
begin
     //������ �� �������
     if TNode.Level<>1 then
     begin
          MessageDlg('�������� ��������!',mtError,[mbOk],0);
          exit;
     end;

     if MessageDlg('�������� �������� �������� � ������ ����������� ������������! ����������?',mtWarning,[mbYes,mbNo],0)=mrNo then exit;

     //������������� ����������
     NameGroup:=TNode.Parent.Text;
     NameStudent:=TNode.Text+'.dat';

     //������� ���������
     res:=Students.Delete(NameGroup, NameStudent);

     //��������� ������������ ��������� �������
     if res=true then
     begin
          groups.Show(main_form.tree_groups);

          //���� ������ ������� ������ ��� ��������
          if pos(NameGroup,main_form.Caption)<>0 then
          begin
               main_form.Caption:='���������� ������������';
               main_form.list_results.Clear;
               main_form.tc_results.Tabs.Clear;
          end;
          
          close;
     end
     else
     begin
          MessageDlg('������ �������� ��������!',mtError,[mbOk],0);
          tv_student.SetFocus;
     end;
end;

end.
