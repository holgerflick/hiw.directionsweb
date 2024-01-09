object ServerContainer: TServerContainer
  Height = 135
  Width = 358
  object Dispatcher: TSparkleHttpSysDispatcher
    Left = 72
    Top = 16
  end
  object Server: TXDataServer
    BaseUrl = 'http://+:2001/'
    Dispatcher = Dispatcher
    EntitySetPermissions = <>
    SwaggerOptions.Enabled = True
    SwaggerUIOptions.Enabled = True
    SwaggerUIOptions.DisplayOperationId = True
    Left = 216
    Top = 16
    object ServerCORS: TSparkleCorsMiddleware
    end
    object ServerForward: TSparkleForwardMiddleware
      OnAcceptProxy = ServerForwardAcceptProxy
      OnAcceptHost = ServerForwardAcceptHost
    end
  end
end
