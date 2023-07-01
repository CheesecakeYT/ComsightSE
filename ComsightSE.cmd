@echo off

set csedir=%cd%
set msgcount=0
systeminfo | findstr /B /C:"OS Name" > os.cse
find /i /c "Microsoft Windows 8" os.cse >NUL
if %errorlevel% equ 0 (
  set win8=1
)
del os.cse

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
  if "%win8%" == 1 set filemd5=%filemd5: =%

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

  if "%filemd5%" == "dcf060e00547cfe641eff3f836ec08c8" set threat=BAT.Ransom.Mallox.A
  if "%filemd5%" == "9a239885dc7044a9289610d58585167b" set threat=BAT.Ransom.Mallox.B
  if "%filemd5%" == "44d88612fea8a8f36de82e1278abb02f" set threat=EicarTestFile
  if "%filemd5%" == "8251b13b7516ca408630c8bdf74e45ca" set threat=OSX.Trojan.JokerSpy.A
  if "%filemd5%" == "1d283dd3ae2312eee624e8b8c46f6adb" set threat=Win32.Adware.Adload.A
  if "%filemd5%" == "039f18876093e1fcc116b303cb697769" set threat=Win32.Adware.Adload.B
  if "%filemd5%" == "a8fdc6db7498f54b6eb67b038a06e016" set threat=Win32.Adware.Adload.C
  if "%filemd5%" == "356d4e8c71c27a523ee19567d1e65c0e" set threat=Win32.Adware.Adposhel.A
  if "%filemd5%" == "2d89abac9d439abad1e427a467f0687d" set threat=Win32.Adware.BProtector.A
  if "%filemd5%" == "898bdcc577a2b49e8eacaf18ddbb3e7b" set threat=Win32.Adware.BProtector.B
  if "%filemd5%" == "8f20a7f89173fe76c4de0c7e23a5bf67" set threat=Win32.Adware.CloverPlus.A
  if "%filemd5%" == "dd17f2d1bd0748ec84fb6ccd088ef829" set threat=Win32.Adware.CloverPlus.B
  if "%filemd5%" == "0f46bcd190c7859bd18a36c7e58a7a13" set threat=Win32.Adware.CsdiMonetize.A
  if "%filemd5%" == "13322e8599367a9b1e31ab61e1dc7136" set threat=Win32.Adware.CsdiMonetize.B
  if "%filemd5%" == "1c9bd7526e179792bc3bce0785a6c58d" set threat=Win32.Adware.Elex.A
  if "%filemd5%" == "9aa537b86a28baa3b2cbcb214240cbb1" set threat=Win32.Adware.Elex.B
  if "%filemd5%" == "223b2cadc499ffe43f445d59ff84ba61" set threat=Win32.Adware.Elex.C
  if "%filemd5%" == "f64829c7f8042e583e41d500fd19faa1" set threat=Win32.Adware.HPDefender.A
  if "%filemd5%" == "0571f609a944d9c06517aa4bbe62ecee" set threat=Win32.Adware.Linkury.A
  if "%filemd5%" == "3b6132561be9cdd598e494cbb240cc60" set threat=Win32.Adware.Linkury.B
  if "%filemd5%" == "05234975b085632d70d89c2f420c5107" set threat=Win32.Adware.MultiPlug.A
  if "%filemd5%" == "e9b27306a18f18b88945cdf066de2fc9" set threat=Win32.Adware.MultiPlug.B
  if "%filemd5%" == "8300c91b40229b42301aebc6d8859907" set threat=Win32.Adware.MultiPlug.C
  if "%filemd5%" == "297c46f413d3c5c5b46e335adf199c09" set threat=Win32.Adware.MultiPlug.D
  if "%filemd5%" == "e1d10cccd5dde588af8ee2cb7309523c" set threat=Win32.Adware.MultiPlug.E
  if "%filemd5%" == "410bb7e2c88f92de31b83a173e173e2d" set threat=Win32.Adware.MultiPlug.F
  if "%filemd5%" == "6223a19e77e3b9b4f633e8863ee1cf40" set threat=Win32.Adware.MultiPlug.G
  if "%filemd5%" == "9afeb7fa65aa31c6b871237d14a8fb94" set threat=Win32.Adware.MultiPlug.H
  if "%filemd5%" == "51869d78edfbeb04d0805522d9232518" set threat=Win32.Adware.MultiPlug.I
  if "%filemd5%" == "b5e8219112f5de28e71487fd8c367b8f" set threat=Win32.Adware.MultiPlug.J
  if "%filemd5%" == "2f21b030acc94619252a33d36dc2694c" set threat=Win32.Adware.MultiPlug.K
  if "%filemd5%" == "83528348154f9f3f3c332191b0849b25" set threat=Win32.Adware.MultiPlug.L
  if "%filemd5%" == "06cfeaa6556d9264ef303884935ddfe2" set threat=Win32.Adware.MultiPlug.M
  if "%filemd5%" == "e1d330228db3f4aab5582d1a294163f3" set threat=Win32.Adware.MultiPlug.N
  if "%filemd5%" == "5a525639bc99f2961bf96f39a08b3f59" set threat=Win32.Adware.MultiPlug.O
  if "%filemd5%" == "0231aebb8155fd069d17eab6a679cc1e" set threat=Win32.Adware.MultiPlug.P
  if "%filemd5%" == "ffe3f0c62f2fede9890b18d73724fd97" set threat=Win32.Adware.MultiPlug.Q
  if "%filemd5%" == "9c354249e2b00af7362d8eecaee9b2b2" set threat=Win32.Adware.MultiPlug.R
  if "%filemd5%" == "dfbbc852264301fc93cf20521025dbda" set threat=Win32.Adware.MultiPlug.S
  if "%filemd5%" == "294725ae35ecfb4f5e0d29239213c2c7" set threat=Win32.Adware.MultiPlug.T
  if "%filemd5%" == "34bc1e9d673cfdf64391674c763cdd77" set threat=Win32.Adware.MultiPlug.U
  if "%filemd5%" == "86caa44adb45c7bb76f01b62d76fed67" set threat=Win32.Adware.MultiPlug.V
  if "%filemd5%" == "926838555c7e13f295fda017b3fa3ea9" set threat=Win32.Adware.MultiPlug.W
  if "%filemd5%" == "5084e8462339af6aaaff60260bfed47c" set threat=Win32.Adware.MultiPlug.X
  if "%filemd5%" == "3f79e9fb0f5afe1afeb58f8eeeef5225" set threat=Win32.Adware.MultiPlug.Y
  if "%filemd5%" == "a84d5bc892e7f990b60de1e812a57bb4" set threat=Win32.Adware.MultiPlug.Z
  if "%filemd5%" == "536b32345f0794f7b2d12cb6e160fb9a" set threat=Win32.Adware.MultiPlug.AA
  if "%filemd5%" == "fcc8cb868f06b18f695811cdab3657e0" set threat=Win32.Adware.MultiPlug.AB
  if "%filemd5%" == "0c13beab56e09c6110efd30d0ace4953" set threat=Win32.Adware.MultiPlug.AC
  if "%filemd5%" == "822b6218dace16adaeef0a2dafb9b357" set threat=Win32.Adware.MultiPlug.AD
  if "%filemd5%" == "adebe8a941c3d85b3a44f44d42990b3e" set threat=Win32.Adware.MultiPlug.AE
  if "%filemd5%" == "2cd7d12a076bf6deff47e4e880c6e78b" set threat=Win32.Adware.MultiPlug.AF
  if "%filemd5%" == "ce843f444734589ccf33e79e3a415f0b" set threat=Win32.Adware.MultiPlug.AG
  if "%filemd5%" == "43832753f3d731620c40862735ab8099" set threat=Win32.Adware.MultiPlug.AH
  if "%filemd5%" == "d0ae479228f8581d9f2e2ef9ca8fc73a" set threat=Win32.Adware.MultiPlug.AI
  if "%filemd5%" == "6781a1fe294a70a6b2b45e34eca04383" set threat=Win32.Adware.MultiPlug.AJ
  if "%filemd5%" == "09cf5bc2d7107c91da164f6984731a5e" set threat=Win32.Adware.MultiPlug.AK
  if "%filemd5%" == "007bebd1adb041a100d02b89ce34ff09" set threat=Win32.Adware.MultiPlug.AL
  if "%filemd5%" == "55a529f002779f50cdc32adca14941b9" set threat=Win32.Adware.MultiPlug.AM
  if "%filemd5%" == "e7a1dc49685734730819f2d3f73a8dab" set threat=Win32.Adware.MultiPlug.AN
  if "%filemd5%" == "16ac8b690466f94bcd113ece78005a67" set threat=Win32.Adware.MultiPlug.AO
  if "%filemd5%" == "b80ac851a69041071df0fa0464227a3b" set threat=Win32.Adware.MultiPlug.AP
  if "%filemd5%" == "74c3ea85be8510449a203e4b053f2617" set threat=Win32.Adware.MultiPlug.AQ
  if "%filemd5%" == "dc4159c3a65ca9c596ac2a8f15cc9eee" set threat=Win32.Adware.MultiPlug.AR
  if "%filemd5%" == "a460b73e3eab8db7e828325550c09124" set threat=Win32.Adware.MultiPlug.AS
  if "%filemd5%" == "3a58d673dac856c13e094cc1c57a867e" set threat=Win32.Adware.MultiPlug.AT
  if "%filemd5%" == "71bcd28169dc323889ed69d4e45b0dca" set threat=Win32.Adware.MultiPlug.AU
  if "%filemd5%" == "13284bfdc933dc1255f59c632b69deba" set threat=Win32.Adware.MultiPlug.AV
  if "%filemd5%" == "e91842a97d3c73418121d68be282d997" set threat=Win32.Adware.MultiPlug.AW
  if "%filemd5%" == "0d93aa1a1ad7fe49791c7d2d5d3f5745" set threat=Win32.Adware.MultiPlug.AX
  if "%filemd5%" == "a99556f6bda1aff1d8949cccb6cee1bb" set threat=Win32.Adware.MultiPlug.AY
  if "%filemd5%" == "6d29592294869fa7dbe0c626fe3b0d2f" set threat=Win32.Adware.MultiPlug.AZ
  if "%filemd5%" == "9cfc3ca63422d5984c94fee42345f1e0" set threat=Win32.Adware.MultiPlug.BA
  if "%filemd5%" == "01bb0dc44ee0b1dc4f5a4ea39d1e0968" set threat=Win32.Adware.MultiPlug.BB
  if "%filemd5%" == "0e78c14fcfe290a43087b2e8ddd5ff8a" set threat=Win32.Adware.MultiPlug.BC
  if "%filemd5%" == "115ed7efb0630dc5956dbcbddcb3e57b" set threat=Win32.Adware.MultiPlug.BD
  if "%filemd5%" == "13b33afe01d1be020556cf838c3b13ca" set threat=Win32.Adware.MultiPlug.BE
  if "%filemd5%" == "2df0a45e759cb85909de50586aead9f0" set threat=Win32.Adware.MultiPlug.BF
  if "%filemd5%" == "3211a7c266f3056039cee594813d675a" set threat=Win32.Adware.MultiPlug.BG
  if "%filemd5%" == "f49fd19d94abc8f667467df7350af082" set threat=Win32.Adware.MultiPlug.BH
  if "%filemd5%" == "aca677b1a5977cacc67ca2a0172e607a" set threat=Win32.Adware.MultiPlug.BI
  if "%filemd5%" == "4422cbecb97bf5c63e576f53db010e1b" set threat=Win32.Adware.MultiPlug.BJ
  if "%filemd5%" == "a8a4ec98667f9f1ae8c6733ac3484764" set threat=Win32.Adware.MultiPlug.BK
  if "%filemd5%" == "a2793771d9f8f84a1528aadfe182d53b" set threat=Win32.Adware.MultiPlug.BL
  if "%filemd5%" == "d84635013c213ecfd68bfe945d9a18a4" set threat=Win32.Adware.MultiPlug.BM
  if "%filemd5%" == "b366c02458508966ea73b3bdffed6eda" set threat=Win32.Adware.MultiPlug.BN
  if "%filemd5%" == "e0062cd7041c54addfb9d982b697f693" set threat=Win32.Adware.MultiPlug.BO
  if "%filemd5%" == "52cc9b26f1b5b6f32396b55e86249086" set threat=Win32.Adware.MultiPlug.BP
  if "%filemd5%" == "974ad54281862631c28e0c587bc49ce0" set threat=Win32.Adware.MultiPlug.BQ
  if "%filemd5%" == "d068c3b02dc61fff62c60942f5f80c6e" set threat=Win32.Adware.MultiPlug.BR
  if "%filemd5%" == "d1342af518bc70b6616b72a65cf3cde9" set threat=Win32.Adware.MultiPlug.BS
  if "%filemd5%" == "9ed2da6d7e27e5f0e7fe6b044f43e7ec" set threat=Win32.Adware.MultiPlug.BT
  if "%filemd5%" == "ff2cd1922ae0eacfc947c2c2e5015397" set threat=Win32.Adware.NetFilter.A
  if "%filemd5%" == "17695e7f65fde6a86966ea79b3392719" set threat=Win32.Adware.OpenSUpdater.A
  if "%filemd5%" == "fb5a451a6876ca313db735971baecce7" set threat=Win32.Adware.ParanoidFish.A
  if "%filemd5%" == "de3ea65a9f1064abdd9b612fd4b19aa1" set threat=Win32.Adware.PCPlus.A
  if "%filemd5%" == "2d935bccc9d30c6f3f4a3b64a9c6ed43" set threat=Win32.Adware.SmartBrowser.A
  if "%filemd5%" == "1f968acbe005442aec5be288abbd5810" set threat=Win32.Adware.Somoto.A
  if "%filemd5%" == "edd19f0dbb38b1ed3b80d90102719c19" set threat=Win32.Adware.SpeedingUpMyPC.A
  if "%filemd5%" == "2e705785860f95358dc9aa6ed402198b" set threat=Win32.Adware.SProtector.A
  if "%filemd5%" == "d59fb8a196cc8ad8e8bde0c437070cc6" set threat=Win32.Adware.SProtector.B
  if "%filemd5%" == "0b8d8ecaded2508690b6a52d9eb61ccd" set threat=Win32.Adware.Techsnab.A
  if "%filemd5%" == "017a762469f1e0f811bb7da274b8a99c" set threat=Win32.Adware.TopTools.A
  if "%filemd5%" == "d9ea10b4401b6e448bf1e64a5be677dd" set threat=Win32.Adware.TrafficMouse.A
  if "%filemd5%" == "4c926c4b6f4b3226752e4b2d75448a65" set threat=Win32.Adware.TrafficMouse.B
  if "%filemd5%" == "fc75a8c64abb4c907441059d5165c8cf" set threat=Win32.Adware.Vosteran.A
  if "%filemd5%" == "fd5eb09872c9736b16b199d78a2487eb" set threat=Win32.Adware.Weiduan.A
  if "%filemd5%" == "8d3fe7e5e5389af219557f0c0db1a074" set threat=Win32.Adware.Zdengo.A
  if "%filemd5%" == "07b73a29b36215d3aa5a3ff353e69c90" set threat=Win32.BadJoke.Agent.A
  if "%filemd5%" == "9939f0f4547a1a7f8c42903ae490ba49" set threat=Win32.BadJoke.Agent.B
  if "%filemd5%" == "844db7862d6294ac569906e85e087e95" set threat=Win32.BadJoke.Agent.C
  if "%filemd5%" == "73c3466b6779344652ef97209ab4db1a" set threat=Win32.BadJoke.Anywork.A
  if "%filemd5%" == "428b5352d8a6bb681ce65e172fe16c29" set threat=Win32.BadJoke.Jepruss.A
  if "%filemd5%" == "9a239885dc7044a9289610d58585167b" set threat=Win32.DDoS.Nitol.A
  if "%filemd5%" == "0a8b84cce97d867b59dffd0eac01e7e1" set threat=Win32.Hacktool.AutoKMS.A
  if "%filemd5%" == "277b5e7870109d38f0f11e9bdf816355" set threat=Win32.Hacktool.Crack.A
  if "%filemd5%" == "247127840ecfe076c95e8cca7b7aa5a3" set threat=Win32.Miner.Agent.A
  if "%filemd5%" == "2693d23b9603649245b016e1f74a1c87" set threat=Win32.Miner.Agent.B
  if "%filemd5%" == "2dd69443fdaf6e73374a7db61fd6d470" set threat=Win32.Miner.Agent.C
  if "%filemd5%" == "2fd3b2b417b2d4535eb46f82a8291833" set threat=Win32.Miner.Agent.D
  if "%filemd5%" == "30cf385e056bb8075366eaaeb1628d6d" set threat=Win32.Miner.Agent.E
  if "%filemd5%" == "31a665444e867ad49999baf955e4a184" set threat=Win32.Miner.Agent.F
  if "%filemd5%" == "4447fded02577a07538f724fa962b686" set threat=Win32.Miner.Agent.G
  if "%filemd5%" == "7e5fb3372131c3225971f6b0d2e9ec31" set threat=Win32.Miner.Agent.H
  if "%filemd5%" == "878e5d10bb7d3dd569266c4c14ed382a" set threat=Win32.Miner.Agent.I
  if "%filemd5%" == "5c99411fa8a11691771a476ff52a9344" set threat=Win32.Miner.Herxmin.A
  if "%filemd5%" == "b5bde51e8f5c854b2c0ff7e13eb57859" set threat=Win32.Ransom.Agent.A
  if "%filemd5%" == "808d8409376a125a75f2f6efc6a93432" set threat=Win32.Ransom.Cerber.A
  if "%filemd5%" == "87175668b1c2aab93f454b179430d39e" set threat=Win32.Ransom.CryFile.A
  if "%filemd5%" == "bd60fae4b72fbc59e591420d5d8525a8" set threat=Win32.Ransom.Cryptodef.A
  if "%filemd5%" == "9935873b88aec32f1f3bc8e067117c91" set threat=Win32.Ransom.Foreign.A
  if "%filemd5%" == "24293996f8f11323226fa1ceb6cd2f7f" set threat=Win32.Ransom.GandCrab.A
  if "%filemd5%" == "3eb2affae110ff41cf75bbc18b5b5694" set threat=Win32.Ransom.GandCrab.B
  if "%filemd5%" == "1b577950ccaf37a8dc7272238eacbf9a" set threat=Win32.Trojan.Agent.A
  if "%filemd5%" == "5f5e677b2ec9defb4f0b884766c370c7" set threat=Win32.Trojan.Agent.B
  if "%filemd5%" == "0dfb0bf5b34d80207e0f9ca3a8ad73e9" set threat=Win32.Trojan.Agent.C
  if "%filemd5%" == "14e5144bc3df9178e952103e79ee17ba" set threat=Win32.Trojan.Agent.D
  if "%filemd5%" == "31e3afcd2cda5de622953834cbced5c8" set threat=Win32.Trojan.Agent.E
  if "%filemd5%" == "3218d67cec773f6754ca09c3d75741e8" set threat=Win32.Trojan.Agent.F
  if "%filemd5%" == "32907aa8f9ce9198949617826702f935" set threat=Win32.Trojan.Agent.G
  if "%filemd5%" == "334e4358dd3058f2a3fc778212784fe3" set threat=Win32.Trojan.Agent.H
  if "%filemd5%" == "3d64d94686018928ef239eda03ac996c" set threat=Win32.Trojan.Agent.I
  if "%filemd5%" == "fc708d1337ee91cd497a83426eea1092" set threat=Win32.Trojan.Agent.J
  if "%filemd5%" == "f897f1a171248ff8a05860019e42c49c" set threat=Win32.Trojan.Agent.K
  if "%filemd5%" == "f72d006df3db1f6a6b3bf796774fd51e" set threat=Win32.Trojan.Agent.L
  if "%filemd5%" == "705f65e733bb6f6e5a39e9622ee62a86" set threat=Win32.Trojan.Agent.M
  if "%filemd5%" == "5183294258534f9e372fe08d92870993" set threat=Win32.Trojan.Agent.N
  if "%filemd5%" == "8445c8bd1d495118644c295ed1971514" set threat=Win32.Trojan.Agent.O
  if "%filemd5%" == "cbc15ca34a62d409b99726b6a2c47a93" set threat=Win32.Trojan.Androm.A
  if "%filemd5%" == "462a2522d2d2fe095e92fe50a663aea5" set threat=Win32.Trojan.Androm.B
  if "%filemd5%" == "25a5f0a8a5822a4dfe57a74316a1b20a" set threat=Win32.Trojan.AutoIT.A
  if "%filemd5%" == "2b788a143ca4e5b7234400cf3a914565" set threat=Win32.Trojan.AutoIT.B
  if "%filemd5%" == "fb9529e54e1b1bb55666d5df8aeb888a" set threat=Win32.Trojan.AutoIT.C
  if "%filemd5%" == "f7808b450b38cfb976de45a51715c291" set threat=Win32.Trojan.AutoIT.D
  if "%filemd5%" == "f67ea7dba5e228238b744dbf47625959" set threat=Win32.Trojan.AutoIT.E
  if "%filemd5%" == "18984aee380f082293298d86ca5daff1" set threat=Win32.Trojan.Betload.A
  if "%filemd5%" == "baf2c6ff6a22b75e28d0181dad88c8b8" set threat=Win32.Trojan.Blouiroet.A
  if "%filemd5%" == "1c77a2c81c6ce3060564906cc257ff1c" set threat=Win32.Trojan.Bsymem.A
  if "%filemd5%" == "389df628d0e4f200be9e2d92771e2056" set threat=Win32.Trojan.Chapak.A
  if "%filemd5%" == "0d1a328d237a0bf9a55859c0c17f8221" set threat=Win32.Trojan.ClipBanker.A
  if "%filemd5%" == "1c7ef02aead4080b864e22b1d3817f16" set threat=Win32.Trojan.ClipBanker.B
  if "%filemd5%" == "4adb32d4452f9d12f075f70d0ffc8e3c" set threat=Win32.Trojan.Emotet.A
  if "%filemd5%" == "26c726fd3bfed270b84a46795f25b58b" set threat=Win32.Trojan.FareIt.A
  if "%filemd5%" == "31abdda236c82d33bf086e1721de6d5a" set threat=Win32.Trojan.GenericTools.A
  if "%filemd5%" == "162ef99584dab004d8918639bfe9c399" set threat=Win32.Trojan.ICLoader.A
  if "%filemd5%" == "19e484144ba89503d237bfb408468904" set threat=Win32.Trojan.ICLoader.B
  if "%filemd5%" == "8407a5532739eab584ab33cd6c6cac62" set threat=Win32.Trojan.Injuke.A
  if "%filemd5%" == "8d6aea5469772b7b01e1801cf22ebf96" set threat=Win32.Trojan.Jadtre.A
  if "%filemd5%" == "229c1734015154c2e362eb88f3a24b9a" set threat=Win32.Trojan.Jetmedia.A
  if "%filemd5%" == "b4167591de350ae09444d4fa465d3d28" set threat=Win32.Trojan.KillProc.A
  if "%filemd5%" == "7dee0193e01240d2c874eaf7e2fb9ee7" set threat=Win32.Trojan.Kuping.A
  if "%filemd5%" == "0615ba0ec73e856a90ff4a1fc118ee33" set threat=Win32.Trojan.Mingloa.A
  if "%filemd5%" == "f703577ee1b98d243df1a8176653c29c" set threat=Win32.Trojan.NanoCore.A
  if "%filemd5%" == "b6dd6af9705333f8108fff280fa4760f" set threat=Win32.Trojan.Olock.A
  if "%filemd5%" == "fd2b649c7daf3475c832cfd4e3728a08" set threat=Win32.Trojan.Regiskazi.A
  if "%filemd5%" == "2c86d25fb14f28b7cbb96c3449994554" set threat=Win32.Trojan.SafeBytes.A
  if "%filemd5%" == "0ad75231018477db663c2d31ff9431d0" set threat=Win32.Trojan.Scar.A
  if "%filemd5%" == "02522476be0e1744064ca1eb489ad0dd" set threat=Win32.Trojan.Staser.A
  if "%filemd5%" == "4f64ced85f504ecec262f037f0628fb2" set threat=Win32.Trojan.Staser.B
  if "%filemd5%" == "81d52759fcef1e3d8a6ef735ada2662c" set threat=Win32.Trojan.Staser.C
  if "%filemd5%" == "3449face5b51114a4c8a26bd3eee3ead" set threat=Win32.Trojan.Staser.D
  if "%filemd5%" == "3c2db9614dbd46b16abd206cacaee7b6" set threat=Win32.Trojan.Suloc.A
  if "%filemd5%" == "142d235670245f630baa5a52bc6b75bf" set threat=Win32.Trojan.Tasker.A
  if "%filemd5%" == "3b1745f3459091b21ffe076fef776445" set threat=Win32.Trojan.Wonknod.A
  if "%filemd5%" == "66028d66816c154aceeca3e01d1f0532" set threat=Win32.Trojan.Wonknod.B
  if "%filemd5%" == "f697cf8052041e9899a14b0834de3223" set threat=Win32.Trojan.Yakes.A
  if "%filemd5%" == "632e6b472f03f7c3923d44475a43f1e8" set threat=Win32.Trojan.Yakes.B
  if "%filemd5%" == "306330092e4c3068f4cf816434df0e27" set threat=Win32.Virus.Jeefo.A
  if "%filemd5%" == "036fd6d32683ec1e2a6458458abeaf23" set threat=Win32.Virus.Neshta.A
  if "%filemd5%" == "0cfe3050745ce31758866a476f39dbf6" set threat=Win64.Miner.Agent.A
  if "%filemd5%" == "105c4744146b83880a638cfcd859f2af" set threat=Win64.Miner.Agent.B
  if "%filemd5%" == "41fb43a6e1eeb477472bf5b16c5f52cc" set threat=Win64.Miner.Agent.C
  if "%filemd5%" == "1446d03692ce0ee3a9cd8b853a262032" set threat=Win64.Miner.Agent.D
  if "%filemd5%" == "16c8869341e513d4054d6a42c4198784" set threat=Win64.Miner.Agent.E
  if "%filemd5%" == "200a865fd58360dcd1fbcf55b29fca38" set threat=Win64.Miner.Agent.F
  if "%filemd5%" == "208b1de5a8108bbc35340cf39b087b25" set threat=Win64.Miner.Agent.G
  if "%filemd5%" == "224fa5f60cdda6f07516048a8df40645" set threat=Win64.Miner.Agent.H
  if "%filemd5%" == "35a1f64dc248d954f5b2b21e6bbe3c63" set threat=Win64.Miner.Agent.I
  if "%filemd5%" == "38d0734066882956ac3bb538f8836135" set threat=Win64.Miner.Agent.J
  if "%filemd5%" == "3ed4adb65428f2c8ab75e60c3cebc9fa" set threat=Win64.Miner.Agent.K
  if "%filemd5%" == "fd94d0c40e2eabe62ad73c60d0bdc340" set threat=Win64.Miner.Agent.L
  if "%filemd5%" == "5d8dbf60120617dd57f4ee851cd32fb6" set threat=Win64.Miner.Agent.M
  if "%filemd5%" == "6c8fc5cf8021bede03abad71a80de913" set threat=Win64.Miner.Agent.N
  if "%filemd5%" == "c002f685a6563ad49e71572c12d96aed" set threat=Win64.Miner.Agent.O
  if "%filemd5%" == "aa378f3f047acc8838ffd9fe4bd0025b" set threat=Win64.Miner.Agent.P
  if "%filemd5%" == "742553e7ffd904182985f5b3e4771271" set threat=Win64.Miner.Agent.Q

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

  find /i /c "Comsight Security Essentials settings - DO NOT CHANGE THIS FILE" %file% > NUL
  if %errorlevel% == 0 goto safe

  find /i /c "EICAR-STANDARD-ANTIVIRUS-TEST-FILE" %file% > NUL
  if %errorlevel% == 0 set threat=EicarTestFile!gen
  find /i /c "givmefilesnow.info" %file% > NUL
  if %errorlevel% == 0 set threat=Win32.Adware.Adload!gen
  find /i /c "i1.forallwebestv.info" %file% > NUL
  if %errorlevel% == 0 set threat=Win32.Adware.Adload!gen
  find /i /c "www.blogdanawa.co.kr" %file% > NUL
  if %errorlevel% == 0 set threat=Win32.Adware.CloverPlus!gen
  find /i /c "Banyan Tree Technology Limited0" %file% > NUL
  if %errorlevel% == 0 set threat=Win32.Adware.Elex!gen
  find /i /c "c:\temp\winnie-pooh\piglet-rules.tmp" %file% > NUL
  if %errorlevel% == 0 set threat=Win32.Adware.MultiPlug!gen
  find /i /c "This program was created as a fun little trick.  It is not meant to hurt anyone." %file% > NUL
  if %errorlevel% == 0 set threat=Win32.BadJoke.Agent.C!gen
  find /i /c "config.wallba.com" %file% > NUL
  if %errorlevel% == 0 set threat=Win32.PUP.Kuping!gen

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
