#!/bin/bash
Ass=As
Bss=Bs
Css=Cs

echo "all variables: $@"
echo "no.of variables: $#"
echo "script name:$0"
echo "current working directory:$PWD"
echo "home directory of the current user: $HOME"
echo "which user is running this script: $USER"
echo "hostname: $HOSTNAME"
echo "process ID of the current shellscript: $$"
echo "process ID of the background command: $!"
