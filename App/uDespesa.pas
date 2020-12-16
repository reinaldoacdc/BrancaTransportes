unit uDespesa;

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
    KM: TEdit;
    ItemLitros: TListBoxItem;
    TOTAL_LITROS: TEdit;
    ItemValor: TListBoxItem;
    infoEmail: TEdit;
    ItemData: TListBoxItem;
    DATA: TDateEdit;
    Layout1: TLayout;
    SpeedButton1: TSpeedButton;
    Layout3D1: TLayout3D;
    Layout2: TLayout;
    ListBox1: TListBox;
    ListBoxItem1: TListBoxItem;
    ULTIMO_KM: TEdit;
    ItemTotal: TListBoxItem;
    Edit1: TEdit;
    ListBoxItem2: TListBoxItem;
    SpeedButton2: TSpeedButton;
    ActionList1: TActionList;
    TakePhotoFromCameraAction1: TTakePhotoFromCameraAction;
    Image1: TImage;
    procedure TakePhotoFromCameraAction1DidFinishTaking(Image: TBitmap);
    procedure SpeedButton2Click(Sender: TObject);
  private
    PermissaoCamera, PermissaoReadStorage, PermissaoWriteStorage : string;
    procedure TakePicturePermissionRequestResult(
        Sender: TObject; const APermissions: TArray<string>;
        const AGrantResults: TArray<TPermissionStatus>);
    procedure DisplayMessageCamera(Sender: TObject;
                const APermissions: TArray<string>;
                const APostProc: TProc);
  public
    { Public declarations }
  end;

implementation

uses FMX.DialogService
     {$IFDEF Android}
     , Androidapi.Helpers, Androidapi.JNI.JavaTypes, Androidapi.JNI.Os
     {$ENDIF}
     ;

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
