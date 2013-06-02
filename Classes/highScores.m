//
//  highScores.m
//  Falldown
//
//  Created by Knikes on 1/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "highScores.h"


@implementation highScores

@synthesize score0;
@synthesize score1;
@synthesize score2;
@synthesize score3;
@synthesize score4;

@synthesize score5;
@synthesize score6;
@synthesize score7;
@synthesize score8;
@synthesize score9;

-(void)setScores:(NSMutableArray*)tilt:(NSMutableArray*)touch
{
	[tilt sortUsingSelector:@selector(compareObjects:)];
	[touch sortUsingSelector:@selector(compareObjects:)];
	
	
	score0.text = [NSString stringWithFormat:@"%@ - %d",((scoreEntry*)[tilt objectAtIndex:0]).names,((scoreEntry*)[tilt objectAtIndex:0]).score];
	score1.text = [NSString stringWithFormat:@"%@ - %d",((scoreEntry*)[tilt objectAtIndex:1]).names,((scoreEntry*)[tilt objectAtIndex:1]).score];
	score2.text = [NSString stringWithFormat:@"%@ - %d",((scoreEntry*)[tilt objectAtIndex:2]).names,((scoreEntry*)[tilt objectAtIndex:2]).score];
	score3.text = [NSString stringWithFormat:@"%@ - %d",((scoreEntry*)[tilt objectAtIndex:3]).names,((scoreEntry*)[tilt objectAtIndex:3]).score];
	score4.text = [NSString stringWithFormat:@"%@ - %d",((scoreEntry*)[tilt objectAtIndex:4]).names,((scoreEntry*)[tilt objectAtIndex:4]).score];
	
	score5.text = [NSString stringWithFormat:@"%@ - %d",((scoreEntry*)[touch objectAtIndex:0]).names,((scoreEntry*)[touch objectAtIndex:0]).score];
	score6.text = [NSString stringWithFormat:@"%@ - %d",((scoreEntry*)[touch objectAtIndex:1]).names,((scoreEntry*)[touch objectAtIndex:1]).score];
	score7.text = [NSString stringWithFormat:@"%@ - %d",((scoreEntry*)[touch objectAtIndex:2]).names,((scoreEntry*)[touch objectAtIndex:2]).score];
	score8.text = [NSString stringWithFormat:@"%@ - %d",((scoreEntry*)[touch objectAtIndex:3]).names,((scoreEntry*)[touch objectAtIndex:3]).score];
	score9.text = [NSString stringWithFormat:@"%@ - %d",((scoreEntry*)[touch objectAtIndex:4]).names,((scoreEntry*)[touch objectAtIndex:4]).score];
	
	prefs = [NSUserDefaults standardUserDefaults];
	
	[[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:tilt] forKey:@"tiltScores"];
	[[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:touch] forKey:@"touchScores"];
	//[prefs setObject:tilt forKey:@"tiltScores"];
	//[prefs setObject:[NSKeyedArchiver archivedDataWithRootObject:touch] forKey:@"touchScores"];
	//[prefs synchronize];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

-(NSMutableArray*)initializeArray
{
	NSMutableArray *ret = [[NSMutableArray alloc] init];
	for(int i=0; i<5; i++)
	{
		scoreEntry *entry = [[scoreEntry alloc] init];
		entry.names = @"-----";
		entry.score = 0;
		[ret addObject:entry];
	}
	return ret;
}

/*-(NSComparisonResult)compareObjects:(scoreEntry*)ent1:(scoreEntry*)ent2
{
	if (ent1.score < ent2.score) return NSOrderedAscending;
	if (ent1.score > ent2.score) return NSOrderedDescending;
	return NSOrderedSame;
}*/


@end
