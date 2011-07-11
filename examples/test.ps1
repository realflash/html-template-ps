Import-Module "c:\inetpub\wwwroot\bin\HTMLTemplate\HTMLTemplate.psm1"
 
$template = New-HTMLTemplate(@{ filename = 'C:\Users\igibbs.admin\Dropbox\ING-Workspace\ING006 - Transition\VDI\Scripts\report_state\test.tmpl'}) 
$template.param('FAVOURITE', 'apple')
$template.param('FRUIT', @( @{ NAME = 'Apple'; COLOUR = 'Green' }, @{ NAME = 'Orange'; COLOUR = 'Orange' } ))  
$template.param('HAVE_APPLE', $true)
 
Write-Output $template.output()