#!/usr/bin/env bash

# $sudo apt install gnumeric
 
file_name=(); size=(); format=(); data_time=(); type=(); video_time=()
folder=$1

while IFS= read -r line; do
  file_name+=($((echo "$line" | awk -F/ '{print $NF}')| awk '{gsub(" ", "_", $0)} 1'))
  size+=( "$((du -hs "$line" | cut -f1)| awk '{gsub(",", ".", $0)} 1')" )
  data_time+=("$(stat -c%.10y "$line")")
  if [ "${line#*.}" == "$line" ]; then
    type+=("unknow")
    video_time+=("-")
  else
    type+=("${line#*.}")
    check_line=$((ffmpeg -v error -i $line 2>&1 | tail -n1)| awk -F': ' '{print $NF}')
    if [ "${check_line}" == 'Invalid data found when processing input' ] || [ "${check_line}" == 'Invalid argument' ]; then
      video_time+=("-")
    else
      video_time+=("$(bc <<< "scale=2; $(ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "$line")/60") Min")
    fi
  fi
done < <(find $folder -type f -not -name '.*')
echo 'List of files:'
echo ${file_name[@]}
echo 'List of sizes:'
echo ${size[@]}
echo 'List of datas:'
echo ${data_time[@]}
echo 'List of types:'
echo ${type[@]}
echo 'List of video/music times:'
echo ${video_time[@]}
len=${#file_name[@]}
string="filename,data create,size of file(byte),type,duration(video music)\n"
for ((i=0;i<len;++i))
do
  string+=${file_name[i]}; string+=","
  string+=${data_time[i]}; string+=","
  string+=${size[i]}; string+=","
  string+=${type[i]}; string+=","
  string+=${video_time[i]}; string+="\n"
done
printf "\nWrite into csv:\n"
echo $string
echo -e $string >.temp.csv
 ssconvert .temp.csv $2
rm .temp.csv
