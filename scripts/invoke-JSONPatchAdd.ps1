function invoke-JSONPatchAdd{
        <#
.SYNOPSIS
apply JSON Patch operations add to JSON

.DESCRIPTION
function will apply add from JSON Patch to JSON

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
    if ($value -is [array]){$array=$true}else{$array=$false}
    if ($path.length -gt 0){
        $decodedpath=$path.Replace('~0','~').replace('~1','/')
        $splitpath=$decodedpath.Split('/')
        $varpath=''
        $i=0
        foreach ($pathpart in $splitpath[1..($splitpath.count-1)]){
            if ($pathpart){
                $varpath+=$pathpart
                $currentvalue=Invoke-Expression -Command "`$json.$varpath"
                if ($i+2 -lt $splitpath.count){
                    if ($currentvalue -eq $null) {
                        Write-Error -Exception "path does not exist"
                        return $null                       
                    }
                    $varpath+='.'
                }else{ #end of path
                    if ($currentvalue -eq $null){                       
                        if ($varpath.Substring(0,$partpath.length).length -eq 0){
                            $varpath=$varpath.Substring(0,1)
                            Invoke-Expression "`$json | add-member -notepropertyname $pathpart -notepropertyvalue `$value"
                        }else{
                            Invoke-Expression "`$json.$($varpath.Substring(0,$partpath.length)) | add-member -notepropertyname $pathpart -notepropertyvalue `$value"
                        }                        
                    }else{
                        if ($array){
                            Invoke-Expression "`$json.$varpath+=`$value"
                        }else{
                            Invoke-Expression "`$json.$varpath+=`$value"
                        }
                    }
                }
            }            
            $i++
        }
        return $json
    }

}