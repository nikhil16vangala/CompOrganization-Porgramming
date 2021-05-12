#ifndef MAIN_H
#define MAIN_H

#include "gba.h"

void startScreen(void);
typedef struct shield {
  int col;
  int top;
  int step;
  int left;
  int right;
  int score;
} Shield;

typedef enum {
  LEFT,
  RIGHT,
} Direction;

typedef struct bomb {
  int row;
  int col;
  int step;
  int right;
} Bomb;


typedef enum {
  START,
  STARTTEXT,
  PLAYEMPTY,
  PLAY,
  LOSE,
  LOSETEXT,
} gba_state;

void makeShield(void);
void playSave(gba_state *state);
Bomb setBomb(void);
void Score(u16 color);

#endif
