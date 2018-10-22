In /var/www/html/
    updates_edited.list
    tar -czvf proj1_old.tgz $(cat updates_edited.list)
    mv proj1_old.tgz proj1_staging/old
    
    #capture permissions
    ls -l $(cat updates_edited.list) > proj1_staging/old/permissions.txt

proj1_staging
    mkdir old
    tar -xzvf proj1_changes_from_aps2.tgz
    
update scripts with directories

run scripts 
1. create_cp_list.sh
2. create_diff_list.sh
3. split cp script file
