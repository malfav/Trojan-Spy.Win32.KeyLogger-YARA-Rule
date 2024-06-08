import "pe"
import "console"
import "hash"
import "math"

private rule Indian_APT_PE_and_String{

	meta :
		Author = "Diyar Saadi"
		Date = "06/07/2024"
		Malware_Nationality = "India"
		Malware_Against_Nation = "Pakistan"
		Malware_MD5_Hash = "8C095479D9BEBA9ED56BB8D95861686D"

	strings:

		$a1 = "jlitest.dll"
		$a2 = "JLI_AcceptableRelease"
		$a3 = "JLI_FreeManifest"
		$a4 = "JLI_Launch"
		$a5 = "JLI_StringDup"
		$a6 = "JLI_MemAlloc"
		$a7 = "JLI_MemFree"
		$a8 = "JLI_ValidVersionString"
		$pathpdb = "E:\\new_ops\\jlitest __change_ops -29no - Copy\\Release\\jlitest.pdb"

		condition:
			console.log("The SHA256 Hash : ", hash.sha256(0,filesize)) and
			console.hex("The Magic Header : ", uint16(0)) and 
			any of them and
			console.log("PE Indicator : ", pe.is_32bit()) or 
			(pe.timestamp == 1639036360 or pe.export_timestamp == 4294967295  ) and
			(pe.number_of_signatures == 0 or pe.number_of_imports == 3 or pe.number_of_exports == 4) and 
			pe.pdb_path contains "E:\\new_ops\\jlitest"
		
}

private rule Indian_APT_Network{

	meta:
		Author = "Diyar Saadi"
		Date = "06/07/2024"
		Malware_Nationality = "India"
		Malware_Against_Nation = "Pakistan"
		Malware_MD5_Hash = "8C095479D9BEBA9ED56BB8D95861686D"

	strings:
		$a0 = "HTTP/1.1User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.0.10) Gecko/2009042316 Firefox/3.0.10"
		$a1 = "Content-Type: application/x-www-form-urlencoded"
		$a2 = "URLDownloadToFileA"
		$a3 = "bgre.kozow.com"
		$a4 = "Gfg786v6fcd6v8j09jg67f6/dolist.php"
		$a5 = "Gfg786v6fcd6v8j09jg67f6/revshll.php"
		$a6 = "Gfg786v6fcd6v8j09jg67f6/filedownload2.php"
		$pers = "Software\\Microsoft\\Windows\\CurrentVersion\\Run"

	condition:
		(5 of ($a*) or $pers)
		
}

private rule Indian_APT_WinAPI{

	meta:
		Author = "Diyar Saadi"
		Date = "06/07/2024"
		Malware_Nationality = "India"
		Malware_Against_Nation = "Pakistan"
		Malware_MD5_Hash = "8C095479D9BEBA9ED56BB8D95861686D"

	condition:
		console.log("The Entry Point : ", pe.entry_point) and
		console.log("The DLL Library Details : ", pe.dll_name) 
}

private rule Indian_APT_Entropy{

	meta:
		Author = "Diyar Saadi"
		Date = "06/07/2024"
		Malware_Nationality = "India"
		Malware_Against_Nation = "Pakistan"
		Malware_MD5_Hash = "8C095479D9BEBA9ED56BB8D95861686D"

	condition:
		math.entropy(0, filesize) > 7.5 
}