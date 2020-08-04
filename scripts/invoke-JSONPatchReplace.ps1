function invoke-JSONPatchReplace{
        <#
.SYNOPSIS
apply JSON Patch operations replace to JSON

.DESCRIPTION
function will apply replace from JSON Patch to JSON

.PARAMETER path
(Required) JSON pointer as specified in RFC6901
https://tools.ietf.org/html/rfc6901

.PARAMETER value
(Required) the value to be added

.PARAMETER JSON
(Required) JSON document

.OUTPUTS
modified JSON document

.LINK
https://tools.ietf.org/html/rfc6902#section-4.1
    
    #>

    [cmdletbinding()]
    Param(
        [Parameter(Mandatory = $true)]
        [string]$path,
        [Parameter(Mandatory = $true)]
        $value,
        [Parameter(Mandatory = $true)]
        [ValidateScript({test-json $_})]
        [string]$JSON
    )
    #remove and then add
    try{
        $json=invoke-jsonPatchRemove -path $path -json $json
        $json=invoke-jsonPatchAdd -path $path -value $value -json $json
    }catch{
        return $null
    }
    return $json
}