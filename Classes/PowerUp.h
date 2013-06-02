//
//  PowerUp.h
//  Falldown
//
//  Created by Knikes on 12/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

typedef enum PwrType { SPEED, FREEZE, SCORE_5 }PwrType;
#define NUM_PUPS 3
#define PUP_RISE_SPEED 2.0

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>

@interface PowerUp : UIImageView 
{
	PwrType type;
	float duration;
	id *game;
}

@property PwrType type;

-(id)initWithFrame:(CGRect)frame:(id*)g;
-(void)setPosition:(float)x:(float)y;
-(void)usePowerUp;
-(void)endPowerUp;
-(void)dealloc;
-(void)change;
-(void)rise;

@end
