//
//  DeployView.m
//  Falldown
//
//  Created by Knikes on 6/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DeployView.h"


@implementation DeployView

@synthesize scroll;

-(void)flashScroll{
    [scroll flashScrollIndicators];
}

-(IBAction)remove{
    //[self setFrame:CGRectMake(0, 0, 320, 388)];
	//[self setBounds:CGRectMake(0, 0, 320, 388)];
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.5];
	[UIView setAnimationDelegate:self];
	[self setFrame:CGRectMake(0, 480, 320, 380)];
	[UIView commitAnimations];

}

@end
