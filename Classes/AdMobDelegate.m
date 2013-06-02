//
//  AdMobDelegate.m
//  Falldown
//
//  Created by Knikes on 1/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AdMobDelegate.h"
#import "AdMobView.h"


@implementation AdMobDelegate

- (id)init:(UIView*)view {
    if ((self = [super init])) {
		myView = view;
		adMobAd = [AdMobView requestAdWithDelegate:self]; 
    }
    return self;
}


// Use this to provide a publisher id for an ad request. Get a publisher id
// from http://www.admob.com
- (NSString *)publisherIdForAd:(AdMobView *)adView 
{
	return @"a14d2226f1826ad"; // this should be prefilled; if not, get it from www.admob.com
}

- (UIViewController *)currentViewControllerForAd:(AdMobView *)adView
{
	return self;
}

// Sent when an ad request loaded an ad; this is a good opportunity to attach
// the ad view to the hierachy.
- (void)didReceiveAd:(AdMobView *)adView {
	NSLog(@"AdMob: Did receive ad");
	// get the view frame
	CGRect frame = myView.frame;
	
	// put the ad at the bottom of the screen
	adMobAd.frame = CGRectMake(0, frame.size.height - 48, frame.size.width, 48);
	
	[myView addSubview:adMobAd];
}

// Sent when an ad request failed to load an ad
- (void)didFailToReceiveAd:(AdMobView *)adView {
	NSLog(@"AdMob: Did fail to receive ad");
	//[adMobAd removeFromSuperview];  // Not necessary since never added to a view, but doesn't hurt and is good practice
	//[adMobAd release];
	adMobAd = nil;
	myView.hidden = YES;
	// we could start a new ad request here, but in the interests of the user's battery life, let's not
}

@end
