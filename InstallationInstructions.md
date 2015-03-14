# Installation in the PowerShell path #
Downloads are a zip file containing PowerShell modules, inside a single folder named after the module name, _HTMLTemplate_. To install the module, just put this folder containing all the files into a location that PowerShell searches for folders. Some suggestions are below. No further steps are necessary.

You can find out which folders PowerShell looks in like this:

  1. Open PowerShell
  1. Type `$env:PSModulePath`

You will get a list of folders. By default they will be the two suggestions below.

## System wide ##
### All Windows OSs ###

To install for all users, place the extracted directory in _C:\WINDOWS\system32\WindowsPowerShell\v1.0\Modules\_

## Single User ##

### Windows 7, Windows Server 2008 ###

To install for you, place in _C:\Users\`<username`>\Documents\WindowsPowershell\Modules\_, creating folders as necessary.

### Windows XP, Windows Server 2003 ###

To install for you, place in _C:\Documents and Settings\`<username`>\My Documents\WindowsPowershell\Modules\_, creating folders as necessary.

# Installation in a custom folder #

If you want to place the module somewhere else, then put it wherever you like, and then when you call Import-Module in your script, pass it the full path to the module rather than just the name of the module. See UsageInstructions.