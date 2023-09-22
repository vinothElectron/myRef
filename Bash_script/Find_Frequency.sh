#Calculate the frequency of each word in a text file words.txt
#	Input:
#		the day is sunny the the
#		the sunny is is
#	ouput: sorted by descending frequency:
#		the 4
#		is 3
#		sunny 2
#		day 1
#	Sollution:
declare -A ass_array
for i in `cat words.txt`
do 
  if [[ -v ass_array[$i] ]]
  then
	 ((ass_array[$i]+=1))
  else
	  ((ass_array[$i]=1))
  fi
done

for k in ${!ass_array[@]}
do
  echo "$k ${ass_array[$k]}"
done |
sort -nr -k2 
