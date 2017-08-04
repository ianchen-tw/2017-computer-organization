#include <iostream>
#include <stdio.h>
#include <math.h>
#define N 1 // N-way set
using namespace std;

struct P{
    unsigned int tagg; // tag
    unsigned int lru; // time
    bool v;
};

struct cache_content{
    P OO[N]; // tag + time + valid bit
//	unsigned int	data[16];
};

const int K=1024;

double log2( double n )
{
    // log(n)/log(2) is log2.
    return log( n ) / log(2)+0.5 ;
}


void simulate(int cache_size, int block_size){
    //
	double miss_count=0;
	double hit_count=0;
	int time=0;
	bool isMiss;
    //

	unsigned int tag,index,x;

	int offset_bit = (int) log2(block_size);
	int index_bit = (int) log2(cache_size/(block_size*N));
	int line= (cache_size>>(offset_bit))/N; // how many set

	cache_content *cache =new cache_content[line];
	//cout<<"cache line:"<<line<<endl;

	for(int j=0;j<line;j++){
        for(int k=0;k<N;k++){
            cache[j].OO[k].lru=0;
            cache[j].OO[k].v=false;
        }
	}


  FILE * fp=fopen("LU.txt","r");					//read file

	while(fscanf(fp,"%x",&x)!=EOF){
	    // when read a data, time++
        time++;
        isMiss=true;
		//cout<<hex<<x<<" ";
		index=(x>>offset_bit)&(line-1);
		tag=x>>(index_bit+offset_bit);

        // valid bit is  true
        for(int i=0;i<N;i++){
            if(cache[index].OO[i].tagg==tag && cache[index].OO[i].v){ // hit
                cache[index].OO[i].lru=time; // update what time is used
                hit_count++;
                isMiss=false;
                break;
            }
        }

		if(isMiss==true){ // miss
			int mini=time;
			int a=0;
			// choose the least recently used to replace
			for(int i=0;i<N;i++){
				if(cache[index].OO[i].lru<mini){
					mini=cache[index].OO[i].lru;
		            a=i;
				}
			}
			cache[index].OO[a].lru=time;
			cache[index].OO[a].v=true;
			cache[index].OO[a].tagg=tag;
			miss_count++;
		}

	}
	fclose(fp);

	cout << miss_count/(miss_count+hit_count)*100 << "% " << endl;

	delete [] cache;
}

int main(){
	// Let us simulate 4KB cache with 16B blocks
	simulate(1*K, 64);
    simulate(2*K, 64);
    simulate(4*K, 64);
    simulate(8*K, 64);
    simulate(16*K, 64);
    simulate(32*K, 64);
}
