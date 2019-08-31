unit F_Picture;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls;

type
  TfmLinkPicture = class(TForm)
    imgLink: TImage;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    pLinkFileName : string;
  end;

var
  fmLinkPicture: TfmLinkPicture;

implementation

{$R *.dfm}

procedure TfmLinkPicture.FormShow(Sender: TObject);
begin
  imgLink.Picture.LoadFromFile(pLinkFileName);
end;

end.
