//
//  highScores.h
//  Falldown
//
//  Created by Knikes on 1/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "scoreEntry.h"

@interface highScores : UIView {

	UIView *scoreView;
	NSUserDefaults *prefs;
	
	//Tilt scores
	UILabel *score0;
	UILabel *score1;
	UILabel *score2;
	UILabel *score3;
	UILabel *score4;
	
	//Touch scores
	UILabel *score5;
	UILabel *score6;
	UILabel *score7;
	UILabel *score8;
	UILabel *score9;
}


@property (nonatomic, retain) IBOutlet UILabel *score0;
@property (nonatomic, retain) IBOutlet UILabel *score1;
@property (nonatomic, retain) IBOutlet UILabel *score2;
@property (nonatomic, retain) IBOutlet UILabel *score3;
@property (nonatomic, retain) IBOutlet UILabel *score4;

@property (nonatomic, retain) IBOutlet UILabel *score5;
@property (nonatomic, retain) IBOutlet UILabel *score6;
@property (nonatomic, retain) IBOutlet UILabel *score7;
@property (nonatomic, retain) IBOutlet UILabel *score8;
@property (nonatomic, retain) IBOutlet UILabel *score9;

-(NSMutableArray*)initializeArray;
-(void)setScores:(NSMutableArray*)tilt:(NSMutableArray*)touch;
-(NSComparisonResult)compareObjects:(scoreEntry*)ent1:(scoreEntry*)ent2;

@end
