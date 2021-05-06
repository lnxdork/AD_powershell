function ConvertTo-Base64Url {

	[CmdletBinding()]
	param (
		[Parameter (Mandatory=$true, ValueFromPipeline=$true, ValueFromPipelinebyPropertyName=$true)]
		[byte[]] $inputBytes
	)

	BEGIN
	{
		$workingBytes = {@()}.Invoke()
	}
	
	PROCESS
	{ 
		if($_ -is [System.Array]) { $workingBytes = $_ } else { $workingBytes.Add($_) }
	}
	
	END
	{
		$outputString = [System.Convert]::ToBase64String($workingBytes)
		$outputString = $outputString.Replace('+', '-');
		$outputString = $outputString.Replace('/', '_');
		$outputString = $outputString.TrimEnd('=');
		
		Write-Output $outputString
	}
}

function ConvertFrom-Base64Url {

	[CmdletBinding()]
	param (
		[Parameter (Mandatory=$true, ValueFromPipeline=$true, ValueFromPipelinebyPropertyName=$true)]
		[string] $inputString
	)

	$inputString = $inputString.Replace('-', '+');
	$inputString = $inputString.Replace('_', '/');
	$inputString = $inputString.PadRight($inputString.Length + (4 - $inputString.Length % 4) % 4, '=');

	$outputBytes = [System.Convert]::FromBase64String($inputString);

	Write-Output $outputBytes
}

Export-ModuleMember -Function ConvertTo-Base64Url
Export-ModuleMember -Function ConvertFrom-Base64Url