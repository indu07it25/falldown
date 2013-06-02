//
//  Block.m
//  Falldown
//
//  Created by Knikes on 12/16/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Block.h"



@implementation Block

@synthesize bounced;
@synthesize riseSpeed;
@synthesize tmpRise;

static float startPosition = 480-BOTTOM_HEIGHT;

-(id)init:(UIView*)view:(int)type
{
	if ((self = [super init])) 
	{
		prefs = [NSUserDefaults standardUserDefaults];
		
		riseSpeed = [prefs floatForKey:@"diff"];
		block_y_pos = startPosition;
		barray = [[NSMutableArray alloc] init];
		game = view;
		bounced = false;
		
		[self initializeBlocks];
		[self chooseType:type];
		start = startPosition;
		startPosition += (480-BOTTOM_HEIGHT)/BLOCKS_IN_SCREEN;
		srand(time(NULL));
		
		[NSTimer scheduledTimerWithTimeInterval:(18.0) target:self selector:@selector(speedUp) userInfo:nil repeats:YES];
	}
    return self;
}

-(void)speedUp
{
	if(riseSpeed < 4.6)riseSpeed += 0.2;
	//[NSTimer scheduledTimerWithTimeInterval:(10.0) target:self selector:@selector(speedUp) userInfo:nil repeats:NO];
}

-(void)initializeBlocks
{
	block1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"block1.png"]];
	[barray addObject:block1];
	[game addSubview:block1];
	[block1 release];
	
	block2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"block1.png"]];
	[barray addObject:block2];
	[game addSubview:block2];
	[block2 release];
	
	block3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"block1.png"]];
	[barray addObject:block3];
	[game addSubview:block3];
	[block3 release];
}

-(void)rise
{
	block_y_pos -= riseSpeed;
	
	for(UIImageView *v in barray)
	{
		v.frame = CGRectMake(v.frame.origin.x, block_y_pos, v.frame.size.width, v.frame.size.height);
		if(block_y_pos <= 0.0) 
		{
			choose = rand()%NUM_BLOCKS;
			[self chooseType:choose];
			block_y_pos = 480-BOTTOM_HEIGHT;
			bounced = false;
		}
	}
}


-(void)reset
{
	prefs = [NSUserDefaults standardUserDefaults];
	block_y_pos = start;
	riseSpeed = [prefs floatForKey:@"diff"];
}

-(NSMutableArray*)getArray
{
	return barray;
}

-(void)chooseType:(int)type
{
	switch (type) {
		case 0:
			[self type0];
			break;
		case 1:
			[self type1];
			break;
		case 2:
			[self type2];
			break;
		case 3:	
			[self type3];
			break;	
		case 4:
			[self type4];
			break;
		case 5:
			[self type5];
			break;
		case 6:	
			[self type6];
			break;
		case 7:
			[self type7];
			break;
		case 8:	
			[self type8];
			break;
		case 9:
			[self type9];
			break;
		case 10:
			[self type10];
			break;
		default:
			break;
	}	
}

//Middle bar
-(void)type0
{
	block1.frame = CGRectMake(64.0, startPosition, 192, BLOCK_HEIGHT);
	[game addSubview:block1];
	[game sendSubviewToBack:block1];
	
	block2.frame = CGRectMake(-10.0, -10.0, 0.0, 0.0);
	block3.frame = CGRectMake(-10.0, -10.0, 0.0, 0.0);
}

//One bars on each side
-(void)type1
{
	block1.frame = CGRectMake(0, startPosition, 128, BLOCK_HEIGHT);
	[game addSubview:block1];
	[game sendSubviewToBack:block1];
	
	block2.frame = CGRectMake(192, startPosition, 128, BLOCK_HEIGHT);
	[game addSubview:block2];
	[game sendSubviewToBack:block2];
		
	block3.frame = CGRectMake(-10, -10, 0, 0);
}

//Long bar from the left side
-(void)type2
{
	block1.frame = CGRectMake(0, startPosition, 280, BLOCK_HEIGHT);
	[game addSubview:block1];
	[game sendSubviewToBack:block1];
	
	block2.frame = CGRectMake(-10, -10, 0, 0);
	block3.frame = CGRectMake(-10, -10, 0, 0);
}

//Long bar from the right side
-(void)type3
{
	block1.frame = CGRectMake(40, startPosition, 280, BLOCK_HEIGHT);
	[game addSubview:block1];
	[game sendSubviewToBack:block1];
	
	block2.frame = CGRectMake(-10, -10, 0, 0);
	block3.frame = CGRectMake(-10, -10, 0, 0);
}

//Two small blocks
-(void)type4
{
	block1.frame = CGRectMake(64, startPosition, 64, BLOCK_HEIGHT);
	[game sendSubviewToBack:block1];
	
	block2.frame = CGRectMake(192, startPosition, 64, BLOCK_HEIGHT);
	[game sendSubviewToBack:block2];
	
	block3.frame = CGRectMake(-10, -10, 0, 0);
}

//Three small blocks equal apart
-(void)type5
{
	block1.frame = CGRectMake(0, startPosition, 64, BLOCK_HEIGHT);
	[game sendSubviewToBack:block1];
	
	block2.frame = CGRectMake(128, startPosition, 64, BLOCK_HEIGHT);
	[game sendSubviewToBack:block2];
	block3.frame = CGRectMake(256, startPosition, 64, BLOCK_HEIGHT);
	[game sendSubviewToBack:block3];
}

//Two long bars with small middle opening
-(void)type6
{
	block1.frame = CGRectMake(0, startPosition, 130, BLOCK_HEIGHT);
	[game sendSubviewToBack:block1];
	
	block2.frame = CGRectMake(190, startPosition, 130, BLOCK_HEIGHT);
	[game sendSubviewToBack:block2];
	
	block3.frame = CGRectMake(-10, -10, 0, 0);
}

//Long bar on left small on right
-(void)type7
{
	block1.frame = CGRectMake(0, startPosition, 192, BLOCK_HEIGHT);
	[game sendSubviewToBack:block1];
	
	block2.frame = CGRectMake(256, startPosition, 64, BLOCK_HEIGHT);
	[game sendSubviewToBack:block2];
	
	block3.frame = CGRectMake(-10, -10, 0, 0);
}

//Long bar on right small on left
-(void)type8
{
	block1.frame = CGRectMake(0, startPosition, 64, BLOCK_HEIGHT);
	[game sendSubviewToBack:block1];
	
	block2.frame = CGRectMake(128, startPosition, 192, BLOCK_HEIGHT);
	[game sendSubviewToBack:block2];
	
	block3.frame = CGRectMake(-10, -10, 0, 0);
}


-(void)type9
{
	block1.frame = CGRectMake(0, startPosition, 64, BLOCK_HEIGHT);
	[game sendSubviewToBack:block1];
	
	block2.frame = CGRectMake(192, startPosition, 128, BLOCK_HEIGHT);
	[game sendSubviewToBack:block2];
	
	block3.frame = CGRectMake(-10, -10, 0, 0);
}

-(void)type10
{
	block1.frame = CGRectMake(0, startPosition, 128, BLOCK_HEIGHT);
	[game sendSubviewToBack:block1];
	
	block2.frame = CGRectMake(256, startPosition, 64, BLOCK_HEIGHT);
	[game sendSubviewToBack:block2];
	
	block3.frame = CGRectMake(-10, -10, 0, 0);
}


@end
