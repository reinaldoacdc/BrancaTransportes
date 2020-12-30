unit Frame.Despesa;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.DateTimeCtrls, FMX.Controls.Presentation, FMX.Edit, FMX.ListBox,
  FMX.Layouts, System.Math.Vectors, FMX.Controls3D, FMX.Layers3D, FMX.Objects,
  System.Actions, FMX.ActnList, FMX.StdActns, FMX.MediaLibrary.Actions,
  System.Permissions, System.ImageList, FMX.ImgList;

type
  TByteArr = array of byte;

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
    ImageList1: TImageList;
    procedure TakePhotoFromCameraAction1DidFinishTaking(Image: TBitmap);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    PermissaoCamera, PermissaoReadStorage, PermissaoWriteStorage : string;
    Fid: Integer;

    function Base64FromBitmap(Bitmap: TBitmap): string;
    function StrToByte(const Value: String): TByteArr;

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

uses System.NetEncoding
   , Model.Entity.CADASTRO_DESPESAS
   , FMX.DialogService
     {$IFDEF Android}
     , Androidapi.Helpers, Androidapi.JNI.JavaTypes, Androidapi.JNI.Os
     {$ENDIF}
     , Form.Main, Frame.Menu, Controller.API, UdmMain;

{$R *.fmx}

function TFrameDespesas.Base64FromBitmap(Bitmap: TBitmap): string;
var
  Input: TBytesStream;
  Output: TStringStream;
  Encoding: TBase64Encoding;
begin
        Input := TBytesStream.Create;
        try
                Bitmap.SaveToStream(Input);
                Input.Position := 0;
                Output := TStringStream.Create('', TEncoding.ASCII);

                try
                    Encoding := TBase64Encoding.Create(0);
                    Encoding.Encode(Input, Output);
                    Result := Output.DataString;
                finally
                        Encoding.Free;
                        Output.Free;
                end;

        finally
                Input.Free;
        end;

end;

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
var
  despesa :TCADASTRO_DESPESAS;
  MemStream: TMemoryStream;
begin
//  despesa := TCADASTRO_DESPESAS.Create;
//  despesa.DATA_ABASTECIMENTO :=  StrToDate( DATA.Text );
//  DESPESA.KM_ABASTECIMENTO := StrToFloat( KM_ABASTECIMENTO.Text );
//  despesa.TOTAL_LITROS := StrToFloat(TOTAL_LITROS.Text);
//  DESPESA.VALOR_LITROS := strToFloat(VALOR_LITROS.Text);
//  //DESPESA.IMAGEM_COMPROVANTE := Base64FromBitmap( Image1.Bitmap );
//  objAPI.postDespesa(despesa);


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
  dmMain.tbDespesaIMAGEM_COMPROVANTE.Value := BytesOf ( Base64FromBitmap( Image1.Bitmap ) );
  dmMain.tbDespesa.Post;

  dmMain.FDConnection1.Commit;


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

function TFrameDespesas.StrToByte(const Value: String): TByteArr;
var

    I: integer;

begin

    SetLength(Result, Length(Value));

    for I := 0 to Length(Value) - 1 do

        Result[I] := ord(Value[I + 1]) - 48;

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
