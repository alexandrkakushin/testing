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
     //Пиктограммы в дереве
     tv_student.Images:=main_form.Images_tree;
end;

procedure TDelete_Student.FormShow(Sender: TObject);
begin
     //Отображение дерева групп
     groups.Show(tv_student);
end;

procedure TDelete_Student.tv_studentClick(Sender: TObject);
begin
     //Выбираем элемент дерева
     TNode:= tv_student.Selected;
end;

procedure TDelete_Student.btn_okClick(Sender: TObject);
label 10;
var
   NameGroup, NameStudent : string;
   res : boolean;
begin
     //Выбран ли студент
     if TNode.Level<>1 then
     begin
          MessageDlg('Выберите студента!',mtError,[mbOk],0);
          exit;
     end;

     if MessageDlg('Удаление студента приведет к потере результатов тестирования! Продолжить?',mtWarning,[mbYes,mbNo],0)=mrNo then exit;

     //Инициализация переменных
     NameGroup:=TNode.Parent.Text;
     NameStudent:=TNode.Text+'.dat';

     //Удаляем студентов
     res:=Students.Delete(NameGroup, NameStudent);

     //Проверяем возвращенный результат функции
     if res=true then
     begin
          groups.Show(main_form.tree_groups);

          //Если выбран студент группы для удаления
          if pos(NameGroup,main_form.Caption)<>0 then
          begin
               main_form.Caption:='Результаты тестирования';
               main_form.list_results.Clear;
               main_form.tc_results.Tabs.Clear;
          end;
          
          close;
     end
     else
     begin
          MessageDlg('Ошибка удаления студента!',mtError,[mbOk],0);
          tv_student.SetFocus;
     end;
end;

end.
