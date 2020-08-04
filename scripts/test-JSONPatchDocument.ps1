function test-JSONPatchDocument($patchjson){
    #flaw in test-json means this won't work
    #https://github.com/PowerShell/PowerShell/issues/9560
    #https://github.com/RicoSuter/NJsonSchema/issues/588
    $schemaResponse=Invoke-webrequest -Method get -Uri http://json.schemastore.org/json-patch
    $schema=$schemaResponse.content
    try{
        $result=Test-Json -Json $patchjson -Schema $schema
    }
    catch{
        $result=$false
    }
    return $result
}