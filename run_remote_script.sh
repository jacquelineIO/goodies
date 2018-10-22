while read line
do
  echo Trying to configure server [IP]: $line >> error.log
  ssh $line 'mkdir -p /home/jflemming/scripts' &>> error.log
  scp my-script.sh $line:/home/jflemming/scripts/ &>> error.log
  ssh root@$line 'cd /home/jflemming/scripts && ./my-script.sh' &> error.log
  echo Finished working with [IP]: $line >> error.log
done <client-ips.txt
