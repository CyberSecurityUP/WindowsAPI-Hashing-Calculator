function Calculate-ApiHash {
    param (
        [string]$apiName
    )
    
    $hash = 0x35

    $apiName.ToCharArray() | ForEach-Object {
        $l = $_
        $c = [int64][char]$l
        
        $hash = (($hash * 0xab10f29f) + $c -band 0xFFFFFF)
    }

    return $hash
}

function Check-HashCollision {
    param (
        [hashtable]$hashTable, 
        [string]$apiName,      
        [int64]$hash           
    )

    if ($hashTable.ContainsKey($hash)) {
        $existingApi = $hashTable[$hash]
        if ($existingApi -ne $apiName) {
            Write-Host "Colisão de hash detectada! API '$apiName' e API '$existingApi' compartilham o mesmo hash: 0x$([string]::Format("{0:X}", $hash))" -ForegroundColor Red
        }
    } else {
        $hashTable[$hash] = $apiName
    }
}

$APIsToHash = @("CreateThread", "VirtualAlloc", "LoadLibraryA", "CreateFileA", "CreateThread")

# Hashtable para armazenar os hashes e detectar colisões
$hashes = @{}

$APIsToHash | ForEach-Object {
    $api = $_
    
    $hash = Calculate-ApiHash -apiName $api
    
    $hashHex = '0x{0:X}' -f $hash
    Write-Host "API: $api, Hash: $hashHex"
    
    Check-HashCollision -hashTable $hashes -apiName $api -hash $hash
}
