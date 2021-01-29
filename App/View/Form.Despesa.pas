unit Form.Despesa;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  System.Math.Vectors, System.ImageList, FMX.ImgList, System.Actions, System.Permissions,
  FMX.ActnList, FMX.StdActns, FMX.MediaLibrary.Actions, FMX.Objects,
  FMX.Controls3D, FMX.Layers3D, FMX.Layouts, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Edit, FMX.DateTimeCtrls, FMX.ListBox;

type
  TFormDespesa = class(TForm)
    PersonalInfoList: TListBox;
    ItemData: TListBoxItem;
    DATA: TDateEdit;
    ItemKM: TListBoxItem;
    KM_ABASTECIMENTO: TEdit;
    ItemLitros: TListBoxItem;
    TOTAL_LITROS: TEdit;
    ItemValor: TListBoxItem;
    VALOR_LITROS: TEdit;
    ListBoxItem2: TListBoxItem;
    SpeedButton2: TSpeedButton;
    Layout1: TLayout;
    SpeedButton1: TSpeedButton;
    Layout3D1: TLayout3D;
    Layout2: TLayout;
    ListBox1: TListBox;
    ListBoxItem1: TListBoxItem;
    KM_ULTIMO_ABASTECIMENTO: TEdit;
    ItemTotal: TListBoxItem;
    Edit1: TEdit;
    Image1: TImage;
    ActionList1: TActionList;
    TakePhotoFromCameraAction1: TTakePhotoFromCameraAction;
    ImageList1: TImageList;
    procedure SpeedButton2Click(Sender: TObject);
    procedure TakePhotoFromCameraAction1DidFinishTaking(Image: TBitmap);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    PermissaoCamera, PermissaoReadStorage, PermissaoWriteStorage : string;
    Fid: Integer;
    procedure TakePicturePermissionRequestResult(
        Sender: TObject; const APermissions: TArray<string>;
        const AGrantResults: TArray<TPermissionStatus>);
    procedure DisplayMessageCamera(Sender: TObject;
                const APermissions: TArray<string>;
                const APostProc: TProc);
    procedure Salvar;
  public
    { Public declarations }
  published
    property Id :Integer read Fid write Fid;
  end;

var
  FormDespesa: TFormDespesa;

implementation

uses BitmapHelper
   , Model.Entity.CADASTRO_DESPESAS
   , FMX.DialogService
     {$IFDEF Android}
     , Androidapi.Helpers, Androidapi.JNI.JavaTypes, Androidapi.JNI.Os
     {$ENDIF}
     , Form.Main, Controller.API, UdmMain;

{$R *.fmx}

{ TFormDespesa }

procedure TFormDespesa.DisplayMessageCamera(Sender: TObject;
  const APermissions: TArray<string>; const APostProc: TProc);
begin
  TDialogService.ShowMessage('O app precisa acessar a câmera e as fotos do seu dispositivo',
          procedure(const AResult: TModalResult)
          begin
                  APostProc;
          end);
end;

procedure TFormDespesa.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
end;

procedure TFormDespesa.Salvar;
begin
  if not(DmMain.tbDespesa.Active) then
    dmMain.tbDespesa.Open;

  dmMain.tbDespesa.Insert;
  dmMain.tbDespesaCODIGO.AsInteger := DmMain.Maximo('CADASTRO_DESPESAS')+1;
  dmMain.tbDespesaDATA_ABASTECIMENTO.AsDateTime := data.Date;
  dmmain.tbDespesaKM_ULTIMO_ABASTECIMENTO.AsFloat := StrToFloat(KM_ULTIMO_ABASTECIMENTO.text);
  dmMain.tbDespesaKM_ABASTECIMENTO.AsFloat := StrToFloat( KM_ABASTECIMENTO.Text );
  dmMain.tbDespesaTOTAL_LITROS.AsFloat := StrToFloat(TOTAL_LITROS.Text);
  dmMain.tbDespesaVALOR_LITROS.AsFloat := strToFloat(VALOR_LITROS.Text);
  dmmain.tbDespesaKM_RODADOS.AsFloat := StrToFloat( KM_ABASTECIMENTO.Text );
  dmMain.tbDespesaIMAGEM_COMPROVANTE.Value := BytesOf (Image1.Bitmap.ToBase64);
  dmMain.tbDespesa.Post;

  dmMain.FDConnection1.Commit;
  Self.Close;
end;

procedure TFormDespesa.SpeedButton1Click(Sender: TObject);
begin
  Salvar;
  Self.Close;
end;

procedure TFormDespesa.SpeedButton2Click(Sender: TObject);
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

procedure TFormDespesa.TakePhotoFromCameraAction1DidFinishTaking(
  Image: TBitmap);
begin
  Image1.Bitmap.Assign(Image);
end;

procedure TFormDespesa.TakePicturePermissionRequestResult(Sender: TObject;
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
