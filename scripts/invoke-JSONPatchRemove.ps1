function invoke-JSONPatchRemove{
        <#
.SYNOPSIS
apply JSON Patch operations remove to JSON

.DESCRIPTION
function will apply remove from JSON Patch to JSON

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
    if ($value -is [array]){$array=$true}else{$array=$false}
    if ($path.length -gt 0){
        $decodedpath=$path.Replace('~0','~').replace('~1','/')
        $json.PSObject.properties.remove($decodedpath.Replace('/','.').Substring(1))        
        return $json
    }
}