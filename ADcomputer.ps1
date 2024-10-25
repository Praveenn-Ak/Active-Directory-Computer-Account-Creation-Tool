# Import required assemblies for GUI
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Create Form
$form = New-Object System.Windows.Forms.Form
$form.Text = "AD Computer Account Creation"
$form.Size = New-Object System.Drawing.Size(400,200)
$form.StartPosition = "CenterScreen"

# Add Label for computer name input
$label = New-Object System.Windows.Forms.Label
$label.Text = "Computer Name:"
$label.Location = New-Object System.Drawing.Point(20,20)
$label.Size = New-Object System.Drawing.Size(100,20)
$form.Controls.Add($label)

# Add Textbox for computer name input
$txtComputerName = New-Object System.Windows.Forms.TextBox
$txtComputerName.Location = New-Object System.Drawing.Point(130,20)
$txtComputerName.Size = New-Object System.Drawing.Size(200,20)
$form.Controls.Add($txtComputerName)

# Add Label for OU selection
$ouLabel = New-Object System.Windows.Forms.Label
$ouLabel.Text = "Select OU:"
$ouLabel.Location = New-Object System.Drawing.Point(20,60)
$ouLabel.Size = New-Object System.Drawing.Size(100,20)
$form.Controls.Add($ouLabel)

# Add Dropdown for OU selection
$ouDropdown = New-Object System.Windows.Forms.ComboBox
$ouDropdown.Location = New-Object System.Drawing.Point(130,60)
$ouDropdown.Size = New-Object System.Drawing.Size(200,20)
$ouDropdown.DropDownStyle = [System.Windows.Forms.ComboBoxStyle]::DropDownList
$ouDropdown.Items.AddRange(@("BLL","ALL","MEL","MLL"))
$form.Controls.Add($ouDropdown)

# Add Button to create computer account
$createButton = New-Object System.Windows.Forms.Button
$createButton.Text = "Create Computer"
$createButton.Location = New-Object System.Drawing.Point(130,100)
$createButton.Size = New-Object System.Drawing.Size(100,30)
$form.Controls.Add($createButton)

# Event for Create Computer Button
$createButton.Add_Click({
    $computerName = $txtComputerName.Text
    $selectedOU = $ouDropdown.SelectedItem

    if (-not $computerName) {
        [System.Windows.Forms.MessageBox]::Show("Please enter a computer name.")
    } elseif (-not $selectedOU) {
        [System.Windows.Forms.MessageBox]::Show("Please select an OU.")
    } else {
        # Define OU paths
        $ouPaths = @{
            "BLL" = "OU=BLL,OU=BusinessUnits,DC=contoso,DC=com"
            "ALL" = "OU=ALL,OU=BusinessUnits,DC=contoso,DC=com"
            "MEL" = "OU=MEL,OU=BusinessUnits,DC=contoso,DC=com"
            "MLL" = "OU=MTS,OU=BusinessUnits,DC=contoso,DC=com"
        }

        # Select the appropriate OU path
        $targetOU = $ouPaths[$selectedOU]

        try {
            # Create the computer account in AD
            New-ADComputer -Name $computerName -SamAccountName $computerName -Path $targetOU -Description "Computer created via GUI tool"
            [System.Windows.Forms.MessageBox]::Show("Computer '$computerName' created successfully in $selectedOU.")
        } catch {
            [System.Windows.Forms.MessageBox]::Show("Error creating computer: $_")
        }
    }
})

# Show the Form
$form.ShowDialog()
