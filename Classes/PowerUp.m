//
//  PowerUp.m
//  Falldown
//
//  Created by Knikes on 12/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "PowerUp.h"
#import "Game.h"

@implementation PowerUp

@synthesize type;

-(id)initWithFrame:(CGRect)frame:(id*)g
{
	srand(time(NULL));
	[super initWithFrame:frame];

	if(self)
	{
		game = g;
	}
	return self;
}

-(void)change
{
	type = rand()%NUM_PUPS;
	float x_position = arc4random()%(320-30);
	self.center = CGPointMake(x_position, 480);
	
	switch (type) 
	{
		case SPEED:
			self.image = [UIImage imageNamed:@"speed.png"];
			break;
		case FREEZE:
			self.image = [UIImage imageNamed:@"time.png"];
			break;
		case SCORE_5:
			self.image = [UIImage imageNamed:@"plus.png"];
			break;
		default:
			break;
	}
}

-(void)setPosition:(float)x:(float)y
{
	self.center = CGPointMake(x,y);
}

-(void)usePowerUp
{
	switch (type) 
	{
		case SPEED:
			((Game*)game).sideSpeed = BALL_SIDE_SPEED + 4;
			((Game*)game).accelMult = 50.0;
			((Game*)game).ball.image = [UIImage imageNamed:@"glowball.png"];
			[NSTimer scheduledTimerWithTimeInterval:(5.0) target:self selector:@selector(endPowerUp) userInfo:nil repeats:NO];
			break;
		case FREEZE:
			((Game*)game).stopRising = true;
			[NSTimer scheduledTimerWithTimeInterval:(5.0) target:self selector:@selector(endPowerUp) userInfo:nil repeats:NO];
			break;
		case SCORE_5:
			((Game*)game).scoring += 5;
			break;
		default:
			break;
	}
}

-(void)endPowerUp
{
	switch (type) 
	{
		case SPEED:
			((Game*)game).sideSpeed = BALL_SIDE_SPEED - 4;
			((Game*)game).accelMult = 30.0;
			((Game*)game).ball.image = [UIImage imageNamed:@"rball.png"];
			break;
		case FREEZE:
			((Game*)game).stopRising = false;
			break;
		default:
			break;
	}	
}

-(void)rise
{
	self.center = CGPointMake(self.center.x,self.center.y - PUP_RISE_SPEED);
}

-(void)dealloc
{
	[super dealloc];
}



@end
