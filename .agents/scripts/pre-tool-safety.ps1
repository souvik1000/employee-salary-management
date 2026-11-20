# Read input payload from stdin
try {
    $rawInput = [Console]::In.ReadToEnd()
    if ($rawInput) {
        $inputJson = $rawInput | ConvertFrom-Json
        $command = $inputJson.toolCall.args.CommandLine

        # Check for accidental destructive patterns
        if ($command -match "git reset --hard|git clean -fd|Remove-Item .* -Recurse -Force|drop database") {
            $response = @{
                decision = "force_ask"
                reason   = "Command contains a potentially destructive action. User confirmation required."
            }
        }
        else {
            $response = @{
                decision = "allow"
            }
        }
    }
    else {
        $response = @{ decision = "allow" }
    }
}
catch {
    $response = @{ decision = "allow" }
}

$response | ConvertTo-Json -Compress
