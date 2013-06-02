 //
//  Block.h
//  Falldown
//
//  Created by Knikes on 12/16/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#define BLOCK_RISE_SPEED 2.3  
#define BOTTOM_HEIGHT 0
#define NUM_BLOCKS 11
#define BLOCK_HEIGHT 10
#define BLOCKS_IN_SCREEN 6



@interface Block : NSObject 
{
	NSMutableArray *barray;
	UIImageView *block1;
	UIImageView *block2;
	UIImageView *block3;
	NSTimer *riseTimer;
	UIView* game;
	
	float riseSpeed;
	float block_y_pos;
	float start;
	bool bounced;
	NSUserDefaults *prefs;
	int choose;
	float tmpRise;
}

@property bool bounced;
@property float riseSpeed;
@property float tmpRise;

-(id)init:(UIView*)g:(int)type;
-(void)initializeBlocks;
-(void)rise;
-(NSMutableArray*)getArray;
-(void)chooseType:(int)type;
-(void)speedUp;
-(void)reset;

-(void)type0;
-(void)type1;
-(void)type2;
-(void)type3;
-(void)type4;
-(void)type5;
-(void)type6;
-(void)type7;
-(void)type8;
-(void)type9;
-(void)type10;
@end
