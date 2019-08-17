#include <iostream>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <opencv2/opencv.hpp>

using namespace std;
using namespace cv;

void full_connect(int input_size, int output_size, double *input, double **weight, double *output, double *bias);
double Relu_activation(double *input, int input_size);
double SoftMax(double *input, int input_size);
double conv1(double ***input, double ***conv1_out, double ****conv1_weight, int cha_size, int out_r_size, int out_c_size, int fch_size, int f_size, int stride, double sum, double *b_weight1);
double pool1(double ***conv1_out, double ***pool1_out, int cha_size, int out_r_size, int out_c_size, int fch_size, int f_size, int stride, double sum, double max);
double conv2(double ***pool1_out, double ***conv2_out, double ****conv2_weight, int cha_size, int out_r_size, int out_c_size, int fch_size, int f_size, int stride, double sum, double *b_weight2);
double pool2(double ***conv2_out, double ***pool2_out, int cha_size, int out_r_size, int out_c_size, int fch_size, int f_size, int stride, double sum, double max);

int main()
{
	int i, j, k, l, m, n, o, p;
	double max, sum;
	int stride;
	int cha_size, out_r_size, out_c_size;
	int depth, r_size, c_size;
	int fch_size, f_size;
	int input_size, output_size, size, out_size;
	double ***input;
	double ***conv1_out;
	double ***pool1_out;
	double ***conv2_out;
	double ***pool2_out;
	double *change_out;
	double *full1_out;
	double *full2_out;
	double ****conv1_weight;
	double ****conv2_weight;
	double **full_weight3;
	double **full_weight4;
	double *bias;
	double *b_weight1;
	double *b_weight2;
	double *b_weight3;
	double *b_weight4;

	char read;
	
	FILE *fp1;
	FILE *fp2;
	FILE *fp3;
	FILE *fp4;
	FILE *fp5;
	FILE *fp6;
	FILE *fp7;
	FILE *fp8;

	fp1 = fopen("./Conv1W.txt","r");
	fp2 = fopen("./Conv2W.txt","r");
	fp3 = fopen("./Ip1W.txt","r");
	fp4 = fopen("./Ip2W.txt","r");
	fp5 = fopen("./Conv1B.txt","r");
	fp6 = fopen("./Conv2B.txt","r");
	fp7 = fopen("./Ip1B.txt","r");
	fp8 = fopen("./Ip2B.txt","r");

/////////////////////////////////////////////동적 할당//////////////////////////////////////////////

	cha_size = 1;
	r_size = 28;
	c_size = 28;

	input = (double ***)malloc(cha_size*sizeof(double**));

	for(i=0; i<cha_size; i++){
		*(input+i) = (double**)malloc(r_size*sizeof(double*));
		for(j=0; j<r_size; j++){
			*(*(input+i)+j) = (double*)malloc(c_size*sizeof(double));
		}
	}
	
	cha_size = 20;
	r_size = 24;
	c_size = 24;
	conv1_out = (double ***)malloc(cha_size*sizeof(double**));

	for(i=0; i<cha_size; i++){
		*(conv1_out+i) = (double**)malloc(r_size*sizeof(double*));
		for(j=0; j<r_size; j++){
			*(*(conv1_out+i)+j) = (double*)malloc(c_size*sizeof(double));
		}
	}

	cha_size = 20;
	r_size = 12;
	c_size = 12;
	pool1_out = (double ***)malloc(cha_size*sizeof(double**));

	for(i=0; i<cha_size; i++){
		*(pool1_out+i) = (double**)malloc(r_size*sizeof(double*));
		for(j=0; j<r_size; j++){
			*(*(pool1_out+i)+j) = (double*)malloc(c_size*sizeof(double));
		}
	}

	cha_size = 50;
	r_size = 8;
	c_size = 8;
	conv2_out = (double ***)malloc(cha_size*sizeof(double**));

	for(i=0; i<cha_size; i++){
		*(conv2_out+i) = (double**)malloc(r_size*sizeof(double*));
		for(j=0; j<r_size; j++){
			*(*(conv2_out+i)+j) = (double*)malloc(c_size*sizeof(double));
		}
	}

	cha_size = 50;
	r_size = 4;
	c_size = 4;
	pool2_out = (double ***)malloc(cha_size*sizeof(double**));

	for(i=0; i<cha_size; i++){
		*(pool2_out+i) = (double**)malloc(r_size*sizeof(double*));
		for(j=0; j<r_size; j++){
			*(*(pool2_out+i)+j) = (double*)malloc(c_size*sizeof(double));
		}
	}

	size = 800;
	change_out = (double *)malloc(size*sizeof(double));

	size = 500;
	full1_out = (double *)malloc(size*sizeof(double));

	size = 10;
	full2_out = (double *)malloc(size*sizeof(double));

////////////////////////웨이트 값들 할당///////////////////////////////////////////////////////////

	depth = 20;
	cha_size = 1;
	f_size = 5;
	
	conv1_weight = (double ****)malloc(depth*sizeof(double***));

	for(i=0; i<depth; i++){
		*(conv1_weight+i) = (double***)malloc(cha_size*sizeof(double**));
		for(j=0; j<cha_size; j++){
			*(*(conv1_weight+i)+j) = (double**)malloc(f_size*sizeof(double*));
			for(k=0; k<f_size; k++){
				*(*(*(conv1_weight+i)+j)+k) = (double*)malloc(f_size*sizeof(double));
			}
		}
	}

	depth = 50;
	cha_size = 20;
	f_size = 5;
	
	conv2_weight = (double ****)malloc(depth*sizeof(double***));

	for(i=0; i<depth; i++){
		*(conv2_weight+i) = (double***)malloc(cha_size*sizeof(double**));
		for(j=0; j<cha_size; j++){
			*(*(conv2_weight+i)+j) = (double**)malloc(f_size*sizeof(double*));
			for(k=0; k<f_size; k++){
				*(*(*(conv2_weight+i)+j)+k) = (double*)malloc(f_size*sizeof(double));
			}
		}
	}

	output_size = 500;
	input_size = 800;

	full_weight3 = (double **)malloc(output_size*sizeof(double*));
	for(i=0; i<output_size; i++)
	{
		*(full_weight3 + i) = (double *)malloc(input_size*sizeof(double));
	}		

	output_size = 10;
	input_size = 500;

	full_weight4 = (double **)malloc(output_size*sizeof(double*));
	for(i=0; i<output_size; i++)
	{
		*(full_weight4 + i) = (double *)malloc(input_size*sizeof(double));
	}

	size =20;
	b_weight1= (double *)malloc(size*sizeof(double));
	size =50;
	b_weight2= (double *)malloc(size*sizeof(double));
	size =500;
	b_weight3= (double *)malloc(size*sizeof(double));
	size =10;
	b_weight4= (double *)malloc(size*sizeof(double));


////////////////////////////////////////////////////웨이트 값 받는거////////////////////////////////////////
	cha_size = 20;
	fch_size = 1;
	f_size = 5;

	for( i = 0 ; i<cha_size ; i++){
		for( j = 0 ; j<fch_size ; j++){
			for( k = 0 ; k<f_size ; k++){
				for( l=0 ; l<f_size ; l++){
					fscanf(fp1, "%lf, ", &conv1_weight[i][j][k][l]);
					//printf("[%d][%d][%d][%d]%.5lf \n", i+1, j+1, k+1, l+1, conv1_weight[i][j][k][l]);
				}
			}
		}
	}
	
	//conv2
	cha_size = 50;
	fch_size = 20;
	f_size = 5;

	for( i = 0 ; i<cha_size ; i++){
		for( j = 0 ; j<fch_size ; j++){
			for( k = 0 ; k<f_size ; k++){
				for( l=0 ; l<f_size ; l++){
					fscanf(fp2, "%lf, ", &conv2_weight[i][j][k][l]);
					//printf("[%d][%d][%d][%d]%.5lf \n", i+1, j+1, k+1, l+1, conv2_weight[i][j][k][l]);
				}
			}
		}
	}

	output_size = 500;
	input_size = 800;

	for( i = 0 ; i<output_size ; i++){
		for( j = 0 ; j<input_size ; j++){
			fscanf(fp3, "%lf, ", &full_weight3[i][j]);
			//printf("[%d][%d]%.5lf \n", i+1, j+1, full_weight3[i][j]);
		}
	}
	
	output_size = 10;
	input_size = 500;

	for( i = 0 ; i<output_size ; i++){
		for( j = 0 ; j<input_size ; j++){
			fscanf(fp4, "%lf, ", &full_weight4[i][j]);
			//printf("[%d][%d]%.5lf \n", i+1, j+1, full_weight4[i][j]);
		}
	}
////////////////////////////////////////바이어스 값 받는거///////////////////////////////////////////////////	
	size = 20;

	fscanf(fp5, " %c ", &read);
	for(i=0; i<size; i++){
		fscanf(fp5, " %lf ,", b_weight1);
		//printf("[%d]%lf \n", i+1,*b_weight1);
	}

	size = 50;

	fscanf(fp6, " %c ", &read);
	for(i=0; i<size; i++){
		fscanf(fp6, " %lf ,", b_weight2);
		//printf("%lf \n", *b_weight2);
	}

	size = 500;

	fscanf(fp7, " %c ", &read);
	for(i=0; i<size; i++){
		fscanf(fp7, " %lf ,", b_weight3);
		//printf("%lf \n", *b_weight3);
	}
	size = 10;

	fscanf(fp8, " %c ", &read);
	for(i=0; i<size; i++){
		fscanf(fp8, " %lf ,", b_weight4);
		//printf("%lf \n", *b_weight4);
	}

	//이미지 받기
	Mat image;
	image = imread("9.png",IMREAD_GRAYSCALE);
	if(image.empty())
	{
		cout<<"Could not open or find the image" <<endl;
		return -1;
	}

	cha_size = 1;
	for(i=0; i<cha_size; i++){
		for(j=0; j<image.rows; j++){
			for(k=0; k<image.cols; k++){
				*(*(*(input+i)+j)+k) = image.at<uchar>(j,k);
			}
		}
	}

////////////////////////////////각 레이어의 변수들 입력 및 main 안의 함수들 처리////////////////////////////
	cha_size =20;
	out_r_size = 24;
	out_c_size = 24;
	fch_size = 1;
	f_size = 5;
	stride = 1;
	conv1(input, conv1_out, conv1_weight, cha_size, out_r_size, out_c_size, fch_size, f_size, stride, sum, b_weight1);
	//printf("%lf, %lf, %lf, %d, %d, %d, %d, %d, %d, %lf, %lf\n", ***input, ***conv1_out, ****conv1_weight, cha_size, out_r_size, out_c_size, fch_size, f_size, stride, sum, *b_weight1);
	cha_size = 20;
	out_r_size = 12;
	out_c_size = 12;
	fch_size = 1;
	f_size = 2;
	stride = 2;
	pool1(conv1_out, pool1_out, cha_size, out_r_size, out_c_size, fch_size, f_size, stride, sum, max);

	cha_size = 50;
	out_r_size = 8;
	out_c_size = 8;
	fch_size = 20;
	f_size = 5;
	stride = 1;
	conv2(pool1_out, conv2_out, conv2_weight, cha_size, out_r_size, out_c_size, fch_size, f_size, stride, sum, b_weight2);

	cha_size = 50;
	out_r_size = 4;
	out_c_size = 4;
	fch_size = 1;
	f_size = 2;
	stride = 2;
	pool2(conv2_out, pool2_out, cha_size, out_r_size, out_c_size, fch_size, f_size, stride, sum, max);

	//3d -> 1d
	cha_size = 50;
	r_size = 4;
	c_size = 4;

	for(i=0; i<cha_size; i++){
		for(j=0; j<r_size; j++){
			for(k = 0; k<c_size; k++){
				*(change_out+i*r_size*c_size+j*r_size+k) = *(*(*(pool2_out+i)+j)+k);
			}
		}
	}

	input_size = 800;
	output_size = 500;
	full_connect(input_size, output_size, change_out, full_weight3, full1_out, b_weight3);
		
	input_size = 500;
	Relu_activation(full1_out, input_size);

	input_size = 500;
	output_size = 10;
	full_connect(input_size, output_size, full1_out, full_weight4, full2_out, b_weight4);

///////////////////////////////결과////////////////////////////////////////////////////////////////
	for(i=0; i<10; i++){
		printf("[%d] : %lf \n",i ,*(full2_out+i));
	} 
	printf("\n");
	
	printf(" SoftMax result like in below \n");
	input_size = 10;
	SoftMax(full2_out, input_size);

	for(i=0; i<input_size; i++){
		printf("[%d] : %lf \n", i,*(full2_out+i));
	}
	printf("\n");

///////////////////////////////////free//////////////////////////////////////////////////////////
	cha_size = 1;
	r_size = 28;

	for(i=0; i<cha_size; i++){
		 for(j=0; j<r_size; j++){
			free(*(*(input+i)+j));
		}
		free(*(input+i));
	}
	free(input);

	cha_size = 20;
	r_size = 24;

	for(i=0; i<cha_size; i++){
		 for(j=0; j<r_size; j++){
			free(*(*(conv1_out+i)+j));
		}
		free(*(conv1_out+i));
	}
	free(conv1_out);

	cha_size = 20;
	r_size = 12;

	for(i=0; i<cha_size; i++){
		 for(j=0; j<r_size; j++){
			free(*(*(pool1_out+i)+j));
		}
		free(*(pool1_out+i));
	}
	free(pool1_out);

	cha_size = 50;
	r_size = 8;

	for(i=0; i<cha_size; i++){
		 for(j=0; j<r_size; j++){
			free(*(*(conv2_out+i)+j));
		}
		free(*(conv2_out+i));
	}
	free(conv2_out);

	cha_size = 50;
	r_size = 4;

	for(i=0; i<cha_size; i++){
		 for(j=0; j<r_size; j++){
			free(*(*(pool2_out+i)+j));
		}
		free(*(pool2_out+i));
	}
	free(pool2_out);

	free(change_out);

	free(full1_out);

	free(full2_out);

////////////////////////////////웨이트 값들free////////////////////////////////////////////////////
	depth = 20;
	cha_size = 1;
	r_size = 5;
	
	for(i=0; i<depth; i++){
		 for(j=0; j<cha_size; j++){
			for(k=0; k<r_size; k++){
				free(*(*(*(conv1_weight+i)+j)+k));		
			}
			free(*(*(conv1_weight+i)+j));
		}
		free(*(conv1_weight+i));
	}
	free(conv1_weight);

	depth = 50;
	cha_size = 20;
	r_size = 5;

	for(i=0; i<depth; i++){
		 for(j=0; j<cha_size; j++){
			for(k=0; k<r_size; k++){
				free(*(*(*(conv2_weight+i)+j)+k));		
			}
			free(*(*(conv2_weight+i)+j));
		}
		free(*(conv2_weight+i));
	}
	free(conv2_weight);

	out_size = 500;

	for(i=0; i<out_size; i++)free(*(full_weight3+i));
	free(full_weight3);

	out_size = 10;

	for(i=0; i<out_size; i++)free(*(full_weight4+i));
	free(full_weight4);

	free(b_weight1);
	free(b_weight2);
	free(b_weight3);
	free(b_weight4);

	return 0;
}

void full_connect(int input_size, int output_size, double *input, double **weight, double *output, double *bias)
{
	for(int i=0; i<output_size; i++){
		for(int j=0; j<input_size; j++){
			output[i] += weight[i][j] * input[j] + bias[i];
		}
	}
}

double Relu_activation(double *input, int input_size)
{
	for(int i=0; i<input_size; i++)
		if(input[i]<0) input[i] = 0;
		else input[i] = input[i];
}

double SoftMax(double *input, int input_size)
{
	double max = input[0];
	double sum;

	for(int i=0; i<input_size; i++){
		if(max<input[i])
		{		
			max = input[i];
		}
	}
	for(int i=0; i<input_size; i++){
		input[i] = exp(input[i] - max);
		sum = sum + input[i];
	}
	for(int i=0; i<input_size; i++){
		input[i] = input[i]/sum;
	} 
}

double conv1(double ***input, double ***conv1_out, double ****conv1_weight, int cha_size,int out_r_size, int out_c_size, int fch_size, int f_size, int stride, double sum, double *b_weight1)
{
	
	for(int i=0; i<cha_size; i++){
		for(int j=0; j<out_r_size; j++){
			for(int k=0; k<out_c_size; k++){
				sum = 0;
				for(int m=0; m<fch_size; m++){
					for(int n=0; n<f_size; n++){
						for(int o=0; o<f_size; o++){
							sum += (*(*(*(input+m)+(j*stride+n))+(k*stride+o)) * *(*(*(*(conv1_weight+i)+m)+n)+o)) + *(b_weight1+i);
						}			
					}
				}
			*(*(*(conv1_out+i)+j)+k) = sum;
			}
		}
	}
}

double pool1(double ***conv1_out, double ***pool1_out, int cha_size,int out_r_size, int out_c_size, int fch_size, int f_size, int stride, double sum,double max)
{

	for(int i=0; i<cha_size; i++){
		for(int j=0; j<out_r_size; j++){
			for(int k=0; k<out_c_size; k++){
				for(int m=0; m<fch_size; m++){
					max = INT_MIN; //to express minimum value
					for(int n=0; n<f_size; n++){
						for(int o=0; o<f_size; o++){
								if(max< *(*(*(conv1_out+i)+(j*stride+n))+(k*stride+o)))
								max = *(*(*(conv1_out+i)+(j*stride+n))+(k*stride+o));
						}
					}
				*(*(*(pool1_out+i)+j)+k) = max;
				}
			}
		}
	}
}

double conv2(double ***pool1_out, double ***conv2_out, double ****conv2_weight, int cha_size,int out_r_size, int out_c_size, int fch_size, int f_size, int stride, double sum, double *b_weight2)
{

	for(int i=0; i<cha_size; i++){
		for(int j=0; j<out_r_size; j++){
			for(int k=0; k<out_c_size; k++){
				sum = 0;
				for(int m=0; m<fch_size; m++){
					for(int n=0; n<f_size; n++){
						for(int o=0; o<f_size; o++){
							sum += (*(*(*(pool1_out+m)+(j*stride+n))+(k*stride+o)) * *(*(*(*(conv2_weight+i)+m)+n)+o)) + *(b_weight2+i);
						}
					}
				}
			*(*(*(conv2_out+i)+j)+k) = sum;
		}		
		}
	}
}

double pool2(double ***conv2_out, double ***pool2_out, int cha_size,int out_r_size, int out_c_size, int fch_size, int f_size, int stride, double sum,double max)
{

	for(int i=0; i<cha_size; i++){
		for(int j=0; j<out_r_size; j++){
			for(int k=0; k<out_c_size; k++){
				for(int m=0; m<fch_size; m++){
					max = INT_MIN;
					for(int n=0; n<f_size; n++){
						for(int o=0; o<f_size; o++){
								if(max< *(*(*(conv2_out+i)+(j*stride+n))+(k*stride+o)))
								max = *(*(*(conv2_out+i)+(j*stride+n))+(k*stride+o));
							}
						}
						*(*(*(pool2_out+i)+j)+k) = max;
				}
			}
		}
	}
}
