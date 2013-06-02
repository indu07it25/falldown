//
//  AdMobDelegate.h
//  Falldown
//
//  Created by Knikes on 1/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdMobDelegateProtocol.h"

@class AdMobView;

@interface AdMobDelegate : UIViewController<AdMobDelegate> {
	AdMobView *adMobAd;
	UIView *myView;
}

- (id)init:(UIView*)view;

@end
