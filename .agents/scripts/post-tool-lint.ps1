try {
    $rawInput = [Console]::In.ReadToEnd()
    if ($rawInput) {
        $inputJson = $rawInput | ConvertFrom-Json
        $filePath = $inputJson.toolCall.args.Path
        # Optional: could run prettier/linter if needed
    }
}
catch {}

# PostToolUse expects an empty JSON object
Write-Output "{}"
