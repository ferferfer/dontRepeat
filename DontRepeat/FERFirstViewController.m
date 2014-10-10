//
//  FERFirstViewController.m
//  DontRepeat
//
//  Created by Fernando Garcia Corrochano on 10/10/14.
//  Copyright (c) 2014 FernandoGarciaCorrochano. All rights reserved.
//

#import "FERFirstViewController.h"

@interface FERFirstViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UIButton *aNewUserButton;

@property (weak, nonatomic) IBOutlet UIButton *existingUserButton;

@end

@implementation FERFirstViewController

-(void)viewWillAppear:(BOOL)animated{
	self.navigationController.navigationBarHidden=YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	[self configure];
}

-(void)configure{
	[UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionAllowAnimatedContent
									 animations:^{
										 self.imageView.alpha=0.4;
										 self.aNewUserButton.alpha=1;
										 self.existingUserButton.alpha=1;
									 } completion:^(BOOL finished) {
									 }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
