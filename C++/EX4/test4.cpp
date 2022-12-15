#include <iostream>
#include <fstream>
using namespace std;

void insertion_sort(int arr[], int len){    //插入排序函数
    int i,j,temp;
    for (i=1;i<len;i++){
            temp = arr[i];
            for (j=i;j>0 && arr[j-1]>temp;j--)
                    arr[j] = arr[j-1];
            arr[j] = temp;}
}
int main(){
    ofstream out("EE-2022-Exercise.txt");   //新建文件
    if(!out){
        cout<<"无法打开该文件\n";
        return 1;
    }
    cout<<"新建文件成功\n";
    int i,k=0;
    int array[174];
    for(i=0;i<174;i++)  //生成随机数,写入文件
        array[i]=rand()%100;
    for(i=0;i<174;i++)
        out<<array[i]<<" ";
        cout<<"写入文件成功\n";
        out.close();
    //打开文件
    ifstream in("EE-2022-Exercise.txt");
    if(!in){
        cout<<"无法打开文件\n";
        return 1;
    }
    cout<<"打开文件成功\n";
    cout<<"文件内容如下:"<<endl;
    insertion_sort(array,174);  //进行插入排序后输出
    for(i=0;i<174;i++){
        cout<<array[i]<<" ";
        k++;
        if(k%15==0) cout<<endl;
    }
    in.close();
    return 0;
}