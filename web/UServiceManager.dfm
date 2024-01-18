object ServiceManager: TServiceManager
  OnCreate = WebDataModuleCreate
  Height = 270
  Width = 393
  object Client: TWebHttpRequest
    Command = httpPOST
    Headers.Strings = (
      'Content-Type=application/json')
    ResponseType = rtJSON
    URL = 
      'https://beta1.flixengineering.com/DirectionsService/DrivingDirec' +
      'tions'
    Left = 64
    Top = 64
  end
end
