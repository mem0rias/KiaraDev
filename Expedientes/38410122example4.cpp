/*----------------------------------------------------------------

*

* Multiprocesadores: TBB

* Fecha: 31-Oct-2022

* Autores: Guillermo Fidel Navarro Vega A01274191
		   Audrey Sofia Nava Utrera     A01740902

*
    Speedup: 2.93
*--------------------------------------------------------------*/
// =================================================================
//
// File: example4.cpp
// Authors:
// Description: This file contains the code to count the number of
//				even numbers within an array using Intel's TBB.
//              To compile: g++ example4.cpp -ltbb
//
// Copyright (c) 2020 by Tecnologico de Monterrey.
// All Rights Reserved. May be reproduced for any non-commercial
// purpose.
//
// =================================================================

#include <iostream>
#include <iomanip>
#include <cmath>
#include <tbb/parallel_reduce.h>
#include <tbb/blocked_range.h>
#include "utils.h"

#define SIZE 1000000000 //1e9

using namespace std;
using namespace tbb;

// place your code here
class EvenCounter{
	private:
		int *Array;
		int size;
        int result = 0;
	public:
		int Evens;
		int getResult() const;
		EvenCounter(EvenCounter &x, split) : Array(x.Array), result(0) {}
		//Constructor
		EvenCounter(int *a, int s);
		//Destructor
		~EvenCounter();
		//Methods
        void operator() (const blocked_range<int> &r);
        void join(const EvenCounter &x);
		void ChangeArray(int *a, int s);
	

};

EvenCounter::EvenCounter(int *a, int s){
	Array = a;
	size = s;
}


EvenCounter::~EvenCounter(){
	Array = nullptr;
}
void EvenCounter::operator() (const blocked_range<int> &r){
	for(int i = r.begin(); i < r.end(); i++){
		if(Array[i]%2 == 0)
			result++;
	}
}

void EvenCounter::join(const EvenCounter &x){
    result += x.result;
}

int EvenCounter::getResult() const {
    return result;
}

void EvenCounter::ChangeArray(int *a, int s){
	Array = a;
	size = s;
}



int main(int argc, char* argv[]) {
	int *a;
	double ms;
	int result;
	a = new int[SIZE];
	fill_array(a, SIZE);
	display_array("a", a);
	
	cout << "Starting..." << endl;
	ms = 0;
	// create object here
	for (int i = 0; i < N; i++) {
		start_timer();
		EvenCounter count(a, SIZE);
		// call your method here.
        parallel_reduce(blocked_range<int>(0, SIZE),count);
        result = count.getResult();
		ms += stop_timer();
	}
	cout << "result = " << setprecision(2) << result << " ";
	cout << "avg time = " << setprecision(15) << (ms / N) << " ms" << endl;

	delete [] a;
	return 0;
}
