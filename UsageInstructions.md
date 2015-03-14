

# Premise #

The goal is to have a module that re-implements, almost exactly, the Perl module HTML::Template by Sam Tregar. It's a great module that I have used religiously since I discovered it. It should be the same in the following ways:

  * It should behave in a similar object-oriented way
  * It should have the same methods and properties
  * It should have the same functionality
  * It should behave in the same way

As such, a Perl programmer who is familiar with HTML::Template should be able to take an existing template and use it with this module in a PowerShell script.

To see the full range of functionality available in HTML::Template, go [here](http://search.cpan.org/~samtregar/HTML-Template-2.9/Template.pm). HTML-Template-2.9 is the targeted version for compatibility.

# Current limitations #

As of v0.2, the following tags are supported:

  * TMPL\_VAR
  * TMPL\_LOOP
  * TMPL\_IF
  * TMPL\_ELSE
  * TMPL\_UNLESS

The following methods are supported:

  * new() `[called slightly differently, see below`]
  * param()
  * output()

Any other functionality described in the HTML::Template documentation (which is [here](http://search.cpan.org/~samtregar/HTML-Template-2.9/Template.pm)) is not implemented yet.

# Usage differences between HTML::Template and html-template-ps #

## new() ##

Perl:
```
my $template = HTML::Template->new( filename => 'file.tmpl', 
                                      option => 'value' 
                                    );
```

PowerShell:
```
$template = New-HTMLTemplate(@{ filename = 'file.tmpl' })
```
**NOTE**: None of the other options to new() are currently implemented

## param() ##

Perl:
```
$template->param(TITLE => 'Some Text')
$template->param(LOOP => [ { NAME => 'Apple', COLOUR => 'Green' }, { NAME => 'Orange', COLOUR => 'Orange' } ]
```
(Array of hashes, with each hash representing the set of parameters to be used for each iteration of the loop)

PowerShell:
```
$template.param('TITLE', 'Some Text')
$template.param('LOOP', @( @{ NAME = 'Apple'; COLOUR = 'Green' }, @{ NAME = 'Orange'; COLOUR = 'Orange' } )
```
**NOTE**: Only usage 3 of param as described [here](http://search.cpan.org/~samtregar/HTML-Template-2.9/Template.pm#param()), setting a single parameter, is supported.
(As per above, this an array of hashes).

## output() ##

Perl:
```
print $template->output()
```

PowerShell
```
Write-Output $template.output()
```
**NOTE**: Supplying a file handle is not supported

# Examples #

First you make a template - this is just a normal HTML file with a few extra tags, the simplest being `<TMPL_VAR>`

For example, C:\test.tmpl: [download](http://code.google.com/p/html-template-ps/downloads/detail?name=test.tmpl&can=2&q=)
```
<html>
  <head><title>List of Fruit</title>
  <body>
    My favourite fruit is <TMPL_VAR NAME="FAVOURITE"><br/>
    <br/>
    <table border="1">
      <tr><th>Name</th><th>Colour</th></tr>
<TMPL_LOOP NAME="FRUIT">      <tr><td><TMPL_VAR NAME="NAME"></td><td><TMPL_VAR NAME="COLOUR"></td></tr>
</TMPL_LOOP>    </table>
  </body>
</html>
```
The spacings may look a bit funny, but everything (including tabs, spaces and new lines) between the `<TMPL_LOOP>` and `</TMPL_LOOP>` gets replicated for each row of data (each element in the array that makes up the loop). So you can either have a pretty template, or pretty output. In this case, I went for pretty output.

Then a short PowerShell script: [download](http://code.google.com/p/html-template-ps/downloads/detail?name=test.ps1&can=2&q=)
```
Import-Module HTMLTemplate

$template = New-HTMLTemplate(@{ filename = 'C:\test.tmpl'})
$template.param('FAVOURITE', 'apple')
$template.param('FRUIT', @( @{ NAME = 'Apple'; COLOUR = 'Green' }, @{ NAME = 'Orange'; COLOUR = 'Orange' } ))

Write-Output $template.output()
```
This assumes you have followed the InstallationInstructions. If not, you can change the first line to
```
Import-Module "c:\path\to\HTMLTemplate\HTMLTemplate.psm1"
```

You can now run the script:
```
PS C:\Users\user> C:\test.ps1
<html>
  <head><title>List of Fruit</title>
  <body>
    My favourite fruit is apple
    <table border="1">
      <tr><th>Name</th><th>Colour>/th></tr>
      <tr><td>Apple</td><td>Green</td></tr>
      <tr><td>Orange</td><td>Orange</td></tr>
    </table>
  </body>
</html>
```

Which gives this output:

![http://html-template-ps.googlecode.com/files/exmaple1-output.png](http://html-template-ps.googlecode.com/files/exmaple1-output.png)

Note that if you want to redirect the output into a file, you can:
```
PS C:\Users\user> C:\test.ps1 >c:\Users\user\Documents\test.html
```
But this will only work if you use Write-Output in your script. If you use Write-Host, the output is written to the console, and the redirection is ignored.