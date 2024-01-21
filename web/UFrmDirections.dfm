object FrmDirections: TFrmDirections
  Width = 873
  Height = 588
  Caption = 'Get directions'
  CSSLibrary = cssBootstrap
  ElementFont = efCSS
  OnCreate = WebFormCreate
  object txtOrigin: TWebEdit
    Left = 24
    Top = 8
    Width = 121
    Height = 22
    ChildOrder = 1
    ElementClassName = 'form-control'
    ElementID = 'inputOrigin'
    ElementFont = efCSS
    HeightStyle = ssAuto
    HeightPercent = 100.000000000000000000
    WidthPercent = 100.000000000000000000
  end
  object txtDestination: TWebEdit
    Left = 24
    Top = 56
    Width = 121
    Height = 22
    ChildOrder = 1
    ElementClassName = 'form-control'
    ElementID = 'inputDestination'
    ElementFont = efCSS
    HeightStyle = ssAuto
    HeightPercent = 100.000000000000000000
    WidthPercent = 100.000000000000000000
  end
  object btnGetDirections: TWebButton
    Left = 216
    Top = 24
    Width = 96
    Height = 25
    ChildOrder = 3
    ElementID = 'btnGetDirections'
    ElementFont = efCSS
    HeightStyle = ssAuto
    HeightPercent = 100.000000000000000000
    WidthPercent = 100.000000000000000000
    OnClick = btnGetDirectionsClick
  end
  object divMap: TWebHTMLDiv
    Left = 24
    Top = 112
    Width = 841
    Height = 433
    ElementID = 'divMap'
    ChildOrder = 3
    ElementPosition = epIgnore
    ElementFont = efCSS
    Role = ''
    object Map: TWebLeafletMaps
      Left = 0
      Top = 0
      Width = 841
      Height = 433
      WidthStyle = ssPercent
      Align = alClient
      ElementPosition = epIgnore
      Options.DefaultLatitude = -34.397000000000000000
      Options.DefaultLongitude = 150.644000000000000000
      ExplicitHeight = 400
    end
  end
end
