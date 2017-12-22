@echo off
set carte="LAN"
set adrfixe=192.168.0.17
set masque=255.255.255.0
set passerelle=192.168.0.254
set dns1=212.27.40.240
set dns2=212.27.40.241

set carte2="LAN"
set adrfixe2=192.168.0.24
set masque2=255.255.255.0
set passerelle2=192.168.0.5
set dns12=192.168.0.5
set dns22=192.168.0.30

:question
SET /P lan=Adressage IP 1/FIXE 2/QUITTER (1/2)? :
if %lan%==1 goto IPfixe2
if %lan%==2 goto Nfin
goto question

:IPfixe2
SET /P lan=confirmer l'adressage en IP Fixe %adrfixe2% (O/N)? :
if %lan%==o goto OKFixe2
if %lan%==O goto OKFixe2
if %lan%==n goto Nfin
if %lan%==N goto Nfin
goto IPfixe2


:IPfixe
SET /P lan=confirmer l'adressage en IP Fixe %adrfixe% (O/N)? :
if %lan%==o goto OKFixe
if %lan%==O goto OKFixe
if %lan%==n goto Nfin
if %lan%==N goto Nfin
goto IPfixe


:OKFixe
netsh interface ipv4 set address %carte% static %adrfixe% %masque% %passerelle% 1
netsh inter ipv4 delete dnsservers LAN all > nul
netsh inter ipv4 set dnsservers LAN static %dns1% primary > nul
netsh inter ipv4 add dnsservers LAN %dns2% index=2 > nul

goto Ofin

:OKFixe2
netsh interface ip set address %carte2% static %adrfixe2% %masque2% %passerelle2% 1
netsh inter ip delete dnsservers LAN all > nul
netsh inter ip set dnsservers LAN static %dns12% primary > nul
netsh inter ip add dnsservers LAN %dns22% index=2 > nul


goto Ofin

:IPDHCP
SET /P lan=confirmer l'adressage en IP Dynamique (O/N)? :
if %lan%==o goto OKDHCP
if %lan%==O goto OKDHCP
if %lan%==n goto Nfin
if %lan%==N goto Nfin
goto IPDHCP

:OKDHCP
netsh interface ip set address %carte% dhcp
netsh inter ip delete dnsservers LAN all > nul
netsh inter ip set dnsservers LAN dhcp > nul
goto Ofin

:Nfin
@echo Aucune modification n'a ete appliquee
@echo -
SET /P lan=appuyez sur [ENTREE] pour quitter
goto fin

:Ofin
@echo La nouvelle configuration vient d'etre appliquee
@echo -
SET /P lan=appuyer sur [ENTREE] pour quitter
goto fin

:fin 