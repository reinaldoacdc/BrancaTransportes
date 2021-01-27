object DmMain: TDmMain
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 719
  Width = 948
  object FDConnection1: TFDConnection
    Params.Strings = (
      'DriverID=SQLite'
      'Database=C:\Projetos\BrancaTransportes\App\DADOS.db')
    Connected = True
    LoginPrompt = False
    Left = 88
    Top = 48
  end
  object FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink
    Left = 160
    Top = 48
  end
  object tbCarregamento: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select * from CADASTRO_CARREGAMENTO')
    Left = 88
    Top = 96
    object tbCarregamentoCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Origin = 'CODIGO'
      Required = True
    end
    object tbCarregamentoDATA_CARREGAMENTO: TDateField
      FieldName = 'DATA_CARREGAMENTO'
      Origin = 'DATA_CARREGAMENTO'
    end
    object tbCarregamentoLOCAL_CARREGAMENTO: TWideStringField
      FieldName = 'LOCAL_CARREGAMENTO'
      Origin = 'LOCAL_CARREGAMENTO'
      Size = 32767
    end
    object tbCarregamentoPESO_LIQ_CARGA: TBCDField
      FieldName = 'PESO_LIQ_CARGA'
      Origin = 'PESO_LIQ_CARGA'
      Precision = 8
      Size = 1
    end
    object tbCarregamentoFRETE_TONELADA: TBCDField
      FieldName = 'FRETE_TONELADA'
      Origin = 'FRETE_TONELADA'
      Precision = 8
      Size = 1
    end
    object tbCarregamentoTOTAL_FRETE: TBCDField
      FieldName = 'TOTAL_FRETE'
      Origin = 'TOTAL_FRETE'
      Precision = 8
      Size = 1
    end
    object tbCarregamentoKM_INICIO: TBCDField
      FieldName = 'KM_INICIO'
      Origin = 'KM_INICIO'
      Precision = 8
      Size = 1
    end
    object tbCarregamentoKM_CHEGADA: TBCDField
      FieldName = 'KM_CHEGADA'
      Origin = 'KM_CHEGADA'
      Precision = 8
      Size = 1
    end
    object tbCarregamentoTOTAL_KM_RODADOS: TBCDField
      FieldName = 'TOTAL_KM_RODADOS'
      Origin = 'TOTAL_KM_RODADOS'
      Precision = 8
      Size = 1
    end
    object tbCarregamentoPRODUTO_CARREGADO: TWideStringField
      FieldName = 'PRODUTO_CARREGADO'
      Origin = 'PRODUTO_CARREGADO'
      Size = 32767
    end
    object tbCarregamentoSINCRONIZZADO: TStringField
      FieldName = 'SINCRONIZZADO'
      Origin = 'SINCRONIZZADO'
      Size = 1
    end
  end
  object FDQuery1: TFDQuery
    Connection = FDConnection1
    Left = 240
    Top = 48
  end
  object qrCarregamento: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select * from CADASTRO_CARREGAMENTO'
      'where CODIGO = :CODIGO')
    Left = 192
    Top = 96
    ParamData = <
      item
        Name = 'CODIGO'
        ParamType = ptInput
      end>
    object qrCarregamentoCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Origin = 'CODIGO'
      Required = True
    end
    object qrCarregamentoDATA_CARREGAMENTO: TDateField
      FieldName = 'DATA_CARREGAMENTO'
      Origin = 'DATA_CARREGAMENTO'
    end
    object qrCarregamentoLOCAL_CARREGAMENTO: TWideStringField
      FieldName = 'LOCAL_CARREGAMENTO'
      Origin = 'LOCAL_CARREGAMENTO'
      Size = 32767
    end
    object qrCarregamentoPESO_LIQ_CARGA: TBCDField
      FieldName = 'PESO_LIQ_CARGA'
      Origin = 'PESO_LIQ_CARGA'
      Precision = 8
      Size = 1
    end
    object qrCarregamentoFRETE_TONELADA: TBCDField
      FieldName = 'FRETE_TONELADA'
      Origin = 'FRETE_TONELADA'
      Precision = 8
      Size = 1
    end
    object qrCarregamentoTOTAL_FRETE: TBCDField
      FieldName = 'TOTAL_FRETE'
      Origin = 'TOTAL_FRETE'
      Precision = 8
      Size = 1
    end
    object qrCarregamentoKM_INICIO: TBCDField
      FieldName = 'KM_INICIO'
      Origin = 'KM_INICIO'
      Precision = 8
      Size = 1
    end
    object qrCarregamentoKM_CHEGADA: TBCDField
      FieldName = 'KM_CHEGADA'
      Origin = 'KM_CHEGADA'
      Precision = 8
      Size = 1
    end
    object qrCarregamentoTOTAL_KM_RODADOS: TBCDField
      FieldName = 'TOTAL_KM_RODADOS'
      Origin = 'TOTAL_KM_RODADOS'
      Precision = 8
      Size = 1
    end
    object qrCarregamentoPRODUTO_CARREGADO: TWideStringField
      FieldName = 'PRODUTO_CARREGADO'
      Origin = 'PRODUTO_CARREGADO'
      Size = 32767
    end
  end
  object tbDespesa: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select * from CADASTRO_DESPESAS')
    Left = 88
    Top = 144
    object tbDespesaCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Origin = 'CODIGO'
      Required = True
    end
    object tbDespesaDATA_ABASTECIMENTO: TDateField
      FieldName = 'DATA_ABASTECIMENTO'
      Origin = 'DATA_ABASTECIMENTO'
    end
    object tbDespesaKM_ULTIMO_ABASTECIMENTO: TBCDField
      FieldName = 'KM_ULTIMO_ABASTECIMENTO'
      Origin = 'KM_ULTIMO_ABASTECIMENTO'
      Precision = 15
      Size = 2
    end
    object tbDespesaKM_ABASTECIMENTO: TBCDField
      FieldName = 'KM_ABASTECIMENTO'
      Origin = 'KM_ABASTECIMENTO'
      Precision = 15
      Size = 2
    end
    object tbDespesaTOTAL_LITROS: TBCDField
      FieldName = 'TOTAL_LITROS'
      Origin = 'TOTAL_LITROS'
      Precision = 15
      Size = 2
    end
    object tbDespesaVALOR_LITROS: TBCDField
      FieldName = 'VALOR_LITROS'
      Origin = 'VALOR_LITROS'
      Precision = 15
      Size = 2
    end
    object tbDespesaVALOR_TOTAL: TBCDField
      FieldName = 'VALOR_TOTAL'
      Origin = 'VALOR_TOTAL'
      Precision = 15
      Size = 2
    end
    object tbDespesaKM_RODADOS: TBCDField
      FieldName = 'KM_RODADOS'
      Origin = 'KM_RODADOS'
      Precision = 15
      Size = 2
    end
    object tbDespesaMEDIA: TBCDField
      FieldName = 'MEDIA'
      Origin = 'MEDIA'
      Precision = 15
      Size = 2
    end
    object tbDespesaIMAGEM_COMPROVANTE: TBlobField
      FieldName = 'IMAGEM_COMPROVANTE'
      Origin = 'IMAGEM_COMPROVANTE'
    end
  end
  object tbDespesaExtra: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select * from CADASTRO_DESPESAS_EXTRAS')
    Left = 192
    Top = 144
    object tbDespesaExtraCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Origin = 'CODIGO'
      Required = True
    end
    object tbDespesaExtraFORNECEDOR: TStringField
      FieldName = 'FORNECEDOR'
      Origin = 'FORNECEDOR'
      Size = 80
    end
    object tbDespesaExtraVALOR: TBCDField
      FieldName = 'VALOR'
      Origin = 'VALOR'
      Precision = 15
      Size = 2
    end
    object tbDespesaExtraDESCRICAO_SERVICO: TStringField
      FieldName = 'DESCRICAO_SERVICO'
      Origin = 'DESCRICAO_SERVICO'
      Size = 150
    end
    object tbDespesaExtraLOCAL: TStringField
      FieldName = 'LOCAL'
      Origin = 'LOCAL'
      Size = 80
    end
    object tbDespesaExtraKM_MANUTENCAO: TBCDField
      FieldName = 'KM_MANUTENCAO'
      Origin = 'KM_MANUTENCAO'
      Precision = 15
      Size = 2
    end
    object tbDespesaExtraCIDADE_MANUTECAO: TStringField
      FieldName = 'CIDADE_MANUTECAO'
      Origin = 'CIDADE_MANUTECAO'
      Size = 80
    end
    object tbDespesaExtraIMAGEM_COMPROVANTE: TBlobField
      FieldName = 'IMAGEM_COMPROVANTE'
      Origin = 'IMAGEM_COMPROVANTE'
    end
  end
  object qrSincronismo: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select * from CADASTRO_CARREGAMENTO'
      'where SINCRONIZZADO = '#39'N'#39)
    Left = 88
    Top = 224
    object qrSincronismoSINCRONIZZADO: TStringField
      FieldName = 'SINCRONIZZADO'
      Origin = 'SINCRONIZZADO'
      Size = 1
    end
    object qrSincronismoCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Origin = 'CODIGO'
      Required = True
    end
  end
end
