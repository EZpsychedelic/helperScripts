#!/bin/bash
## user input for yes/no
read -n1 -p "Are these correct? [Y,n] " ANS
case $ANS in
	y|Y) continue ;;
	*) exit 0 ;;
esac

## Error wrapper
error ()
{
  echo >&2 `tput setaf 1`"[-] FAILED: ${*}"`tput sgr0`
  exit 78
}

## Check root privilage wrapper
check_root ()
{
  if [ $EUID -ne 0 ]; then
    error "User must be root!"
  fi
}

## Make a Directory if it doesn't exist
make_newDir ()
{
  if [ ! -d "$newDir ]; then
    mkdir -pv /mnt/$newDir
    echo "[+] $newDir created"
  fi
}
## If previous return code does not equal 0
if [ $? -ne 0 ]; then

## do somthing else

## If no arguments are passed send an error message and exit
parse_args ()
{
  if [[ $# -eq 0 ]]; then
  echo "Usage: Some usage mesage..."
  exit 1
  fi
}
