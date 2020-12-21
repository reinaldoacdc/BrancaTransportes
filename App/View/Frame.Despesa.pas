unit Frame.Despesa;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.DateTimeCtrls, FMX.Controls.Presentation, FMX.Edit, FMX.ListBox,
  FMX.Layouts, System.Math.Vectors, FMX.Controls3D, FMX.Layers3D, FMX.Objects,
  System.Actions, FMX.ActnList, FMX.StdActns, FMX.MediaLibrary.Actions,
  System.Permissions;

type
  TFrameDespesas = class(TFrame)
    PersonalInfoList: TListBox;
    ItemKM: TListBoxItem;
    KM_ABASTECIMENTO: TEdit;
    ItemLitros: TListBoxItem;
    TOTAL_LITROS: TEdit;
    ItemValor: TListBoxItem;
    VALOR_LITROS: TEdit;
    ItemData: TListBoxItem;
    DATA: TDateEdit;
    Layout1: TLayout;
    SpeedButton1: TSpeedButton;
    Layout3D1: TLayout3D;
    Layout2: TLayout;
    ListBox1: TListBox;
    ListBoxItem1: TListBoxItem;
    KM_ULTIMO_ABASTECIMENTO: TEdit;
    ItemTotal: TListBoxItem;
    Edit1: TEdit;
    ListBoxItem2: TListBoxItem;
    SpeedButton2: TSpeedButton;
    ActionList1: TActionList;
    TakePhotoFromCameraAction1: TTakePhotoFromCameraAction;
    Image1: TImage;
    procedure TakePhotoFromCameraAction1DidFinishTaking(Image: TBitmap);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
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

implementation

uses Model.Entity.CADASTRO_DESPESAS
   , FMX.DialogService
     {$IFDEF Android}
     , Androidapi.Helpers, Androidapi.JNI.JavaTypes, Androidapi.JNI.Os
     {$ENDIF}
     , Form.Main, Frame.Menu;

{$R *.fmx}

procedure TFrameDespesas.DisplayMessageCamera(Sender: TObject;
  const APermissions: TArray<string>; const APostProc: TProc);
begin
  TDialogService.ShowMessage('O app precisa acessar a câmera e as fotos do seu dispositivo',
          procedure(const AResult: TModalResult)
          begin
                  APostProc;
          end);
end;

procedure TFrameDespesas.Salvar;
//var
//  despesa :TCADASTRO_DESPESAS;
begin
//  despesa := TCADASTRO_DESPESAS.Create;
//  despesa.DATA_ABASTECIMENTO :=  StrToDate( DATA.Text );
//  DESPESA.KM_ABASTECIMENTO := StrToFloat( KM_ABASTECIMENTO.Text );
//  despesa.TOTAL_LITROS := StrToFloat(TOTAL_LITROS.Text);
//  DESPESA.VALOR_LITROS := strToFloat(VALOR_LITROS.Text);
//  //DESPESA.IMAGEM_COMPROVANTE :=
end;

procedure TFrameDespesas.SpeedButton1Click(Sender: TObject);
begin
  Salvar;
  FormMain.LoadFrame<TFrameMenu>;
end;

procedure TFrameDespesas.SpeedButton2Click(Sender: TObject);
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

procedure TFrameDespesas.TakePhotoFromCameraAction1DidFinishTaking(
  Image: TBitmap);
begin
  Image1.Bitmap.Assign(Image);
end;

procedure TFrameDespesas.TakePicturePermissionRequestResult(Sender: TObject;
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
