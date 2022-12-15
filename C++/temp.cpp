#include <iostream>
#include <iomanip>
using namespace std;
int main()
{
double x = 9876543.21,y = 76.54321;
int n = 7654321;
int m = 21;
cout << setiosflags(ios::fixed) <<
setprecision(6) << x << endl
<< y << endl << n << endl << m;
}