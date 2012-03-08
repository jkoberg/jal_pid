
set PACK=..\jallib-pack-2.4o-0.8.0
set COMPILER=%PACK%\compiler\jalv2.exe
set LIB=%PACK%\lib

%COMPILER% -long-start -s %LIB% main.jal

pause

