Add-Type -AssemblyName System.Windows.Forms

$formObject = [System.Windows.Forms.Form]
$labelObject = [System.Windows.Forms.Label]
$ButtomObject = [System.Windows.Forms.Button]
$ComboObject = [System.Windows.Forms.ComboBox]
$TextObject = [System.Windows.Forms.TextBox]




# Setting Up Window Format
$helloObject= New-Object $formObject
$helloObject.ClientSize = '700, 500'
$helloObject.StartPosition = "CenterScreen"
$helloObject.Text = 'Service Descriptor' 
$helloObject.BackColor= '#A1B2BF'

#Setting up First label
$labelTitle = New-Object $labelObject
$labelTitle.Text = "._."
$labelTitle.AutoSize = $true
$labelTitle.Font = "Verdana , 32 ,style=Regular"
$labelTitle.Location= New-Object System.Drawing.Point(240,40)
#Printing on window

#Setting up 2nd label
$seclabel = New-Object $labelObject
$seclabel.Text = "Service :"
$seclabel.AutoSize = $true
$seclabel.Font = "Verdana , 14 ,style=Regular"
$seclabel.Location= New-Object System.Drawing.Point(125,120)

$deslabel = New-Object $labelObject
$deslabel.Text = "Service Description :"
$deslabel.AutoSize = $true
$deslabel.Font = "Verdana , 10 ,style=Regular"
$deslabel.Location= New-Object System.Drawing.Point(15,160)

$desname = New-Object $TextObject
$desname.WordWrap = $true  
$desname.Multiline = $true
$desname.Text = ""
$desname.Width = '420'
$desname.AutoSize = $true
$desname.Font = "Verdana , 10 ,style=Regular"
$desname.Location= New-Object System.Drawing.Point(200,160)

$statlabel = New-Object $labelObject
$statlabel.Text = "Status Description :"
$statlabel.AutoSize = $true
$statlabel.Font = "Verdana , 10 ,style=Regular"
$statlabel.Location= New-Object System.Drawing.Point(25,220)

$statname = New-Object $TextObject
$statname.WordWrap = $true  
$statname.Multiline = $true
$statname.Text = ""
$statname.Width = '480'
$statname.ScrollBars = "Vertical"
$statname.Height = '80'
$statname.AutoSize = $true
$statname.Font = "Verdana , 10 ,style=Regular"
$statname.Location= New-Object System.Drawing.Point(200,220)

$dblservice = New-Object $ComboObject
$dblservice.Font = "Verdana , 14 ,style=Regular"
$dblservice.Width = "420"
$dblservice.Location= New-Object System.Drawing.Point(250 , 120)
$helloObject.Controls.AddRange(@($labelTitle ,$seclabel ,$dblservice , $deslabel ,$desname, $statlabel ,$statname))

## Load the Drop Down list ##
$serviceLogicName = Get-Service | ForEach-Object{$dblservice.Items.Add($_.Name)}

function GetServiceDetails{
    $serviceName = $dblservice.SelectedItem
    $namedetails = Get-CimInstance -ClassName Win32_Service -Filter "Name= `"$($servicename)`""  | Select-Object DisplayName 
    $statdetails = Get-CimInstance -ClassName Win32_Service -Filter "Name= `"$($servicename)`""  | Select-Object Description 
    
    $desname.Text = $namedetails.displayname
    $statname.Text = $statdetails.description
}

$dblservice.Add_SelectedIndexChanged({GetServiceDetails})


$helloObject.ShowDialog()
$helloObject.Dispose()


