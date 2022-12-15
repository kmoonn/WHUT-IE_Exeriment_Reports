#include <iostream>
#include <ctime>
#include <fstream>

using namespace std;

int random(int a, int b){
    srand((int)time(0));         // 随机数种子
    return rand() % (b - a) + a; //生成范围内随机数
}

int main(){
    ofstream out;
    out.open("out.txt", ios::app);

    srand((int)time(0)); // 产生随机种子

    int num = random(1,87);
    cout << num<< endl;
    out << num << " ";
    out << "\n";
    out.close();
    return 0;
}
