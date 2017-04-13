#!/bin/bash
#author wanglimin
#one key publish version
#update 20160831
source /etc/profile
deploy_version=$1
code_dir=$HOME/upcode
bak_dir=$code_dir/appserver_bakup
version_dir=/data/upgrade/server/
work_shell_dir=/data/upgrade/shell
update_py=$work_shell_dir/update_yyt.py
update_shell=$work_shell_dir/yytstart.sh
if [ ! -d $bak_dir ];then
	mkdir -p $bak_dir
fi
uid=`id -u`
user='yytuser'
if [ $uid -eq 0 ];then
  echo "not allow root to run it please run as a application user"
  exit
fi
if [ $user != $(id -nu) ];then
  echo "not allow other $(id -nu) to run it"
  exit
fi
if [  $# -lt 2 ];then
   echo "Please input `basename $0` version_number tar_md5";
   exit;
fi
if [ -d $bak_dir/$deploy_version ];then
		echo "$deploy_version has publish please check it"
		exit
fi

check_tar(){
update_version=$1
md5=$2
tar_file=${deploy_version}.tar
if [ -f $tar_file ];then
  tar_md5=$(md5sum $tar_file|awk '{print $1}')
  if [ "$tar_md5" == "$md5" ];then
		tar xf $tar_file -C /data/upgrade/server/
    return 0    
  else  
    return 1    
  fi    
else
  return 2
fi
}
cd $version_dir
if [ -d $deploy_version ] ;then
        rm -rf $deploy_version
  check_tar $deploy_version $2 
  RET=$?
  if [ $RET -eq 0 ];then
    $update_py $deploy_version
    sleep 2
    $update_shell stop
    sleep 2
    $update_shell start
    mv $deploy_version $bak_dir
  else
    echo "tar is err"
  fi
else
    check_tar $deploy_version $2
RET=$?
if [ $RET -eq 0 ];then
  $update_py $deploy_version
  sleep 2
  $update_shell stop
  sleep 2
  $update_shell start
  mv $deploy_version $bak_dir
else
  echo "tar is err"
fi
fi

