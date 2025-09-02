@echo off
chcp 65001 > nul
:: 65001 - UTF-8
::
cd /d "%~dp0"
call service_status.bat zapret
call check_updates.bat soft
echo:

set BIN=%~dp0bin\

start "zapret: general" /min "%BIN%winws.exe" --wf-tcp=80,443 --wf-udp=443,590-1400,50000-50099 ^
--filter-udp=443 --hostlist="list-general.txt" --dpi-desync=fake --dpi-desync-repeats=6 --dpi-desync-fake-quic="%BIN%quic_initial_www_google_com.bin" --new ^
--filter-udp=590-1400 --ipset="%~dp0files\ipset-telegram.txt" --filter-l7=stun --dpi-desync=fake --dpi-desync-any-protocol --dpi-desync-cutoff=d3 --dpi-desync-repeats=6 --new ^
--filter-tcp=80 --hostlist="list-general.txt" --dpi-desync=fake,split2 --dpi-desync-autottl=2 --dpi-desync-fooling=md5sig --new ^
--filter-tcp=443 --hostlist="list-general.txt" --dpi-desync=fake,split --dpi-desync-autottl=2 --dpi-desync-repeats=6 --dpi-desync-fooling=badseq --dpi-desync-fake-tls="%BIN%tls_clienthello_www_google_com.bin"
