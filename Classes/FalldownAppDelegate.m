//
//  FalldownAppDelegate.m
//  Falldown
//
//  Created by Knikes on 8/11/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "FalldownAppDelegate.h"

@implementation FalldownAppDelegate

@synthesize window;
@synthesize mainView;
@synthesize difficulty;
@synthesize game;
@synthesize loadView;
@synthesize adView;
@synthesize high;
@synthesize achieveView;
@synthesize deploy;

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    //Disable unnecessary things
	[UIApplication sharedApplication].statusBarHidden = YES;
	[[UIApplication sharedApplication] setIdleTimerDisabled:YES];

	//Default speed is medium
	prefs = [NSUserDefaults standardUserDefaults];
	[prefs setFloat:2.8f forKey:@"diff"];
	
	game.frame = [[UIScreen mainScreen] bounds];
	//back1 = [ [UIImageView alloc] initWithImage: [UIImage imageNamed:@"cloud1.png"]];
	//back2 = [ [UIImageView alloc] initWithImage: [UIImage imageNamed:@"cloud2.png"]];	
	gf = [ [UIImageView alloc] initWithImage: [UIImage imageNamed:@"gf.png"]];
	gfbig = [ [UIImageView alloc] initWithImage: [UIImage imageNamed:@"loadscreen.png"]];
	
	//back1.frame = CGRectMake(0, 0, 320, 480);
	//back2.frame = CGRectMake(0, 480, 320, 480);
	gfbig.frame = CGRectMake(0, 0, 320, 480);
	
	gf.frame = CGRectMake(0, 0, 275, 230);
	gf.center = CGPointMake(160, 240);


	[self animateBack];
	//[mainView addSubview:back1];
	//[mainView sendSubviewToBack:back1];
	//[mainView addSubview:back2];
	//[mainView sendSubviewToBack:back2];
	[window addSubview:mainView];
	
	[adView createAdBannerView];
	[adView setCoordinates:0 :430];
	
	
	loadView = [[UIView alloc] init];
	loadView.frame = CGRectMake(0, 0, 320, 480);
	[loadView addSubview:gfbig];
	//loadView.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"loadscreen.png"]];
	[loadView addSubview:gf];
	[window addSubview:loadView];
	
	
	prefs = [NSUserDefaults standardUserDefaults];
	
    // Add the view controller's view to the window and display.
    [window makeKeyAndVisible];
	
	

	//NSTimer scheduledTimerWithTimeInterval:(0.05) target:self selector:@selector(animateBack) userInfo:nil repeats:YES];
	
	[NSTimer scheduledTimerWithTimeInterval:(2.0) target:self selector:@selector(fadeAnimation) userInfo:nil repeats:NO];
	[NSTimer scheduledTimerWithTimeInterval:(3.0) target:self selector:@selector(removeLoadScreen) userInfo:nil repeats:NO];
	
	[game getArrays];
	
	float systemVersion = [[[ UIDevice currentDevice ] systemVersion ] floatValue ];
	if (systemVersion >= 4.2)
	{
		[Appirater appLaunched:YES];
	}
    return YES;
}

-(IBAction)TouchMode
{
	mode = ARROW_MODE;
	[mainView removeFromSuperview];
	[game initialize:mode];
	[game reset];
	[window addSubview:game];
}

-(IBAction)TiltMode
{
	mode = ACCELEROMETER_MODE;
	[mainView removeFromSuperview];
	[game initialize:mode];
	[game reset];
	[window addSubview:game];
}

-(IBAction)moreView{
    [window addSubview:deploy];

    [deploy setFrame:CGRectMake(0, 480, 320, 380)];
    [deploy setBounds:CGRectMake(0, 0, 320, 380)];
        
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelegate:self];
    [deploy setFrame:CGRectMake(0, 100, 320, 380)];
    [UIView commitAnimations];
    
    [deploy flashScroll];
}

-(IBAction)difficultyView{
	[window addSubview:difficulty];
}

-(IBAction)achievements{
	[window addSubview:achieveView];
}



/*****************************BELOW THIS LINE IS DEPRACATED *********************************/

-(void)fadeAnimation
{
	loadView.alpha = 1;
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
	[UIView setAnimationDuration:1];
	loadView.alpha = 0;
	[UIView commitAnimations];
}

-(void)removeLoadScreen
{
	[loadView removeFromSuperview];
}

-(void)animateBack
{
	back1.center = CGPointMake(back1.center.x, back1.center.y-5);
	back2.center = CGPointMake(back2.center.x, back2.center.y-5);
	
	if(back1.center.y <= -240)
	{
		back1.center = CGPointMake(160, 720);
	}
	
	if(back2.center.y <= -240)
	{
		back2.center = CGPointMake(160, 720);
	}
}

-(IBAction)highScoreView
{
	high.frame = CGRectMake(0, 0, 320, 480);
	[window addSubview:high];
}

-(void)gfAnimate
{
	[UIView beginAnimations:@"pan" context:nil];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
	[UIView setAnimationDuration:1];
	gf.frame = CGRectMake(gf.center.x, gf.center.y, 275, 230);
	//gf.center = CGPointMake(160, 240);
	[UIView commitAnimations];
}



-(IBAction)easy
{
	prefs = [NSUserDefaults standardUserDefaults];
	[prefs setFloat:2.3f forKey:@"diff"];
	
	//[game reset];
	[difficulty removeFromSuperview];
	[window addSubview:game];
}

-(IBAction)medium
{
	prefs = [NSUserDefaults standardUserDefaults];
	[prefs setFloat:2.8f forKey:@"diff"];
	
	[game reset];
	[difficulty removeFromSuperview];
	[window addSubview:game];
}


-(IBAction)hard
{
	prefs = [NSUserDefaults standardUserDefaults];
	[prefs setFloat:3.4f forKey:@"diff"];
	
	[game reset];
	[difficulty removeFromSuperview];
	[window addSubview:game];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
	
	float systemVersion = [[[ UIDevice currentDevice ] systemVersion ] floatValue ];
	if (systemVersion >= 4.2)
	{
		[Appirater appEnteredForeground:YES];
	}
	
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}



#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    [window release];
    [super dealloc];
}


@end
