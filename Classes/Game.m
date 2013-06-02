//
//  Game.m
//  Falldown
//
//  Created by Knikes on 8/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Game.h"



@implementation Game 

@synthesize scoring;
@synthesize sideSpeed; 
@synthesize accelerometer;
@synthesize stopRising;
@synthesize resetView;
@synthesize diffView;
@synthesize adView;
@synthesize ball;
@synthesize accelMult;
@synthesize lblDisplayScore;
@synthesize scoreView;
@synthesize alertView;
@synthesize scoreText;

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
		
    }
    return self;
}

-(void)initialize:(int)diffMode{
	x_pos = 50;
	y_pos = 50;
	

	back1 = [ [UIImageView alloc] initWithImage: [UIImage imageNamed:@"Clouds-Background.png"]];
	back1.frame = CGRectMake(0, 0, 320, 1440);
	
	back2 = [ [UIImageView alloc] initWithImage: [UIImage imageNamed:@"Clouds-Background2.png"]];
	back2.frame = CGRectMake(0, 1440, 320, 1440);
	
	pause2 = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"Pause2.png"]];
	scoreTop = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"Score-display.png"]];
	high2 = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"High-Score-Icon.png"]];
	pause2.frame = CGRectMake(20, 0, 30, 30);
	scoreTop.frame = CGRectMake(0, 0, 320, 20);
	high2.frame = CGRectMake(260, 0, 60, 40);
	
	
	[self addSubview:back1];
	[self addSubview:back2];
	[self addSubview:pause2];
	[self addSubview:scoreTop];
	[self addSubview:high2];
	pause2.userInteractionEnabled = YES;
	
	[NSTimer scheduledTimerWithTimeInterval:(0.02) target:self selector:@selector(animateBack) userInfo:nil repeats:YES];
	
	srand(time(NULL));
	
	//Initialize arrays
	blockArray = [[NSMutableArray alloc] init];
	pup = [[PowerUp alloc] initWithFrame: CGRectMake(-10, -10, 30, 30):self];

	//Setup different blocks used to rise
	[self blockSetup];
	
	//Initialize our ball
	pauseView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pause.png"]];
	pauseView.frame = CGRectMake(20, 170, 300, 70);
	
	//Initialize our ball
	ball = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rball.png"]];
	ball.center = CGPointMake(x_pos, y_pos);
	ball.frame = CGRectMake(ball.frame.origin.x, ball.frame.origin.y, BALL_WIDTH, BALL_HEIGHT);
	ball.layer.anchorPoint = CGPointMake(0.5, 0.5);
	[self addSubview:ball];
	[ball release];
	
	
	//Initialize score label
	lblScore = [[UILabel alloc] init];
	lblScore.frame = CGRectMake(182, 0, 50,18);
	lblScore.opaque = YES;
	[lblScore setBackgroundColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.0]];
	lblScore.textColor = [UIColor blackColor];
	lblScore.text = @"0";
	[scoreTop addSubview:lblScore];
	
	//Select either tilt or arrow mode
	[self selectMode:diffMode];
	
	//Screen width and height
	CGRect cgRect =[[UIScreen mainScreen] bounds];
	CGSize size = cgRect.size;
	width = size.width;
	height = size.height-BOTTOM_HEIGHT;
	
	//Properties for the ball
	gameRunning = false ;
	scoring = 0.0;
	canFall = true;
	fallSpeed = BALL_FALL_SPEED;
	moveLeft = false;
	moveRight = false;
	rotate = 0;
	radius_h = BALL_HEIGHT/2;
	radius_w = BALL_WIDTH/2;
	sideSpeed = BALL_SIDE_SPEED;
	stopRising = false;
	accelMult = 30.0;
	addTimer = 0.0;
	framesPerSecond = 1.0/70.0;
	paused = false;
	
	
	//Set the fps based on which version is being used
	[self determineVersion];
	[self performSelectorOnMainThread:@selector(start) withObject:nil waitUntilDone:NO];
	
}



// Game loop scheduler
-(void)start
{
	//change true to bool
	while (true) {
		NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
		while(CFRunLoopRunInMode(kCFRunLoopDefaultMode, (framesPerSecond), FALSE) == kCFRunLoopRunHandledSource);
		[self gameLoop];
		[pool release];
	}
	
}

// Get high scores for tilt and touch modes
-(void)getArrays
{		
	NSUserDefaults *currentDefaults = [NSUserDefaults standardUserDefaults];
	NSData *dataRepresentingSavedArray = [currentDefaults objectForKey:@"tiltScores"];
	if (dataRepresentingSavedArray != nil)
	{
        NSArray *oldSavedArray = [NSKeyedUnarchiver unarchiveObjectWithData:dataRepresentingSavedArray];
        if (oldSavedArray != nil){
			tiltScores = [[NSMutableArray alloc] initWithArray:oldSavedArray];
		}
        else
			tiltScores = [scoreView initializeArray];
		
		
	} else
		tiltScores = [scoreView initializeArray];
	
	dataRepresentingSavedArray = [currentDefaults objectForKey:@"touchScores"];
	if (dataRepresentingSavedArray != nil)
	{
		
        NSArray *oldSavedArray = [NSKeyedUnarchiver unarchiveObjectWithData:dataRepresentingSavedArray];
		if (oldSavedArray != nil){
			touchScores = [[NSMutableArray alloc] initWithArray:oldSavedArray];
		}
        else
			touchScores = [scoreView initializeArray];
		
	} else
		touchScores = [scoreView initializeArray];
	
	[scoreView setScores:tiltScores :touchScores]; 
}

// Pausing the game
-(void)pause{
	paused = !paused;
	
	// Stop the game and halt things
	if(paused) {
		gameRunning = false;
		[scoreTimer invalidate];
		scoreTimer = nil;
		[self addSubview:pauseView];
		[self bringSubviewToFront:pauseView];
		
		for(Block *b in blockArray){
			b.tmpRise = b.riseSpeed;
		}
	}
	else{
		gameRunning = true;
		scoreTimer = [NSTimer scheduledTimerWithTimeInterval:(1.0) target:self selector:@selector(score) userInfo:nil repeats:YES];
		[pauseView removeFromSuperview];
		if(pupTimer == nil) pupTimer = [NSTimer scheduledTimerWithTimeInterval:(addTimer) target:self selector:@selector(addPowerup) userInfo:nil repeats:NO];
		
		for(Block *b in blockArray){
			b.riseSpeed = b.tmpRise;
		}
	}

}

-(IBAction)reset{
	scoring = 0.0;
	x_pos = 50;
	y_pos = 50;
	accelMult = 30.0;
	sideSpeed = BALL_SIDE_SPEED;
	ball.image = [UIImage imageNamed:@"rball.png"];
	lblScore.text = @"0";
	lblScore.hidden = NO;
	ball.hidden = NO;
	
	[adView removeFromSuperview];
	[resetView removeFromSuperview];
	if(pupTimer != nil) [pupTimer invalidate];
	pupTimer = nil;
	
	for(Block *b in blockArray){
		[b reset];
	}
	
	gameRunning = true;
	
	addTimer = rand()%10 + 10;
	pupTimer = [NSTimer scheduledTimerWithTimeInterval:(addTimer) target:self selector:@selector(addPowerup) userInfo:nil repeats:NO];
	scoreTimer = [NSTimer scheduledTimerWithTimeInterval:(1.0) target:self selector:@selector(score) userInfo:nil repeats:YES];
}

-(IBAction)changeDifficulty{
	gameRunning = false;
	[resetView removeFromSuperview];
	[self addSubview:diffView];
}

-(void)lose{
	gameRunning = false;
	lblDisplayScore.text = [NSString stringWithFormat:@"%d",scoring];
	ball.hidden = YES;
	lblScore.hidden = YES;
	[resetView addSubview:adView];
	[scoreTimer invalidate];
	scoreTimer = nil;
	[pup setPosition:-100 :-100];
	
	resetView.frame = CGRectMake(0, 0, 320, 480);
	[self addSubview:resetView];
	
	
	if([[NSUserDefaults standardUserDefaults] floatForKey:@"diff"] == 3.4f){
		if( (mode == ACCELEROMETER_MODE && [scoreEntry newHighScore:scoring :tiltScores] ) || 
			(mode == ARROW_MODE && [scoreEntry newHighScore:scoring :touchScores] )){
			[self addSubview:alertView];
		}
	}
	
		
}

-(void)addPowerup
{		
	if(!gameRunning) 
	{
		if(pupTimer != nil) [pupTimer invalidate];
		pupTimer = nil;
		return;
	}
		
	[self addSubview:pup];
	[self sendSubviewToBack:pup];
	[pup change];
	addTimer = rand()%10 + 10;
	pupTimer = [NSTimer scheduledTimerWithTimeInterval:(addTimer) target:self selector:@selector(addPowerup) userInfo:nil repeats:NO];
}




//User selects whether to use the accelerometer or to use the arrows
-(void)selectMode:(int)selection
{
	mode = selection;
	if(selection == ACCELEROMETER_MODE)
	{
		self.accelerometer = [UIAccelerometer sharedAccelerometer];
		self.accelerometer.updateInterval = (1.0/50.0);
		self.accelerometer.delegate = self;
		
	}
	else if(selection == ARROW_MODE)
	{
		self.accelerometer = nil;
	}
}

//Add blocks to the array
//Specify which type of block to add
-(void)blockSetup
{
	float random = 0;
	Block *addBlock;
	
	for(int i=0; i<BLOCKS_IN_SCREEN; i++)
	{
		random = arc4random()%NUM_BLOCKS;
		addBlock = [[Block alloc] init:self:random];
		[blockArray addObject:addBlock];
	}
	
}

-(void)determineVersion
{
	float systemVersion = [[[ UIDevice currentDevice ] systemVersion ] floatValue ];

	
	if (systemVersion < 4.0)
	{
		framesPerSecond = 1.0/58.0;
		self.accelerometer.updateInterval = (1.0/40.0);
	}
}



-(void)gameLoop
{	
	if(paused) return;
	//Initial increase position of ball
	y_pos += fallSpeed;
	canFall = true;
	
	//For each block on the screen, check to see if there is a collision with the ball
	for(Block *b in blockArray)
	{
		if(!stopRising) [b rise];
		[self sendSubviewToBack:back1];
		[self sendSubviewToBack:back2];
		for(UIImageView *v in [b getArray])
			{
				//If botttom of ball is touching top of block, stop the ball from falling
				if(![self ballCollide:v] && ball.center.x-radius_w < v.frame.origin.x+v.frame.size.width &&
										   ball.center.x+radius_w > v.frame.origin.x && ball.center.y+radius_h < v.center.y) 
				{
					y_pos = (v.center.y - v.frame.size.height/2) - radius_h;
					if(!b.bounced) 
					{
						[self startBounceAnimation];
						b.bounced = true;
					}
				}
				
				//If side of ball is colliding with side of block, stop the ball from moving left or right
				if(![self ballCollide:v] && ball.frame.origin.y+ball.frame.size.height > v.frame.origin.y)
				{
					if(ball.frame.origin.x >= v.frame.origin.x+v.frame.size.width && moveLeft ) x_pos = v.frame.origin.x+v.frame.size.width;
					if(ball.frame.origin.x+ball.frame.size.width <= v.frame.origin.x && moveRight) x_pos = v.frame.origin.x; 
				}
			}
	}
	
	
	[pup rise];
	//Check for collision with powerup
	if(![self ballCollide:pup])
	{
		[pup removeFromSuperview];
		[pup setPosition:-100 :-100];
		[pup usePowerUp];
	}
	
	//Keep the rotation within 30 degrees
	if(rotate > 60) rotate = 60;
	if(rotate < -60) rotate = -60;
	ball.transform = CGAffineTransformRotate(ball.transform, degreesToRadians(rotate));
	
	//Only increase/decrease the x position if the arrows are being pressed
	if(moveLeft || moveRight)
	{
		if(moveLeft)
		{ 
			accel_x-= 2.0;
			rotate -= 10.0;
		}
		if(moveRight)
		{ 
			accel_x += 2.0;
			rotate += 10.0;
		}
		if(accel_x > sideSpeed) accel_x = sideSpeed;
		if(accel_x < -sideSpeed) accel_x = -sideSpeed;
	}
	else 
	{
		if(accel_x > 0) accel_x -= 1.0;
		if(accel_x < 0) accel_x += 1.0;
		if(rotate > 0) rotate -= 2.0;
		if(rotate < 0) rotate += 2.0;
	}
	x_pos += accel_x;
		
	//Keep x position within the bounds of the screen
	if(x_pos-radius_w <= 0) x_pos = radius_w;
	if(x_pos+radius_w >= width) x_pos = width-radius_w;
	ball.center = CGPointMake(x_pos, y_pos);
	
	//Keep ball within bounds of the screen
	if(x_pos-radius_w <= 0) x_pos = radius_w;
	if(x_pos+radius_w >= width) x_pos = width-radius_w;
	if(y_pos-radius_h <= 0) 
	{
		y_pos = radius_h;
		if(gameRunning != false) [self lose];
	}
	if(y_pos+radius_h*2 >= height) 
	{
		y_pos = height-radius_h*2.0;
		stopRising = false;
	}
}


- (void) accelerometer: (UIAccelerometer*) accelerometer didAccelerate:(UIAcceleration*) acceleration
{
	if(paused) return;
	add = acceleration.x*accelMult;

	if(add > 0 && add > ACCEL_SIDE_SPEED) add = ACCEL_SIDE_SPEED;
	if(add < 0 && add < -ACCEL_SIDE_SPEED) add = -ACCEL_SIDE_SPEED;
	
	if(add > 5) rotate += 8.0;
	else if(add < -5.0) rotate -= 8.0;
	else if(add > 0.0 && add < 5.0) rotate -= 1.0;
	else if(add < 0.0 && add > -5.0) rotate += 1.0;

	x_pos += add;
}

//Returns true if there is not a collision, false otherwise
-(bool)collisions:(UIImageView*)a:(UIImageView*)v
{
	if(a.center.y + a.frame.size.height/2 < v.center.y - v.frame.size.height/2 ||
	   a.center.y - a.frame.size.height/2 > v.center.y + v.frame.size.height/2 ||
	   a.center.x + a.frame.size.width/2 < v.center.x - v.frame.size.width/2 ||
	   a.center.x - a.frame.size.width/2 > v.center.x + v.frame.size.width/2)
	{
		return YES;
	}
	
	return NO;
}

//Returns true if there is not a collision, false otherwise
-(bool)ballCollide:(UIImageView*)v
{
	if(y_pos + radius_h < v.center.y - v.frame.size.height/2 ||
	   y_pos - radius_h > v.center.y + v.frame.size.height/2 ||
	   x_pos + radius_w < v.center.x - v.frame.size.width/2 ||
	   x_pos - radius_w > v.center.x + v.frame.size.width/2)
	{
		return YES;
	}
	
	return NO;
}

/********************************** SCORING **********************************/ 

-(IBAction)removeHighScores{
	[scoreView removeFromSuperview];
	scoreView.frame = CGRectMake(0, 0, 320, 430);
}

-(void)score{
	if(!gameRunning) return;
	scoring++;
	lblScore.text = [NSString stringWithFormat:@"%d",scoring];
}

-(IBAction)handleScore{
	//Should probably make this an animation
	[alertView removeFromSuperview];
	NSRange stringRange = {0,10};
	
	if(scoreText.text.length > 10){
		scoreText.text = [scoreText.text substringWithRange:stringRange];
	}
	
	[self highScores:scoring :scoreText.text];
	[scoreView setScores:tiltScores :touchScores];
	[self addSubview:scoreView];
}

-(void)highScores:(int)s:(NSString*)n{
	scoreEntry *newScore = [[scoreEntry alloc] init];
	newScore.score = s;
	newScore.names = n;
	
	if(mode == ACCELEROMETER_MODE){
		[tiltScores addObject:newScore];
		[scoreEntry sortArray:tiltScores];
		if([tiltScores count] > 5) [tiltScores removeLastObject];
	}
	
	if(mode == ARROW_MODE){		
		[touchScores addObject:newScore];
		[scoreEntry sortArray:touchScores];
		if([touchScores count] > 5) [touchScores removeLastObject];
	}
}

/********************************** TOUCHES **********************************/ 

-(void)touchesBegan:(NSSet*)touches withEvent:(UIEvent *)event{
	
	UITouch *touch = [touches anyObject];
	
	// If we touch the pause button
	if( [touch view] == pause2){
		[self pause];
	}
	
	// If we're not in touch mode, stop
	if(mode != ARROW_MODE) return;
	
	// Touching left side of the screen
	if([touch locationInView:self].x < 160){
		if(moveRight) moveRight = false;
		moveLeft = true;
	}
	
	// Touching the right side of the screen
	else if([touch locationInView:self].x >= 160){
		if(moveLeft) moveLeft = false;
		moveRight = true;
	}
}

// Done touching
-(void)touchesEnded:(NSSet*)touches withEvent:(UIEvent *)event{
	// Don't proceed if not in arrow mode
	if(mode != ARROW_MODE) return;
	
	UITouch *touch = [touches anyObject];
	
	// Releasing from left side
	if([touch locationInView:self].x < 160){
		moveLeft = false;
	}
	
	// Releasing from right side
	else if([touch locationInView:self].x >= 160){
		moveRight = false;
	}
}

/********************************** ANIMATIONS **********************************/ 

-(void)animateBack{
	back1.center = CGPointMake(back1.center.x, back1.center.y-5);
	back2.center = CGPointMake(back2.center.x, back2.center.y-5);
	
	if(back1.center.y <= -1200){
		back1.center = CGPointMake(160,1200);
	}
	
	if(back2.center.y <= -1200){
		back2.center = CGPointMake(160,1200);
	}
	
}

-(void)startBounceAnimation{
	[UIView beginAnimations:@"theAnimation" context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(stopBounceAnimation:finished:context:)];
    [UIView setAnimationDuration: 0.15];
    CGAffineTransform moveUp = CGAffineTransformMakeTranslation(0, -6);
    ball.transform = moveUp;
    [UIView commitAnimations]; 
}

-(void)stopBounceAnimation:(NSString*)animationID finished:(bool)finished context:(void*)context{
	[UIView beginAnimations:@"theAnimation" context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration: 0.03];
    CGAffineTransform moveUp = CGAffineTransformMakeTranslation(0, 3);
    ball.transform = moveUp;
    [UIView commitAnimations]; 
}

- (void)dealloc {
    [super dealloc];
}


@end
