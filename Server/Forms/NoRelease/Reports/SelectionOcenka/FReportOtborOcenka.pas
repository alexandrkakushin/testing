unit FReportOtborOcenka;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls;

type
  TOtborOcenka = class(TForm)
    tb_selection: TTabControl;
    ListResults: TListView;
    procedure tb_selectionChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  OtborOcenka: TOtborOcenka;

implementation

uses F_Report;

{$R *.dfm}


procedure SelectionOfBalls (var ListIn, ListOut : TListView; Ball : string);
var
   i, k : integer;
   li_in, li_out : TListItem;

begin
     //Очистка списка отбора
     ListIn.Clear;

     //Количество студентов первоначально = 0
     k:=0;

     //Перебираем все записи
     for i:=0 to ListOut.Items.Count-1 do
     begin
          li_out:=ListOut.Items.Item[i];
          //Если найден студент с нужной оценкой
          if li_out.SubItems.Strings[1]=Ball then
          begin
               //Добавляем его в список вывода
               k:=k+1;
               li_in:=ListIn.Items.Add;
               li_in.Caption:=IntToStr(k);
               li_in.SubItems.Add(li_out.SubItems.Strings[0]);
               li_in.SubItems.Add(li_out.SubItems.Strings[2]);               
          end;
     end;
end;

procedure TOtborOcenka.tb_selectionChange(Sender: TObject);
begin
     //Отбор по оценке (заголовок закладки)
     SelectionOfBalls(ListResults,Report.List_report,tb_selection.Tabs[tb_selection.TabIndex]);
end;

procedure TOtborOcenka.FormShow(Sender: TObject);
begin
     tb_selection.OnChange(tb_selection);
end;

end.
