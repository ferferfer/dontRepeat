//
//  FERInfoViewController.h
//  DontRepeat
//
//  Created by Fernando Garcia Corrochano on 24/10/14.
//  Copyright (c) 2014 FernandoGarciaCorrochano. All rights reserved.
//


#import "FERInfoViewController.h"

@interface FERInfoViewController ()<UITextViewDelegate>

@end

@implementation FERInfoViewController

- (void)viewDidLoad{
  [super viewDidLoad];
	[self createTitle];
	[self createText];
}

-(void)createTitle{
	UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 200, 20)];
	title.text = @"Recomendation";
	[self.view addSubview:title];
}

-(void)createText{
	UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(5, 30, 200, 80)];
	textView.text = @"Enter a valid email for password  recovery. \nIn case you lost it ;)";
	textView.backgroundColor=[UIColor clearColor];
	textView.delegate = self;
	[self.view addSubview:textView];
}


#pragma mark - UITextViewDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView{
    if ([self.delegate respondsToSelector:@selector(startedEditing)])
    {
        [self.delegate startedEditing];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    if ([self.delegate respondsToSelector:@selector(finishedEditing)])
    {
        [self.delegate finishedEditing];
    }
}

@end
