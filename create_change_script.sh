# use changepass.xp
#
# Can also be run as this: ~/scripts_new/changepass2.xp jflemming "OLD PASSWORD 222" e32 "NEW PASSWORD 05"
# 
#
for i in $(cat host_list_proxy_201704.txt)
do

 echo "~/scripts_new/changepass2.xp jflemming \"OLD PASSWORD\" $i \"NEW PASSWORD\"" >> change_for_sep.txt
done
