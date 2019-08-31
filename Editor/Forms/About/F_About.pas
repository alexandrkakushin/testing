unit F_About;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, ImgList;

type
  TfmAbout = class(TForm)
    Panel1: TPanel;
    ProgramIcon: TImage;
    ProductName: TLabel;
    Version: TLabel;
    OKButton: TButton;
    Year: TLabel;
    PhysMem: TLabel;
    FreeMem: TLabel;
    Design: TLabel;
    l_show_PhysMem: TLabel;
    l_show_FreeMem: TLabel;
    Timer1: TTimer;
    OZU: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmAbout: TfmAbout;

implementation


{$R *.dfm}

procedure TfmAbout.FormCreate(Sender: TObject);
var
  MS: TMemoryStatus;
begin
  GlobalMemoryStatus(MS);
  l_show_physmem.Caption:=FormatFloat('#,###"  байт"', MS.dwTotalPhys div 1024);
  l_show_freemem.Caption:=Formatfloat('#,###"  байт"',MS.dwAvailPhys div 1024);

  ProgramIcon.Picture.Icon:=Application.Icon;


end;

procedure TfmAbout.Timer1Timer(Sender: TObject);
var
  MS: TMemoryStatus;
begin
  GlobalMemoryStatus(MS);
  l_show_physmem.Caption:=FormatFloat('#,###"  байт"', MS.dwTotalPhys div 1024);
  l_show_freemem.Caption:=Formatfloat('#,###"  байт"',MS.dwAvailPhys div 1024);

end;

procedure TfmAbout.OKButtonClick(Sender: TObject);
begin
     fmAbout.Close;
end;

end.

