#include <fstream>
#include <iostream>
#include <sstream>
#include <string>
#include <vector>
using namespace std;

void insertion_sort(int arr[], int len) //插入排序函数
{
    int i, j, temp;
    for (i = 1; i < len; i++)
    {
        temp = arr[i];
        for (j = i; j > 0 && arr[j - 1] > temp; j--)
            arr[j] = arr[j - 1];
        arr[j] = temp;
    }
}


int main()
{
    vector<vector<string>> data;
    ifstream infile("in.txt");
    int array[100];
    int i = 0,j=0;

    while (infile)
    {
        string s;
        if (!getline(infile, s))
            break;

        istringstream ss(s);
        vector<string> record;

        while (ss)
        {
            string s;
            if (!getline(ss, s, ','))
                break;
            record.push_back(s);
        }
        for (auto x : record)
        {
            // c_str()：生成一个const char*指针，指向以空字符终止的数组。
            // cout << atoi(x.c_str()) << " "; // string转int
            array[i++] = atoi(x.c_str());
        }
        cout << endl;
        data.push_back(record);
    }

    if (!infile.eof())
    {
        cerr << "Error!\n";
    }

    insertion_sort(array,i);    //进行插入排序
    for(j=0;j<i;j++)
        cout<<array[j]<<" ";    //输出排序后的数字

    ofstream out("out.txt");   //新建文件
    if(!out){
        cout<<"无法打开该文件\n";
        return 1;
    }
    //写入文件
    for(j=0;j<i;j++)
        out<<array[j]<<" ";
    out.close();
}