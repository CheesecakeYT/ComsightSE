@echo off

set csedir=%cd%
set msgcount=0

if not exist cse_config.txt (
  cls
  color 0f
  title Configuring - Comsight Security Essentials
  echo Comsight Security Essentials
  echo.
  echo Building a secure internet
  echo.
  echo.
  echo Thank you for downloading Comsight Security Essentials!
  echo It was detected that you either:
  echo - have outdated configuration files or
  echo - installed Comsight Security Essentials for the first time.
  echo Please wait until we finish configuring your software.

  if not exist cse_config.txt (
    aaaa > cse_config.txt
    echo Comsight Security Essentials settings - DO NOT CHANGE THIS FILE > cse_config.txt
    echo Version Of Configuration Files 1 >> cse_config.txt
    echo Piracy not detected >> cse_config.txt  
  )
  cls
  echo Comsight Security Essentials
  echo.
  echo Building a secure internet
  echo.
  echo.
  echo Thank you for downloading Comsight Security Essentials!
  echo It was detected that you either:
  echo - have outdated configuration files or
  echo - installed Comsight Security Essentials for the first time.
  echo Please wait until we finish configuring your software.
  echo Configuration complete. You can now continue.
  pause
)

rem if not exist cse_config.txt (
rem   set /a msgcount=msgcount+1
rem )
  
  tasklist > tasks.txt
  find /i /c "TJprojMain.exe" %file% > NUL
  if %errorlevel% == 0 (
    set suspicioustask="TJprojMain.exe"
    wmic process where "name='TJprojMain.exe'" get ExecutablePath > tasks.txt
    for /f "tokens=1*delims=:" %%G in ('findstr /n "^" tasks.txt') do if %%G equ 1 set suspiciousfile=%%H
    set suspicioustask=1
  )
  find /i /c "Synaptics.exe" %file% > NUL
  if %errorlevel% == 0 (
    set suspicioustask="Synaptics.exe"
    wmic process where "name='Synaptics.exe'" get ExecutablePath > tasks.txt
    for /f "tokens=1*delims=:" %%G in ('findstr /n "^" tasks.txt') do if %%G equ 1 set suspiciousfile=%%H
    set suspicioustask=1
  )
  del tasks.txt
  if "%suspicioustask%" == "1" goto suspicioustask

:start
  cd %csedir%
  find /i /c "Piracy detected" cse_config.txt > NUL
  if %errorlevel% equ 0 goto antipiracy
  cls
  color 0f
  title Comsight Security Essentials
  set dirscan=false
  echo Comsight Security Essentials
  echo.
  echo Building a secure internet
  echo.
  echo.
  echo You're fully protected.
  echo You have %msgcount% messages.
  echo.
  echo (FILE) - scan file
  echo (DIR) - scan directory
  echo (QUARANTINE) - show quarantine settings
  echo (SETTINGS) - show CSE settings
  echo (MESSAGES) - show messages
  echo (EXIT) - exit
  echo.
  set /p choice="Enter your choice: "

  if /i "%choice%" == "exit" exit
  if /i "%choice%" == "file" goto file
  if /i "%choice%" == "dir" goto dir
  if /i "%choice%" == "quarantine" goto quarantine_menu
  if /i "%choice%" == "settings" goto settings
  if /i "%choice%" == "messages" goto messages
  echo.
  echo %choice% is not a valid choice.
  pause
  goto start
  
:suspicioustask
  cls
  color cf
  title Your action is required - Comsight Security Essentials
  echo Comsight Security Essentials
  echo.
  echo Building a secure internet
  echo.
  echo
  echo A file was found hosting a suspicious task.
  echo.
  echo.
  echo Task: %suspicioustask%
  echo.
  echo Hosting file: %suspiciousfile%
  echo.
  echo.
  echo Do you want to scan the hosting file for malware?
  echo.
  echo (YES) - scan the file
  echo (NO) - don't scan the file
  echo.
  set /p choice="Enter your choice: "
  if /i "%choice%" == "yes" (
    set file=%suspiciousfile%
    goto md5
  )
  if /i "%choice%" == "no" (
    echo.
    echo The file won't be scanned.
    pause
    goto start
  )
  echo.
  echo %choice% is not a valid choice.
  pause
  goto suspicioustask
  
:messages
  cls
  title Comsight Security Essentials
  echo Comsight Security Essentials
  echo.
  echo Building a secure internet
  echo.
  echo.
  echo Messages: %msgcount%
  echo.
  rem if not exist cse_config.txt (
  rem  echo Detection information sharing is turned off. Sharing
  rem  echo some detection information helps us to develop our
  rem  echo scans. To turn it on, navigate to Settings - Analytics.
  rem  echo.
  rem )
  echo (BACK) - back
  echo.
  set /p choice="Enter your choice: "

  if /i "%choice%" == "back" goto start
  echo.
  echo %choice% is not a valid choice.
  pause
  goto messages
  
:settings
  cls
  echo Comsight Security Essentials
  echo.
  echo Building a secure internet
  echo.
  echo.
  echo (BACK) - back
  echo.
  set /p choice="Enter your choice: "

  if /i "%choice%" == "back" goto start
  echo.
  echo %choice% is not a valid choice.
  pause
  goto settings

:quarantine_menu
  cls
  echo Comsight Security Essentials
  echo.
  echo Building a secure internet
  echo.
  echo.
  cd %csedir%
  if not exist quarant\ mkdir quarant
  dir quarant\
  echo.
  echo (DEL) - delete all files
  echo (BACK) - back
  echo.
  set /p choice="Enter your choice: "

  if /i "%choice%" == "del" (
    dir /A /B "quarant\" | findstr /R ".">NUL && goto quarantine_del
    echo Quarantine is already empty.
    pause
    goto quarantine_menu
  )
  if /i "%choice%" == "back" goto start
  echo.
  echo %choice% is not a valid choice.
  pause
  goto quarantine_menu

:quarantine_del
  echo.
  set /p choice="Are you sure? (Y/N): "
  if /i "%choice%" == "y" (
    del quarant\
    mkdir quarant\
    echo Files were deleted.
    pause
    goto quarantine_menu
  )
  if /i "%choice%" == "n" (
    goto quarantine_menu
  )
  echo.
  echo %choice% is not a valid choice.
  pause
  goto quarantine_menu
  
:antipiracy
  title BEING A CRIMINAL IS NO GOOD
  echo Piracy detected >> cse_config.txt 
  cls
  color cf
  echo.
  echo WAIT A MINUTE...
  echo.
  echo :(
  echo.
  echo PIRACY IS A CRIME.
  echo.
  echo Software piracy was detected.
  echo Copying software without permission is illegal and the consequences
  echo can result in a fine or even imprisoning. If you are not the author
  echo of this pirated copy of Comsight Security Essentials, report this copy
  echo to Comsight.
  echo.
  echo If you think this is an error, ask Comsight support.
  echo.
  echo CLOSE THE PROGRAM OR PRESS ANY KEY TO CLOSE IT.
  pause >NUL
  exit

:dir
  cls
  echo Comsight Security Essentials
  echo.
  echo Building a secure internet
  echo.
  echo.
  echo (BACK) - back
  echo.
  set /p dir="Enter a directory to scan: "

  if "%dir%" == "back" goto start

  cd %dir%
  dir /s /b > files.txt
  set filenumber=1

  title MD5 Scan Pending - Comsight Security Essentials
  set dirscan=true
  for /f %%A in ('dir /a-d-s-h /b /s ^| find /v /c ""') do set cnt=%%A
  goto scan

:file
  cls
  echo Comsight Security Essentials
  echo.
  echo Building a secure internet
  echo.
  echo.
  echo (BACK) - back
  echo.
  set /p file="Enter a filename to scan: "

  if "%file%" == "back" goto start
  
:md5
  title MD5 Scan Pending - Comsight Security Essentials
  @CertUtil -hashfile %file% MD5 > md5.txt

  for /f "tokens=1*delims=:" %%G in ('findstr /n "^" md5.txt') do if %%G equ 2 set filemd5=%%H
  del md5.txt
  goto scan

:scan
  cls
  color 9f
  if "%dirscan%" == "true" (
    for /f "tokens=1*delims=:" %%G in ('findstr /n "^" files.txt') do if %%G equ %filenumber% set file=%%H
    @CertUtil -hashfile %file% MD5 > md5.txt

    for /f "tokens=1*delims=:" %%G in ('findstr /n "^" md5.txt') do if %%G equ 2 set filemd5=%%H
    del md5.txt

    if "%cnt%" lss "%filenumber%" (
      goto safe
    )
  )
  echo Comsight Security Essentials
  echo.
  echo Building a secure internet
  echo.
  echo.
  if "%dirscan%" == "true" (
    echo Now scanning: %file%
    echo.
  )
  echo MD5 Scan: Pending
  echo Behavior Scan: Waiting

  set threat=""

  if "%filemd5%" == "44d88612fea8a8f36de82e1278abb02f" set threat="EicarTestFile"
  if "%filemd5%" == "07b73a29b36215d3aa5a3ff353e69c90" set threat="Win32.BadJoke.Agent.A"
  if "%filemd5%" == "9939f0f4547a1a7f8c42903ae490ba49" set threat="Win32.BadJoke.Agent.B"
  if "%filemd5%" == "844db7862d6294ac569906e85e087e95" set threat="Win32.BadJoke.Agent.C"
  if "%filemd5%" == "73c3466b6779344652ef97209ab4db1a" set threat="Win32.BadJoke.Anywork.A"
  if "%filemd5%" == "428b5352d8a6bb681ce65e172fe16c29" set threat="Win32.BadJoke.Jepruss.A"

  if "%threat%" == """" goto md5_safe

:md5_threat
  cls
  color cf
  title Your action is required - Comsight Security Essentials
  echo Comsight Security Essentials
  echo.
  echo Building a secure internet
  echo.
  echo.
  echo Warning! Malware was found inside this file.
  echo.
  echo Reported by: MD5 Scan
  echo.
  echo Threat: %threat%
  echo.
  echo Path: %file%
  echo.
  echo (DELETE) - deletes the file
  echo (QUARANTINE) - quarantines the file
  echo (TERMINATE) - forcibly terminates all tasks provided by the threat, then returns to this point
  echo (IGNORE) - ignores the threat
  echo.
  set /p choice="Enter your choice: "
  if /i "%choice%" == "delete" goto delete
  if /i "%choice%" == "ignore" goto ignore
  if /i "%choice%" == "quarantine" goto quarantine
  if /i "%choice%" == "terminate" goto terminate
  echo.
  echo %choice% is not a valid choice.
  pause
  goto md5_threat

:delete
  echo.
  del %file%
  echo Threat deleted.
  pause
  if "%dirscan%" == "true" (
    set threat=""""
    set /a filenumber=%filenumber%+1
    goto scan
  )
  goto start

:quarantine
  echo.
  cd %csedir%
  if not exist quarant\ mkdir quarant
  move /Y %file% quarant\%threat%.csequarant
  cipher /e quarant\%threat%.csequarant
  echo Threat quarantined.
  pause
  if "%dirscan%" == "true" (
    set threat=""""
    set /a filenumber=%filenumber%+1
    goto scan
  )
  goto start

:terminate
  echo.
  taskkill /f /im %file%
  echo Tasks killed.
  goto md5_threat

:ignore
  echo.
  echo Threat ignored.
  pause
  if "%dirscan%" == "true" (
    set threat=""""
    set /a filenumber=%filenumber%+1
    goto scan
  )
  goto start

:md5_safe
  cls
  title Behavior Scan Pending - Comsight Security Essentials
  echo Comsight Security Essentials
  echo.
  echo Building a secure internet
  echo.
  echo.
  if "%dirscan%" == "true" (
    echo Now scanning: %file%
    echo.
  )
  echo MD5 Scan: Successful
  echo Behavior Scan: Pending

  find /i /c "EICAR-STANDARD-ANTIVIRUS-TEST-FILE" %file% > NUL
  if %errorlevel% == 0 set threat=EicarTestFile
  find /i /c "git clone http" %file% > NUL
  if %errorlevel% == 0 set threat=Exploit.CVE-2017-9800
  find /i /c "git clone ssh" %file% > NUL
  if %errorlevel% == 0 set threat=Exploit.CVE-2017-9800
  find /i /c "67.231.149.140" %file% > NUL
  if %errorlevel% == 0 set threat=MaliciousIP
  find /i /c "96.47.72.85" %file% > NUL
  if %errorlevel% == 0 set threat=MaliciousIP
  find /i /c "184.168.221.67" %file% > NUL
  if %errorlevel% == 0 set threat=MaliciousIP
  find /i /c "14.17.102.104" %file% > NUL
  if %errorlevel% == 0 set threat=MaliciousIP
  find /i /c "35.186.238.101" %file% > NUL
  if %errorlevel% == 0 set threat=MaliciousIP
  find /i /c "120.79.208.189" %file% > NUL
  if %errorlevel% == 0 set threat=MaliciousIP
  find /i /c "151.139.128.14" %file% > NUL
  if %errorlevel% == 0 set threat=MaliciousIP
  find /i /c "198.181.163.103" %file% > NUL
  if %errorlevel% == 0 set threat=MaliciousIP
  find /i /c "173.232.146.37" %file% > NUL
  if %errorlevel% == 0 set threat=MaliciousIP
  find /i /c "winoxior.tk" %file% > NUL
  if %errorlevel% == 0 set threat=MaliciousWebsite
  find /i /c "lywja.healthsvsolu.com" %file% > NUL
  if %errorlevel% == 0 set threat=MaliciousWebsite
  find /i /c "krjregh.sacreeflame.com" %file% > NUL
  if %errorlevel% == 0 set threat=MaliciousWebsite
  find /i /c "news.softfix.co.kr" %file% > NUL
  if %errorlevel% == 0 set threat=MaliciousWebsite
  find /i /c "bbs.gokickes.com" %file% > NUL
  if %errorlevel% == 0 set threat=MaliciousWebsite
  find /i /c "www.gokickes.com" %file% > NUL
  if %errorlevel% == 0 set threat=MaliciousWebsite
  find /i /c "arinas.tk" %file% > NUL
  if %errorlevel% == 0 set threat=MaliciousWebsite
  find /i /c "bedrost.com" %file% > NUL
  if %errorlevel% == 0 set threat=MaliciousWebsite
  find /i /c "branter.tk" %file% > NUL
  if %errorlevel% == 0 set threat=MaliciousWebsite
  find /i /c "bronerg.tk" %file% > NUL
  if %errorlevel% == 0 set threat=MaliciousWebsite
  find /i /c "celestyna.tk" %file% > NUL
  if %errorlevel% == 0 set threat=MaliciousWebsite
  find /i /c "crusider.tk" %file% > NUL
  if %errorlevel% == 0 set threat=MaliciousWebsite
  find /i /c "davilta.tk" %file% > NUL
  if %errorlevel% == 0 set threat=MaliciousWebsite
  find /i /c "This program was created as a fun little trick.  It is not meant to hurt anyone." %file% > NUL
  if %errorlevel% == 0 set threat=Win32.BadJoke.Agent.C!gen

  if "%threat%" == """" (
    if "%dirscan%" == "true" (
      set /a filenumber=filenumber+1
      goto scan
    ) else (
      goto safe
    )
  )

:behavior_threat
 rem if exist cse_config.txt (
 rem   for /f "tokens=1*delims=:" %%G in ('findstr /n "^" cse_config.txt') do if %%G equ 3 set email=%%H
 rem   rem for /f "tokens=1*delims=:" %%G in ('findstr /n "^" cse_config.txt') do if %%G equ 4 set smtp=%%H
 rem   Malware %threat% found inside %filemd5% by Behavior Scan. > blatmsg.txt
 rem   blat -f %email% -to martinekmatej@gmail.com -s "Comsight Security Essentials: Malware was found" -body "%filemd5% was classified as %threat% by Behavior Scan."
 rem )
  cls
  color cf
  title Your action is required - Comsight Security Essentials
  echo Comsight Security Essentials
  echo.
  echo Building a secure internet
  echo.
  echo.
  echo Warning! Malware was found inside this file.
  echo We recommend you to report %filemd5% to Comsight staff.
  echo.
  echo Reported by: Behavior Scan
  echo Note: Behavior Scan doesn't always have to be accurate.
  echo.
  echo Threat: %threat%
  echo.
  echo Path: %file%
  echo.
  echo (DELETE) - deletes the file
  echo (QUARANTINE) - quarantines the file
  echo (TERMINATE) - force terminates all tasks provided by the threat, then returns to this point
  echo (IGNORE) - ignores the threat
  echo.
  set /p choice="Enter your choice: "
  if /i "%choice%" == "delete" goto delete
  if /i "%choice%" == "ignore" goto ignore
  if /i "%choice%" == "quarantine" goto quarantine
  if /i "%choice%" == "terminate" goto terminate_behavior
  echo.
  echo %choice% is not a valid choice.
  pause
  goto behavior_threat

:terminate_behavior
  echo.
  taskkill /f /im %file%
  echo Tasks killed.
  goto behavior_threat
  
:behavior_safe
  cls
  title Behavior Scan Pending - Comsight Security Essentials
  echo Comsight Security Essentials
  echo.
  echo Building a secure internet
  echo.
  echo.
  if "%dirscan%" == "true" (
    echo Now scanning: %file%
    echo.
  )
  echo MD5 Scan: Successful
  echo Behavior Scan: Successful

  if "%threat%" == """" (
    if "%dirscan%" == "true" (
      set /a filenumber=filenumber+1
      goto scan
    ) else (
      goto safe
    )
  )

:safe
  cls
  color af
  title Scan finished - Comsight Security Essentials
  if "%dirscan%" == "true" del files.txt
  echo Comsight Security Essentials
  echo.
  echo Building a secure internet
  echo.
  echo.
  echo No virus detected. Excellent!
  pause
  goto start
