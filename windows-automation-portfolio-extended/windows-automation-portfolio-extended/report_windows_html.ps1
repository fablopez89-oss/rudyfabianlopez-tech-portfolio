$cpu = (Get-Counter '\Processor(_Total)\% Processor Time').CounterSamples.CookedValue
$ram = (Get-Counter '\Memory\Available MBytes').CounterSamples.CookedValue
$disk = Get-WmiObject Win32_LogicalDisk -Filter "DriveType=3"

$html = @"
<html><body>
<h2>Reporte de Estado del Servidor</h2>
<p>CPU: $cpu %</p>
<p>RAM Libre: $ram MB</p>
<h3>Discos</h3>
<table border='1'>
<tr><th>Unidad</th><th>Tamaño</th><th>Libre</th></tr>
"@

foreach ($d in $disk) {
    $html += "<tr><td>$($d.DeviceID)</td><td>$([math]::Round($d.Size/1GB,2)) GB</td><td>$([math]::Round($d.FreeSpace/1GB,2)) GB</td></tr>"
}

$html += "</table></body></html>"

$html | Out-File ".\server_report.html"
