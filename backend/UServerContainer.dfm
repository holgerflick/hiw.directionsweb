object ServerContainer: TServerContainer
  Height = 135
  Width = 358
  object Dispatcher: TSparkleHttpSysDispatcher
    Active = True
    Left = 72
    Top = 16
  end
  object Server: TXDataServer
    BaseUrl = 'http://+:2001/directions'
    Dispatcher = Dispatcher
    EntitySetPermissions = <>
    SwaggerOptions.Enabled = True
    SwaggerUIOptions.Enabled = True
    SwaggerUIOptions.DisplayOperationId = True
    Left = 216
    Top = 16
  end
end
