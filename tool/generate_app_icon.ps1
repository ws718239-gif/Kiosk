Add-Type -AssemblyName System.Drawing

function New-RoundedRectanglePath([System.Drawing.RectangleF]$rect, [single]$radius) {
  $path = New-Object System.Drawing.Drawing2D.GraphicsPath
  $diameter = $radius * 2
  $path.AddArc($rect.X, $rect.Y, $diameter, $diameter, 180, 90)
  $path.AddArc($rect.Right - $diameter, $rect.Y, $diameter, $diameter, 270, 90)
  $path.AddArc($rect.Right - $diameter, $rect.Bottom - $diameter, $diameter, $diameter, 0, 90)
  $path.AddArc($rect.X, $rect.Bottom - $diameter, $diameter, $diameter, 90, 90)
  $path.CloseFigure()
  return $path
}

function Save-AppIcon([string]$path, [int]$size) {
  $bitmap = New-Object System.Drawing.Bitmap $size, $size
  $graphics = [System.Drawing.Graphics]::FromImage($bitmap)
  $graphics.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
  $graphics.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
  $graphics.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality

  $scale = $size / 1024.0
  $canvas = New-Object System.Drawing.RectangleF 0, 0, $size, $size
  $background = New-Object System.Drawing.Drawing2D.LinearGradientBrush(
    $canvas,
    [System.Drawing.Color]::FromArgb(255, 18, 94, 217),
    [System.Drawing.Color]::FromArgb(255, 77, 157, 255),
    45
  )
  $graphics.FillRectangle($background, $canvas)

  $shadow = New-RoundedRectanglePath ([System.Drawing.RectangleF]::new(196*$scale, 152*$scale, 632*$scale, 650*$scale)) (112*$scale)
  $shadowBrush = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(38, 0, 34, 94))
  $graphics.FillPath($shadowBrush, $shadow)

  $body = New-RoundedRectanglePath ([System.Drawing.RectangleF]::new(190*$scale, 136*$scale, 644*$scale, 650*$scale)) (112*$scale)
  $bodyBrush = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::White)
  $graphics.FillPath($bodyBrush, $body)

  $screen = New-RoundedRectanglePath ([System.Drawing.RectangleF]::new(250*$scale, 196*$scale, 524*$scale, 400*$scale)) (64*$scale)
  $screenBrush = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(255, 230, 240, 255))
  $graphics.FillPath($screenBrush, $screen)

  $headBrush = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(255, 18, 94, 217))
  $graphics.FillEllipse($headBrush, 448*$scale, 254*$scale, 128*$scale, 128*$scale)
  $torso = New-RoundedRectanglePath ([System.Drawing.RectangleF]::new(360*$scale, 414*$scale, 304*$scale, 108*$scale)) (54*$scale)
  $graphics.FillPath($headBrush, $torso)

  $standBrush = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(255, 18, 94, 217))
  $graphics.FillRectangle($standBrush, 466*$scale, 786*$scale, 92*$scale, 78*$scale)
  $base = New-RoundedRectanglePath ([System.Drawing.RectangleF]::new(344*$scale, 850*$scale, 336*$scale, 66*$scale)) (33*$scale)
  $graphics.FillPath($standBrush, $base)

  $graphics.Dispose()
  $background.Dispose(); $shadow.Dispose(); $shadowBrush.Dispose(); $body.Dispose(); $bodyBrush.Dispose()
  $screen.Dispose(); $screenBrush.Dispose(); $headBrush.Dispose(); $torso.Dispose(); $standBrush.Dispose(); $base.Dispose()
  $directory = Split-Path -Parent $path
  if (-not (Test-Path -LiteralPath $directory)) { New-Item -ItemType Directory -Path $directory -Force | Out-Null }
  $bitmap.Save($path, [System.Drawing.Imaging.ImageFormat]::Png)
  $bitmap.Dispose()
}

$root = Split-Path -Parent $PSScriptRoot
Save-AppIcon "$root\assets\branding\kiosk_app_icon.png" 1024

$androidSizes = @{ 'mipmap-mdpi'=48; 'mipmap-hdpi'=72; 'mipmap-xhdpi'=96; 'mipmap-xxhdpi'=144; 'mipmap-xxxhdpi'=192 }
foreach ($entry in $androidSizes.GetEnumerator()) {
  Save-AppIcon "$root\android\app\src\main\res\$($entry.Key)\ic_launcher.png" $entry.Value
}

$iosSizes = @{
  'Icon-App-20x20@1x.png'=20; 'Icon-App-20x20@2x.png'=40; 'Icon-App-20x20@3x.png'=60
  'Icon-App-29x29@1x.png'=29; 'Icon-App-29x29@2x.png'=58; 'Icon-App-29x29@3x.png'=87
  'Icon-App-40x40@1x.png'=40; 'Icon-App-40x40@2x.png'=80; 'Icon-App-40x40@3x.png'=120
  'Icon-App-60x60@2x.png'=120; 'Icon-App-60x60@3x.png'=180
  'Icon-App-76x76@1x.png'=76; 'Icon-App-76x76@2x.png'=152; 'Icon-App-83.5x83.5@2x.png'=167
  'Icon-App-1024x1024@1x.png'=1024
}
foreach ($entry in $iosSizes.GetEnumerator()) {
  Save-AppIcon "$root\ios\Runner\Assets.xcassets\AppIcon.appiconset\$($entry.Key)" $entry.Value
}

Save-AppIcon "$root\web\icons\Icon-192.png" 192
Save-AppIcon "$root\web\icons\Icon-512.png" 512
Save-AppIcon "$root\web\icons\Icon-maskable-192.png" 192
Save-AppIcon "$root\web\icons\Icon-maskable-512.png" 512
