//
//  FERObjectsHelper.m
//  DontRepeat
//
//  Created by Fernando Garcia Corrochano on 09/09/14.
//  Copyright (c) 2014 FernandoGarciaCorrochano. All rights reserved.
//

#import "FERObjectsHelper.h"

#define IMAGE_RATIO 0.9288
#define BUTTON_HIGH_PLUS_SEPARATION 48.0
#define SPACE_FROM_BOTTOM 63.0

@implementation FERObjectsHelper
- (void)titlePressed:(FERDontRepeatObjects *)obj foriPhone:(BOOL)iPhone forView:(UIView *)myView{
	[UIView animateWithDuration:1 animations:^{

										 if (iPhone) {
											 obj.titleButton.frame = CGRectMake(8, 10, 304, 50);
											 obj.titleTextField.frame = CGRectMake(8, 58, 304, 30);
											 obj.descriptionButton.frame = CGRectMake(8, 96, 304, 50);
											 obj.dateButton.frame = CGRectMake(8, 154, 304, 50);
											 obj.pictureButton.frame = CGRectMake(8, 212, 304, 50);
											 obj.pictureImageView.frame = CGRectMake(8, 270, 304, 408);
										 }else{
											 CGFloat titleButtonHeight=obj.titleButton.frame.size.height;
											 CGFloat titleButtonWidth=obj.titleButton.frame.size.width;
											 CGFloat titleTextFieldHeight=obj.titleTextField.frame.size.height;
											 CGFloat titleTextFieldWidth=obj.titleTextField.frame.size.width;
											 CGFloat descriptionButtonHeight=obj.descriptionButton.frame.size.height;
											 CGFloat descriptionButtonWidth=obj.descriptionButton.frame.size.width;
											 CGFloat dateButtonHeight=obj.dateButton.frame.size.height;
											 CGFloat dateButtonWidth=obj.dateButton.frame.size.width;
											 CGFloat pictureButtonHeight=obj.pictureButton.frame.size.height;
											 CGFloat pictureButtonWidth=obj.pictureButton.frame.size.width;
											 obj.titleButton.frame = CGRectMake(myView.frame.size.width/2-titleButtonWidth/2,
																													80,
																													titleButtonWidth,
																													titleButtonHeight);
											 obj.titleTextField.frame = CGRectMake(myView.frame.size.width/2-titleTextFieldWidth/2,
																														 128,
																														 titleTextFieldWidth,
																														 titleTextFieldHeight);
											 obj.descriptionButton.frame= CGRectMake(myView.frame.size.width/2-descriptionButtonWidth/2,
																															 149,
																															 descriptionButtonWidth,
																															 descriptionButtonHeight);
											 obj.dateButton.frame = CGRectMake(myView.frame.size.width/2-dateButtonWidth/2,
																												 197,
																												 dateButtonWidth,
																												 dateButtonHeight);
											 obj.pictureButton.frame = CGRectMake(myView.frame.size.width/2-pictureButtonWidth/2,
																														254,
																														pictureButtonWidth,
																														pictureButtonHeight);
											 obj.pictureImageView.frame = [self calculateImageFrameWithView:myView andPictureButton:obj.pictureButton];
										 }
										 
										 obj.titleTextField.layer.borderWidth = 1.0f;
										 obj.titleTextField.layer.borderColor = [[UIColor grayColor] CGColor];
										 
										 obj.titleTextField.hidden=NO;
										 obj.titleTextField.alpha=1;
										 obj.datePicker.hidden=YES;
										 obj.datePicker.alpha=0;
										 obj.descriptionTextView.hidden=YES;
										 obj.descriptionTextView.alpha=0;
										 obj.pictureImageView.hidden=NO;
									 } completion:^(BOOL finished) {
									 }];
	
}
- (void)datePressed:(FERDontRepeatObjects *)obj foriPhone:(BOOL)iPhone forView:(UIView *)myView {
	[UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionAllowAnimatedContent
									 animations:^{
										 
										 if (iPhone) {
											 obj.titleButton.frame = CGRectMake(8, 10, 304, 50);
											 obj.descriptionButton.frame = CGRectMake(8,58, 304, 50);
											 obj.dateButton.frame = CGRectMake(8,116, 304, 50);
											 obj.datePicker.frame = CGRectMake(8,144, 304, 162);
											 obj.pictureButton.frame = CGRectMake(8,344, 304, 50);
											 obj.pictureImageView.frame = CGRectMake(8,392, 304, 408);
										 }else{
											 obj.titleButton.frame = CGRectMake(myView.frame.size.width/2-270/2,80,270,40);
											 obj.descriptionButton.frame = CGRectMake(myView.frame.size.width/2-270/2,128,270,40);
											 obj.dateButton.frame = CGRectMake(myView.frame.size.width/2-270/2,176,270,40);
											 obj.datePicker.frame = CGRectMake(myView.frame.size.width/2-obj.datePicker.frame.size.width/2,
																												 204,obj.datePicker.frame.size.width,obj.datePicker.frame.size.height);
											 obj.pictureButton.frame = CGRectMake(myView.frame.size.width/2-270/2,408,270,40);
											 obj.pictureImageView.frame = [self calculateImageFrameWithView:myView andPictureButton:obj.pictureButton];
										 }
										 
										 obj.titleTextField.hidden=YES;
										 obj.titleTextField.alpha=0;
										 obj.datePicker.hidden=NO;
										 obj.datePicker.alpha=1;
										 obj.descriptionTextView.hidden=YES;
										 obj.descriptionTextView.alpha=0;
										 obj.pictureImageView.hidden=NO;
									 } completion:^(BOOL finished) {
									 }];
}
- (void)descriptionPressed:(FERDontRepeatObjects *)obj foriPhone:(BOOL)iPhone forView:(UIView *)myView {
	[UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionAllowAnimatedContent
									 animations:^{
										 
										 if (iPhone) {
											 obj.titleButton.frame = CGRectMake(8, 10, 304, 50);
											 obj.descriptionButton.frame = CGRectMake(8,58, 304, 50);
											 obj.descriptionTextView.frame = CGRectMake(8, 116, 304, 121);
											 obj.dateButton.frame = CGRectMake(8,237, 304, 50);
											 obj.pictureButton.frame = CGRectMake(8,295, 304, 50);
											 obj.pictureImageView.frame = CGRectMake(8,353, 304, 408);
										 }else{
											 obj.titleButton.frame = CGRectMake(myView.frame.size.width/2-270/2,80,270,40);
											 obj.descriptionButton.frame = CGRectMake(myView.frame.size.width/2-270/2,128,270,40);
											 obj.descriptionTextView.frame = CGRectMake(myView.frame.size.width/2-389/2,176,389,128);
											 obj.dateButton.frame = CGRectMake(myView.frame.size.width/2-270/2,312,270,40);
											 obj.pictureButton.frame = CGRectMake(myView.frame.size.width/2-270/2,360,270,40);
											 obj.pictureImageView.frame = [self calculateImageFrameWithView:myView andPictureButton:obj.pictureButton];
										 }
										 
										 obj.descriptionTextView.layer.borderWidth = 1.0f;
										 obj.descriptionTextView.layer.borderColor = [[UIColor grayColor] CGColor];
										 
										 obj.titleTextField.hidden=YES;
										 obj.titleTextField.alpha=0;
										 obj.datePicker.hidden=YES;
										 obj.datePicker.alpha=0;
										 obj.descriptionTextView.hidden=NO;
										 obj.descriptionTextView.alpha=1;
										 obj.pictureImageView.hidden=NO;
									 } completion:^(BOOL finished) {
									 }];
	
}
- (void)picturePressed:(FERDontRepeatObjects *)obj foriPhone:(BOOL)iPhone forView:(UIView *)myView {
	[UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionAllowAnimatedContent
									 animations:^{
										 
										 if (iPhone) {
											 obj.titleButton.frame = CGRectMake(8, 10, 304, 50);
											 obj.descriptionButton.frame = CGRectMake(8,58, 304, 50);
											 obj.dateButton.frame = CGRectMake(8,116, 304, 50);
											 obj.pictureButton.frame = CGRectMake(8,174, 304, 50);
											 obj.pictureImageView.frame = CGRectMake(8, 232, 304, 408);
										 }else{
											 obj.titleButton.frame = CGRectMake(myView.frame.size.width/2-270/2,80,270,40);
											 obj.descriptionButton.frame = CGRectMake(myView.frame.size.width/2-270/2,128,270,40);
											 obj.dateButton.frame = CGRectMake(myView.frame.size.width/2-270/2,176,270,40);
											 obj.pictureButton.frame = CGRectMake(myView.frame.size.width/2-270/2,224,270,40);
											 obj.pictureImageView.frame = [self calculateImageFrameWithView:myView andPictureButton:obj.pictureButton];
										 }
										 
										 [self hideFields:obj];
									 } completion:^(BOOL finished) {
									 }];
}

-(void)originalPosition:(FERDontRepeatObjects *)obj foriPhone:(BOOL)iPhone forView:(UIView *)myView{
	
	if (iPhone) {
		obj.titleButton.frame = CGRectMake(8, 10, 304, 50);
		obj.titleTextField.frame = CGRectMake(8, 58, 304, 30);
		obj.dateButton.frame = CGRectMake(8,116, 304, 50);
		obj.datePicker.frame = CGRectMake(8,144, 304, 162);
		obj.descriptionButton.frame = CGRectMake(8,58, 304, 50);
		obj.descriptionTextView.frame = CGRectMake(8, 116, 304, 121);
		obj.pictureButton.frame = CGRectMake(8,174, 304, 50);
		obj.pictureImageView.frame = CGRectMake(8, 232, 304, 408);
	}else{
		obj.titleButton.frame = CGRectMake(myView.frame.size.width/2-270/2,80,270,40);
		obj.titleTextField.frame = CGRectMake(myView.frame.size.width/2-389/2,128,389,25);
		obj.dateButton.frame = CGRectMake(myView.frame.size.width/2-270/2,176,270,40);
		obj.datePicker.frame = CGRectMake(myView.frame.size.width/2-obj.datePicker.frame.size.width/2,204,obj.datePicker.frame.size.width,obj.datePicker.frame.size.height);
		obj.descriptionButton.frame = CGRectMake(myView.frame.size.width/2-270/2,128,270,40);
		obj.descriptionTextView.frame = CGRectMake(myView.frame.size.width/2-389/2,176,389,128);
		obj.pictureButton.frame = CGRectMake(myView.frame.size.width/2-270/2,224,270,40);
		obj.pictureImageView.frame = [self calculateImageFrameWithView:myView andPictureButton:obj.pictureButton];
	}
	[self hideFields:obj];
	
}

-(void)hideFields:(FERDontRepeatObjects *)obj{
	[UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionAllowAnimatedContent
									 animations:^{
										 obj.titleTextField.hidden=YES;
										 obj.titleTextField.alpha=0;
										 obj.datePicker.hidden=YES;
										 obj.datePicker.alpha=0;
										 obj.descriptionTextView.hidden=YES;
										 obj.descriptionTextView.alpha=0;
										 obj.pictureImageView.hidden=NO;
									 } completion:^(BOOL finished) {
									 }];
}


-(CGRect)calculateImageFrameWithView:(UIView *)myView
										andPictureButton:(UIButton *)picButton{
	CGFloat y=picButton.frame.origin.y + BUTTON_HIGH_PLUS_SEPARATION;
	CGFloat height=myView.frame.size.height - y - SPACE_FROM_BOTTOM;
	CGFloat width=myView.frame.size.width;//height*IMAGE_RATIO;
	CGRect ratio=CGRectMake(myView.frame.size.width/2-width/2, y, width, height);
	
	return ratio;
}

@end
