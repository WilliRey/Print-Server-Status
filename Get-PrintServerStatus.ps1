#Create Filename(includes date)

$date = Get-date -Format 'MM-dd-yyyy'
$filename = "PrintStatus_$date.txt"
$filepath = Join-Path $PSScriptRoot $filename


#Get printer status 

Get-Printer -ComputerName ["SERVER NAME"] | SELECT Name, PrinterStatus, Location |
Out-File -FilePath $filepath


#build email
#assumes SMTP server doesn't require Auth

$SendMailMessageNoti = @{
    From = ""
    To = ""
    cc = ""
    Subject = "Print Status $date"
    Body = 'Attached Print Server Status'
    Attachments = $filepath
    Priority = 'High'
    SmtpServer = ''



}

Send-MailMessage $SendMailMessageNoti

#TODO
#Schedule to run Daily on server
#Notify when printers change to offline/Error Status
#Create incident ticket when printer goes offline