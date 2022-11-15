#include<stdio.h>
#include<windows.h>
#include<sql.h>
#include<sqlext.h>
#include<sqltypes.h>
#include<string.h>

SQLRETURN ret;
SQLHENV henv;
SQLHDBC hdbc;
SQLHSTMT hstmt;

SQLCHAR sno[20],sname[20],ssex[10];
SQLCHAR sNo[20],sName[20],sSex[10],myID[20];

//连接
void LinkDatabase(){
    ret=SQLAllocHandle(SQL_HANDLE_ENV,NULL,&henv);//申请环境句柄
    ret=SQLSetEnvAttr(henv,SQL_ATTR_ODBC_VERSION,(SQLPOINTER)SQL_OV_ODBC3,SQL_IS_INTEGER);//设置环境属性
    ret=SQLAllocHandle(SQL_HANDLE_DBC,henv,&hdbc);//申请数据库连接句柄
	ret=SQLConnect(hdbc,(SQLCHAR*)"MSSQL_EX1",SQL_NTS,(SQLCHAR*)"sa",SQL_NTS,(SQLCHAR*)"123456",SQL_NTS);//连接数据库
}
//查询
void Select(){
    if(ret==SQL_SUCCESS || ret==SQL_SUCCESS_WITH_INFO){
        ret=SQLAllocHandle(SQL_HANDLE_STMT,hdbc,&hstmt);//申请SQL语句句柄
        SQLCHAR sql[]="SELECT * FROM Student WHERE sno = ? ";
        SQLINTEGER p = SQL_NTS;
        printf("请输入你要查找的学生学号:\n");
        scanf("%s",myID);
        ret=SQLPrepare(hstmt,sql,SQL_NTS);//准备SQL语句
        ret=SQLBindParameter(hstmt,1,SQL_PARAM_INPUT,SQL_C_CHAR,SQL_VARCHAR,50,0,myID,50,&p);//绑定参数
        ret=SQLExecute(hstmt);
        if(ret==SQL_SUCCESS || ret==SQL_SUCCESS_WITH_INFO){
            SQLBindCol(hstmt,1,SQL_C_CHAR,sno,20,&sNo);
            SQLBindCol(hstmt,2,SQL_C_CHAR,sname,20,&sName);
            SQLBindCol(hstmt,3,SQL_C_CHAR,ssex,10,&sSex);
            ret=SQLFetch(hstmt);//移动光标
            if(ret == SQL_NO_DATA){
                printf("未找到该学生！\n");
            }
            while(ret != SQL_NO_DATA){
                printf("%s %s %s\n",sno,sname,ssex);
                ret=SQLFetch(hstmt);
            }
        }
        else{
            printf("查询失败！\n");
        }
        SQLDisconnect(hdbc);//断开与数据库的连接
	}
	else{
        printf("数据库连接失败！\n");
	}
	SQLFreeHandle(SQL_HANDLE_DBC,hdbc);//释放连接句柄
	SQLFreeHandle(SQL_HANDLE_ENV,henv);//释放环境句柄
}
//插入
void Insert(){
	if(ret==SQL_SUCCESS || ret==SQL_SUCCESS_WITH_INFO){
		ret=SQLAllocHandle(SQL_HANDLE_STMT,hdbc,&hstmt);
        SQLCHAR sql[] = "INSERT INTO Student VALUES(?,?,?)";
        SQLINTEGER P = SQL_NTS;
        printf("请输入学号:\n");
        scanf("%s",sno);
        printf("请输入姓名:\n");
        scanf("%s",sname);
        printf("请输入性别:\n");
        scanf("%s",ssex);
        ret = SQLPrepare(hstmt,sql,SQL_NTS);
        ret=SQLBindParameter(hstmt,1,SQL_PARAM_INPUT,SQL_C_CHAR,SQL_VARCHAR,20,0,sno,20,&P);
        ret=SQLBindParameter(hstmt,2,SQL_PARAM_INPUT,SQL_C_CHAR,SQL_VARCHAR,20,0,sname,20,&P);
        ret=SQLBindParameter(hstmt,3,SQL_PARAM_INPUT,SQL_C_CHAR,SQL_VARCHAR,10,0,ssex,20,&P);
        ret = SQLExecute(hstmt);
        if(ret==SQL_SUCCESS || ret==SQL_SUCCESS_WITH_INFO){
            printf("添加成功！\n");
        }
        else{
            printf("添加失败！\n");
        }
        SQLDisconnect(hdbc);
	}
	else{
        printf("数据库连接失败！\n");
	}
	SQLFreeHandle(SQL_HANDLE_DBC,hdbc);//释放连接句柄
	SQLFreeHandle(SQL_HANDLE_ENV,henv);
}
//删除
void Delete(){
    if(ret==SQL_SUCCESS || ret==SQL_SUCCESS_WITH_INFO){
        ret=SQLAllocHandle(SQL_HANDLE_STMT,hdbc,&hstmt);//申请SQL语句句柄
        SQLCHAR sql[]="DELETE FROM Student WHERE sno = ? ";
        SQLINTEGER P = SQL_NTS;
        printf("请输入你要删除学生的学号！\n");
        scanf("%s",myID);
        ret=SQLPrepare(hstmt,sql,SQL_NTS);
        ret=SQLBindParameter(hstmt,1,SQL_PARAM_INPUT,SQL_C_CHAR,SQL_VARCHAR,50,0,myID,50,&P);//绑定参数
        ret=SQLExecute(hstmt);
        if(ret==SQL_SUCCESS || ret==SQL_SUCCESS_WITH_INFO){
            printf("删除成功！\n");
        }
        else{
            printf("未找到该学生！\n");
        }
        SQLDisconnect(hdbc);
    }
    else{
        printf("数据库连接失败！\n");
    }
    SQLFreeHandle(SQL_HANDLE_DBC,hdbc);//释放连接句柄
	SQLFreeHandle(SQL_HANDLE_ENV,henv);//释放环境句柄
}

//修改
void Update(){
    int mark=0;
    printf("请输入你要修改的学生学号！\n");
    scanf("%s",myID);
    ret=SQLAllocHandle(SQL_HANDLE_STMT,hdbc,&hstmt);//申请SQL语句句柄
    SQLCHAR sql[]="SELECT * FROM Student WHERE sno = ? ";
    SQLINTEGER p = SQL_NTS;
    ret=SQLPrepare(hstmt,sql,SQL_NTS);//准备SQL语句
    ret=SQLBindParameter(hstmt,1,SQL_PARAM_INPUT,SQL_C_CHAR,SQL_VARCHAR,50,0,myID,50,&p);//绑定参数
    ret=SQLExecute(hstmt);
    if(ret==SQL_SUCCESS || ret==SQL_SUCCESS_WITH_INFO){
        SQLBindCol(hstmt,1,SQL_C_CHAR,sno,20,&sNo);
        SQLBindCol(hstmt,2,SQL_C_CHAR,sname,20,&sName);
        SQLBindCol(hstmt,3,SQL_C_CHAR,ssex,10,&sSex);
        ret=SQLFetch(hstmt);//移动光标
        if(ret == SQL_NO_DATA){
            printf("未找到该学生！\n");
        }
        while(ret != SQL_NO_DATA){
            printf("%s %s %s\n",sno,sname,ssex);
            mark = 1;
            ret=SQLFetch(hstmt);
        }
    }
    else{
        printf("查询失败！\n");
    }
    LinkDatabase();
    if(mark == 1){
		if(ret==SQL_SUCCESS || ret==SQL_SUCCESS_WITH_INFO){
			ret=SQLAllocHandle(SQL_HANDLE_STMT,hdbc,&hstmt);//申请SQL语句句柄
			SQLCHAR sql[]="UPDATE Student SET sname=? WHERE sno=?";
			SQLINTEGER P = SQL_NTS;
			printf("请输入新的学生姓名！\n");
			scanf("%s",sname);
			ret=SQLPrepare(hstmt,sql,SQL_NTS);//准备SQL语句
			ret=SQLBindParameter(hstmt,1,SQL_PARAM_INPUT,SQL_C_CHAR,SQL_VARCHAR,20,0,sname,20,&P);
			ret=SQLBindParameter(hstmt,2,SQL_PARAM_INPUT,SQL_C_CHAR,SQL_VARCHAR,50,0,myID,50,&P);//绑定参数
			ret=SQLExecute(hstmt);//执行SQL语句
			if(ret==SQL_SUCCESS || ret==SQL_SUCCESS_WITH_INFO){
				printf("修改成功！\n");
			}
			else{
				printf("修改失败！\n");
			}
			SQLDisconnect(hdbc);//断开与数据库的连接
		}
		else{
			printf("数据库连接失败！\n");
		}
		SQLFreeHandle(SQL_HANDLE_DBC,hdbc);//释放连接句柄
		SQLFreeHandle(SQL_HANDLE_ENV,henv);//释放环境句柄
    }
}
//显示全部学生信息
void Showall(){
    if(ret==SQL_SUCCESS || ret==SQL_SUCCESS_WITH_INFO){
    ret=SQLAllocHandle(SQL_HANDLE_STMT,hdbc,&hstmt);//申请SQL语句句柄
    SQLCHAR sqlString[]="SELECT * FROM Student";
	ret=SQLExecDirect(hstmt,sqlString,SQL_NTS);//直接执行SQL语句
	if(ret==SQL_SUCCESS || ret==SQL_SUCCESS_WITH_INFO)
           {
	    while(SQLFetch(hstmt)!=SQL_NO_DATA){//遍历结果集
            SQLGetData(hstmt,1,SQL_C_CHAR,sno,20,&sNo);
            SQLGetData(hstmt,2,SQL_C_CHAR,sname,20,&sName);
            SQLGetData(hstmt,3,SQL_C_CHAR,ssex,10,&sSex);
            printf("%s %s %s \n",sno,sname,ssex);
        }
    SQLFreeHandle(SQL_HANDLE_STMT,hstmt);//释放语句句柄
    }else printf("查询数据库操作失败！\n");
    SQLDisconnect(hdbc);//断开与数据库的连接
    }
    else //printf("连接数据库失败!\n");
    SQLFreeHandle(SQL_HANDLE_DBC,hdbc);//释放连接句柄
    SQLFreeHandle(SQL_HANDLE_ENV,henv);//释放环境句柄
}

int main(){
    while(1){
        printf("请输入对应数字进行下一步操作:\n1.添加学生信息\n2.查找学生信息\n3.修改学生信息\n4.删除学生信息\n5.显示学生信息\n6.退出系统\n");
        LinkDatabase();
        int c;
        scanf("%d",&c);
        switch(c){
            case 1:Insert();break;
            case 2:Select();break;
            case 3:Update();break;
            case 4:Delete();break;
            case 5:Showall();break;
            case 6:return 0;break;
        }
    }
}

// CREATE DATABASE Students;

// CREATE TABLE Student(
//   sno int  NOT NULL,
//   sname varchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
//   ssex nchar(10) COLLATE Chinese_PRC_CI_AS DEFAULT '男' NOT NULL
// )

// INSERT INTO Student (sno, sname, ssex) VALUES ('1', '文章', '男')
// INSERT INTO Student (sno, sname, ssex) VALUES ('2', '罗杰', '男')
// INSERT INTO Student (sno, sname, ssex) VALUES ('3', '卫佳', '男')
// INSERT INTO Student (sno, sname, ssex) VALUES ('4', '郭昱', '男')
// INSERT INTO Student (sno, sname, ssex) VALUES ('5', '闻锋', '男')
// INSERT INTO Student (sno, sname, ssex) VALUES ('6', '李四', '男')
// INSERT INTO Student (sno, sname, ssex) VALUES ('7', '张洁', '女')
// INSERT INTO Student (sno, sname, ssex) VALUES ('8', '夏林', '男')
// INSERT INTO Student (sno, sname, ssex) VALUES ('9', '胡姗', '男')
// INSERT INTO Student (sno, sname, ssex) VALUES ('10','张三', '男')