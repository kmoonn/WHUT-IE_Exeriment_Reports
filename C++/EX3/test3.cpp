#include <iostream>
#include <string.h>
using namespace std;


class Date{ //日期类
    int year;
    int month;
    int day;
    public:
        Date() {} //默认构造
        Date(int y, int m, int d){ //含参构造
            year = y;
            month = m;
            day = d;
        }
    void set(){ //设置数据函数
        cin >> year >> month >> day;
    }
    void show(){ //显示函数
        cout << year << " Year " << month << " Month " << day << " Day ";
    }
};
class People{ //人员类
    char name[11];
    char number[20];
    char sex;
    Date birthday;  //日期类内嵌子对象
    char ID[30];
    public:
        People(){}; //默认构造
        People(char n[11], char num[7],int y, int m, int d, char id[20], char s = 'm') : birthday(y, m, d){     //有默认值的带参构造
            strcpy(name,n);
            strcpy(number,num);
            sex = s;
            strcpy(ID, id);
        };                
        People(People &p){              //拷贝构造函数
            strcpy(name,p.name);
            strcpy(number,p.number);
            sex = p.sex;
            birthday = p.birthday;
            strcpy(ID, p.ID);
        }
        //内联成员函数
        void input(){ //输入函数
            cout << "Name:";
            cin >> name;
            cout << "Number:";
            cin >> number;
            cout << "Sex(m/f):";
            cin >> sex;
            cout << "Birthday(Year/Month/Day):";
            birthday.set();
            cout << "ID:";
            cin >> ID;
            cout << "--- --- --- --- ---\n";
        };
        void output(){ //输出函数
            cout << "录入的学生信息:" << endl;
            cout << "Number:" << number << endl;
            cout << "Name:" << name << endl;
            cout << "Sex:" << sex << endl;
            cout << "Birthday:";
            birthday.show();    
            cout << endl;
            cout << "ID:" << ID << endl;
        };
        ~People(){ //析构函数
            cout << "录入成功!." << endl;
        }
};

//Part 2
class student : public People{
    char classNO[10];
    public:
        student(){}
        void input(){
            People::input();
            cout << "请输入班级编号:" << endl;
            cin >> classNO;
        }
        void output(){
            People::output();
            cout << "班级编号:" << classNO << endl;
        }
};
class teacher : public People{
    char pship[11], departt[21];
    public:
        teacher(){}
        void input(){
            People::input();
            cout << "请输入职务:" << endl;
            cin >> pship;
            cout << "请输入部门:" << endl;
            cin >> departt;
        }
        void output(){
            People::output();
            cout<<"职务: "<<pship<<endl;
            cout<<"部门: "<<departt<<endl;
        }
    };

class graduate : public student{
        char subject[21], adviser[21];
        public:
            graduate(){}
            void input(){
                student::input();
                cout << "请输入专业: " << endl;
                cin >> subject;
                cout << "请输入导师: " << endl;
                cin >> adviser;
            }
            void output(){
                student::output();
                cout << "专业: " << subject << endl;
                cout << "导师: " << adviser << endl;
            }
};
class TA: public graduate, teacher{
    public:
        TA(){}
        void input(){
            graduate::input();
            teacher::input();
        }
        void output(){
            graduate::output();
            teacher::output();
        }
};

int main(){
    People p;
    student s;
    teacher t;
    graduate g;
    TA T;

    cout << "请输入人员信息" << endl;
    p.input();
    cout << "请输入学生信息" << endl;
    s.input();
    cout << "请输入教师信息" << endl;
    t.input();
    cout << "请输入研究生信息" << endl;
    g.input();
    cout << "请输入助教博士生信息" << endl;
    T.input();
    cout << "人员信息: "<< endl;
    p.output();
    cout << "学生信息:"<< endl;
    s.output();
    cout << "教师信息: "<< endl;
    t.output();
    cout << "研究生信息: "<< endl;
    g.output();
    cout << "助教博士生信息: "<< endl;
    T.output();
    return 0;
}