Function Cut-CSV
    {

        $filename = $TextBox1.Text
        $rootName = $TextBox2.Text
        $ext = "csv"
        $linesperFile = $TextBox3.Text


        $filecount = 1
        $reader = $null
        try{
            $reader = [io.file]::OpenText($filename)
            try{
                $writer = [io.file]::CreateText("{0}{1}.{2}" -f ($rootName,$filecount.ToString("000"),$ext))
                $filecount++
                $linecount = 0

                while($reader.EndOfStream -ne $true) {
                    while( ($linecount -lt $linesperFile) -and ($reader.EndOfStream -ne $true)){
                        $writer.WriteLine($reader.ReadLine());
                        $linecount++
                    }

                    if($reader.EndOfStream -ne $true) {
                        $writer.Dispose();

                        $writer = [io.file]::CreateText("{0}{1}.{2}" -f ($rootName,$filecount.ToString("000"),$ext))
                        $filecount++
                        $linecount = 0
                    }
                }
            } finally {
                $writer.Dispose();
            }
        } finally {
            $reader.Dispose();
        }
$oReturn=[System.Windows.Forms.MessageBox]::Show("Finished","CSV Cutter",[System.Windows.Forms.MessageBoxButtons]::OK)	
    }

Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()
[void][reflection.assembly]::LoadWithPartialName
("System.Windows.Forms")

$Form                            = New-Object system.Windows.Forms.Form
$Form.ClientSize                 = '500,300'
$Form.text                       = "Form"
$Form.TopMost                    = $false

$TextBox1                        = New-Object system.Windows.Forms.TextBox
$TextBox1.multiline              = $false
$TextBox1.width                  = 253
$TextBox1.height                 = 20
$TextBox1.location               = New-Object System.Drawing.Point(108,52)
$TextBox1.Font                   = 'Microsoft Sans Serif,10'

$TextBox2                        = New-Object system.Windows.Forms.TextBox
$TextBox2.multiline              = $false
$TextBox2.width                  = 253
$TextBox2.height                 = 20
$TextBox2.location               = New-Object System.Drawing.Point(108,90)
$TextBox2.Font                   = 'Microsoft Sans Serif,10'

$TextBox3                        = New-Object system.Windows.Forms.TextBox
$TextBox3.multiline              = $false
$TextBox3.width                  = 253
$TextBox3.height                 = 20
$TextBox3.location               = New-Object System.Drawing.Point(108,191)
$TextBox3.Font                   = 'Microsoft Sans Serif,10'

$Button1                         = New-Object system.Windows.Forms.Button
$Button1.text                    = "button"
$Button1.width                   = 60
$Button1.height                  = 30
$Button1.location                = New-Object System.Drawing.Point(140,254)
$Button1.Font                    = 'Microsoft Sans Serif,10'
$Button1.Add_Click(
    {
        Cut-CSV
    }
) #run cutter


$Button2                         = New-Object system.Windows.Forms.Button
$Button2.text                    = "button"
$Button2.width                   = 90
$Button2.height                  = 40
$Button2.location                = New-Object System.Drawing.Point(400,52)
$Button2.Font                    = 'Microsoft Sans Serif,10'
$Button2.add_Click({
    $ofd = New-Object system.windows.forms.Openfiledialog
    $script:filename = 'Not found'
    if($ofd.ShowDialog() -eq 'Ok'){
        $script:filename = $TextBox1.Text = $ofd.FileName
    }    
}) #fill box1

$Button3                         = New-Object system.Windows.Forms.Button
$Button3.text                    = "button"
$Button3.width                   = 90
$Button3.height                  = 40
$Button3.location                = New-Object System.Drawing.Point(400,102)
$Button3.Font                    = 'Microsoft Sans Serif,10'
$Button3.add_Click({
    $ofd = New-Object system.windows.forms.Openfiledialog
    $script:filename = 'Not found'
    if($ofd.ShowDialog() -eq 'Ok'){
        $script:filename = $TextBox2.Text = $ofd.FileName
    }    
}) #fillbox2

$Label1                          = New-Object system.Windows.Forms.Label
$Label1.text                     = "I want to cut:"
$Label1.AutoSize                 = $true
$Label1.width                    = 25
$Label1.height                   = 10
$Label1.location                 = New-Object System.Drawing.Point(22,52)
$Label1.Font                     = 'Microsoft Sans Serif,10'

$Label2                          = New-Object system.Windows.Forms.Label
$Label2.text                     = "To the folder:"
$Label2.AutoSize                 = $true
$Label2.width                    = 25
$Label2.height                   = 10
$Label2.location                 = New-Object System.Drawing.Point(21,90)
$Label2.Font                     = 'Microsoft Sans Serif,10'

$Label3                          = New-Object system.Windows.Forms.Label
$Label3.text                     = "Lines per file:"
$Label3.AutoSize                 = $true
$Label3.width                    = 25
$Label3.height                   = 10
$Label3.location                 = New-Object System.Drawing.Point(19,191)
$Label3.Font                     = 'Microsoft Sans Serif,10'

$Form.controls.AddRange(@($TextBox1,$TextBox2,$TextBox3,$Button1,$Button2,$Button3,$Label1,$Label2,$Label3))


$Form.ShowDialog()
$filename