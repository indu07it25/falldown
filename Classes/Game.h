//
//  Game.h
//  Falldown
//
//  Created by Knikes on 8/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Block.h"
#import <QuartzCore/QuartzCore.h>
#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import "PowerUp.h"
#import "AdViewControl.h"
#import "highScores.h"
#import "scoreEntry.h"

#define BALL_FALL_SPEED 10
#define ACCELEROMETER_MODE 1
#define ARROW_MODE 2
#define BALL_SIDE_SPEED 11
#define ACCEL_SIDE_SPEED 20

#define BALL_WIDTH 25
#define BALL_HEIGHT 25  

#define degreesToRadians(x) (M_PI * x / 180.0)
                                                                                                                                                                                                                                             

@interface Game : UIView <UIAccelerometerDelegate>
{
	IBOutlet UIView* resetView;
	IBOutlet UIView* diffView;	
	IBOutlet UIView* alertView;
	IBOutlet highScores* scoreView;
	UITextField *scoreText;
	
	UIImageView* ball;
	//UIImageView* infoBlock;
	//UIImageView* leftArrow;
	//UIImageView* rightArrow;
	UIImageView* animationView;
	UIImageView* pauseView;
	UIImageView* pause2;
	UIImageView* scoreTop;
	UIImageView* high2;
	AdViewControl *adView;
	
	NSTimer *gameTimer;
	NSTimer *scoreTimer;
	NSTimer *pupTimer;
	UILabel *lblScore;
	UILabel *lblDisplayScore;
	
	UIAccelerometer *accelerometer;
	NSMutableArray *blockArray;
	NSMutableArray *tiltScores;
	NSMutableArray *touchScores;

	PowerUp* pup;
	
	
	UIImageView *back1;
	UIImageView *back2;
	bool gameRunning;
	float x_pos;
	float y_pos;
	float radius_h;
	float radius_w;
	
	float fallSpeed;
	float block_y_pos;
	float riseSpeed;
	float rotate;
	float accel_x;
	float sideSpeed;
	float add;
	float accelMult;
	float addTimer;
	float framesPerSecond;
	
	int scoring;
	int width;
	int height;
	int mode;
	bool canFall;
	bool moveLeft;
	bool moveRight;
	bool stopRising;
	bool paused;
	float accelSpeed;
}

@property int scoring;
@property float accelMult;
@property (nonatomic,retain) UIAccelerometer *accelerometer;
@property (nonatomic,retain) IBOutlet UITextField* scoreText;
@property (nonatomic,retain) IBOutlet UIView* resetView;
@property (nonatomic,retain) IBOutlet UIView* diffView;
@property (nonatomic,retain) IBOutlet UIView* alertView;
@property (nonatomic,retain) UIImageView* ball;
@property (nonatomic,retain) IBOutlet UILabel *lblDisplayScore;
@property (nonatomic, retain) IBOutlet highScores* scoreView;
@property float sideSpeed;
@property bool stopRising;
@property (nonatomic,retain) IBOutlet AdViewControl *adView;


-(void)start;
-(void)initialize:(int)mode;
-(void)gameLoop;	
-(bool)collisions:(UIImageView*)a:(UIImageView*)v;
-(void)selectMode:(int)selection;
-(void)blockSetup;
-(bool)ballCollide:(UIImageView*)v;
-(void)addPowerup;
-(void)startBounceAnimation;
-(void)stopBounceAnimation:(NSString*)animationID finished:(bool)finished context:(void*)context;
-(void)score;
-(void)lose;
-(IBAction)reset;
-(IBAction)changeDifficulty;
-(void)determineVersion;
-(void)highScores:(int)s:(NSString*)n;
-(void)getArrays;
-(IBAction)handleScore;
-(IBAction)removeHighScores;
-(void)pause;
-(void)animateBack;

@end
