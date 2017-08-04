#include <iostream>
#include <stdio.h>
#include <math.h>

using namespace std;

struct cache_content{
	bool v;
	unsigned int  tag;
//	unsigned int	data[16];
};

const int K=1024;

double log2( double n )
{
    // log(n)/log(2) is log2.
    return log( n ) / log(2) ;
}

void simulate(int cache_size, int block_size){
    //
	double miss_count=0;
	double hit_count=0;
    //

	unsigned int tag,index,x;

	int offset_bit = (int) round(log2(block_size));
	int index_bit = (int) round(log2(cache_size/block_size));
	int line= cache_size>>(offset_bit);

	cache_content *cache =new cache_content[line];
	cout<<"cache line:"<<line<<endl;

	for(int j=0;j<line;j++)
		cache[j].v=false;

  FILE * fp=fopen("DCACHE.txt","r");					//read file

	while(fscanf(fp,"%x",&x)!=EOF){
		//cout<<hex<<x<<" ";
		index=(x>>offset_bit)&(line-1);
		tag=x>>(index_bit+offset_bit);
		if(cache[index].v && cache[index].tag==tag){
			cache[index].v=true; 			//hit
			hit_count++;
		}
		else{
			cache[index].v=true;			//miss
			cache[index].tag=tag;
			miss_count++;
		}
	}
	fclose(fp);

	cout << miss_count/(miss_count+hit_count)*100 << "% " << endl;

	delete [] cache;
}

int main(){
	// Let us simulate 4KB cache with 16B blocks
	simulate(4*K, 16);
	simulate(4*K, 32);
	simulate(4*K, 64);
	simulate(4*K, 128);
	simulate(4*K, 256);
}
