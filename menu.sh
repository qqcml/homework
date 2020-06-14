#!/bin/bash    
dataSource='passwd';
addUsers="./add.sh";
deleteUsers="./delete.sh";
CheckDataSourceFileExist()
{
	if [ -f $dataSource ]   
	then
		#文件存在
		return 0;
	else
		#文件不存在
		clear;
		echo -n "警告 【$dataSource】 不存在！请确认！";     		
read ;
		return 1;
	fi
}
	choice="F";
	while [ $choice != "Q" -a $choice != "q" ]  
	do
		CheckDataSourceFileExist;
		if [ $? -ne 1 ]  
		then         
			clear;
			echo "			用户信息管理主菜单";
			echo "===========================================================";
			echo "		1.显示当前所有记录";
			echo "		2.格式化显示当前所有记录";
			echo "		3.查询特定用户信息";
			echo "		4.添加新用户";
			echo "		5.删除用户";
			echo "		Q.退出";
			echo -n "你的选择:";
			read choice;
			if [ -z $choice ]         
			then
				choice="empty";
			fi
			clear;
			if [ $choice = "empty" ];
			then
				echo "选项尚未选择！";
			else
				case $choice in
					1) CheckDataSourceFileExist;
						if [ $? -ne 1 ]
						then
			echo "当前的所有的用户信息如下所示:";
			echo "用户名 密码 ID GID 说明 工作目录 登录Shell"
			cat $dataSource | tr ":" " " | more;   						fi;;
					2) 	CheckDataSourceFileExist;
							if [ $? -ne 1 ]
							then
			echo "当前的所有的用户信息如下所示:";
			echo -e "用户名\t密码\tID\tGID\t说明\t工作目录\t登录Shell"                           								sort -k 1 $dataSource | awk -F ":" '{print $1 "\t" $2 "\t" $3 "\t" $4 "\t" $5 "\t" $6 "\t" $7 "\t"}' | more;
							fi;;
					3) CheckDataSourceFileExist;
						if [ $? -ne 1 ]
						then
							keyWords="";
							while [ -z $keyWords ]
							do
								echo -n "输入搜索关键词:";
								read keyWords;
								if [ -z $keyWords ]
								then
									echo "搜索关键词不能为空，请重新输入";
								fi
							done
						CheckDataSourceFileExist;
						if [ $? -ne 1 ]
						then
							grep -i $keyWords $dataSource;							
							if [ $? -eq 1 ]
							then
								echo "很遗憾，【$dataSource】文件中，并不存在与 $keyWords 一致的信息。";
							fi
						fi
						fi;;
					4) $addUsers;;
					5) $deleteUsers;;
					Q) printf "程序已经退出。";;
					q) printf "程序已经退出。";;
					*) echo $choice "：此选项不是默认提供的功能。请确认";;
				esac
			fi
			echo -n "确认？";
			read ;
		fi
	Done