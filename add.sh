#!/bin/bash    
dataSource='passwd';
clear;	
	isContinue="y";
	userName="";
	while [ $isContinue = "y" -o $isContinue = "Y" ]  
	do
		userName="";
		while [ -z $userName ]
		do
			echo -n "用户名:";
			read userName;
			if [ -z $userName ]
			then
				echo "错误！用户名是不能为空的，请重新输入！";
				continue;
			fi	
			if [ `expr match $userName "[a-zA-Z][0-9a-zA-Z]*"` -ne `expr length $userName` ]
			then
	echo "错误！用户名的只能由非数字打头的字符和数字组成，请重新输入！";
				userName="";
				continue;
			fi
		done
		passWord="";
		passWordAgain="";
		while [ -z $passWord ]
		do
			echo -n "密码:";
			read passWord;		
			if [ -z $passWord ]
			then
				echo "错误！密码是不能为空的，请重新输入！";
				continue;	fi		
			if [ `expr length $passWord` -ne 6 ]
			then
				echo "密码长度为6位，请重新输入!";
				passWord="";
				continue;
			fi		
			if [ `expr match $passWord "[0-9a-zA-Z]*"` -ne `expr length $passWord` ]
			then
				echo "密码由大小写字母、数字和控制字符组成，请重新输入!";
				passWord="";
				continue;
			fi	
			echo -n "请在输入一次密码：";
			read passWordAgain;	
			if [ $passWordAgain != $passWord ]
			then
				echo "两次输入的密码不一样，请重新输入！";
				passWord="";
				continue;
			fi
		done
		#用户UID输入处理,UID为数字、一般非超级用户的ID大等于500
		uID="";
		while [ -z $uID ]
		do
			echo -n "用户UID:";
			read uID;		
			if [ -z $uID ]
			then
				echo "错误！用户UID是不能为空的，请重新输入！";
				continue;
			fi	
			if [ `expr match $uID "[0-9]*"` -ne `expr length $uID` ]
			then
				echo "错误！用户的UID必须为数字，请重新输入！";
				uID="";
				continue;
			fi		
		if [ $uID -lt 500 -o $uID -gt 60000 ]	# <  或者  >
			then
			echo "错误！一般非超级用户的ID范围为500～60000，请重新输入!";
				uID="";
				continue;
			fi
		done	
		#用户组GID处理
		gID="";
		while [ -z $gID ]
		do
			echo -n "用户组GID:";
			read gID;		
			if [ -z $gID ]
			then
				echo "错误！用户GID是不能为空的，请重新输入！";
				continue;
			fi		
			if [ `expr match $gID "[0-9]*"` -ne `expr length $gID` ]
			then
				echo "错误！用户的GID必须为数字，请重新输入！";
				gID="";
				continue;
			fi	
			if [ $gID -lt 500 -o $gID -gt 60000 ]
			then
				echo "错误！用户组的ID范围为500～60000，请重新输入!";
				gID="";
				continue;
			fi
		done
		echo -n "说明:";read note;
		#bash,sh,csh,ksh
		shellVersion="";
		while [ -z $shellVersion ]
		do
			echo -n "登录SHELL（bash,sh,csh,ksh）:";
			read shellVersion;
			if [ $shellVersion != "bash" -a $shellVersion != "sh" -a $shellVersion != "csh" -a $shellVersion != "ksh" ]
			then
			echo "输入的Shell类型【$shellVersion】不在本系统支持范围内，请重新输入！";
				shellVersion="";
			fi
		done	
		echo -n "用户工作目录:";
		mkdir /home/$userName;
		if [ $? -eq 0 ]
		then
			echo $userName "成功创建！";
		fi
	userInfo="$userName:$passWord:$uID:$gID:$note:$userName:$shellVersion";
		echo $userInfo >> $dataSource;	
		if [ $? -eq 0 ]
		then
			echo "$userName用户信息添加成功！";
		else
			echo "$userName用户信息添加失败！";
		fi		
	echo -n "是否继续添加其他用户？？（y/n）";
		read isContinue;	
	done