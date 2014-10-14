//
//  FERObjectsHelper.m
//  DontRepeat
//
//  Created by Fernando Garcia Corrochano on 09/09/14.
//  Copyright (c) 2014 FernandoGarciaCorrochano. All rights reserved.
//

#import "FERObjectsHelper.h"

@implementation FERObjectsHelper
- (void)titlePressed:(FERDontRepeatObjects *)obj foriPhone:(BOOL)iPhone forView:(UIView *)view{
	[obj.titleTextField becomeFirstResponder];
	[obj.descriptionTextView resignFirstResponder];
	[UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionAllowAnimatedContent
									 animations:^{
										 
										 if (iPhone) {
											 obj.titleButton.frame = CGRectMake(8, 10, 304, 50);
											 obj.titleTextField.frame = CGRectMake(8, 58, 304, 30);
											 obj.descriptionButton.frame = CGRectMake(8, 96, 304, 50);
											 obj.dateButton.frame = CGRectMake(8, 154, 304, 50);
											 obj.pictureButton.frame = CGRectMake(8, 212, 304, 50);
											 obj.pictureImageView.frame = CGRectMake(8, 270, 304, 408);
										 }else{
											 obj.titleButton.frame = CGRectMake(view.frame.size.width/2-270/2,80,270,40);
											 obj.titleTextField.frame = CGRectMake(view.frame.size.width/2-389/2,128,389,25);
											 obj.descriptionButton.frame= CGRectMake(view.frame.size.width/2-270/2,168,270,40);
											 obj.dateButton.frame = CGRectMake(view.frame.size.width/2-270/2,216,270,40);
											 obj.pictureButton.frame = CGRectMake(view.frame.size.width/2-270/2,254,270,40);
											 obj.pictureImageView.frame = CGRectMake(view.frame.size.width/2-640/2,307,640,654);
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
- (void)datePressed:(FERDontRepeatObjects *)obj foriPhone:(BOOL)iPhone forView:(UIView *)view {
	[obj.datePicker becomeFirstResponder];
	[obj.titleTextField resignFirstResponder];
	[obj.descriptionTextView resignFirstResponder];
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
											 obj.titleButton.frame = CGRectMake(view.frame.size.width/2-270/2,80,270,40);
											 obj.descriptionButton.frame = CGRectMake(view.frame.size.width/2-270/2,128,270,40);
											 obj.dateButton.frame = CGRectMake(view.frame.size.width/2-270/2,176,270,40);
											 obj.datePicker.frame = CGRectMake(view.frame.size.width/2-389/2,204,389,216);
											 obj.pictureButton.frame = CGRectMake(view.frame.size.width/2-270/2,408,270,40);
											 obj.pictureImageView.frame = CGRectMake(view.frame.size.width/2-640/2,456,640,510);
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
- (void)descriptionPressed:(FERDontRepeatObjects *)obj foriPhone:(BOOL)iPhone forView:(UIView *)view {
	[obj.descriptionTextView becomeFirstResponder];
	[obj.titleTextField resignFirstResponder];
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
											 obj.titleButton.frame = CGRectMake(view.frame.size.width/2-270/2,80,270,40);
											 obj.descriptionButton.frame = CGRectMake(view.frame.size.width/2-270/2,128,270,40);
											 obj.descriptionTextView.frame = CGRectMake(view.frame.size.width/2-389/2,176,389,128);
											 obj.dateButton.frame = CGRectMake(view.frame.size.width/2-270/2,312,270,40);
											 obj.pictureButton.frame = CGRectMake(view.frame.size.width/2-270/2,360,270,40);
											 obj.pictureImageView.frame = CGRectMake(view.frame.size.width/2-640/2,408,640,558);
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
- (void)picturePressed:(FERDontRepeatObjects *)obj foriPhone:(BOOL)iPhone forView:(UIView *)view {
	[obj.pictureImageView becomeFirstResponder];
	[obj.titleTextField resignFirstResponder];
	[obj.descriptionTextView resignFirstResponder];
	[UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionAllowAnimatedContent
									 animations:^{
										 
										 if (iPhone) {
											 obj.titleButton.frame = CGRectMake(8, 10, 304, 50);
											 obj.descriptionButton.frame = CGRectMake(8,58, 304, 50);
											 obj.dateButton.frame = CGRectMake(8,116, 304, 50);
											 obj.pictureButton.frame = CGRectMake(8,174, 304, 50);
											 obj.pictureImageView.frame = CGRectMake(8, 232, 304, 408);
										 }else{
											 obj.titleButton.frame = CGRectMake(view.frame.size.width/2-270/2,80,270,40);
											 obj.descriptionButton.frame = CGRectMake(view.frame.size.width/2-270/2,128,270,40);
											 obj.dateButton.frame = CGRectMake(view.frame.size.width/2-270/2,176,270,40);
											 obj.pictureButton.frame = CGRectMake(view.frame.size.width/2-270/2,224,270,40);
											 obj.pictureImageView.frame = CGRectMake(view.frame.size.width/2-640/2,272,640,689);
										 }
										 
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

-(void)originalPosition:(FERDontRepeatObjects *)obj foriPhone:(BOOL)iPhone forView:(UIView *)view{
	
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
		obj.titleButton.frame = CGRectMake(view.frame.size.width/2-270/2,80,270,40);
		obj.titleTextField.frame = CGRectMake(view.frame.size.width/2-389/2,128,389,25);
		obj.dateButton.frame = CGRectMake(view.frame.size.width/2-270/2,176,270,40);
		obj.datePicker.frame = CGRectMake(view.frame.size.width/2-389/2,204,389,216);
		obj.descriptionButton.frame = CGRectMake(view.frame.size.width/2-270/2,128,270,40);
		obj.descriptionTextView.frame = CGRectMake(view.frame.size.width/2-389/2,176,389,128);
		obj.pictureButton.frame = CGRectMake(view.frame.size.width/2-270/2,224,270,40);
		if (view.frame.size.height>view.frame.size.width) {
			obj.pictureImageView.frame = CGRectMake(view.frame.size.width/2-640/2,272,640,689);
		}else{
			obj.pictureImageView.frame = CGRectMake(view.frame.size.width/2-640/2,272,640,430);
		}

	}
	
	obj.titleTextField.hidden=YES;
	obj.titleTextField.alpha=0;
	obj.datePicker.hidden=YES;
	obj.datePicker.alpha=0;
	obj.descriptionTextView.hidden=YES;
	obj.descriptionTextView.alpha=0;
	obj.pictureImageView.hidden=NO;
	
}

-(void)hideFields:(FERDontRepeatObjects *)obj{
	[obj.titleTextField resignFirstResponder];
	[obj.descriptionTextView resignFirstResponder];
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


@end
