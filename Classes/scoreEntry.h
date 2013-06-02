//
//  scoreEntry.h
//  Falldown
//
//  Created by Knikes on 1/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface scoreEntry : NSObject 
{
	NSString *names;
	int score;
}

@property (nonatomic,retain) NSString* names;
@property int score;


-(NSComparisonResult)compareObjects:(scoreEntry*)ent1:(scoreEntry*)ent2;
+(void)sortArray:(NSMutableArray*)array;
+(BOOL)newHighScore:(int)s:(NSMutableArray*)array;

@end
