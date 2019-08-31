unit U_Test;

interface

uses
    Windows, ComCtrls, SysUtils, Dialogs, Classes, Forms,
    fEnterPassword, F_Picture, F_SoundVideo, F_Browser, ShellApi;

type
{******************************************************************************}
{*******************************���� ������************************************}
{******************************************************************************}
  TActionForm = (ADD, EDIT, CANCEL, SELECT);

  TOrder = (ORD_123N, ORD_RANDOM);
  TMode = (HARD, SOFT);
  TParam = (ENABLE, MODE, ORDER_QUESTIONS, ORDER_ANSWER, PTIME, PURPOSE, INSTRUCTION, DEVELOPER, PROCENT);
  TResult = array [1..8] of real;
  TInfoDeveloper = record
    Name, Organization, WWW, EMail,
    Telephone, Achievement, MiscInfo : string;
  end;

  TLinks = array of string;

  TAnswerSelect = record
    Text : string;
    Correct : boolean;
    sLinks : TLinks;
  end;

  TAnswerUpDown = record
    Text : string;
    Position : integer;
    sLinks : TLinks;
  end;

  TAnswerText = record
    Text : string;
  end;

  TAnswerLink = record
    Text, Text2 : string;
    sLinks, sLinks2 : TLinks;
  end;

  TAnswers = record
    aswSelect : array of TAnswerSelect;
    aswUpDown : array of TAnswerUpDown;
    aswText : TAnswerText;
    aswLink : array of TAnswerLink;
  end;

  TParametrs = record
    Enable : boolean;
    Mode : TMode;
    Result : TResult;
    OrderQuestion, OrderAnswer : TOrder;
    Time : integer;
    InfoDeveloper : TInfoDeveloper;
    Purpose, Instruction : string;
  end;

  TTypeQuestion = (tqSELECT_ONE_SEVERAL, tqUP_DOWN, tqTEXT, tqLINK);

  TQuestion = record
    tpQuestion : TTypeQuestion;
    sQuestion : string;
    sLinkQuestion : TLinks;
    sComment : string;
    Weight : real;
    Ebable : boolean;

    //���� ������
    Answer : TAnswers;
  end;

  TArrayQuestions = array of TQuestion;

  TTopic = record
    Name : string;
    Parametrs : TParametrs;
    Question : TArrayQuestions;
  end;

  TArrayTopics = array of TTopic;

  TTypeOpen = (tfPICTURE, tfSOUND, tfVIDEO, tfBROWSER, tfWINDOWS);

  TTypeFiles = record
    Files : string;
    TypeFiles : TTypeOpen;
  end;

  TArrayTypeFiles = array of TTypeFiles;

{******************************************************************************}
{****************************�������� �������**********************************}
{******************************************************************************}
  TPassword = class
    private
      fPass : string;
      bCheck : boolean;
      procedure GetPass (var TempContainer : TStringList);
    public
      function CheckPass (UserPass : string) : boolean;
      procedure IdentificationForm (Form : TfmEnterPassword);
    published
      property Pass : string read fPass write fPass;
      property Check : boolean read bCheck write bCheck;
  end;

  TManagerLinks = class
    private
      procedure ReadTypeOpen (var List: TStringList; var aTypeOpen : TArrayTypeFiles);
    public
      constructor Create;
      procedure Save;

      //������ � ���������
      procedure GetListTypeFile (var List : TListView; var slLinkFiles : TStringList);
      procedure AddFilter (Name, Filter : string; var slLinkFiles : TStringList);
      procedure EditFilter (Name, Filter : string; Index : integer; var slLinkFiles : TStringList);
      procedure DeleteFilter (index : integer; var slLinkFiles : TStringList);

      //������� ��������
      procedure GetListTypeOpen (var List : TListView; var aTypeOpen : TArrayTypeFiles);
      function ExportTypeOpen (var aTypeOpen : TArrayTypeFiles) : TStringList;
      procedure ImportTypeOpen (var List : TStringList; var aTypeOpen : TArrayTypeFiles);
      
    published

  end;

  TDevelopers = class
    private
      faProfiles : array of TInfoDeveloper;
      fProfileFile : string;
    public
      constructor Create;
      function Add(Info : TInfoDeveloper): string;
      function Edit (Index : integer; Info: TInfoDeveloper): string;
      procedure Delete (Index : integer);
      procedure ProcessingFile;
      procedure GetList (List : TListView);
      procedure SaveProfiles;
      function LoadProfile (Index : integer) : TInfoDeveloper;
    published

  end;

  TLink = class
    private
      function GetTypeFile (FileName : string) : TTypeOpen;
    public
      function Add (var Link : TLinks; FileName : string) : boolean;
      procedure Delete (var Link : TLinks; Index : integer);
      procedure GetList (var Link : TLinks; var List : TListView);
      procedure OpenFile (FileName : string);
      
    published

  end;

  TAnswer = class
    private

    public

      function CheckAnswerSel (Answers : TAnswers; Answer : TAnswerSelect) : boolean;
      procedure InsertSel (var Answers : TAnswers; Answer : TAnswerSelect; index : integer);
      procedure AddSel (var Answers : TAnswers; Answer : TAnswerSelect);
      procedure DeleteSel (var Answers : TAnswers; index : integer);
      procedure GetListSel (Answers : array of TAnswerSelect; var List : TListView);
    published
  end;

  TQuestions = class
    private
      fLink : TLink;
      fAnswer : TAnswer;
      fTopics : TTopic;
    public
      constructor Create;
      function Add (IndexTopic : integer; var Question : TQuestion) : integer;
      procedure Delete (IndexTopic, IndexQuestion : integer);
      procedure Move (IndexTopicOut, IndexTopicIn, IndexQuestion: integer);

    published
      property Link : TLink read fLink write fLink;
      property Answer : TAnswer read fAnswer write fAnswer;
  end;


  TTopics = class
    private
      fQuestions : TQuestions;

      //�������������� ���������� � ������
      //function ConvertToStr (Param : TParam; var Parametrs : TParametrs) : TStringList;
      function FindParam (Param : TParam; var TempContainer : TStringList) : integer;

    public
      constructor Create;
      //������ � ������: ����������, ��������, ���������
      //procedure AddPrepare (iCount : integer);
      procedure Add (var AddTopic : TTopic);
      procedure Delete (Index : integer);
      procedure Rename (Index : integer; NewName : string);

      //������/������ ����������
      function ReadParametrs(var TempContainer : TStringList) : TParametrs;
      function ReadQuestions (var TempContainer : TStringList) : TArrayQuestions;
      //procedure WriteParam (TopicIndex : integer; Param : TParam; var Parametrs : TParametrs);

      //�����������
      procedure GetList (var List : TListView);
      function GetListQuestions (var List : TListView; index : integer) : integer;

    published
      property Questions : TQuestions read fQuestions write fQuestions;
      
  end;


  TTest = class
    private
      fTopics : TTopics;
      fDevelopers : TDevelopers;
      fManagerLinks : TManagerLinks;
      fPassword : TPassword;
      fSubject : string;
      fContainer : TStringList;

      //������� ���������� ��� ����������
      procedure DeleteOldLink (Dir : string);
      procedure MoveToSave (ShortFileName, SaveDir : string);
      function PrepareQuestions (var pQuestions : TArrayQuestions) : TStringList;
      function PrepareResult (var pParam : TParametrs) : TStringList;
      function PrepareDeveloper (var pParam : TParametrs) : TStringList;
      function GenerateParametr (sName, sValue : string) : TStringList;

      function PrepareSaveTopics (index : integer) : TStringList;


      procedure MoveToLoad (FromFile, WhereDir : string);
      procedure ClearTemps (Dir : string);
      procedure ProcessingContainer;

      //�����������/�������������
      procedure Code (var slList : TStringList);
      procedure Decode (var slList : TStringList);
    public


      //��������, ���������� � �������� ������ �����
      procedure Close (Form : TForm);
      procedure Open(FileName : string; Form : TForm);
      procedure Save (FileName : string);
      procedure New (Form : TForm);

      constructor Create  (Owner : TTest);
      destructor Destroy; override;

    published


      property Subject : string read fSubject write fSubject;
      property Topics : TTopics read fTopics write fTopics;
      property Developers : TDevelopers read fDevelopers write fDevelopers;
      property Password : TPassword read fPassword write fPassword;
      property ManagerLinks : TManagerLinks read fManagerLinks write fManagerLinks;
  end;

var
  //����������� �����
  bTestModified : boolean;

  //������ � ������
  aTopics : TArrayTopics;

  //������� ������ � ���� ��������
  sLinkFiles, sFileName : string;
  aTypeOpen : TArrayTypeFiles;
  slLinkFiles : TStringList;

implementation

var
  sTempDir, sShortFileName, sDataDir, sDirLinkSave : string;
  slFiles : TStringList; {������ ������������� ������, ������������ ��� ����������}



{ TTopics }


{*******************************���������� ����********************************}
procedure TTopics.Add(var AddTopic : TTopic);
var
  iCount : integer;
begin
  //�������������
  iCount:=length(aTopics);

  //����������
  SetLength(aTopics,iCount+1);
  aTopics[iCount]:=AddTopic;

  bTestModified:=true;  

end;

{***************************���������� ���� � ����������***********************
procedure TTopics.AddPrepare(iCount : integer);
var
   i, j : integer;
   sList : TStringList;
begin
     //������������� ���������
     SetLength(faTopics, iCount+1);

     //�������� �����������
     FATopics[iCount,0]:=TStringList.Create;
     FATopics[iCount,1]:=TStringList.Create;
     FATopics[iCount,2]:=TStringList.Create;

     //�����������
     sList:=TStringList.Create;
     sList.Clear;
     sList.Add('Mode');
     sList.Add('Order');
     sList.Add('Purpose');
     sList.Add('Instruction');
     sList.Add('OrderAnswer');
     sList.Add('Time');
     sList.Add('Enable');
     sList.Add('Developer');
     sList.Add('Procent');

     for i:=0 to sList.Count-1 do
     begin
          //����� ������������
          FATopics[iCount,2].Add('<Begin'+sList[i]+'>');
          case i of
                  5 : FATopics[iCount,2].Add('0');
                  7 : for j:=1 to i do FATopics[iCount,2].Add('');
                  8 : for j:=1 to i do FATopics[iCount,2].Add('0');
          else
              FATopics[iCount,2].Add('');
          end;
          FATopics[iCount,2].Add('<End'+sList[i]+'>');
     end;

     //�������� �������
     sList.Free;
end;}

{******************�������������� � ���������� ����****************************
function TTopics.ConvertToStr(Param : TParam;
         var Parametrs: TParametrs): TStringList;
var
   i : integer;
   sTemp : string;
begin
     //������������� ����������
     sTemp:='';
     ConvertToStr:=TStringList.Create;
     ConvertToStr.Clear;

     case Param of
          OrderQuestion :  if Parametrs.OrderQuestion=Ord123N
                              then ConvertToStr.Add('123')
                              else ConvertToStr.Add('random');

            OrderAnswer :  if Parametrs.OrderAnswer=Ord123N
                              then ConvertToStr.Add('123')
                              else ConvertToStr.Add('random');

                 Enable :  ConvertToStr.Add(BoolToStr(Parametrs.Enable));

                   Mode :  if Parametrs.Mode=HARD
                              then ConvertToStr.Add('hard')
                              else ConvertToStr.Add('soft');

                 PTime :  ConvertToStr.Add(IntToStr(Parametrs.Time));

                Purpose :  ConvertToStr.Add(Parametrs.Purpose);

            Instruction :  ConvertToStr.Add(Parametrs.Instruction);

                Procent :  begin
                                for i:=1 to 8 do
                                    ConvertToStr.Add(FloatToStr(Parametrs.Result[i]));
                           end;

              Developer :  begin
                                sTemp:='';
                                with Parametrs.Developer do
                                begin
                                     ConvertToStr.Add(Name);
                                     ConvertToStr.Add(Organization);
                                     ConvertToStr.Add(WWW);
                                     ConvertToStr.Add(EMail);
                                     ConvertToStr.Add(Telephone);
                                     ConvertToStr.Add(Achievement);
                                     ConvertToStr.Add(MiscInfo);
                                end;
                           end;
     end;
end;}


{****************************�������� ����*************************************}
procedure TTopics.Delete(Index: integer);
var
  i, iCount : integer;
begin
  //������������
  iCount:=length(aTopics);

  //�����������
  for i:=index to iCount-1 do
  begin
    if i+1=iCount then break;
      aTopics[i]:=aTopics[i+1];
  end;

  //��������� �������
  SetLength(aTopics,iCount-1);

  bTestModified:=true;
end;

{******************************����� ���������� ����***************************}
function TTopics.FindParam(Param : TParam; var TempContainer : TStringList) : integer;
var
	sParam : string;
begin
	case Param of
		ORDER_QUESTIONS : sParam:='<BeginOrderQuestions>';
		ORDER_ANSWER : sParam:='<BeginOrderAnswer>';
		ENABLE : sParam:='<BeginEnable>';
		PTIME : sParam:='<BeginTime>';
		PURPOSE : sParam:='<BeginPurpose>';
		INSTRUCTION : sParam:='<BeginInstruction>';
		DEVELOPER : sParam:='<BeginDeveloper>';
		PROCENT : sParam:='<BeginProcent>';
		MODE : sParam:='<BeginMode>';
	end;

    FindParam:=TempContainer.IndexOf(sParam)+1;
end;

{******************������ ���������� ��������� ����***************************}
function TTopics.ReadParametrs(var TempContainer : TStringList) : TParametrs;
var
   i, iFind : integer;
  Parametrs : TParametrs;
begin
	//��������� ����������
  iFind:=FindParam(ORDER_QUESTIONS, TempContainer);
  if TempContainer[iFind]='123'
	  then Parametrs.OrderQuestion:=ORD_123N
    else Parametrs.OrderQuestion:=ORD_RANDOM;


	iFind:=FindParam(ORDER_ANSWER, TempContainer);
  if TempContainer[iFind]='123'
    then Parametrs.OrderAnswer:=ORD_123N
    else Parametrs.OrderAnswer:=ORD_RANDOM;

	iFind:=FindParam(ENABLE, TempContainer);

  if TempContainer[iFind]='true'
    then Parametrs.Enable:=true
    else Parametrs.Enable:=false;

	iFind:=FindParam(MODE, TempContainer);
  if TempContainer[iFind]='hard'
    then Parametrs.Mode:=HARD
    else Parametrs.Mode:=SOFT;

	iFind:=FindParam(PTIME, TempContainer);
  Parametrs.Time:=StrToInt(TempContainer[iFind]);

  iFind:=FindParam(PURPOSE, TempContainer);
  Parametrs.Purpose:=TempContainer[iFind];

  iFind:=FindParam(INSTRUCTION, TempContainer);
  Parametrs.Instruction:=TempContainer[iFind];

  iFind:=FindParam(PROCENT, TempContainer);
  for i:=1 to 8 do
    Parametrs.Result[i]:=StrToFloat(TempContainer[iFind+i-1]);

  iFind:=FindParam(DEVELOPER, TempContainer);
  with Parametrs.InfoDeveloper do
  begin
    Name:=TempContainer[iFind];
    Organization:=TempContainer[iFind+1];
    WWW:=TempContainer[iFind+2];
    EMail:=TempContainer[iFind+3];
    Telephone:=TempContainer[iFind+4];
    Achievement:=TempContainer[iFind+5];
    MiscInfo:=TempContainer[iFind+6];
  end;

  //������� ��������
  ReadParametrs:=Parametrs;

end;

{************************�������������� ��������� ����*************************}
procedure TTopics.Rename(Index: integer; NewName: string);
begin
  aTopics[Index].Name:=NewName;
  bTestModified:=true;  
end;


{***************************������ ��� (TListView)*****************************}
procedure TTopics.GetList(var List: TListView);
var
  TempItem : TListItems;
         i : integer;
begin
     //������������� ����������
     with List.Items do
     begin
          BeginUpdate;
          Clear;
          EndUpdate;
     end;
     TempItem:=List.Items;

     //������������ �����
     for i:=0 to length(aTopics)-1 do
     begin
          TempItem.Add.Caption:=Trim(aTopics[i].Name);
     end;
end;

{****************************������ ���������� ����****************************}
{procedure TTopics.WriteParam(TopicIndex : integer;
   Param : TParam; var Parametrs : TParametrs);
var
   sParam : string;
   sResult : TStringList;
   iFind, i : integer;
begin
     //������������� ����������
     sResult:=TStringList.Create;;
     sResult.Clear;

     //�������������� � ������� ���
     case Param of
          OrderQuestion : sParam:='Order';
            OrderAnswer : sParam:='OrderAnswer';
                 Enable : sParam:='Enable';
                   Mode : sParam:='Mode';
                  PTime : sParam:='Time';
                Purpose : sParam:='Purpose';
            Instruction : sParam:='Instruction';
                Procent : sParam:='Procent';
              Developer : sParam:='Developer';
     end;

     //�������������� ���������
     sResult:=ConvertToStr(Param, Parametrs);

     //������ ���������
     iFind:=FATopics[TopicIndex,2].IndexOf('<Begin'+sParam+'>')+1;
     for i:=0 to sResult.Count-1 do
     begin
          FATopics[TopicIndex,2][iFind+i]:=sResult[i];
     end;

     //�������� �������
     sResult.Free;

end;}

{ TTest }

{*************************����������� ����������*******************************}
procedure TTest.Code(var slList: TStringList);
var
  i, j : integer;
  sCode, sText : string;
begin
  //������ �����������
  for i:=0 to slList.Count-1 do
  begin
    sText:=slList[i];
    sCode:='';
    for j:=1 to length(sText) do
    begin
      sCode:=sCode+' '+IntToStr(Ord(sText[j]));
    end;
    slList[i]:=sCode;
  end;
end;

{***********************������������� ����������*******************************}
procedure TTest.Decode(var slList: TStringList);
var
  i, j, n, iCount : integer;
  sText, sDecode, sNumb : string;
begin
  for i:=0 to slList.Count-1 do
  begin
    sText:=slList[i];
    sDecode:='';
    n:=1;
    iCount:=length(sText);
    for j:=1 to iCount do
    begin
      if (sText[j]=' ') or (j=iCount) then
      begin
        sNumb:=Trim(copy(sText,n,j-n+1));
        n:=j;
        if sNumb<>'' then sDecode:=sDecode+Chr(StrToInt(sNumb));
      end;
    end;
    slList[i]:=sDecode;
  end;

end;

{*************************������� ��������� �����******************************}
procedure TTest.ClearTemps(Dir: string);
var
  sFileNameNoExt : TStringList;
              SR : TSearchRec;
               i : integer;
begin
     //������������� ����������
     sFileNameNoExt:=TStringList.Create;
     sFileNameNoExt.Clear;

     //�������� ��������� �����
     if FindFirst(Dir+'\*.*',faAnyFile, SR) = 0 then
     begin
          sFileNameNoExt.Add(Dir+'\'+Copy(SR.Name,1,length(SR.Name)-4));
          DeleteFile(Dir+'\'+SR.Name);

          while FindNext(SR)=0 do
          begin
               sFileNameNoExt.Add(Dir+'\'+Copy(SR.Name,1,length(SR.Name)-4));
               DeleteFile(Dir+'\'+SR.Name);
          end;
     end;
     FindClose(SR);

     //�������� ������ �� ��������� �����
     for i:=0 to sFileNameNoExt.Count-1 do
     begin
          if FindFirst(sFileNameNoExt[i]+'_files\*.*',faAnyFile, SR) = 0 then
          begin
               DeleteFile(sFileNameNoExt[i]+'_Files\'+SR.Name);
               while FindNext(SR)=0 do
               begin
                    DeleteFile(sFileNameNoExt[i]+'_Files\'+SR.Name);
               end;
          end;
          FindClose(SR);

          //�������� �����
          RemoveDir(sFileNameNoExt[i]+'_Files');
     end;

     //�������� ��������
     sFileNameNoExt.Free;
end;

{******************************���������� ������*******************************}
constructor TTest.Create;
begin
  //������������� ����������
  bTestModified:=false;

  //��������� ����������
  sTempDir:=ExtractFilePath(Application.Exename)+'Temp';
  sDataDir:=ExtractFilePath(Application.Exename)+'Data';

  //�������� �������
  Developers:=TDevelopers.Create;
  ManagerLinks:=TManagerLinks.Create;
  Topics:=TTopics.Create;
  Password:=TPassword.Create;

  //�������� ��������
     

end;

{****************************�������� �����************************************}
procedure TTest.Close (Form : TForm);
begin
  Form.Caption:='�������� ������';
  Password.fPass:='';
  fSubject:='';

  SetLength(aTopics,0);

  bTestModified:=false;  

end;

{******************************���������� ������*******************************}
destructor TTest.Destroy;
begin
  inherited;

  Topics.Free;
  Developers.Free;

end;

{************************�������� ������ ������������**************************}
procedure TTest.DeleteOldLink(Dir: string);
var
  slDelete : TStringList;
  SR : TSearchRec;
  i : integer;
begin
  slDelete:=TStringList.Create;
  slDelete.Clear;

  //����� ���� ������
  if FindFirst(Dir+'\*.*',faAnyFile, SR) = 0 then
  begin
    slDelete.Add(SR.Name);
    while FindNext(SR)=0 do
    begin
      slDelete.Add(SR.Name);
    end;
  end;
  FindClose(SR);

  //��������
  for i:=0 to slDelete.Count-1 do
  begin
    if slFiles.IndexOf(slDelete[i])=-1 then
      DeleteFile(Dir+'\'+slDelete[i]);
  end;
  
end;

{**************************����������� ������������****************************}
procedure TTest.MoveToSave(ShortFileName, SaveDir: string);
var
  sFileOut, sFileIn : string;
begin
  //�������������
  sFileOut:=sTempDir+'\'+sShortFileName+'_files\'+ShortFileName;
  sFileIn:=SaveDir+'\'+ShortFileName;

  //�����������
  Windows.CopyFile(PChar(sFileOut),PChar(sFileIn),false);
  slFiles.Add(ShortFileName);
end;

{**************************���������� ��������*********************************}
function TTest.PrepareQuestions(
  var pQuestions: TArrayQuestions): TStringList;
var
  i, j, z : integer;
  sValue : string;
begin
  //�������������
  PrepareQuestions:=TStringList.Create;
  PrepareQuestions.Clear;

  //���������� ��������
  PrepareQuestions.Add('<BeginQuestions>');
  PrepareQuestions.Add(IntToStr(length(pQuestions)));

  for i:=0 to length(pQuestions)-1 do
  begin
    PrepareQuestions.Add('<BeginQuestion'+IntToStr(i+1)+'>');

    //���������� �������
    if pQuestions[i].Ebable=true then sValue:='true' else sValue:='false';
    PrepareQuestions.Add(sValue);

    //��� �������
    PrepareQuestions.Add(FloatToStr(pQuestions[i].Weight));

    {***************������ �� ����� ����������*************************}
    if pQuestions[i].tpQuestion=tqSELECT_ONE_SEVERAL then
    begin
      PrepareQuestions.Add('select');

      //������, �����������
      PrepareQuestions.Add(pQuestions[i].sQuestion);
      PrepareQuestions.Add(pQuestions[i].sComment);

      //���-�� ������� � ������������
      sValue:=IntToStr(length(pQuestions[i].Answer.aswSelect));
      PrepareQuestions.Add(sValue);
      PrepareQuestions.Add(IntToStr(length(pQuestions[i].sLinkQuestion)));

      //������ ������������
      for j:=0 to length(pQuestions[i].sLinkQuestion)-1 do
      begin
        PrepareQuestions.Add(pQuestions[i].sLinkQuestion[j]);
        MoveToSave(pQuestions[i].sLinkQuestion[j],sDirLinkSave);
      end;

      //������ ��������� ������
      for j:=0 to length(pQuestions[i].Answer.aswSelect)-1 do
      begin
        PrepareQuestions.Add('<BeginAnswer'+IntToStr(i+1)+IntToStr(j+1)+'>');

        //�����
        PrepareQuestions.Add(pQuestions[i].Answer.aswSelect[j].Text);

        //������������
        if pQuestions[i].Answer.aswSelect[j].Correct=false then sValue:='false' else sValue:='true';
        PrepareQuestions.Add(sValue);

        //���-�� ������������ � ���� ������������
        PrepareQuestions.Add(IntToStr(length(pQuestions[i].Answer.aswSelect[j].sLinks)));
        for z:=0 to length(pQuestions[i].Answer.aswSelect[j].sLinks)-1 do
        begin
          PrepareQuestions.Add(pQuestions[i].Answer.aswSelect[j].sLinks[z]);
          MoveToSave(pQuestions[i].Answer.aswSelect[j].sLinks[z],sDirLinkSave);
        end;

        PrepareQuestions.Add('<EndAnswer'+IntToStr(i+1)+IntToStr(j+1)+'>');
      end;
      
    end;
    PrepareQuestions.Add('<EndQuestion'+IntToStr(i+1)+'>');
    PrepareQuestions.Add('');    

  end;
  PrepareQuestions.Add('<EndQuestions>');
    
end;

{********************���������� ���������� �� �������**************************}
function TTest.PrepareResult(var pParam: TParametrs): TStringList;
var
  i : integer;
begin
  //�������������
  PrepareResult:=TStringList.Create;
  PrepareResult.Clear;

  //����������
  PrepareResult.Add('<BeginProcent>');
  for i:=1 to 8 do
    PrepareResult.Add(FloatToStr(pParam.Result[i]));
  PrepareResult.Add('<EndProcent>');
  PrepareResult.Add('');

end;

{********************���������� ���������� � ������������**********************}
function TTest.PrepareDeveloper(var pParam: TParametrs): TStringList;
begin
  PrepareDeveloper:=TStringList.Create;
  PrepareDeveloper.Clear;

  PrepareDeveloper.Add('<BeginDeveloper>');
  PrepareDeveloper.Add(pParam.InfoDeveloper.Name);
  PrepareDeveloper.Add(pParam.InfoDeveloper.Organization);
  PrepareDeveloper.Add(pParam.InfoDeveloper.WWW);
  PrepareDeveloper.Add(pParam.InfoDeveloper.EMail);
  PrepareDeveloper.Add(pParam.InfoDeveloper.Telephone);
  PrepareDeveloper.Add(pParam.InfoDeveloper.Achievement);
  PrepareDeveloper.Add(pParam.InfoDeveloper.MiscInfo);
  PrepareDeveloper.Add('<EndDeveloper>');
  PrepareDeveloper.Add('');

end;

{***************************������������� ����������***************************}
function TTest.GenerateParametr(sName, sValue: string): TStringList;
begin
  //�������������
  GenerateParametr:=TStringList.Create;
  GenerateParametr.Clear;

  //������������ ���������
  GenerateParametr.Add('<Begin'+sName+'>');
  GenerateParametr.Add(sValue);
  GenerateParametr.Add('<End'+sName+'>');
  GenerateParametr.Add('');
end;

{************************���������� ���� � ����������**************************}
function TTest.PrepareSaveTopics(index: integer): TStringList;
var
  sValue : string;
  pParam : TParametrs;
  qQuestions : TArrayQuestions;
begin
  //�������������
  pParam:=aTopics[index].Parametrs;
  qQuestions:=aTopics[index].Question;
  PrepareSaveTopics:=TStringList.Create;
  PrepareSaveTopics.Clear;

  PrepareSaveTopics.Add('<BeginTopic'+aTopics[index].Name+'>');

  //���������� ����
  if pParam.Enable=false then sValue:='false' else sValue:='true';
  PrepareSaveTopics.AddStrings(GenerateParametr('Enable',sValue));

  //����� ������������
  if pParam.Mode=hard then sValue:='hard' else sValue:='soft';
  PrepareSaveTopics.AddStrings(GenerateParametr('Mode',sValue));

  //������� ��������
  if pParam.OrderQuestion=ORD_123N then sValue:='123' else sValue:='random';
  PrepareSaveTopics.AddStrings(GenerateParametr('OrderQuestions',sValue));

  //����������
  PrepareSaveTopics.AddStrings(GenerateParametr('Purpose',pParam.Purpose));

  //����������
  PrepareSaveTopics.AddStrings(GenerateParametr('Instruction',pParam.Instruction));

  //������� �������
  if pParam.OrderAnswer=ORD_123N then sValue:='123' else sValue:='random';
  PrepareSaveTopics.AddStrings(GenerateParametr('OrderAnswer',sValue));

  //���������� � ������������
  PrepareSaveTopics.AddStrings(PrepareDeveloper(pParam));

  //����� ������
  PrepareSaveTopics.AddStrings(PrepareResult(pParam));

  //����������� �� �������
  PrepareSaveTopics.AddStrings(GenerateParametr('Time',IntToStr(pParam.Time)));

  //�������
  PrepareSaveTopics.AddStrings(PrepareQuestions(qQuestions));

  PrepareSaveTopics.Add('<EndTopic'+aTopics[index].Name+'>');
  PrepareSaveTopics.Add('');

end;


{*******************************����������� ������****************************}
{******************************������� �����������****************************}
{**********�� ������������ ����� �� ������������� � ����� �����***************}
procedure TTest.MoveToLoad(FromFile, WhereDir: string);
var
   ListFile : TStringList;
         SR : TSearchRec;
   ShortName,
   FromPath : string;
          i : integer;
begin
     //��� �����
     ShortName:=ExtractFileName(FromFile);
     ShortName:=Copy(ShortName,1,length(ShortName)-4);
     sShortFileName:=ShortName;

     FromPath:=ExtractFilePath(FromFile);

     //�������� ������ ������
     ListFile:=TStringList.Create;
     ListFile.Clear;

     //������������ ������ ������
     ListFile.Add(ShortName+'.tst');
     if FindFirst(FromPath+ShortName+'_files\*.*',faAnyFile, SR) = 0 then
     begin
          ListFile.Add(ShortName+'_files\'+SR.Name);
          while FindNext(SR)=0 do
          begin
               ListFile.Add(ShortName+'_files\'+SR.Name);
          end;
     end;
     FindClose(SR);

     //����������� ������
     CreateDir(WhereDir+'\'+ShortName+'_files');
     for i:=0 to ListFile.Count-1 do
     begin
          //�������� ������, �������� �� TRUE
          CopyFile(PChar(FromPath+ListFile[i]),PChar(WhereDir+'\'+ListFile[i]),false);
     end;

end;

procedure TTest.New (Form : TForm);
begin
  Subject:='����������';
  Form.Caption:='�������� ������ - '+Subject;
  sFileName:='';

  bTestModified:=false;  
end;

{*********************************�������� �����******************************}
procedure TTest.Open(FileName: string; Form : TForm);
var
   ShortFileName : string;
begin
  //������������� ����������
  ShortFileName:=ExtractFileName(FileName);
  fContainer:=TStringList.Create;
  fContainer.Clear;
  sFileName:=FileName;

  //������� ��������� ����������
  ClearTemps(sTempDir);

  //����������� ������ �� ��������� �����
  MoveToLoad(FileName, sTempDir);

  //�������� � ���������
  fContainer.LoadFromFile(sTempDir+'\'+ShortFileName);
  Decode(fContainer);

  //�������� ������
  fPassword.GetPass(fContainer);
  if fPassword.fPass<>'' then
  begin
    fPassword.IdentificationForm(fmEnterPassword);

    if fPassword.bCheck=false then
    begin
      fContainer.Free;
      ClearTemps(sTempDir);
      exit;
    end;
  end;

  //�������������� ��������� ���������� (������� � ����)
  ProcessingContainer;

  //������ ��������� (��������� �������� ���� � ...)
  Form.Caption:='�������� ������ - '+FSubject;

  //�������� ����������
  FContainer.Free;

  //��������� ��������
  bTestModified:=false;

end;

{*****************************��������� ����������****************************}
{******************************������� �����������****************************}
{*******************����������� ������������� ������ POS**********************}
procedure TTest.ProcessingContainer;
label Jump;
var
   i, j, z, count, next : integer;
   sFindBegin, sFindEnd : string;
   TopicContainer : TStringList;
begin
  //������������� ����������
  count:=0;
  TopicContainer:=TStringList.Create;
	TopicContainer.Clear;

  //��������� �������� �������� � ������ ������ ���
  for i:=0 to FContainer.Count-1 do
  begin
    //�������� �������a
    if FContainer[i]='<BeginSubject>' then FSubject:=FContainer[i+1];

    if FContainer[i]='<BeginTopics>' then
    begin
      for j:=i+1 to FContainer.Count-1 do
      begin
        //����� �� ����� �� ���������� ������ ���
        if FContainer[j]='<EndTopics>' then
        begin
          next:=j;
          break;
        end;

        //������ �������� ���
        count:=count+1;
        SetLength(aTopics,count);
        aTopics[count-1].Name:=Trim(FContainer[j]);
      end;
    end;
  end;

  //��������� ����� ���
  for i:=0 to length(aTopics)-1 do
  begin
    //����������� ����� ������ ���
    sFindBegin:='<BeginTopic'+Trim(aTopics[i].Name)+'>';
    sFindEnd:='<EndTopic'+Trim(aTopics[i].Name)+'>';

    for j:=next to FContainer.Count-1 do
    begin
      //����� ������ ����
      if FContainer[j]=sFindBegin then
      begin
        for z:=j+1 to FContainer.Count-1 do
        begin
          if FContainer[z]=sFindEnd then
          begin
            next:=z;
            goto Jump;
          end;

          TopicContainer.Add(FContainer[z]);
        end;
      end;
    end;

    Jump:
    //��������� ���������� � ������� ����������
    aTopics[i].Parametrs:=fTopics.ReadParametrs(TopicContainer);
    aTopics[i].Question:=fTopics.ReadQuestions(TopicContainer);


    TopicContainer.Clear;

  end;

	//�������� ���������� � ������
	TopicContainer.Free;

end;

procedure TTest.Save(FileName: string);
var
  slSave : TStringList;
  sShortName : string;
  i : integer;
begin
  //�������������
  slFiles:=TStringList.Create;
  slSave:=TStringList.Create;
  slSave.Clear;
  slFiles.Clear;  
  sShortName:=copy(ExtractFileName(FileName),1,length(ExtractFileName(FileName))-4);

  sDirLinkSave:=ExtractFilePath(FileName)+sShortName+'_files';

  //�������� �������� ������������
  CreateDir(sDirLinkSave);

  //������ ����������
  with slSave do
  begin
    //�������� ��������
    AddStrings(GenerateParametr('Subject',Subject));

    //������
    AddStrings(GenerateParametr('Password',Password.Pass));

    //������ ���
    Add('<BeginTopics>');
    for i:=0 to length(aTopics)-1 do
    begin
      Add(aTopics[i].Name);
    end;
    Add('<EndTopics>');
    Add('');

    //������ ���
    for i:=0 to length(aTopics)-1 do
    begin
      AddStrings(PrepareSaveTopics(i));
    end;

    //�����������
    Code(slSave);

    //������ �����
    slSave.SaveToFile(FileName);
    sFileName:=FileName;
  end;

  //�������� ������ ������������
  DeleteOldLink(sDirLinkSave);

  //��������� ��������
  bTestModified:=false;

  //��������
  slFiles.Free;
  slSave.Free;
end;

{ TDeveloper }
{************************��������� ������ �������������************************}
procedure TDevelopers.GetList(List: TListView);
var
  i : integer;
begin
     //�������
     List.Clear;

     //��������� ��� �������������
     for i:=0 to length(faProfiles)-1 do
     begin
          with List.Items.Add do
          begin
               Caption:=IntToStr(i+1);
               SubItems.Add(faProfiles[i].Name);
          end;
     end;
end;

procedure TDevelopers.SaveProfiles;
var
      i : integer;
  sTemp : TStringList;
begin
     //�������������
     sTemp:=TStringList.Create;
     sTemp.Clear;

     //������
     for i:=0 to length(faProfiles)-1 do
     begin
          with sTemp do
          begin
               Add('[InfoProfile]');
               Add(faProfiles[i].Name);
               Add(faProfiles[i].Organization);
               Add(faProfiles[i].WWW);
               Add(faProfiles[i].EMail);
               Add(faProfiles[i].Telephone);
               Add(faProfiles[i].Achievement);
               Add(faProfiles[i].MiscInfo);
          end;
     end;

     //���������� � �������� ����������
     sTemp.SaveToFile(FProfileFile);
     sTemp.Free;
end;

{***************************�������� �������***********************************}
function TDevelopers.LoadProfile(Index: integer): TInfoDeveloper;
begin
     LoadProfile:=faProfiles[Index];
end;

{***********************��������� ����� ��������*******************************}
procedure TDevelopers.ProcessingFile;
var
     sTemp : TStringList;
  i, Index : integer;
begin
     //������������� � ��������
     sTemp:=TStringList.Create;
     sTemp.Clear;
     sTemp.LoadFromFile(FProfileFile);
     index:=-1;
     i:=0;

     while i<=sTemp.Count-1 do
     begin
          if sTemp[i]='[InfoProfile]' then
          begin
               Inc(Index);
               SetLength(faProfiles,Index+1);
               with faProfiles[Index] do
               begin
                    Name:=sTemp[i+1];
                    Organization:=sTemp[i+2];
                    WWW:=sTemp[i+3];
                    EMail:=sTemp[i+4];
                    Telephone:=sTemp[i+5];
                    Achievement:=sTemp[i+6];
                    MiscInfo:=sTemp[i+7];
               end;
               i:=i+7;
          end;
          Inc(i);
     end;

     //�������� ����������
     sTemp.Free;
     
end;

{************************�������� ������ �������������*************************}
constructor TDevelopers.Create;
begin
     //�������������� ��� �����
     fProfileFile:=sDataDir+'\Profiles.dat';

     //��������� ����� � ���������
     ProcessingFile;
end;

{*****************************���������� �������*******************************}
function TDevelopers.Add(Info : TInfoDeveloper): string;
var
   iLength : integer;
begin
     //�������������
     iLength:=length(faProfiles);
     SetLength(faProfiles,iLength+1);

     faProfiles[iLength]:=Info;

     Add:=Info.Name;
end;

{***************************�������������� �������*****************************}
function TDevelopers.Edit(Index: integer; Info: TInfoDeveloper): string;
begin
     faProfiles[Index]:=Info;
     Edit:=Info.Name;
end;

{******************************�������� �������********************************}
procedure TDevelopers.Delete(Index: integer);
var
   i, iCount : integer;
begin
     //������������
     iCount:=length(faProfiles);

     //�����������
     for i:=index to iCount-1 do
     begin
          if i+1=iCount then break;
          faProfiles[i]:=faProfiles[i+1];
     end;

     //��������� �������
     SetLength(faProfiles,iCount-1);
end;

{***************************�������� ������************************************}
constructor TTopics.Create;
begin
     fQuestions:=TQuestions.Create;
end;

{ TPassword }
{**************************�������� ������*************************************}
function TPassword.CheckPass (UserPass : string) : boolean;
begin
  if UserPass<>fPass
    then CheckPass:=false
    else CheckPass:=true;
end;

{***************************��������� ������***********************************}
procedure TPassword.GetPass(var TempContainer: TStringList);
var
  i : integer;
begin
  //�������������
  i:=TempContainer.IndexOf('<BeginPassword>');
  //�������� ������
  fPass:=TempContainer[i+1];

  if fPass='' then bCheck:=true;

end;

{**********************����������� ����� ��������******************************}
procedure TPassword.IdentificationForm(Form: TfmEnterPassword);
begin
  //�������� �����
  Form:=TfmEnterPassword.Create(Application);
  Form.ShowModal;

  Form.Free;
end;

{ TQuestions }
{***************************������ ��������************************************}

{***************************������ ��������************************************}
function TTopics.ReadQuestions(
  var TempContainer: TStringList): TArrayQuestions;
var
  aQuestions : TArrayQuestions;
  iFind, iEnd,
     i, j, z : integer;
     sNumber : string;
  rCount : record
    iQuestions,
    iAnswer,
    iLink : integer;
  end;

begin
  //�������������
  iFind:=TempContainer.IndexOf('<BeginQuestions>');
  rCount.iQuestions:=StrToInt(TempContainer[iFind+1]);

  //��������� ��������
  SetLength(aQuestions,rCount.iQuestions);
  for i:=1 to rCount.iQuestions do
  begin
    sNumber:=IntToStr(i);
    iFind:=TempContainer.IndexOf('<BeginQuestion'+sNumber+'>');

    //����������� �������
    if TempContainer[iFind+1]='true'
      then aQuestions[i-1].Ebable:=true
      else aQuestions[i-1].Ebable:=false;

    //��� �������
    aQuestions[i-1].Weight:=StrToFloat(TempContainer[iFind+2]);

    //��� ������� (����� ����������)
    if TempContainer[iFind+3]='select' then
    begin
      aQuestions[i-1].tpQuestion:=tqSELECT_ONE_SEVERAL;
      //������
      aQuestions[i-1].sQuestion:=TempContainer[iFind+4];
      //�����������
      aQuestions[i-1].sComment:=TempContainer[iFind+5];
      //���-�� �������
      rCount.iAnswer:=StrToInt(TempContainer[iFind+6]);
      //���-�� ������������
      rCount.iLink:=StrToInt(TempContainer[iFind+7]);

      //������������ � �������
      SetLength(aQuestions[i-1].sLinkQuestion,rCount.iLink);
      for j:=1 to rCount.iLink do
        aQuestions[i-1].sLinkQuestion[j-1]:=(TempContainer[iFind+7+j]);

      //������
      SetLength(aQuestions[i-1].Answer.aswSelect,rCount.iAnswer);

      for j:=1 to rCount.iAnswer do
      begin
        iFind:=TempContainer.IndexOf('<BeginAnswer'+sNumber+IntToStr(j)+'>');
        aQuestions[i-1].Answer.aswSelect[j-1].Text:=TempContainer[iFind+1];

        if TempContainer[iFind+2]='true'
          then aQuestions[i-1].Answer.aswSelect[j-1].Correct:=true
          else aQuestions[i-1].Answer.aswSelect[j-1].Correct:=false;

        rCount.iLink:=StrToInt(TempContainer[iFind+3]);
        SetLength(aQuestions[i-1].Answer.aswSelect[j-1].sLinks,rCount.iLink);
        for z:=1 to rCount.iLink do
          aQuestions[i-1].Answer.aswSelect[j-1].sLinks[z-1]:=(TempContainer[iFind+3+z]);
      end;
    end;
  end;

  //������
  ReadQuestions:=aQuestions;

end;


{******************************������ �������� ����****************************}
function TTopics.GetListQuestions(var List: TListView; index: integer) : integer;
var
               i : integer;
        TempItem : TListItems;
  tqTypeQuestion : TTypeQuestion;
   sTypeQuestion : string;
begin
  //������������� ����������
  with List.Items do
  begin
    BeginUpdate;
    Clear;
    EndUpdate;
  end;
  TempItem:=List.Items;

  for i:=0 to length(aTopics[index].Question)-1 do
  begin
    TempItem.Add.Caption:=IntToStr(i+1);
    TempItem.Item[TempItem.Count-1].SubItems.Add(aTopics[index].Question[i].sQuestion);
    TempItem.Item[TempItem.Count-1].SubItems.Add(FloatToStr(aTopics[index].Question[i].Weight));

    tqTypeQuestion:=aTopics[index].Question[i].tpQuestion;
    case tqTypeQuestion of
      tqSELECT_ONE_SEVERAL : sTypeQuestion:='����� ����������';
      tqUP_DOWN : sTypeQuestion:='��������������';
      tqTEXT : sTypeQuestion:='���� ������';
      tqLINK : sTypeQuestion:='������������';
    end;

    TempItem.Item[TempItem.Count-1].SubItems.Add(sTypeQuestion);
    TempItem.Item[TempItem.Count-1].Checked:=aTopics[index].Question[i].Ebable;
  end;

  GetListQuestions:=length(aTopics[index].Question);

end;




{ TLink }

{****************************������������ �����********************************}
function TLink.Add(var Link : TLinks; FileName: string) : boolean;
var
  sCopyFileName : string;
      i, iCount : integer;
begin
  Add:=true;
  sCopyFileName:=sTempDir+'\'+sShortFileName+'_files'+'\'+ExtractFileName(FileName);

  for i:=0 to length(Link)-1 do
  begin
    if ExtractFileName(FileName)=Trim(Link[i]) then
    begin
      MessageDlg('��������� ���� ��� ����������...',mtInformation,[mbok],0);
      Add:=false;
      exit;
    end;
  end;

  iCount:=length(link);
  SetLength(link,iCount+1);
  Link[iCount]:=(ExtractFileName(sCopyFileName));
  CopyFile(PChar(FileName),PChar(sCopyFileName),true);

  bTestModified:=true;  
end;

{**************************�������� ������������*******************************}
procedure TLink.Delete(var Link : TLinks; Index: integer);
var
    k,  i, iCount : integer;
  tLink : TLinks;
begin
  //������������
  iCount:=length(Link);
  SetLength(tLink,iCount-1);
  k:=-1;

  for i:=0 to iCount-1 do
  begin
    if i<>index then
    begin
      k:=k+1;
      tLink[k]:=Link[i];
    end;
  end;

  Link:=tLink;

  bTestModified:=true;
end;

{***************************������ ������������********************************}
procedure TLink.GetList (var Link : TLinks; var List: TListView);
var
  TempItem : TListItems;
         i : integer;
begin
  //������������� ����������
  with List.Items do
  begin
    BeginUpdate;
    Clear;
    EndUpdate;
  end;
  TempItem:=List.Items;

  for i:=0 to length(Link)-1 do
  begin
    TempItem.Add.Caption:=Link[i];

  end;
end;

{************************������� �������� �����********************************}
function TLink.GetTypeFile(FileName: string): TTypeOpen;
var
  sExt : string;
     i : integer;
  bRes : boolean;
begin
  bRes:=false;
  sExt:=ExtractFileExt(FileName);
  for i:=0 to length(aTypeOpen)-1 do
  begin
    if pos(sExt,aTypeOpen[i].Files)<>0 then
    begin
      GetTypeFile:=aTypeOpen[i].TypeFiles;
      bRes:=true;
      break;
    end;
  end;

  if bRes=false then
    GetTypeFile:=tfWINDOWS;

end;

{***************************�������� �����*************************************}
procedure TLink.OpenFile(FileName: string);
var
  sFile : string;
  tfOpen : TTypeOpen;
begin
  tfOpen:=GetTypeFile(FileName);
  sFile:=sTempDir+'\'+sShortFileName+'_files\'+FileName;
  case tfOpen of
    tfPICTURE : begin
                  fmLinkPicture:=TfmLinkPicture.Create(application);
                  with fmLinkPicture do
                  begin
                    pLinkFileName:=sFile;
                    Caption:=FileName;
                    ShowModal;
                    Free;
                  end;
                end;

      tfVIDEO,
      tfSound : begin
                  fmLinkSoundVideo:=TfmLinkSoundVideo.Create(Application);
                  with fmLinkSoundVideo do
                  begin
                    pLinkFileName:=sFile;
                    Caption:=FileName;
                    ShowModal;
                    Free;
                  end;

                end;
    tfBROWSER : begin
                  fmLinkBrowser:=TfmLinkBrowser.Create(Application);
                  with fmLinkBrowser do
                  begin
                    pLinkFileName:=sFile;
                    Caption:=FileName;
                    ShowModal;
                    Free;
                  end;
                end;

    tfWINDOWS : begin
                  ShellExecute(Application.Handle,PChar('open'),PChar(FileName),nil,PChar(sTempDir+'\'+sShortFileName+'_files'),Sw_ShowNormal);
                end;
  end;
end;

{ TQuestions }

procedure TQuestions.Delete(IndexTopic, IndexQuestion: integer);
var
  i, iCount : integer;
begin
  //������������
  iCount:=length(aTopics[IndexTopic].Question);

  //�����������
  for i:=IndexQuestion to iCount-1 do
  begin
    if i+1=iCount then break;
    aTopics[IndexTopic].Question[i]:=aTopics[IndexTopic].Question[i+1];
  end;

  //��������� �������
  SetLength(aTopics[IndexTopic].Question,iCount-1);

  bTestModified:=true;  
end;

function TQuestions.Add(IndexTopic : integer; var Question: TQuestion): integer;
var
  i, iCount : integer;
begin
  //��������� ������� �������
  iCount:=length(aTopics[IndexTopic].Question);
  SetLength(aTopics[IndexTopic].Question,iCount+1);

  //���������� �������
  aTopics[IndexTopic].Question[iCount]:=Question;

  bTestModified:=true;  

end;

{******************************����������� �������*****************************}
procedure TQuestions.Move(IndexTopicOut, IndexTopicIn, IndexQuestion: integer);
var
  Question : TQuestion;
  iCountOut, iCountIn : integer;
begin
  Question:=aTopics[IndexTopicOut].Question[IndexQuestion];

  //�������
  Add(IndexTopicIn,Question);

  //��������
  Delete(IndexTopicOut,IndexQuestion);

  bTestModified:=true;
end;



constructor TQuestions.Create;
begin
  fLink:=TLink.Create;
  fAnswer:=TAnswer.Create;
end;



{ TAnswer }
{***************************������� �������� ������****************************}
procedure TAnswer.InsertSel(var Answers: TAnswers; Answer: TAnswerSelect;
  index: integer);
var
  iCount, i : integer;
  asMove : TAnswerSelect;
begin
  //������������ ���-�� ��������� ������
  iCount:=length(Answers.aswSelect);

  //�������� ������ �������
  SetLength(Answers.aswSelect,iCount+1);

  //����������� ������
  for i:=iCount-1 downto Index do
  begin
    asMove:=Answers.aswSelect[i];
    Answers.aswSelect[i+1]:=asMove;
  end;

  //�������
  Answers.aswSelect[index]:=Answer;

  bTestModified:=true;  

end;

procedure TAnswer.AddSel(var Answers: TAnswers; Answer: TAnswerSelect);
var
  iCount : integer;
begin
  iCount:=length(Answers.aswSelect);
  SetLength(Answers.aswSelect,iCount+1);
  Answers.aswSelect[iCount]:=Answer;

  bTestModified:=true;
end;

function TAnswer.CheckAnswerSel(Answers: TAnswers;
  Answer: TAnswerSelect): boolean;
var
  i : integer;
begin
  result:=true;
  for i:=0 to length(Answers.aswSelect)-1 do
  begin
    if (Answers.aswSelect[i].Text=Answer.Text) then
    begin
      result:=false;
      break;
    end;
  end;
end;

procedure TAnswer.DeleteSel(var Answers: TAnswers; index : integer);
var
  i, iCount : integer;
begin
  //������������
  iCount:=length(Answers.aswSelect);

  //�����������
  for i:=index to iCount-1 do
  begin
    if i+1=iCount then break;
    Answers.aswSelect[i]:=Answers.aswSelect[i+1];
  end;

  //��������� �������
  SetLength(Answers.aswSelect,iCount-1);

  bTestModified:=true;  
end;

procedure TAnswer.GetListSel(Answers: array of TAnswerSelect; var List: TListView);
var
  TempItem : TListItems;
         i : integer;
begin
  //������������� ����������
  with List.Items do
  begin
    BeginUpdate;
    Clear;
    EndUpdate;
  end;
  TempItem:=List.Items;

  for i:=0 to length(Answers)-1 do
  begin
    TempItem.Add.Caption:=Answers[i].Text;
    TempItem.Item[TempItem.Count-1].Checked:=Answers[i].Correct;
  end;
end;

 
{ TManagerLinks }
{****************************�������� �������**********************************}
procedure TManagerLinks.DeleteFilter(index: integer; var slLinkFiles : TStringList);
begin
  slLinkFiles.Delete(index);
end;

{******************************��������� �������*******************************}
procedure TManagerLinks.EditFilter(Name, Filter: string; Index: integer; var slLinkFiles : TStringList);
begin
  slLinkFiles[index]:=Name+'|'+Filter+'|';
end;

{******************************���������� �������******************************}
procedure TManagerLinks.AddFilter(Name, Filter: string; var slLinkFiles : TStringList);
begin
  slLinkFiles.Add(Name+'|'+Filter+'|');
end;

{*****************�������� �����, �������� ������ �� ������********************}
constructor TManagerLinks.Create;
var
          lTemp : TStringList;
           n, i : integer;
         tfTemp : TTypeOpen;
begin
  //������������� ����������
  lTemp:=TStringList.Create;
  slLinkFiles:=TStringList.Create;
  sLinkFiles:='';

  //����� ��� ������������
  slLinkFiles.LoadFromFile(sDataDir+'\LinkFiles.dat');
  for i:=0 to slLinkFiles.Count-1 do
    sLinkFiles:=sLinkFiles+slLinkFiles[i];

  //������������ ������ � ������ ��������
  lTemp.LoadFromFile(sDataDir+'\TypeOpen.dat');
  //������ ��������
  ReadTypeOpen (lTemp, aTypeOpen);
  lTemp.Free;
end;

{*********************������ ��������(���� ������)*****************************}
procedure TManagerLinks.GetListTypeFile(var List: TListView; var slLinkFiles : TStringList);
var
  sRecord, sName, sFilter : string;
  i, p : integer;
  liTemp : TListItem;
begin
  //������� ���� �������
  for i:=0 to slLinkFiles.Count-1 do
  begin
    //��������� ������
    sRecord:=slLinkFiles[i];
    p:=pos('|',sRecord);
    sName:=copy(sRecord,1,p-1);
    sFilter:=copy(sRecord,p+1,length(sRecord)-p-1);

    //���������� � TListView
    liTemp:=List.Items.Add;
    liTemp.Caption:=sName;
    liTemp.SubItems.Add(sFilter);
   end;
   
end;

{**************************������� ��������************************************}
procedure TManagerLinks.GetListTypeOpen (var List : TListView; var aTypeOpen : TArrayTypeFiles);
var
  i : integer;
  sType : string;
  liTemp : TListItem;
begin
  //������
  List.Items.BeginUpdate;
  List.Items.Clear;

  //������� ���� �������� �������
  for i:=0 to length(aTypeOpen)-1 do
  begin
    //������ ��������
    case aTypeOpen[i].TypeFiles of
      tfPicture : sType:='�������';
        tfVideo : sType:='�����';
        tfSound : sType:='�����';
      tfBrowser : sType:='�������';
      tfWindows : sType:='Windows';
    end;

    liTemp:=List.Items.Add;
    liTemp.Caption:=sType;

    //������� ������
    liTemp.SubItems.Add(aTypeOpen[i].Files);
  end;

  //�������� ���������� ���������
  List.Items.EndUpdate;
  
end;

{**************************������� �������� ��������***************************}
function TManagerLinks.ExportTypeOpen (var aTypeOpen : TArrayTypeFiles) : TStringList;
var
  i : integer;
  sType : string;
begin
  //�������� � �������
  ExportTypeOpen:=TStringList.Create;
  ExportTypeOpen.Clear;

  //������ ����������
  for i:=0 to length(aTypeOpen)-1 do
  begin
    //������������ ��������
    case aTypeOpen[i].TypeFiles of
      tfPicture : sType:='picture|';
        tfVideo : sType:='video|';
        tfSound : sType:='sound|';
      tfBrowser : sType:='browser|';
      tfWindows : sType:='windows|';
    end;
    sType:=sType+aTypeOpen[i].Files;

    //������
    ExportTypeOpen.Add(sType);
  end;

  

end;

{**********************������ �������� ��������********************************}
procedure TManagerLinks.ImportTypeOpen(var List: TStringList; var aTypeOpen : TArrayTypeFiles);
begin
  ReadTypeOpen(List, aTypeOpen);
end;

{***********************������ �������� ��������*******************************}
procedure TManagerLinks.ReadTypeOpen(var List: TStringList; var aTypeOpen : TArrayTypeFiles);
var
  i, n : integer;
  sType, sFiles : string;
  tfTemp : TTypeOpen;
begin
  for i:=0 to List.Count-1 do
  begin
    n:=pos('|',List[i]);
    sType:=copy(List[i],1,n-1);
    sFiles:=copy(List[i],n+1,length(List[i])-n);

    SetLength(aTypeOpen,i+1);
    if sType='picture' then  tfTemp:=tfPICTURE;
    if sType='sound' then  tfTemp:=tfSOUND;
    if sType='video' then  tfTemp:=tfVIDEO;
    if sType='browser' then  tfTemp:=tfBROWSER;
    if sType='windows' then  tfTemp:=tfWINDOWS;

    aTypeOpen[i].Files:=sFiles;
    aTypeOpen[i].TypeFiles:=tfTemp;
  end;
end;

{*************************���������� ���������*********************************}
procedure TManagerLinks.Save;
begin
  //���������� ��������
  slLinkFiles.SaveToFile(sDataDir+'\LinkFiles.dat');

  //���������� ������ ��������
  ExportTypeOpen(aTypeOpen).SaveToFile(sDataDir+'\TypeOpen.dat');
end;

end.
