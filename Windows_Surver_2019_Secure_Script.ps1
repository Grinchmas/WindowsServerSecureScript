
#This is a Scipt that was written by Grinchmas

#Changes Admin Password
Net user "Administrator" $in = Read-Host "Enter_Admin_Pwd";
$in = "NiceTry \_(^_^)_/";

#Messes with Firewall (non GPO)
Set-NetFirewallProfile -All -Enabled True;
Set-NetFirewallProfile -Name ('Public','Private','Domain') -DefaultInboundAction Block;
Set-NetFirewallProfile -Name ('Public','Private','Domain') -DefaultOutboundAction Allow;

#Blocks Bad Ports (non GPO) (check the last port)
$BadPorts = Read-Host "('1'..'12'+'23..24'+'26'..'52'+'81'..'109'+'111'..'442'+'444'..'7999'+'8001'..'65535')"
New-NetFirewallRule -DisplayName "BlockOutboundBadPortsTCP" -Profile ('Domain','Private','Public') -Direction Outbound -Action Block -Protocol TCP -Local Port $BadPorts;
New-NetFirewallRule -DisplayName "BlockInboundBadPortsTCP" -Profile ('Domain','Private','Public') -Direction Inbound -Action Block -Protocol TCP -Local Port $BadPorts;
New-NetFirewallRule -DisplayName "BlockOutboundBadPortsUDP" -Profile ('Domain','Private','Public') -Direction Outbound -Action Block -Protocol UDP -Local Port $BadPorts;
New-NetFirewallRule -DisplayName "BlockInboundBadPortsUDP" -Profile ('Domain','Private','Public') -Direction Inbound -Action Block -Protocol UDP -Local Port $BadPorts;

#Removes Bad GPOs
Get-GPO -All;
$BadGPO = Read-Host "EnterBadGPONameAfterDocumentation";
Remove-GPO $BadGPO;

#other thing to secure Windows
Disable-PSRemoting;
Stop-Service -Name ("bthserv","MapsBroker","Spooler","SSDPSRV");

#end Powershell
Exit;