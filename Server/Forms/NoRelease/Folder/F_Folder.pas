unit F_Folder;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, ShellCtrls;

type
  TFolder = class(TForm)
    Shell_folder: TShellTreeView;
    btn_ok: TBitBtn;
    btn_cancel: TBitBtn;
    procedure btn_okClick(Sender: TObject);
    procedure btn_cancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Folder: TFolder;

implementation

uses F_Setting;

{$R *.dfm}

procedure TFolder.btn_okClick(Sender: TObject);
begin
     Setting.le_path_result.Text:=Shell_Folder.Path;
     Setting.le_path_result.SetFocus;

     close;
end;

procedure TFolder.btn_cancelClick(Sender: TObject);
begin
     close;
end;

end.
