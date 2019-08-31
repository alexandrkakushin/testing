unit F_Report;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, TeEngine, Series, TeeProcs, Chart,
  Menus, ImgList, U_Reports, ShellApi;

type
  TReport = class(TForm)
    List_report: TListView;
    pg_report: TPageControl;
    tb_report: TTabSheet;
    tb_chart: TTabSheet;
    Panel: TPanel;
    l_subject: TLabel;
    l_tema: TLabel;
    l_teacher: TLabel;
    l_date: TLabel;
    l_AvgBall: TLabel;
    Panel_diag: TPanel;
    l_5: TLabel;
    l_4: TLabel;
    l_3: TLabel;
    l_2: TLabel;
    l_n: TLabel;
    l_quality: TLabel;
    l_progress: TLabel;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Chart: TChart;
    Series1: TPieSeries;
    Menu_report: TMainMenu;
    mn_report: TMenuItem;
    mn_export: TMenuItem;
    mn_print: TMenuItem;
    mn_html: TMenuItem;
    mn_otbor: TMenuItem;
    mn_ocenky: TMenuItem;
    Images: TImageList;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure pg_reportChange(Sender: TObject);
    procedure mn_ocenkyClick(Sender: TObject);
    procedure mn_htmlClick(Sender: TObject);
    procedure mn_printClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Report: TReport;
  Reports : TReports;
  SL_HTML : TStringList;
  TempFile : string;  
implementation

uses FReportOtborOcenka, F_Data_reports_group, F_HTML_View;

{$R *.dfm}

procedure TReport.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     list_report.Clear;
end;

procedure TReport.pg_reportChange(Sender: TObject);
begin
     //����������, ������� �� �������� "���������"
     if PG_Report.TabIndex=1 then
     begin
          //���������� ���������� ������ (5,4,3,2 � �)
     end;
end;

procedure TReport.mn_ocenkyClick(Sender: TObject);
var
   i : integer;
begin
     //��������� ����� ������ �� �������
     OtborOcenka.ShowModal;
end;

procedure PreparationHTML;
begin
     //�������� ������� Reports
     Reports:=TReports.Create;
     TempFile:=ExtractFilePath(application.ExeName)+'Temp\TempReport.html';

     SL_HTML:=TStringList.Create;

     //������� ������ � HTML, ����������
     Reports.ExportResultsGroupInHTML(Report.list_report,Param,SL_HTML);
     SL_HTML.SaveToFile(TempFile);

     //������� ������
     Reports.Free;
end;

procedure TReport.mn_htmlClick(Sender: TObject);
begin
     //���������� ������
     PreparationHTML;

     //��������� ������ � ��������� ����� ��������� ������ � HTML
     with HTML_View do
     begin
          WebBrowser.Navigate(TempFile);
          ShowModal;
     end;
end;

procedure TReport.mn_printClick(Sender: TObject);
var
   FName, FDir : string;
begin
     //���������� ������ HTML
     PreparationHTML;

     //���������� ����������
     FName:=ExtractFileName(TempFile);
     FDir:=ExtractFileDir(TempFile);

     //������
     ShellExecute(Report.Handle,PChar('print'), PChar(FName),nil,PChar(FDir),SW_SHOWNORMAL);

end;

end.
