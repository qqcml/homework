#! /bin/bash    
dataSource='passwd';
../menu.sh;
clear;
	isContinue="y";
	userName="";
	while [ $isContinue = "y" -o $isContinue = "Y" ]
	do
		while [ $isContinue = "y" -o $isContinue = "Y" ]
		do
			echo -n "输入用户名:";
			read userName;
			if [ -z "$userName" ]
			then
				echo "用户名不能为空，请重新输入！";
				isContinue="Y";
				continue;
			fi	
			CheckDataSourceFileExist;
			if [ $? -ne 1 ]
			then
				deleteUser=$(awk -F ":" '$1 == "'$userName'" { print $0 }' $dataSource);		           
				if [ $deleteUser ]
				then
					echo "用户信息为：" $deleteUser;
					echo -n "是否删除？（y/n）";
					read isContinue;
					if [ -z $isContinue ]
					then
						isContinue="N";
					fi			
					if [ $isContinue = "y" -o $isContinue = "Y"  ]
					then
						CheckDataSourceFileExist;
						if [ $? -ne 1 ]
						then
							rowID=$(grep -n $deleteUser $dataSource | awk -F ":" '{print $1}');
 							sed -e "$rowID d" $dataSource > tempFile;
							cat tempFile > $dataSource;
							rm tempFile;
						fi				
						if [ $? -eq 0 ]
						then
							echo "记录删除！";
						else
							echo "系统错误，删除失败！";
						fi			
						isContinue="N";
					fi
				else
					echo "你输入的 【$userID】 用户不存在！";
					isContinue="N";
				fi   fi           done	
		if [ -n "$userName" ]  
		then
			echo -n "是否继续删除其他用户？？（y/n）";
			read isContinue;
			if [ -z $isContinue ]
			then
				isContinue="N";
			fi
		fi
	Done