function invoke-JSONPatchCopy{
        <#
.SYNOPSIS
apply JSON Patch operations copy to JSON

.DESCRIPTION
function will apply copy from JSON Patch to JSON

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
        [string]$JSON
    )
    if ($path.length -gt 0)
    $decodedpath=$path.Replace('~0','~').replace('~1','/')
    $splitpath=$decodedpath.Split('/')
    

}