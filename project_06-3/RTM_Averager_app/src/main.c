#include "xil_types.h"
#include <stdio.h>
#include <stdlib.h>

#define SSD_BASE 0x43C00000
#define SSDC (*((uint32_t *)(SSD_BASE+0x0))) // Seven Segment Display
#define BTNS (*((uint32_t *)(SSD_BASE+0x04))) // buttons

uint32_t inttoBCD(uint32_t);
void sleep(uint32_t);
uint32_t reactiontime(void);

char bcd_lut[16] = {0xC0,0xF9,0xA4,0xB0,0x99,0x92,0x82,0xF8,0x80,0x90,0x88,0x83,0xC6,0xA1,0x86,0x8E};

int main(void)
{
	SSDC = 0x00000000;
	uint32_t i = 0;
	uint32_t count = 0;
	uint32_t read_val;

	uint32_t exit_condition;
	uint32_t start_flag;

	uint32_t average;
	for(i=0;i<10;i++)
	{
		SSDC = inttoBCD(1111 * i);
		sleep(7500000);
	}

	while(1)
	{
		average = 0;
		exit_condition = 0;
		start_flag = 1;
		i=1;
			SSDC = 0xFFFFFFFF;
		read_val = BTNS;
		while(exit_condition == 0x00)
		{
			read_val = BTNS;

			switch (read_val)
			{
			case 0x00: //do nothing
				break;
			case 0x01:
				if(start_flag == 0x01)
				{
					SSDC = 0xFFFFFFFF;
					count = reactiontime();
					average = ((average * (i-1))+ count)/i;
					start_flag = 0x00;
				}
				break;
			case 0x02:
				if(start_flag ==0x00)
				{
					SSDC = 0xFFFFFFFF;
					start_flag = 0x01;
					i++;
				}
				break;
			case 0x04:
				if(i >= 3)
				{
					SSDC = inttoBCD(average);
				}
				break;
			case 0x08:
				exit_condition = 0x01;
				break;
			default:
				//do nothing
				break;
			}

		}

	}
	return 1;
}


uint32_t inttoBCD(uint32_t number)
{
	uint8_t number0;
	uint8_t number1;
	uint8_t number2;
	uint8_t number3;

	number0 = bcd_lut[number%10];
	number1 = bcd_lut[(number/10)%10];
	number2 = bcd_lut[(number/100)%10];
	number3 = bcd_lut[(number/1000)%10];

	return (uint32_t)(number0 + (number1<<8) + (number2<<16) + (number3<<24));

}

void sleep(uint32_t time)
{
	int i;
	for( i = 0 ; i < time ; i++)
	{};

}

uint32_t reactiontime(void)
{
	uint32_t sleeptime = 0;
	uint32_t counter = 0;
	uint32_t read_val;
	sleeptime = (rand()%100)*10000000;
	sleep(sleeptime);
	SSDC=0xFFFFFF7F;

	read_val = BTNS;
	while((read_val & 0x01) == 0x01)
	{
		read_val = BTNS;
	}
	while((read_val & 0x01) == 0x00)
	{
		counter++;
		sleep(50000);
		read_val = BTNS;
	}

		SSDC = inttoBCD(counter);

	return counter;
}