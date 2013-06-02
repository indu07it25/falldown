//
//  scoreEntry.m
//  Falldown
//
//  Created by Knikes on 1/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "scoreEntry.h"


@implementation scoreEntry

@synthesize names;
@synthesize score;


- (id)initWithCoder:(NSCoder *)coder;
{
    self = [[scoreEntry alloc] init];
    if (self != nil)
    {
        names = [coder decodeObjectForKey:@"names"];
        score = [coder decodeIntegerForKey:@"score"];
		
		[names retain];
    }   
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder;
{
    [coder encodeObject:names forKey:@"names"];
    [coder encodeInteger:score forKey:@"score"];
}

-(NSComparisonResult)compareObjects:(scoreEntry*)ent1
{
	if (self.score > ent1.score) return NSOrderedAscending;
	if (self.score < ent1.score) return NSOrderedDescending;
	return NSOrderedSame;
}

+(void)sortArray:(NSMutableArray*)array
{
	[array sortUsingSelector:@selector(compareObjects:) ];
}

+(BOOL)newHighScore:(int)s:(NSMutableArray*)array
{
	//NSLog(@"%d",[array count]);
	for(scoreEntry *se in array)
	{
		if(s > se.score) return YES;
		//NSLog(@"now: %d and %d", s, se.score);
	}
	return NO;
}



@end
