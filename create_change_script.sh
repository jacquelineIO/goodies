# use changepass.xp
for i in $(cat host_list_proxy_201704.txt)
do

 echo "~/scripts_new/changepass2.xp jflemming \"OLD PASSWORD\" $i \"NEW PASSWORD\"" >> change_for_sep.txt
done
