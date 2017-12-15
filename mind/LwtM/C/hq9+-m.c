/********************************************************************
Akihiro Kubota a.k.a. hemokosa.
Copyright (C) 2017

hqgtaf9+-m

This file is a part of hq9+-m software project based on Ivan
Grigoryevich Zaigralin's hq9+-i program.
http://melikamp.com/features/hq9pm.shtml

hq9+-m is free software; you can redistribute it and/or modify it
under the terms of the GNU General Public License as published by the
Free Software Foundation; either version 3 of the License, or (at your
option) any later version.

This program is distributed in the hope that it will be useful, but
without any warranty; without even the implied warranty of
merchantability or fitness for a particular purpose. Compiling,
interpreting, executing or merely reading the text of the program may
result in lapses of consciousness and/or very being, up to and
including the end of all existence and the Universe as we know it.
See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program (most likely, a file named COPYING).  If not,
see <http://www.gnu.org/licenses/>.
********************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <time.h>

void hello_world(void){
  printf("Hello, World!\n");
}

void power(void){
  printf("Abuse of Power Comes As No Surprise.\n");
}

void ninety_nine(void){
  int i = 99;
  while(i > 2){
    printf("%d bottles of beer on the wall, %d bottles of beer.\n", i, i);
    printf("Take one down and pass it around, %d bottles of beer on the wall.\n\n", --i);
  }
  printf("%d bottles of beer on the wall, %d bottles of beer.\n", i, i);
  printf("Take one down and pass it around, %d bottle of beer on the wall.\n\n", --i);
  printf("%d bottle of beer on the wall, %d bottle of beer.\n", i, i);
  printf("Take one down and pass it around, no more bottles of beer on the wall.\n\n");
  printf("No more bottles of beer on the wall, no more bottles of beer.\n");
  printf("Go to the store and buy some more, 99 bottles of beer on the wall.\n");
}

void fizz_buzz(void){
  int i;
  for (i = 1; i <= 100; i++) {
    if (i % 3 == 0 && i % 5 == 0) {
        printf("FizzBuzz\n");
    } else if (i % 3 == 0) {
        printf("Fizz\n");
    } else if (i % 5 == 0) {
        printf("Buzz\n");
    } else {
        printf("%d\n", i);
    }
  }
}

void quine( unsigned char *source, size_t size ){
  size_t i = 0;
  fwrite(source, size, 1, stdout);
  printf("\n");
}

int main(int argc, char **argv){
  srand(time(NULL));
  unsigned char *source;
  size_t size, i;
  int last, before_last;
  int mind = 0;
  int accumulator = 0;
  int fname = 0;
  int option = 0;
  FILE *fp;

  if(argc == 2) fname = 1;
  if(fname == 0){
    fprintf(stderr, "HQ9+-m interpreter, Version 1.0, (C) hemokosa 2017.\n");
    fprintf(stderr, "Usage: hq9+-m <source file name>\n");
    exit(1);
  }

  fp = fopen(argv[fname], "r");
  if(fp == NULL){
    fprintf(stderr, "Could not open file %s, aborting.\n", argv[1]);
    exit(1);
  }

  fseek(fp, 0, SEEK_END);
  size = (size_t)ftell(fp);
  source = malloc(size);
  if(source == NULL){
    fprintf(stderr, "Could not allocate %ld bytes of memory, aborting.\n",
	    (long int)size);
    exit(1);
  }
  fseek(fp, 0, SEEK_SET);
  fread(source, size, 1, fp);
  fclose(fp);

  for(i = 0; i < size; i++){
    switch(source[i]){
    case 'H':
    case 'h': hello_world(); break;
    case 'Q':
    case 'q': quine(source, size); break;
    case '9': ninety_nine(); break;
    case 'F':
    case 'f': fizz_buzz(); sleep(3); break;
    case '+': if(rand()%10 != 0) accumulator++; break;
    case '-': if(rand()%10 != 0) accumulator--; break;
    }
    //printf("accumulator = %d\n", accumulator);
  }
  free(source);
  return 0;
}
