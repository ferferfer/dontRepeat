//
//  FERObjectsHelper.m
//  DontRepeat
//
//  Created by Fernando Garcia Corrochano on 09/09/14.
//  Copyright (c) 2014 FernandoGarciaCorrochano. All rights reserved.
//

#import "FERObjectsHelper.h"

@implementation FERObjectsHelper

- (void)titlePressed:(FERDontRepeatObjects *)obj{
	[obj.titleTextField becomeFirstResponder];
	[obj.descriptionTextView resignFirstResponder];
	[UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionAllowAnimatedContent
									 animations:^{
										 CGRect rectTitButton = obj.titleButton.frame;
										 CGRect rectTit = obj.titleTextField.frame;
										 CGRect rectDate = obj.dateButton.frame;
										 CGRect rectDesc = obj.descriptionButton.frame;
										 CGRect rectPic = obj.pictureButton.frame;
										 CGRect rectImg = obj.pictureImageView.frame;
										 
										 rectTitButton.origin = CGPointMake(8, 10);
										 rectTit.origin = CGPointMake(8, 58);
										 rectDesc.origin = CGPointMake(8, 96);
										 rectDate.origin = CGPointMake(8, 154);
										 rectPic.origin = CGPointMake(8, 212);
										 rectImg.origin = CGPointMake(8, 270);
										 
										 obj.titleButton.frame=rectTitButton;
										 obj.titleTextField.frame=rectTit;
										 obj.titleTextField.layer.borderWidth = 1.0f;
										 obj.titleTextField.layer.borderColor = [[UIColor grayColor] CGColor];
										 obj.dateButton.frame = rectDate;
										 obj.descriptionButton.frame = rectDesc;
										 obj.pictureButton.frame = rectPic;
										 obj.pictureImageView.frame = rectImg;
										 
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
- (void)datePressed:(FERDontRepeatObjects *)obj {
	[obj.datePicker becomeFirstResponder];
	[obj.titleTextField resignFirstResponder];
	[obj.descriptionTextView resignFirstResponder];
	[UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionAllowAnimatedContent
									 animations:^{
										 CGRect rectTitButton = obj.titleButton.frame;
										 CGRect rectDate = obj.dateButton.frame;
										 CGRect rectDatePicker = obj.datePicker.frame;
										 CGRect rectDesc = obj.descriptionButton.frame;
										 CGRect rectPic = obj.pictureButton.frame;
										 CGRect rectImg = obj.pictureImageView.frame;
										 
										 rectTitButton.origin = CGPointMake(8, 10);
										 rectDesc.origin = CGPointMake(8,58);
										 rectDate.origin = CGPointMake(8,116);
										 rectDatePicker.origin = CGPointMake(8,144);
										 rectPic.origin = CGPointMake(8,344);
										 rectImg.origin = CGPointMake(8,392);
										 
										 obj.titleButton.frame=rectTitButton;
										 obj.dateButton.frame = rectDate;
										 obj.datePicker.frame = rectDatePicker;
										 obj.descriptionButton.frame = rectDesc;
										 obj.pictureButton.frame = rectPic;
										 obj.pictureImageView.frame = rectImg;
										 
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
- (void)descriptionPressed:(FERDontRepeatObjects *)obj {
	[obj.descriptionTextView becomeFirstResponder];
	[obj.titleTextField resignFirstResponder];
	[UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionAllowAnimatedContent
									 animations:^{
										 CGRect rectTitButton = obj.titleButton.frame;
										 CGRect rectDate = obj.dateButton.frame;
										 CGRect rectDescText = obj.descriptionTextView.frame;
										 CGRect rectDesc = obj.descriptionButton.frame;
										 CGRect rectPic = obj.pictureButton.frame;
										 CGRect rectImg = obj.pictureImageView.frame;
										 
										 rectTitButton.origin = CGPointMake(8, 10);
										 rectDesc.origin = CGPointMake(8,58);
										 rectDescText.origin = CGPointMake(8, 116);
										 rectDate.origin = CGPointMake(8,237);
										 rectPic.origin = CGPointMake(8,295);
										 rectImg.origin = CGPointMake(8,353);
										 
										 obj.titleButton.frame=rectTitButton;
										 obj.dateButton.frame = rectDate;
										 obj.descriptionTextView.frame = rectDescText;
										 obj.descriptionTextView.layer.borderWidth = 1.0f;
										 obj.descriptionTextView.layer.borderColor = [[UIColor grayColor] CGColor];
										 obj.descriptionButton.frame = rectDesc;
										 obj.pictureButton.frame = rectPic;
										 obj.pictureImageView.frame = rectImg;
										 
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
- (void)picturePressed:(FERDontRepeatObjects *)obj {
	[obj.pictureImageView becomeFirstResponder];
	[obj.titleTextField resignFirstResponder];
	[obj.descriptionTextView resignFirstResponder];
	[UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionAllowAnimatedContent
									 animations:^{
	CGRect rectTitButton = obj.titleButton.frame;
	CGRect rectDate = obj.dateButton.frame;
	CGRect rectDesc = obj.descriptionButton.frame;
	CGRect rectPic = obj.pictureButton.frame;
	CGRect rectPicView = obj.pictureImageView.frame;
	
	rectTitButton.origin = CGPointMake(8, 10);
	rectDesc.origin = CGPointMake(8,58);
	rectDate.origin = CGPointMake(8,116);
	rectPic.origin = CGPointMake(8,174);
	rectPicView.origin = CGPointMake(8, 232);
	
	obj.titleButton.frame=rectTitButton;
	obj.dateButton.frame = rectDate;
	obj.descriptionButton.frame = rectDesc;
	obj.pictureButton.frame = rectPic;
	obj.pictureImageView.frame = rectPicView;
	
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

-(void)originalPosition:(FERDontRepeatObjects *)obj{
	
	CGRect rectTitButton = obj.titleButton.frame;
	CGRect rectDate = obj.dateButton.frame;
	CGRect rectDesc = obj.descriptionButton.frame;
	CGRect rectPic = obj.pictureButton.frame;
	CGRect rectImage =obj.pictureImageView.frame;
	
	rectTitButton.origin = CGPointMake(8, 10);
	rectDesc.origin = CGPointMake(8,58);
	rectDate.origin = CGPointMake(8,116);
	rectPic.origin = CGPointMake(8,174);
	rectImage.origin = CGPointMake(8, 232);
	
	obj.titleButton.frame=rectTitButton;
	obj.dateButton.frame = rectDate;
	obj.descriptionButton.frame = rectDesc;
	obj.pictureButton.frame = rectPic;
	obj.pictureImageView.frame=rectImage;
	
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
