/*----------------------------------------------------------------

*

* Multiprocesadores: TBB

* Fecha: 31-Oct-2022

* Autores: Guillermo Fidel Navarro Vega A01274191
		   Audrey Sofia Nava Utrera     A01740902

*
    Speedup: 4.06
*--------------------------------------------------------------*/
// =================================================================
//
// File: example8.cpp
// Author: Pedro Perez
// Description: This file contains the code that implements the
//				enumeration sort algorithm using Intel's TBB.
//				To compile: g++ example8.cpp -ltbb
//
// Copyright (c) 2020 by Tecnologico de Monterrey.
// All Rights Reserved. May be reproduced for any non-commercial
// purpose.
//
// =================================================================

#include <iostream>
#include <iomanip>
#include <cstring>
#include <cmath>
#include <tbb/parallel_for.h>
#include <tbb/blocked_range.h>
#include "utils.h"

const int SIZE = 100000;

using namespace std;
using namespace tbb;

// place your code here
class EnumerationSort {
private:
	int *CopyArray(int *array) const {
		
		int *b = new int[size];
		for (int i = 0; i < size; i++) {
			b[i] = array[i];
		}
		return b;
	}
	int *a;
	int size;

public:
	EnumerationSort(int *array, int s) : a(array), size(s) {}

	void operator() (const blocked_range<int> &r) const {
		int aux = 0;
		int *b;
		b = CopyArray(a);
		for (int i = r.begin(); i < r.end(); i++) {
			aux = 0;
			for (int j = 0; j < size; j++) {
				if (b[i] > b[j]) {
					aux++;
				} else if (b[i] == b[j] && j < i) {
					aux++;
				}
			}
			a[aux] = b[i];
		}
		delete[] b;
	}

	int *Sorted() {
		return a;
	}
};


int main(int argc, char *argv[]) {
	int *a;
	double ms;
	int *res;
	a = new int[SIZE];

	random_array(a, SIZE);
	display_array("before", a);

	cout << "Starting..." << endl;
	ms = 0;
	// create object here
	for (int i = 0; i < N; i++) {
		start_timer();
		parallel_for(blocked_range<int>(0,SIZE), EnumerationSort(a, SIZE));
		
		// call your method here.
		
		ms += stop_timer();
	}

	display_array("after", a);
	cout << "avg time = " << setprecision(15) << (ms / N) << " ms" << endl;

	delete[] a;
	return 0;
}
