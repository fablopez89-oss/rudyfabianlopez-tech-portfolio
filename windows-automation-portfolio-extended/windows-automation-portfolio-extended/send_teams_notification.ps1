param([string]$Message)

$WebhookUrl = Get-Content ".\teams_webhook_url.txt"

$payload = @{
    text = $Message
} | ConvertTo-Json

Invoke-RestMethod -Uri $WebhookUrl -Method Post -Body $payload -ContentType "application/json"
