object FrmDirections: TFrmDirections
  Width = 873
  Height = 620
  Caption = 'Get directions'
  CSSLibrary = cssBootstrap
  ElementFont = efCSS
  object divMap: TWebHTMLDiv
    Left = 8
    Top = 104
    Width = 857
    Height = 400
    ElementID = 'divMap'
    HeightStyle = ssPercent
    WidthStyle = ssPercent
    ElementPosition = epIgnore
    ElementFont = efCSS
    Role = ''
    object Maps: TTMSFNCLeaflet
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
      Options.DefaultLatitude = 40.689247000000000000
      Options.DefaultLongitude = -74.044501999999990000
      Options.DefaultZoomLevel = 12.000000000000000000
      Options.AttributionPrefix = '<a href='#39'https://www.leafletjs.com'#39' target='#39'_blank'#39'>Leaflet</a>'
      Options.AttributionText = 
        '&copy; <a href='#39'https://www.openstreetmap.org/copyright'#39' target=' +
        #39'_blank'#39'>OpenStreetMap</a>'
      LocalFileAccess = True
      TileLayers = <>
      ElementContainers = <>
      HeadLinks = <>
      DesigntimeEnabled = False
      ExplicitLeft = 280
      ExplicitTop = 152
      ExplicitWidth = 500
      ExplicitHeight = 350
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
end
