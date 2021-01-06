# Short bash script swaps the endianess of MAC addresses as they are commonly found in feature phones. Normally this process involves hand parsing these data values out of the hex dump and manually reversing them in some manner. I found it easiest to copy and paste them to a text file that I could run a script on to reorder and beautify.

```bash
IFS='\n'
RANDOM=$((RANDOM%=100))
TMP_FILE="`pwd`/"$RANDOM.txt""
#Input will be a text file argument after command e.g: $ ./bt_swapper.sh bluetoothaddress.txt
ARR=($(<$1))

slice() {
  b=${*}
  i=${#b}
  while [ i -gt 0 ]
    i=$[i-2]
    p=${b:$i:-2}":"
      echo -n "$p" >> $TMP_FILE
  done
  echo >> $TMP_FILE
}

#Get each string as an element in an array and send it to slice funtion
for a in "${ARR[@]}"; do
  slice $a
done

#Remove the last colon
while read line; do
  echo ${line::-1} >> NEW_FILE
done < $TMP_FILE

rm $TMP_FILE
cat $NEW_FILE
```
