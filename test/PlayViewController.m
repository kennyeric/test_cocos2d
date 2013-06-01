//
//  PlayViewController.m
//  test
//
//  Created by kenny on 6/1/13.
//
//

#import "PlayViewController.h"

@interface PlayViewController ()

@end

@implementation PlayViewController
@synthesize dict;
@synthesize flag;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //The setup code (in viewDidLoad in your view controller)

    [self createPlayDict];
    [self listSubviewsOfView:self.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)listSubviewsOfView:(UIView *)view {
    
    // Get the subviews of the view
    NSArray *subviews = [view subviews];
    
    // Return if there are no subviews
    if ([subviews count] == 0) return;

    for (UIView *subview in subviews) {
        if (subview.restorationIdentifier)
            NSLog(@"%d", [subview.restorationIdentifier integerValue]);
            UITapGestureRecognizer *singleFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                    action:@selector(handleSingleTap:)];
            [subview addGestureRecognizer:singleFingerTap];
    }
}

- (UIView *)getSubViewWithIdentify:(UIView *)view identify:(NSInteger) identify{
    
    // Get the subviews of the view
    NSArray *subviews = [view subviews];
    
    // Return if there are no subviews
    if ([subviews count] == 0) return nil;
    
    for (UIView *subview in subviews) {
        if ([subview.restorationIdentifier integerValue] == identify)
            return subview;
    }
    return nil;
}

- (void)createPlayDict {
    self.dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"dear", @"亲爱的", @"亲爱的", @"dear", @"mather", @"母亲", @"母亲", @"mather", @"family", @"家庭", @"家庭", @"family", @"lover", @"情人", @"情人", @"lover", nil];
}

- (void)changeColor:(UITapGestureRecognizer *)recognizer {
    if (recognizer.view.backgroundColor == [UIColor whiteColor])
        recognizer.view.backgroundColor = [UIColor greenColor];
    else
        recognizer.view.backgroundColor = [UIColor whiteColor];
}

- (void)showAlert{
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle: @"匹配成功"
                          message: @"你做对了！恭喜你"
                          delegate: nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil];
    [alert show];
    self.flag = 0;
}

//The event handling method
- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
//    CGPoint location = [recognizer locationInView:[recognizer.view superview]];
    
    //Do stuff here...
    NSLog(@"%@", recognizer.view.restorationIdentifier);
    NSInteger indentify = [recognizer.view.restorationIdentifier intValue];
    if (self.flag == 0) {
        self.flag = indentify;
        [self changeColor:recognizer];
    } else if (self.flag == indentify) {
        [self changeColor:recognizer];
    } else if (self.flag % 2 == 0) {
        if (indentify % 2 == 1) {
            UIButton *pre_view = (UIButton *)[self getSubViewWithIdentify:self.view identify:self.flag];
            UIButton *cur_view = (UIButton *)[self getSubViewWithIdentify:self.view identify:indentify];
            if ([[self.dict objectForKey:pre_view.currentTitle] isEqualToString:cur_view.currentTitle])
                [self showAlert];
        }
    } else if (self.flag % 2 == 1) {
        if (indentify % 2 == 0) {
            UIButton *pre_view = (UIButton *)[self getSubViewWithIdentify:self.view identify:self.flag];
            UIButton *cur_view = (UIButton *)[self getSubViewWithIdentify:self.view identify:indentify];
            if ([[self.dict objectForKey:pre_view.currentTitle] isEqualToString:cur_view.currentTitle])
                [self showAlert];
        }
    }
}
@end
