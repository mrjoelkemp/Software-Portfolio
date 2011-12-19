all: pong

pong: pong.o Sprite.o timers.o Paddle.o Ball.o Collision.o 
	g++ pong.o Sprite.o timers.o Paddle.o Ball.o Collision.o -o pong -lncurses

pong.o: pong.cpp
	g++ -c pong.cpp

Sprite.o: Sprite.cpp
	g++ -c Sprite.cpp

timers.o: timers.c
	g++ -c timers.c

Paddle.o: Paddle.cpp
	g++ -c Paddle.cpp

Ball.o: Ball.cpp
	g++ -c Ball.cpp

Collision.o: Collision.cpp
	g++ -c Collision.cpp

clean:
	rm -rf *o pong