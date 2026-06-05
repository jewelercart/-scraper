Add-Type -AssemblyName System.Windows.Forms
$project='C:\Users\Admin\Downloads\pythonScripts\pythonScripts\house_price_app'
Set-Location $project
$proc = Start-Process -FilePath "$project\venv\Scripts\python.exe" -ArgumentList 'app.py' -WorkingDirectory $project -WindowStyle Hidden -PassThru
$uri='http://127.0.0.1:5000/'
Write-Host "Started PID $($proc.Id). Waiting for $uri ..."
while ($true) {
try { $r = Invoke-WebRequest -Uri $uri -UseBasicParsing -TimeoutSec 2 -ErrorAction Stop; if ($r.StatusCode -eq 200) { break } } catch {}
Start-Sleep -Seconds 1
}
[System.Media.SystemSounds]::Beep.Play()
[System.Windows.Forms.MessageBox]::Show("Server running at 
𝑢
𝑟
𝑖
‘
𝑛
𝑃
𝐼
𝐷
:
uri‘nPID:($proc.Id)","Server Ready")