unit F_SoundVideo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ImgList, MPlayer, ExtCtrls, StdCtrls;

type

  TfmLinkSoundVideo = class(TForm)
    ImagesPlayer: TImageList;
    tbPlayer: TToolBar;
    tbtnPlay: TToolButton;
    tbtnPause: TToolButton;
    tbtnStop: TToolButton;
    mpSound: TMediaPlayer;
    tmrSound: TTimer;
    trkSound: TScrollBar;
    lblPosTime: TLabel;
    ToolButton2: TToolButton;
    procedure btnPlayerClick (Sender : TObject);
    procedure FormShow(Sender: TObject);
    procedure tmrSoundTimer(Sender: TObject);
    procedure trkSoundExit(Sender: TObject);
    procedure trkSoundScroll(Sender: TObject; ScrollCode: TScrollCode;
      var ScrollPos: Integer);

    function IntToTime (iValue : integer) : TTime;

  private
    { Private declarations }
  public
    { Public declarations }
    pLinkFileName : string;
    iMin, iMax, iPos : integer;
    bChange : boolean;
  end;

var
  fmLinkSoundVideo: TfmLinkSoundVideo;
  ActionMedia : (amPlay, amPause, amStop);



implementation

{$R *.dfm}

procedure TfmLinkSoundVideo.btnPlayerClick(Sender: TObject);
begin
  case (Sender as TToolButton).Tag of
    1 : mpSound.Play;
    2 : mpSound.Pause;
    3 : begin
          mpSound.Stop;
          mpSound.Position:=0;
        end;
  end;


end;

procedure TfmLinkSoundVideo.FormShow(Sender: TObject);
begin
  mpSound.FileName:=pLinkFileName;
  mpSound.Open;
  mpSound.TimeFormat:=tfMilliseconds;

  iMin:=0;
  iPos:=0;
  iMax:=mpSound.Length;
  trkSound.Max:=iMax;

  mpSound.Play;
  bChange:=false;

end;

function TfmLinkSoundVideo.IntToTime(iValue: integer): TTime;
var
  MSec, Sec, Min, Hour : Word;
begin
  Sec:=iValue div 1000;
  MSec:=iValue-(Sec*1000);
  Min:=Sec div 60;
  Sec:=Sec-(Min*60);
  Hour:=min div 60;
  Min:=Min-(Hour*60);

  IntToTime:=EncodeTime(Hour,Min,Sec,MSec);

end;

procedure TfmLinkSoundVideo.tmrSoundTimer(Sender: TObject);
begin
  //Текущий режим
  case mpSound.Mode of
    mpStopped : begin
                  iPos:=0;
                end;
    mpPlaying : begin
                  iPos:=mpSound.Position;
                end;
    mpSeeking : begin
                  iPos:=trkSound.Position;
                end;
  end;

  if bChange=false then
  begin
    trkSound.Position:=iPos;
    lblPosTime.Caption:=TimeToStr(IntToTime(iPos));    
  end;

end;

procedure TfmLinkSoundVideo.trkSoundExit(Sender: TObject);
begin
  ShowMessage('');
end;

procedure TfmLinkSoundVideo.trkSoundScroll(Sender: TObject;
  ScrollCode: TScrollCode; var ScrollPos: Integer);
begin
  bChange:=true;
  iPos:=ScrollPos;
  lblPosTime.Caption:=TimeToStr(IntToTime(iPos));  

  case ScrollCode of
    scEndScroll : begin
                    bChange:=false;
                    mpSound.Position:=iPos;
                    mpSound.Play;
                  end;
    scLineUp : ScrollPos:=ScrollPos-1000;
    scLineDown : ScrollPos:=ScrollPos+1000;
  end;

end;

end.
