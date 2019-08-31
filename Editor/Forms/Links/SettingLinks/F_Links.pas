unit F_Links;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, ImgList, ToolWin, U_Test;

type
  TfmLinks = class(TForm)
    tsTypeFiles: TTabSheet;
    tsTypeOpen: TTabSheet;
    btnOK: TBitBtn;
    btnCancel: TBitBtn;
    pcLinks: TPageControl;
    lstTypeFiles: TListView;
    tbTypeFiles: TToolBar;
    Images: TImageList;
    tbAddType: TToolButton;
    tbDeleteType: TToolButton;
    tbEditType: TToolButton;
    lstTypeOpen: TListView;
    tbTypeOpen: TToolBar;
    tbExport: TToolButton;
    tbImport: TToolButton;
    ToolButton1: TToolButton;
    tbEdit: TToolButton;
    procedure btnCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tbAddTypeClick(Sender: TObject);
    procedure tbEditTypeClick(Sender: TObject);

    procedure EnableTypeFiles (bValue : boolean);
    procedure EnableTypeOpen (bValue : boolean);

    procedure tbDeleteTypeClick(Sender: TObject);
    procedure lstTypeFilesSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure lstTypeOpenSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure tbExportClick(Sender: TObject);
    procedure tbImportClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure tbEditClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    bCloseOK : boolean;
    pTypeOpen : TArrayTypeFiles;
    pslFilter : TStringList;
  end;

var
  fmLinks: TfmLinks;
  afLinks : TActionForm;

implementation

uses F_Main_form, F_AddEditFilter, F_EditTypeOpen;

{$R *.dfm}

procedure TfmLinks.btnCancelClick(Sender: TObject);
begin
  afLinks:=Cancel;
  close;
end;

procedure TfmLinks.EnableTypeFiles(bValue: boolean);
begin
  tbEditType.Enabled:=bValue;
  tbDeleteType.Enabled:=bValue;
end;

procedure TfmLinks.FormShow(Sender: TObject);
begin
  //������ �������� � �������� ��������
  Test.ManagerLinks.GetListTypeFile(lstTypeFiles, pslFilter);
  Test.ManagerLinks.GetListTypeOpen(lstTypeOpen, pTypeOpen);

  //���������� ����������
  if (lstTypeFiles.Items.Count=0) or (lstTypeFiles.Selected=nil)
    then EnableTypeFiles(false)
    else EnableTypeFiles(true);

  if lstTypeOpen.Selected=nil
    then EnableTypeOpen(false)
    else EnableTypeOpen(true);


end;

procedure TfmLinks.tbAddTypeClick(Sender: TObject);
var
  liAdd : TListItem;
begin
  //�������� �����
  fmAddEditFilter:=TfmAddEditFilter.Create(application);
  afAddEditFilter:=ADD;
  fmAddEditFilter.ShowModal;

  //���������� ����
  if afAddEditFilter=ADD then
  begin
    //����������
    with fmAddEditFilter.pFilter do
    begin
      Test.ManagerLinks.AddFilter(Name, Filter, pslFilter);

      //������������
      liAdd:=lstTypeFiles.Items.Add;
      liAdd.Caption:=Name;
      liAdd.SubItems.Add(Filter);
    end;
  end;

  //�������� �����
  fmAddEditFilter.Free;

end;

procedure TfmLinks.tbEditTypeClick(Sender: TObject);
var
  liEdit : TListItem;
begin
  //�������� �����
  fmAddEditFilter:=TfmAddEditFilter.Create(application);
  afAddEditFilter:=EDIT;

  //�������� ����������
  liEdit:=lstTypeFiles.Selected;
  with fmAddEditFilter.pFilter do
  begin
    Name:=liEdit.Caption;
    Filter:=liEdit.SubItems.Strings[0];
  end;

  fmAddEditFilter.ShowModal;

  //���������� ����
  if afAddEditFilter=EDIT then
  begin
    //����������
    with fmAddEditFilter.pFilter do
    begin
      Test.ManagerLinks.EditFilter(Name, Filter,liEdit.Index, pslFilter);

      //������������
      liEdit.Caption:=Name;
      liEdit.SubItems[0]:=Filter;
    end;
  end;

  //�������� �����
  fmAddEditFilter.Free;

end;

procedure TfmLinks.tbDeleteTypeClick(Sender: TObject);
var
  index : integer;
begin
  //�������������
  if MessageDlg('������� ��������� ������?',mtWarning,[mbYes, mbNo],0)=mrNo then Exit;

  //��������
  index:=lstTypeFiles.ItemIndex;
  Test.ManagerLinks.DeleteFilter(index, pslFilter);
  lstTypeFiles.Items.Delete(Index);

end;

procedure TfmLinks.lstTypeFilesSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
begin
  EnableTypeFiles (Selected);
end;

procedure TfmLinks.EnableTypeOpen(bValue: boolean);
begin
  tbEdit.Enabled:=bValue;
end;

procedure TfmLinks.lstTypeOpenSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
begin
  EnableTypeOpen(Selected);
end;

procedure TfmLinks.tbExportClick(Sender: TObject);
var
  dlgSave : TSaveDialog;
begin
  //�������� ������� ����������
  dlgSave:=TSaveDialog.Create(Self);
  dlgSave.Filter:='����� �������� (*.cfg)|*.cfg;';
  dlgSave.DefaultExt:='CFG';

  //�������� �������
  if dlgSave.Execute then
  begin
    //�������
    Test.ManagerLinks.ExportTypeOpen(pTypeOpen).SaveToFile(dlgSave.FileName);
    Test.ManagerLinks.ExportTypeOpen(pTypeOpen).Free;
  end;

  //��������
  dlgSave.Free;
end;

procedure TfmLinks.tbImportClick(Sender: TObject);
var
  dlgOpen : TOpenDialog;
  slOpen : TStringList;
begin
  //�������� ������� ����������
  dlgOpen:=TOpenDialog.Create(Self);
  dlgOpen.Filter:='����� �������� (*.cfg)|*.cfg;';
  dlgOpen.DefaultExt:='CFG';

  //�������� �������
  if dlgOpen.Execute then
  begin
    //������ � ���������� ����������
    if MessageDlg('������ �������� � ������ ������� ��������. ����������?!',mtInformation,[mbYes,mbNo],0)=mrNo then exit;
    slOpen:=TStringList.Create;
    slOpen.LoadFromFile(dlgOpen.FileName);
    Test.ManagerLinks.ImportTypeOpen(slOpen, pTypeOpen);
    Test.ManagerLinks.GetListTypeOpen(lstTypeOpen, pTypeOpen);
    
    slOpen.Free;
  end;

  //��������
  dlgOpen.Free;
end;

procedure TfmLinks.btnOKClick(Sender: TObject);
begin
  bCloseOK:=true;
  close;
end;

procedure TfmLinks.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if bCloseOK=false then afLinks:=Cancel;
end;

procedure TfmLinks.FormCreate(Sender: TObject);
begin
  //�������������
  bCloseOK:=false;
  pslFilter:=TStringList.Create;
  
end;

procedure TfmLinks.tbEditClick(Sender: TObject);
var
  liEdit : TListItem;
begin
  //�������� �����
  fmEditTypeOpen:=TfmEditTypeOpen.Create(Application);
  afEditTypeOpen:=EDIT;
  liEdit:=lstTypeOpen.Selected;
  fmEditTypeOpen.psTypeOpen:=liEdit.Caption;
  fmEditTypeOpen.pFiles:=liEdit.SubItems.Strings[0];
  fmEditTypeOpen.ShowModal;

  //���������
  if afEditTypeOpen=Edit then
  begin
    liEdit.SubItems.Strings[0]:=fmEditTypeOpen.pFiles;
  end;

  //�������� �����
  fmEditTypeOpen.Free;

end;

end.
