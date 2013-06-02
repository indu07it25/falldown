 /************************************************************************************************
 *
 * Achievements.h
 *
 ************************************************************************************************/

#import "highScores.h"

@interface Achievements : UIScrollView <UIScrollViewDelegate> {
	// Pointers/variables used to manage the scrolling
	BOOL pageControlUsed;
	UIPageControl *pageControl;
	NSMutableArray *viewControllers;
	
    highScores *high;
    
	// Pointers to the views in the scroll view
	UIViewController* easyView;
	UIViewController* medView;
	UIViewController* hardView;
    
    UIButton* btnEasy;
    UIButton* btnMed;
    UIButton* btnHard;
    
    UIImageView* easyScore;
    UIImageView* medScore;
    UIImageView* hardScore;
}

@property (nonatomic, retain) IBOutlet UIPageControl *pageControl;
@property (nonatomic, retain) IBOutlet UIViewController* easyView;
@property (nonatomic, retain) IBOutlet UIViewController* medView;
@property (nonatomic, retain) IBOutlet UIViewController* hardView;

@property (nonatomic, retain) IBOutlet UIButton* btnEasy;
@property (nonatomic, retain) IBOutlet UIButton* btnMed;
@property (nonatomic, retain) IBOutlet UIButton* btnHard;
@property (nonatomic, retain) IBOutlet highScores* high;


// Functions used to manage scrolling the pages
-(void)loadScrollViewWithPage:(int)page;
-(IBAction)changePage:(id)sender;
-(void)switchPage:(int)pageNum;
-(IBAction)back;

@end
