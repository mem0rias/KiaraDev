/*----------------------------------------------------------------

*

* Multiprocesadores: TBB

* Fecha: 31-Oct-2022

* Autores: Guillermo Fidel Navarro Vega A01274191
		   Audrey Sofia Nava Utrera     A01740902

*
    Speedup: 5.702
*--------------------------------------------------------------*/
// =================================================================
//
// File: example7.cpp
// Author: Pedro Perez
// Description: This file contains the code to brute-force all
//				prime numbers less than MAXIMUM using Intel's TBB.
//				To compile: g++ example7.cpp -ltbb
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
#include <tbb/parallel_reduce.h>
#include <tbb/blocked_range.h>
#include "utils.h"

const int MAXIMUM = 1000000; //1e6

using namespace std;
using namespace tbb;

// place your code here
class primeNumbers{
	private:
		int max;
        double result = 0;
		int isPrime(int val){
			if(val < 2)
				return 0;
			for(int i = 2; i <= sqrt(val); i++){
				if(val%i == 0)
					return 0;
			}
			return 1;
		}
	public:
		primeNumbers(int s){max = s; result = 0;}
        primeNumbers(primeNumbers &x, split) : max(x.max), result(0) {}
		void operator() (const blocked_range<int> &r) {
            for(int i = r.begin(); i < r.end(); i++){
                if(isPrime(i))
                    result += i;
            }
        }
        
       void join(const primeNumbers &x){
            result += x.result;
       }

       double getResult() const {
            return result;
       }
	
};



int main(int argc, char* argv[]) {
	int i;
	double ms;
	double result;
	cout << "Starting..." << endl;
	ms = 0;
	// create object here
	for (int i = 0; i < N; i++) {
		start_timer();
		primeNumbers primos(MAXIMUM);
        parallel_reduce(blocked_range<int>(0,MAXIMUM), primos);
        result = primos.getResult();
		// call your method here.

		ms += stop_timer();
	}
	cout << "result = " << setprecision(2) << result << " ";
	cout << "avg time = " << setprecision(15) << (ms / N) << " ms" << endl;
	return 0;
}
