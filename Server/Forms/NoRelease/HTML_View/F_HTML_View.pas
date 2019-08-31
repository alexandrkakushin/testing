unit F_HTML_View;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OleCtrls, SHDocVw, ImgList, Menus, ShellApi;

type
  THTML_View = class(TForm)
    WebBrowser: TWebBrowser;
    Menu_view_report: TMainMenu;
    Images: TImageList;
    mn_report: TMenuItem;
    mn_save: TMenuItem;
    mn_print: TMenuItem;
    SaveDlg: TSaveDialog;
    procedure mn_saveClick(Sender: TObject);
    procedure mn_printClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  HTML_View: THTML_View;

implementation

uses F_Report;

{$R *.dfm}

procedure THTML_View.mn_saveClick(Sender: TObject);
begin
     //Сохранение отчета
     if SaveDlg.Execute then
     begin
          //Сохранение
          SL_HTML.SaveToFile(SaveDlg.FileName);

          //Удаление объекта
          SL_HTML.Free;
     end;
end;

procedure THTML_View.mn_printClick(Sender: TObject);
var
   FName, FDir : string;
begin
     //Подготовка переменных
     FName:=ExtractFileName(TempFile);
     FDir:=ExtractFileDir(TempFile);

     //Печать
     ShellExecute(Report.Handle,PChar('print'), PChar(FName),nil,PChar(FDir),SW_SHOWNORMAL);

end;

end.
