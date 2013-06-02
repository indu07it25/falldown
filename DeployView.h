//
//  DeployView.h
//  Falldown
//
//  Created by Knikes on 6/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameScroll.h"

@interface DeployView : UIView {
    GameScroll *scroll;
}

@property (nonatomic, retain) IBOutlet GameScroll *scroll;

-(void)flashScroll;
-(IBAction)remove;


@end
