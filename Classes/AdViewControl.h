//
//  AdViewControl.h
//  Vocab
//
//  Created by Knikes on 7/7/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iAd/ADBannerView.h"
#import "AdMobDelegateProtocol.h"
#import "AdMobInterstitialDelegateProtocol.h"
#import "AdMobInterstitialAd.h"
#import "AdMobDelegate.h";

@interface AdViewControl : UIView <ADBannerViewDelegate> 
{
	id _adBannerView;
	BOOL _adBannerViewIsVisible;
	AdMobDelegate *adelegate;
}

@property (nonatomic, retain) id adBannerView;
@property (nonatomic) BOOL adBannerViewIsVisible;

-(void)setCoordinates:(int)x:(int)y;
- (void)createAdBannerView;

@end
