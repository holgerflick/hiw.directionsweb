object ServiceManager: TServiceManager
  OnCreate = WebDataModuleCreate
  Height = 352
  Width = 447
  object Client: TWebHttpRequest
    Command = httpPOST
    Headers.Strings = (
      'Content-Type=application/json')
    ResponseType = rtJSON
    URL = 
      'https://beta1.flixengineering.com/DirectionsService/DrivingDirec' +
      'tions'
    Left = 56
    Top = 80
  end
end
