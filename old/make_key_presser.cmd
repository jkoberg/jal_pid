@echo off

set jalfile=Key_presser.jal

rem J:\src\pic\JAL\jallib-read-only\include

set compiler=.\jallib-read-only\compiler\jalv2.exe
set libdir=.\jallib-read-only\include

%compiler% -long-start -s %libdir%\include;%libdir%\external;%libdir%\external\storage;%libdir%\external\storage\eeprom;%libdir%\external\storage\pata_hard_disk;%libdir%\external\storage\ram;%libdir%\external\storage\ram\23k256;%libdir%\external\storage\sd_card;%libdir%\external\seven_segment;%libdir%\external\remote_control;%libdir%\external\adc;%libdir%\external\co2;%libdir%\external\can;%libdir%\external\motor;%libdir%\external\motor\stepper;%libdir%\external\motor\period_skip;%libdir%\external\motor\servo;%libdir%\external\motor\dc;%libdir%\external\temperature;%libdir%\external\ranger;%libdir%\external\ranger\us;%libdir%\external\ranger\ir;%libdir%\external\media;%libdir%\external\one_wire;%libdir%\external\rtc;%libdir%\external\dds;%libdir%\external\keyboard;%libdir%\external\humidity;%libdir%\external\lcd;%libdir%\external\lcd\fonts;%libdir%\peripheral;%libdir%\peripheral\data_eeprom;%libdir%\peripheral\flash_memory;%libdir%\peripheral\pwm;%libdir%\peripheral\spi;%libdir%\peripheral\usart;%libdir%\peripheral\comparator;%libdir%\peripheral\adc;%libdir%\peripheral\timer;%libdir%\peripheral\can;%libdir%\peripheral\rtc;%libdir%\peripheral\i2c;%libdir%\peripheral\usb;%libdir%\device;%libdir%\networking;%libdir%\protocol;%libdir%\filesystem;%libdir%\jal %jalfile%

pause
