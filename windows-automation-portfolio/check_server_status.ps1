param([string]$Server="localhost")

if (Test-Connection $Server -Count 2 -Quiet) {
    Write-Output "Servidor accesible: $Server"
} else {
    Write-Output "Servidor NO responde: $Server"
}
