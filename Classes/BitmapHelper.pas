unit BitmapHelper;

interface

uses FMX.Graphics;

type
   TBitmapHelper = class helper for TBitmap
     function ToBase64 :String;
   end;


implementation

uses System.Classes, System.SysUtils, System.NetEncoding;

{ TBitmapHelper }

function TBitmapHelper.ToBase64: String;
var
  Input: TBytesStream;
  Output: TStringStream;
  Encoding: TBase64Encoding;
begin
  Input := TBytesStream.Create;
  try
    Self.SaveToStream(Input);
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

end.
