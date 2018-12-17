#This tool will search Windows log files based on following parameters 

##Need to record variables that we will be working with. Script will reach out to computers based on timestamps

param([string]$ComputerName = 'localhost',[datetime]$StartTimestamp,[datetime]$EndTimestamp)

##Must store log data into a log variable for further manipulation

###The where operator will serve to output only winevent objects that have a record count
$Logs = (Get-WinEvent -ListLog * -ComputerName $ComputerName | where { $_.RecordCount }).Logname
$FilterTable = @{
    'StartTime' = $StartTimestamp
    'EndTime' = $EndTimestamp
    'LogName' = $Logs
}

Get-WinEvent -ComputerName $ComputerName -FilterHashtable $FilterTable -ErrorAction 'SilentlyContinue'
