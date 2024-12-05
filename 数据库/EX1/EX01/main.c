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

// ����
void LinkDatabase(){
    ret=SQLAllocHandle(SQL_HANDLE_ENV,NULL,&henv);//���뻷�����
    ret=SQLSetEnvAttr(henv,SQL_ATTR_ODBC_VERSION,(SQLPOINTER)SQL_OV_ODBC3,SQL_IS_INTEGER);//���û�������
    ret=SQLAllocHandle(SQL_HANDLE_DBC,henv,&hdbc);//�������ݿ����Ӿ��
	ret=SQLConnect(hdbc,(SQLCHAR*)"MSSQL_EX1",SQL_NTS,(SQLCHAR*)"sa",SQL_NTS,(SQLCHAR*)"123456",SQL_NTS);//�������ݿ�
}
//��ѯ
void Select(){
    if(ret==SQL_SUCCESS || ret==SQL_SUCCESS_WITH_INFO){
        ret=SQLAllocHandle(SQL_HANDLE_STMT,hdbc,&hstmt);//����SQL�����
        SQLCHAR sql[]="SELECT * FROM Student WHERE sno = ? ";
        SQLINTEGER p = SQL_NTS;
        printf("��������Ҫ���ҵ�ѧ��ѧ��:\n");
        scanf("%s",myID);
        ret=SQLPrepare(hstmt,sql,SQL_NTS);//׼��SQL���
        ret=SQLBindParameter(hstmt,1,SQL_PARAM_INPUT,SQL_C_CHAR,SQL_VARCHAR,50,0,myID,50,NULL);//�󶨲���
        ret=SQLExecute(hstmt);
        if(ret==SQL_SUCCESS || ret==SQL_SUCCESS_WITH_INFO){
            SQLBindCol(hstmt,1,SQL_C_CHAR,sno,20,&sNo);
            SQLBindCol(hstmt,2,SQL_C_CHAR,sname,20,&sName);
            SQLBindCol(hstmt,3,SQL_C_CHAR,ssex,10,&sSex);
            ret=SQLFetch(hstmt);//�ƶ����
            if(ret == SQL_NO_DATA){
                printf("δ�ҵ���ѧ�� ��\n");
            }
            while(ret != SQL_NO_DATA){
                printf("%s %s %s\n",sno,sname,ssex);
                ret=SQLFetch(hstmt);
            }
        }
        else{
            printf("��ѯʧ�ܣ�\n");
        }
        SQLDisconnect(hdbc);//�Ͽ������ݿ������
	}
	else{
        printf("���ݿ�����ʧ�ܣ�\n");
	}
	SQLFreeHandle(SQL_HANDLE_DBC,hdbc);//�ͷ����Ӿ��
	SQLFreeHandle(SQL_HANDLE_ENV,henv);//�ͷŻ������
}
//����
void Insert(){
	if(ret==SQL_SUCCESS || ret==SQL_SUCCESS_WITH_INFO){
		ret=SQLAllocHandle(SQL_HANDLE_STMT,hdbc,&hstmt);
        SQLCHAR sql[] = "INSERT INTO Student VALUES(?,?,?)";
        SQLINTEGER P = SQL_NTS;
        printf("������ѧ��:\n");
        scanf("%s",sno);
        printf("����������:\n");
        scanf("%s",sname);
        printf("�������Ա�:\n");
        scanf("%s",ssex);
        ret = SQLPrepare(hstmt,sql,SQL_NTS);
        ret=SQLBindParameter(hstmt,1,SQL_PARAM_INPUT,SQL_C_CHAR,SQL_VARCHAR,20,0,sno,20,&P);
        ret=SQLBindParameter(hstmt,2,SQL_PARAM_INPUT,SQL_C_CHAR,SQL_VARCHAR,20,0,sname,20,&P);
        ret=SQLBindParameter(hstmt,3,SQL_PARAM_INPUT,SQL_C_CHAR,SQL_VARCHAR,10,0,ssex,20,&P);
        ret = SQLExecute(hstmt);
        if(ret==SQL_SUCCESS || ret==SQL_SUCCESS_WITH_INFO){
            printf("��ӳɹ���\n");
        }
        else{
            printf("���ʧ�ܣ�\n");
        }
        SQLDisconnect(hdbc);
	}
	else{
        printf("���ݿ�����ʧ�ܣ�\n");
	}
	SQLFreeHandle(SQL_HANDLE_DBC,hdbc);//�ͷ����Ӿ��
	SQLFreeHandle(SQL_HANDLE_ENV,henv);
}
//ɾ��
void Delete(){
    if(ret==SQL_SUCCESS || ret==SQL_SUCCESS_WITH_INFO){
        ret=SQLAllocHandle(SQL_HANDLE_STMT,hdbc,&hstmt);//����SQL�����
        SQLCHAR sql[]="DELETE FROM Student WHERE sno = ? ";
        SQLINTEGER P = SQL_NTS;
        printf("��������Ҫɾ��ѧ����ѧ�ţ�\n");
        scanf("%s",myID);
        ret=SQLPrepare(hstmt,sql,SQL_NTS);
        ret=SQLBindParameter(hstmt,1,SQL_PARAM_INPUT,SQL_C_CHAR,SQL_VARCHAR,50,0,myID,50,&P);//�󶨲���
        ret=SQLExecute(hstmt);
        if(ret==SQL_SUCCESS || ret==SQL_SUCCESS_WITH_INFO){
            printf("ɾ���ɹ���\n");
        }
        else{
            printf("δ�ҵ���ѧ����\n");
        }
        SQLDisconnect(hdbc);
    }
    else{
        printf("���ݿ�����ʧ�ܣ�\n");
    }
    SQLFreeHandle(SQL_HANDLE_DBC,hdbc);//�ͷ����Ӿ��
	SQLFreeHandle(SQL_HANDLE_ENV,henv);//�ͷŻ������
}

//�޸�
void Update(){
    int mark=0;
    printf("��������Ҫ�޸ĵ�ѧ��ѧ�ţ�\n");
    scanf("%s",myID);
    ret=SQLAllocHandle(SQL_HANDLE_STMT,hdbc,&hstmt);//����SQL�����
    SQLCHAR sql[]="SELECT * FROM Student WHERE sno = ? ";
    SQLINTEGER p = SQL_NTS;
    ret=SQLPrepare(hstmt,sql,SQL_NTS);//׼��SQL���
    ret=SQLBindParameter(hstmt,1,SQL_PARAM_INPUT,SQL_C_CHAR,SQL_VARCHAR,50,0,myID,50,&p);//�󶨲���
    ret=SQLExecute(hstmt);
    if(ret==SQL_SUCCESS || ret==SQL_SUCCESS_WITH_INFO){
        SQLBindCol(hstmt,1,SQL_C_CHAR,sno,20,&sNo);
        SQLBindCol(hstmt,2,SQL_C_CHAR,sname,20,&sName);
        SQLBindCol(hstmt,3,SQL_C_CHAR,ssex,10,&sSex);
        ret=SQLFetch(hstmt);//�ƶ����
        if(ret == SQL_NO_DATA){
            printf("δ�ҵ���ѧ����\n");
        }
        while(ret != SQL_NO_DATA){
            printf("%s %s %s\n",sno,sname,ssex);
            mark = 1;
            ret=SQLFetch(hstmt);
        }
    }
    else{
        printf("��ѯʧ�ܣ�\n");
    }
    LinkDatabase();
    if(mark == 1){
		if(ret==SQL_SUCCESS || ret==SQL_SUCCESS_WITH_INFO){
			ret=SQLAllocHandle(SQL_HANDLE_STMT,hdbc,&hstmt);//����SQL�����
			SQLCHAR sql[]="UPDATE Student SET sname=? WHERE sno=?";
			SQLINTEGER P = SQL_NTS;
			printf("�������µ�ѧ��������\n");
			scanf("%s",sname);
			ret=SQLPrepare(hstmt,sql,SQL_NTS);//׼��SQL���
			ret=SQLBindParameter(hstmt,1,SQL_PARAM_INPUT,SQL_C_CHAR,SQL_VARCHAR,20,0,sname,20,&P);
			ret=SQLBindParameter(hstmt,2,SQL_PARAM_INPUT,SQL_C_CHAR,SQL_VARCHAR,50,0,myID,50,&P);//�󶨲���
			ret=SQLExecute(hstmt);//ִ��SQL���
			if(ret==SQL_SUCCESS || ret==SQL_SUCCESS_WITH_INFO){
				printf("�޸ĳɹ���\n");
			}
			else{
				printf("�޸�ʧ�ܣ�\n");
			}
			SQLDisconnect(hdbc);//�Ͽ������ݿ������
		}
		else{
			printf("���ݿ�����ʧ�ܣ�\n");
		}
		SQLFreeHandle(SQL_HANDLE_DBC,hdbc);//�ͷ����Ӿ��
		SQLFreeHandle(SQL_HANDLE_ENV,henv);//�ͷŻ������
    }
}
//��ʾȫ��ѧ����Ϣ
void Showall(){
    if(ret==SQL_SUCCESS || ret==SQL_SUCCESS_WITH_INFO){
    ret=SQLAllocHandle(SQL_HANDLE_STMT,hdbc,&hstmt);//����SQL�����
    SQLCHAR sqlString[]="SELECT * FROM Student";
	ret=SQLExecDirect(hstmt,sqlString,SQL_NTS);//ֱ��ִ��SQL���
	if(ret==SQL_SUCCESS || ret==SQL_SUCCESS_WITH_INFO)
           {
	    while(SQLFetch(hstmt)!=SQL_NO_DATA){//���������
            SQLGetData(hstmt,1,SQL_C_CHAR,sno,20,&sNo);
            SQLGetData(hstmt,2,SQL_C_CHAR,sname,20,&sName);
            SQLGetData(hstmt,3,SQL_C_CHAR,ssex,10,&sSex);
            printf("%s %s %s \n",sno,sname,ssex);
        }
    SQLFreeHandle(SQL_HANDLE_STMT,hstmt);//�ͷ������
    }else printf("��ѯ���ݿ����ʧ�ܣ�\n");
    SQLDisconnect(hdbc);//�Ͽ������ݿ������
    }
    else //printf("�������ݿ�ʧ��!\n");
    SQLFreeHandle(SQL_HANDLE_DBC,hdbc);//�ͷ����Ӿ��
    SQLFreeHandle(SQL_HANDLE_ENV,henv);//�ͷŻ������
}

int main(){
    while(1){
        printf("�������Ӧ���ֽ�����һ������:\n1.���ѧ����Ϣ\n2.����ѧ����Ϣ\n3.�޸�ѧ����Ϣ\n4.ɾ��ѧ����Ϣ\n5.��ʾѧ����Ϣ\n6.�˳�ϵͳ\n");
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
