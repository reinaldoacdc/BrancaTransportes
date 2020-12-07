object dmPrincipal: TdmPrincipal
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 447
  Width = 546
  object Fconnection: TFDConnection
    Params.Strings = (
      'Database=C:\System Erp\Dados\DADOS.FDB'
      'Password=masterkey'
      'Server=localhost'
      'User_Name=SYSDBA'
      'DriverID=FB')
    Left = 88
    Top = 56
  end
  object Fquery: TFDQuery
    Connection = Fconnection
    Left = 144
    Top = 56
  end
end
