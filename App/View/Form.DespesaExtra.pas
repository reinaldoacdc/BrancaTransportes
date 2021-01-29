unit Form.DespesaExtra;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Actions,
  FMX.ActnList, FMX.StdActns, FMX.MediaLibrary.Actions, System.ImageList, System.Permissions,
  FMX.ImgList, FMX.Objects, FMX.Layouts, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Edit, FMX.ListBox;

type
  TFormDespesaExtra = class(TForm)
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
    ListBoxItem2: TListBoxItem;
    SpeedButton3: TSpeedButton;
    Layout1: TLayout;
    SpeedButton1: TSpeedButton;
    Image1: TImage;
    ImageList1: TImageList;
    ActionList1: TActionList;
    TakePhotoFromCameraAction1: TTakePhotoFromCameraAction;
    procedure SpeedButton3Click(Sender: TObject);
    procedure TakePhotoFromCameraAction1DidFinishTaking(Image: TBitmap);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    PermissaoCamera, PermissaoReadStorage, PermissaoWriteStorage : string;
    procedure TakePicturePermissionRequestResult(
        Sender: TObject; const APermissions: TArray<string>;
        const AGrantResults: TArray<TPermissionStatus>);
    procedure DisplayMessageCamera(Sender: TObject;
                const APermissions: TArray<string>;
                const APostProc: TProc);
    procedure Salvar;
  public
    { Public declarations }
  end;

var
  FormDespesaExtra: TFormDespesaExtra;

implementation

{$R *.fmx}

uses BitmapHelper, Form.Main
   , FMX.DialogService
     {$IFDEF Android}
     , Androidapi.Helpers, Androidapi.JNI.JavaTypes, Androidapi.JNI.Os
     {$ENDIF}
, UdmMain;

{ TFormDespesaExtra }

procedure TFormDespesaExtra.DisplayMessageCamera(Sender: TObject;
  const APermissions: TArray<string>; const APostProc: TProc);
begin
  TDialogService.ShowMessage('O app precisa acessar a câmera e as fotos do seu dispositivo',
          procedure(const AResult: TModalResult)
          begin
                  APostProc;
          end);
end;

procedure TFormDespesaExtra.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
end;

procedure TFormDespesaExtra.Salvar;
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

  dmMain.tbDespesaExtra.Post;
  Self.Close;

end;

procedure TFormDespesaExtra.SpeedButton3Click(Sender: TObject);
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

procedure TFormDespesaExtra.TakePhotoFromCameraAction1DidFinishTaking(
  Image: TBitmap);
begin
  Image1.Bitmap.Assign(Image);
end;

procedure TFormDespesaExtra.TakePicturePermissionRequestResult(Sender: TObject;
  const APermissions: TArray<string>;
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
