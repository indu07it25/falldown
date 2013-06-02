//
//  AdViewControl.m
//  Vocab
//
//  Created by Knikes on 7/7/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AdViewControl.h"


@implementation AdViewControl


@synthesize adBannerView = _adBannerView;
@synthesize adBannerViewIsVisible = _adBannerViewIsVisible;


-(void)viewDidLoad{
	[self createAdBannerView];
	[self setFrame:CGRectMake(0, 270, 320, 50)]; ///Problem here
}

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        
    }
    return self;
}

-(void)setCoordinates:(int)x :(int)y
{
	[self setFrame:CGRectMake(x,y, 320, 50)];
}

- (int)getBannerHeight:(UIDeviceOrientation)orientation {
    if (UIInterfaceOrientationIsLandscape(orientation)) {
        return 32;
    } else {
        return 50;
    }
}

- (int)getBannerHeight {
    return [self getBannerHeight:[UIDevice currentDevice].orientation];
}

- (void)createAdBannerView {
    Class classAdBannerView = NSClassFromString(@"ADBannerView");
    if (classAdBannerView != nil) {
        self.adBannerView = [[[classAdBannerView alloc] 
							  initWithFrame:CGRectZero] autorelease];
        [_adBannerView setRequiredContentSizeIdentifiers:[NSSet setWithObjects: 
														 ADBannerContentSizeIdentifier320x50, 
														  ADBannerContentSizeIdentifier480x32, nil]];
        if (UIInterfaceOrientationIsLandscape([UIDevice currentDevice].orientation)) {
            [_adBannerView setCurrentContentSizeIdentifier:
			 ADBannerContentSizeIdentifier480x32];
        } else {
            [_adBannerView setCurrentContentSizeIdentifier:
			 ADBannerContentSizeIdentifier320x50];            
        }
        [_adBannerView setFrame:CGRectOffset([_adBannerView frame], 0, 
											 -[self getBannerHeight])];
		[_adBannerView setFrame:CGRectMake(0,0, 320, 50)];
        [_adBannerView setDelegate:self];
		
        [self addSubview:_adBannerView]; 
		
    }
}

- (BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave
{
    //NSLog(@"Banner view is beginning an ad action");
	self.hidden = NO;
	banner.frame = CGRectMake(0,430, 320, 50);
	[self setFrame:CGRectMake(0,430, 320, 50)];

    BOOL shouldExecuteAction = YES; // your application implements this method
	
    if (!willLeave && shouldExecuteAction)
		
    {
        //No services need to be suspended
    }
	
    return shouldExecuteAction;
}


- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
	//if (self.bannerIsVisible)
	{
		[UIView beginAnimations:@"animateAdBannerOff" context:NULL];
		// assumes the banner view is at the top of the screen.
		banner.frame = CGRectOffset(banner.frame, 0, 600);
		[UIView commitAnimations];
		//self.hidden = YES;
		//self.bannerIsVisible = NO;
	}
	
	adelegate = [[AdMobDelegate alloc] init:self];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)dealloc {
	self.adBannerView = nil;
    [super dealloc];
}


@end
