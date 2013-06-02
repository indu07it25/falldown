//
//  GameScroll.h
//  Falldown
//
//  Created by Knikes on 6/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GameScroll : UIScrollView <UIScrollViewDelegate> {
    // Pointers/variables used to manage the scrolling
	BOOL pageControlUsed;
	UIPageControl *pageControl;
	NSMutableArray *viewControllers;

    UIView *satVocab;
    UIView *blockTap;
}

@property (nonatomic, retain) IBOutlet UIPageControl *pageControl;
@property (nonatomic, retain) IBOutlet UIView *satVocab;
@property (nonatomic, retain) IBOutlet UIView *blockTap;


// Functions used to manage scrolling the pages
-(void)loadScrollViewWithPage:(int)page;
-(IBAction)changePage:(id)sender;
-(void)switchPage:(int)pageNum;

@end
