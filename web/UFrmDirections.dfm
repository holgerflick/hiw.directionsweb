object FrmDirections: TFrmDirections
  Width = 873
  Height = 588
  Caption = 'Get directions'
  CSSLibrary = cssBootstrap
  ElementFont = efCSS
  OnCreate = WebFormCreate
  object divMap: TWebHTMLDiv
    Left = 8
    Top = 104
    Width = 857
    Height = 400
    ElementID = 'divMap'
    WidthStyle = ssPercent
    ElementPosition = epIgnore
    ElementFont = efCSS
    Role = ''
    object Map: TTMSFNCMaps
      Left = 0
      Top = 0
      Width = 857
      Height = 400
      Align = alClient
      ParentDoubleBuffered = False
      DoubleBuffered = True
      TabOrder = 0
      Polylines = <>
      Polygons = <>
      Circles = <>
      Rectangles = <>
      Markers = <>
      ElementContainers = <>
      Labels = <>
      HeadLinks = <>
      Options.DefaultZoomLevel = 12.000000000000000000
      Service = msOpenLayers
    end
  end
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
end
