# Active Directory Computer Account Creation Tool

This PowerShell GUI tool simplifies the process of creating computer accounts in Active Directory (AD) and placing them in specific Organizational Units (OUs). Designed to save time and reduce errors, this tool allows users to enter a computer name, select a target OU from a dropdown list, and create the account with a single click.

## Features

- **User-Friendly GUI**: A graphical interface for ease of use, reducing reliance on the command line.
- **Predefined OU Options**: Users can choose from four predefined OUs: `BEL`, `ATL`, `MED`, and `MTS`.
- **Automated Account Placement**: Automatically places new computer accounts in the appropriate OU based on the selection.
- **Error Handling**: Provides feedback on missing inputs or any errors during the creation process.

## Requirements

- PowerShell with the **Active Directory module**.
- Necessary permissions to create computer accounts in the designated OUs.

## Usage

1. **Input the Computer Name**: Type the desired name for the computer account.
2. **Select the OU**: Choose the appropriate OU from the dropdown list (BEL, ATL, MED, or MTS).
3. **Create Account**: Click "Create Computer" to generate the computer account in AD.

If successful, a confirmation message appears with the OU details. In case of issues (e.g., permission errors), an error message will provide additional details.

## Installation

1. Clone this repository.
2. Run the PowerShell script directly from the `ps1` file by opening it in PowerShell and executing.

## Sample Code

Here's a snippet of the core logic:

```powershell
$ouPaths = @{
    "BLL" = "OU=BLL,OU=BusinessUnits,DC=contoso,DC=com"
    "ALL" = "OU=ALL,OU=BusinessUnits,DC=contoso,DC=com"
    "MEL" = "OU=MEL,OU=BusinessUnits,DC=contoso,DC=com"
    "MLL" = "OU=MLL,OU=BusinessUnits,DC=contoso,DC=com"
}
```

The script uses the selected OU path and the computer name to create an AD computer account with `New-ADComputer`.

## License

This project is open-source and available under the MIT License.
