unit F_Browser;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OleCtrls, SHDocVw;

type
  TfmLinkBrowser = class(TForm)
    wbBrowser: TWebBrowser;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    pLinkFileName : string;
  end;

var
  fmLinkBrowser: TfmLinkBrowser;

implementation

{$R *.dfm}

procedure TfmLinkBrowser.FormShow(Sender: TObject);
begin
  wbBrowser.Navigate(pLinkFileName);
end;

end.
