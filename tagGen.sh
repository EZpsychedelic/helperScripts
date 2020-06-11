#!/bin/bash
# short script to autogenerate tags in wxHexeditor. Needed this to do a few thousand lines of something for demonstration purposes
# Font and note colour format: #000000
# This works, but you need to output it to a file with >> name.tags. It must have a *.tags extension for wxHex to recognize it.

START_OFFSET=$1
END_OFFSET=$2
SKIP=$3
FONT_COLOUR=$4
NOTE_COLOUR=$5
OUT=$6

LENGTH=$(($END_OFFSET-$START_OFFSET))
TAG=1

#echo "Tag: $TAG"
#echo "Length: $LENGTH"

echoXML() {

echo "
    <TAG id=\"$TAG\">
      <start_offset>$START_OFFSET</start_offset>
      <end_offset>$((START_OFFSET+LENGTH))</end_offset>
      <tag_text></tag_text>
      <font_colour>#$FONT_COLOUR</font_colour>
      <note_colour>#$NOTE_COLOUR</note_colour>
    </TAG>"

TAG=$((TAG+1))
START_OFFSET=$(((START_OFFSET+LENGTH)+(SKIP+1)))
}

if [[ $# < 5 ]]; then
	echo "Usage: START_OFFSET END_OFFSET SKIP_COUNT FONT_COLOUR NOTE_COLOUR"
	echo "Colours:000000"
	exit 0
fi

echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<wxHexEditor_XML_TAG>
  <filename path=\"$(pwd)/$OUT\">"

for((i=0;i<$SKIP;i++)); do
	echoXML
done
echo "
	 </filename>
</wxHexEditor_XML_TAG>"
