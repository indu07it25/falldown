//
//  FalldownAppDelegate.h
//  Falldown
//
//  Created by Knikes on 8/11/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Game.h"
#import "Block.h"
#import <CoreGraphics/CoreGraphics.h>
#import "AdViewControl.h"
#import "Appirater.h"
#import "highScores.h"
#import "Achievements.h"
#import "DeployView.h"

@class FalldownViewController;

@interface FalldownAppDelegate : NSObject <UIApplicationDelegate> {
    int mode;
	
	Game *game;
	UIWindow *window;
	UIView* mainView;
	UIView* difficulty;
	UIView* loadView;
	UIImageView *back1;
	UIImageView *back2;
	UIImageView *gf;
	UIImageView *gfbig;
	UIScrollView* scroll;
	AdViewControl *adView;
	NSUserDefaults *prefs;
	highScores *high;
    Achievements *achieveView;
    DeployView *deploy;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UIView* mainView;
@property (nonatomic, retain) IBOutlet UIView* difficulty;
@property (nonatomic, retain) IBOutlet UIView* loadView;
@property (nonatomic, retain) IBOutlet Game *game;
@property (nonatomic, retain) IBOutlet AdViewControl *adView;
@property (nonatomic, retain) IBOutlet highScores *high;
@property (nonatomic, retain) IBOutlet Achievements *achieveView;
@property (nonatomic, retain) IBOutlet DeployView *deploy;

-(IBAction)easy;
-(IBAction)medium;
-(IBAction)hard;
-(IBAction)TouchMode;
-(IBAction)TiltMode;
-(void)removeLoadScreen;
-(void)fadeAnimation;
-(IBAction)highScoreView;
-(void)animateBack;
-(void)gfAnimate;
-(IBAction)difficultyView;
-(IBAction)achievements;
-(IBAction)moreView;


@end

