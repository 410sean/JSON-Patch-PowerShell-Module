function join-JSONPatchDocumenttoJSON{
    <#
.SYNOPSIS
apply JSON Patch operations to JSON

.DESCRIPTION
function will apply add, remove, replace, move, copy, test
from JSON Patch to JSON

.PARAMETER JSONPatch
(Required) JSON Patch Document

.PARAMETER JSON
(Required) JSON document
    
    #>

    [cmdletbinding()]
    Param(
        [Parameter(Mandatory = $true)]
        #[ValidateScript({test-json $_})]
        [string]$JSONPatch,
        [Parameter(Mandatory = $true)]
        [ValidateScript({test-json $_})]
        [string]$JSON
    )
    $JsonPatchPSO=ConvertFrom-Json $JSONPatch -Depth 10
    $jsonPSO=$json | ConvertFrom-Json -Depth 10
    foreach ($op in $JsonPatchPSO){
        switch($op.op){
            'add'{
                $params=@{
                    JSON=$jsonPSO
                    path=$op.Path
                    value=$op.value
                }
                $jsonPSO=invoke-JSONPatchAdd @params
            }
            'remove'{
                $params=@{
                    JSON=$jsonPSO
                    path=$op.Path
                }
                $jsonPSO=invoke-JSONPatchRemove @params
            }
            'replace'{
                $params=@{
                    JSON=$jsonPSO
                    path=$op.Path
                    value=$op.value
                }
                $jsonPSO=invoke-JSONPatchReplace @params
            }
            'move'{
                $params=@{
                    JSON=$jsonPSO
                    path=$op.Path
                    from=$op.from
                }
                $jsonPSO=invoke-JSONPatchMove @params
            }
            'copy'{
                $params=@{
                    JSON=$jsonPSO
                    path=$op.Path
                    from=$op.from
                }
                $jsonPSO=invoke-JSONPatchCopy @params
            }
            'test'{
                $params=@{
                    JSON=$jsonPSO
                    path=$op.Path
                    value=$op.value
                }
                $jsonPSO=invoke-JSONPatchTest @params
            }
        }
    }
    return $jsonPSO | convertto-json -Depth 10
}