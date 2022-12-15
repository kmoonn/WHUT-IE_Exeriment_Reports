//C++程序设计 课内实验
//实验一 类与对象的操作实验
//author: 信息2001 胡姗

#include <iostream>
#include <string.h>
#include <iomanip>
using namespace std;

//定义一个学生类Student
class Student{
    public:
        //含参构造函数
        Student(int s_id,string s_name,double s_score);
        //修改分数的成员函数
        void ChangeScore();
        //输出平均分的静态成员函数
        static void GetAverage();
    private:
        int id;
        string name;
        double score;
        static double total;
        static int count;
};

//静态成员变量初始化
double Student::total=0;
int Student::count=0;

//成员函数定义
void Student::ChangeScore(){
    total+=score;
    count++;
};

void Student::GetAverage(){
	cout<<setprecision(4);  //输出保留2位小数
    cout<<"分数平均分为:"<<total/count<<"分"<<endl;
};

//构造函数初始化
Student::Student(int i,string n,double s):id(i),name(n),score(s){};

int main(){
    int id;
    string name;
    double score;
    int num;
    cout<<"请输入学生人数:"<<endl;
    cin>>num;
    cout<<"学生人数为"<<num<<"人"<<endl;
    for(int i=0;i<num;i++){
        cout<<"请输入学生学号,姓名,分数:"<<endl;
        cin>>id>>name>>score;
        Student stu(id,name,score);
        stu.ChangeScore();
        
    }
    Student::GetAverage();
    return 0;
};