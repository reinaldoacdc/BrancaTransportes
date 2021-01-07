unit Frame.DespesaExtra;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Edit, FMX.ListBox, FMX.Layouts,
  System.Permissions, System.ImageList, FMX.ImgList, FMX.Objects,
  System.Actions, FMX.ActnList, FMX.StdActns, FMX.MediaLibrary.Actions;

type
  TFrameDespesasExtras = class(TFrame)
    ListBox: TListBox;
    itemFornecedor: TListBoxItem;
    FORNECEDOR: TEdit;
    itemValor: TListBoxItem;
    VALOR: TEdit;
    itemServico: TListBoxItem;
    SERVICO: TEdit;
    itemLocal: TListBoxItem;
    LOCAL: TEdit;
    itemKM: TListBoxItem;
    KM: TEdit;
    itemCidade: TListBoxItem;
    CIDADE: TEdit;
    Layout1: TLayout;
    SpeedButton1: TSpeedButton;
    ImageList1: TImageList;
    ListBoxItem2: TListBoxItem;
    SpeedButton3: TSpeedButton;
    Image1: TImage;
    ActionList1: TActionList;
    TakePhotoFromCameraAction1: TTakePhotoFromCameraAction;
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
  private
    PermissaoCamera, PermissaoReadStorage, PermissaoWriteStorage : string;
    procedure TakePicturePermissionRequestResult(
        Sender: TObject; const APermissions: TArray<string>;
        const AGrantResults: TArray<TPermissionStatus>);
    procedure DisplayMessageCamera(Sender: TObject;
                const APermissions: TArray<string>;
                const APostProc: TProc);
  public
    procedure Salvar;
  end;

implementation

{$R *.fmx}

uses BitmapHelper, Form.Main, Frame.Menu
   , FMX.DialogService
     {$IFDEF Android}
     , Androidapi.Helpers, Androidapi.JNI.JavaTypes, Androidapi.JNI.Os
     {$ENDIF}
, UdmMain;

procedure TFrameDespesasExtras.DisplayMessageCamera(Sender: TObject;
  const APermissions: TArray<string>; const APostProc: TProc);
begin
  TDialogService.ShowMessage('O app precisa acessar a câmera e as fotos do seu dispositivo',
          procedure(const AResult: TModalResult)
          begin
                  APostProc;
          end);
end;

procedure TFrameDespesasExtras.Salvar;
begin
  if not(dmMain.tbDespesaExtra.Active) then
    dmMain.tbDespesaExtra.Open;


  dmMain.tbDespesaExtra.Insert;
  dmMain.tbDespesaExtraCODIGO.AsInteger    := dmMain.Maximo('CADASTRO_DESPESAS_EXTRAS')+1;
  dmMain.tbDespesaExtraFORNECEDOR.AsString := FORNECEDOR.Text;
  dmMain.tbDespesaExtraVALOR.AsFloat       := StrToFloat(VALOR.Text);
  dmMain.tbDespesaExtraDESCRICAO_SERVICO.AsString := SERVICO.Text;
  dmMain.tbDespesaExtraLOCAL.AsString := LOCAL.Text;
  dmMain.tbDespesaExtraKM_MANUTENCAO.AsFloat := StrToFloat(KM.Text);
  dmMain.tbDespesaExtraCIDADE_MANUTECAO.AsString := CIDADE.Text;
  dmMain.tbDespesaExtraIMAGEM_COMPROVANTE.AsBytes := BytesOf(Image1.Bitmap.ToBase64);
end;

procedure TFrameDespesasExtras.SpeedButton1Click(Sender: TObject);
begin
  Salvar;
  FormMain.LoadFrame<TFrameMenu>;
end;

procedure TFrameDespesasExtras.SpeedButton3Click(Sender: TObject);
begin
  {$IFDEF Android}
  PermissaoCamera := JStringToString(TJManifest_permission.JavaClass.CAMERA);
  PermissaoReadStorage := JStringToString(TJManifest_permission.JavaClass.READ_EXTERNAL_STORAGE);
  PermissaoWriteStorage := JStringToString(TJManifest_permission.JavaClass.WRITE_EXTERNAL_STORAGE);

  PermissionsService.RequestPermissions([PermissaoCamera,
                                         PermissaoReadStorage,
                                         PermissaoWriteStorage],
                                         TakePicturePermissionRequestResult,
                                         DisplayMessageCamera
                                         );
  {$ENDIF}
end;

procedure TFrameDespesasExtras.TakePicturePermissionRequestResult(
  Sender: TObject; const APermissions: TArray<string>;
  const AGrantResults: TArray<TPermissionStatus>);
begin
  // 3 Permissoes: CAMERA, READ_EXTERNAL_STORAGE e WRITE_EXTERNAL_STORAGE
  if (Length(AGrantResults) = 3) and
     (AGrantResults[0] = TPermissionStatus.Granted) and
     (AGrantResults[1] = TPermissionStatus.Granted) and
     (AGrantResults[2] = TPermissionStatus.Granted) then
          TakePhotoFromCameraAction1.Execute
  else
          TDialogService.ShowMessage('Você não tem permissão para tirar fotos');

end;

end.
