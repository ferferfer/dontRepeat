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
#define SPACE 8.0

@implementation FERObjectsHelper
- (void)titlePressed:(FERDontRepeatObjects *)obj foriPhone:(BOOL)iPhone forView:(UIView *)myView{
	[UIView animateWithDuration:1 animations:^{
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
		CGFloat deleteButtonHeight=obj.deleteButton.frame.size.height;
		CGFloat deleteButtonWidth=obj.deleteButton.frame.size.width;
		if (iPhone) {
				obj.titleButton.frame = CGRectMake([self centerFrameWithView:myView andWidth:titleButtonWidth],
																					 SPACE,
																					 titleButtonWidth,
																					 titleButtonHeight);
		}else{
			obj.titleButton.frame = CGRectMake([self centerFrameWithView:myView andWidth:titleButtonWidth],
																				 80,
																				 titleButtonWidth,
																				 titleButtonHeight);
			
		}
		obj.titleTextField.frame = CGRectMake([self centerFrameWithView:myView andWidth:titleTextFieldWidth],
																					[self calculateYpositionWithPreviousView:obj.titleButton],
																					titleTextFieldWidth,
																					titleTextFieldHeight);
		obj.descriptionButton.frame= CGRectMake([self centerFrameWithView:myView andWidth:descriptionButtonWidth],
																						[self calculateYpositionWithPreviousView:obj.titleTextField],
																						descriptionButtonWidth,
																						descriptionButtonHeight);
		obj.dateButton.frame = CGRectMake([self centerFrameWithView:myView andWidth:dateButtonWidth],
																			[self calculateYpositionWithPreviousView:obj.descriptionButton],
																			dateButtonWidth,
																			dateButtonHeight);
		obj.pictureButton.frame = CGRectMake([self centerFrameWithView:myView andWidth:pictureButtonWidth],
																				 [self calculateYpositionWithPreviousView:obj.dateButton],
																				 pictureButtonWidth,
																				 pictureButtonHeight);
		if (iPhone) {
			CGFloat pictureImageViewWidth = obj.pictureImageView.frame.size.width;
			CGFloat pictureImageViewHeight = obj.pictureImageView.frame.size.height;
			obj.pictureImageView.frame =  CGRectMake([self centerFrameWithView:myView andWidth:pictureImageViewWidth],
																							 [self calculateYpositionWithPreviousView:obj.pictureButton],
																							 pictureImageViewWidth,
																							 pictureImageViewHeight);
		}else{
			obj.pictureImageView.frame = [self calculateImageFrameWithView:myView andPictureButton:obj.pictureButton];
		}
		
		obj.deleteButton.frame = CGRectMake([self centerFrameWithView:myView andWidth:deleteButtonWidth],
																				 [self calculateYpositionWithPreviousView:obj.pictureImageView],
																				 deleteButtonWidth,
																				 deleteButtonHeight);
		
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
										 CGFloat titleButtonHeight=obj.titleButton.frame.size.height;
										 CGFloat titleButtonWidth=obj.titleButton.frame.size.width;
										 CGFloat descriptionButtonHeight=obj.descriptionButton.frame.size.height;
										 CGFloat descriptionButtonWidth=obj.descriptionButton.frame.size.width;
										 CGFloat dateButtonHeight=obj.dateButton.frame.size.height;
										 CGFloat dateButtonWidth=obj.dateButton.frame.size.width;
										 CGFloat datePickerHeight=obj.datePicker.frame.size.height;
										 CGFloat datePickerWidth=obj.datePicker.frame.size.width;
										 CGFloat pictureButtonHeight=obj.pictureButton.frame.size.height;
										 CGFloat pictureButtonWidth=obj.pictureButton.frame.size.width;
										 CGFloat deleteButtonHeight=obj.deleteButton.frame.size.height;
										 CGFloat deleteButtonWidth=obj.deleteButton.frame.size.width;
										 if (iPhone) {
												 obj.titleButton.frame = CGRectMake([self centerFrameWithView:myView andWidth:titleButtonWidth],
																														SPACE,
																														titleButtonWidth,
																														titleButtonHeight);
										 }else{
											 obj.titleButton.frame = CGRectMake([self centerFrameWithView:myView andWidth:titleButtonWidth],
																													80,
																													titleButtonWidth,
																													titleButtonHeight);
										 }
										 
										 
										 obj.descriptionButton.frame = CGRectMake([self centerFrameWithView:myView andWidth:descriptionButtonWidth],
																															[self calculateYpositionWithPreviousView:obj.titleButton],
																															descriptionButtonWidth,
																															descriptionButtonHeight);
										 obj.dateButton.frame = CGRectMake([self centerFrameWithView:myView andWidth:dateButtonWidth],
																											 [self calculateYpositionWithPreviousView:obj.descriptionButton],
																											 dateButtonWidth,
																											 dateButtonHeight);
										 obj.datePicker.frame = CGRectMake([self centerFrameWithView:myView andWidth:datePickerWidth],
																											 [self calculateYpositionWithPreviousView:obj.dateButton],
																											 datePickerWidth,
																											 datePickerHeight);
										 obj.pictureButton.frame = CGRectMake([self centerFrameWithView:myView andWidth:pictureButtonWidth],
																													[self calculateYpositionWithPreviousView:obj.datePicker],
																													pictureButtonWidth,
																													pictureButtonHeight);
										 if (iPhone) {
											 CGFloat pictureImageViewWidth = obj.pictureImageView.frame.size.width;
											 CGFloat pictureImageViewHeight = obj.pictureImageView.frame.size.height;
											 obj.pictureImageView.frame =  CGRectMake([self centerFrameWithView:myView andWidth:pictureImageViewWidth],
																																[self calculateYpositionWithPreviousView:obj.pictureButton],
																																pictureImageViewWidth,
																																pictureImageViewHeight);
										 }else{
											 obj.pictureImageView.frame = [self calculateImageFrameWithView:myView andPictureButton:obj.pictureButton];
										 }
										 
										 obj.deleteButton.frame = CGRectMake([self centerFrameWithView:myView andWidth:deleteButtonWidth],
																												 [self calculateYpositionWithPreviousView:obj.pictureImageView],
																												 deleteButtonWidth,
																												 deleteButtonHeight);
										 
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
										 CGFloat titleButtonHeight=obj.titleButton.frame.size.height;
										 CGFloat titleButtonWidth=obj.titleButton.frame.size.width;
										 CGFloat dateButtonHeight=obj.dateButton.frame.size.height;
										 CGFloat dateButtonWidth=obj.dateButton.frame.size.width;
										 CGFloat descriptionButtonHeight=obj.descriptionButton.frame.size.height;
										 CGFloat descriptionButtonWidth=obj.descriptionButton.frame.size.width;
										 CGFloat descriptionTextViewHeight=obj.descriptionTextView.frame.size.height;
										 CGFloat descriptionTextViewWidth=obj.descriptionTextView.frame.size.width;
										 CGFloat pictureButtonHeight=obj.pictureButton.frame.size.height;
										 CGFloat pictureButtonWidth=obj.pictureButton.frame.size.width;
										 CGFloat deleteButtonHeight=obj.deleteButton.frame.size.height;
										 CGFloat deleteButtonWidth=obj.deleteButton.frame.size.width;
										 if (iPhone) {
												 obj.titleButton.frame = CGRectMake([self centerFrameWithView:myView andWidth:titleButtonWidth],
																														SPACE,
																														titleButtonWidth,
																														titleButtonHeight);
										 }else{
											 obj.titleButton.frame = CGRectMake([self centerFrameWithView:myView andWidth:titleButtonWidth],
																													80,
																													titleButtonWidth,
																													titleButtonHeight);
										 }
										 
										 obj.descriptionButton.frame = CGRectMake([self centerFrameWithView:myView andWidth:descriptionButtonWidth],
																															[self calculateYpositionWithPreviousView:obj.titleButton],
																															descriptionButtonWidth,
																															descriptionButtonHeight);
										 obj.descriptionTextView.frame = CGRectMake([self centerFrameWithView:myView andWidth:descriptionTextViewWidth],
																																[self calculateYpositionWithPreviousView:obj.descriptionButton],
																																descriptionTextViewWidth,
																																descriptionTextViewHeight);
										 obj.dateButton.frame = CGRectMake([self centerFrameWithView:myView andWidth:dateButtonWidth],
																											 [self calculateYpositionWithPreviousView:obj.descriptionTextView],
																											 dateButtonWidth,
																											 dateButtonHeight);
										 obj.pictureButton.frame = CGRectMake([self centerFrameWithView:myView andWidth:pictureButtonWidth],
																													[self calculateYpositionWithPreviousView:obj.dateButton],
																													pictureButtonWidth,
																													pictureButtonHeight);
										 if (iPhone) {
											 CGFloat pictureImageViewWidth = obj.pictureImageView.frame.size.width;
											 CGFloat pictureImageViewHeight = obj.pictureImageView.frame.size.height;
											 obj.pictureImageView.frame =  CGRectMake([self centerFrameWithView:myView andWidth:pictureImageViewWidth],
																																[self calculateYpositionWithPreviousView:obj.pictureButton],
																																pictureImageViewWidth,
																																pictureImageViewHeight);
										 }else{
											 obj.pictureImageView.frame = [self calculateImageFrameWithView:myView andPictureButton:obj.pictureButton];
										 }
										 
										 obj.deleteButton.frame = CGRectMake([self centerFrameWithView:myView andWidth:deleteButtonWidth],
																												 [self calculateYpositionWithPreviousView:obj.pictureImageView],
																												 deleteButtonWidth,
																												 deleteButtonHeight);
										 
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
										 [self originalPosition:obj foriPhone:iPhone forView:myView];
										 [self hideFields:obj];
									 } completion:^(BOOL finished) {
									 }];
}

-(void)originalPosition:(FERDontRepeatObjects *)obj foriPhone:(BOOL)iPhone forView:(UIView *)myView{
	
	CGFloat titleButtonHeight=obj.titleButton.frame.size.height;
	CGFloat titleButtonWidth=obj.titleButton.frame.size.width;
	CGFloat dateButtonHeight=obj.dateButton.frame.size.height;
	CGFloat dateButtonWidth=obj.dateButton.frame.size.width;
	CGFloat descriptionButtonHeight=obj.descriptionButton.frame.size.height;
	CGFloat descriptionButtonWidth=obj.descriptionButton.frame.size.width;
	CGFloat pictureButtonHeight=obj.pictureButton.frame.size.height;
	CGFloat pictureButtonWidth=obj.pictureButton.frame.size.width;
	CGFloat deleteButtonHeight=obj.deleteButton.frame.size.height;
	CGFloat deleteButtonWidth=obj.deleteButton.frame.size.width;
	
	if (iPhone) {
			obj.titleButton.frame = CGRectMake([self centerFrameWithView:myView andWidth:titleButtonWidth],
																				 SPACE,
																				 titleButtonWidth,
																				 titleButtonHeight);
	}else{
		obj.titleButton.frame = CGRectMake([self centerFrameWithView:myView andWidth:titleButtonWidth],
																			 80,
																			 titleButtonWidth,
																			 titleButtonHeight);
	}
	obj.descriptionButton.frame = CGRectMake([self centerFrameWithView:myView andWidth:descriptionButtonWidth],
																					 [self calculateYpositionWithPreviousView:obj.titleButton],
																					 descriptionButtonWidth,
																					 descriptionButtonHeight);
	obj.dateButton.frame = CGRectMake([self centerFrameWithView:myView andWidth:dateButtonWidth],
																		[self calculateYpositionWithPreviousView:obj.descriptionButton],
																		dateButtonWidth,
																		dateButtonHeight);
	obj.pictureButton.frame = CGRectMake([self centerFrameWithView:myView andWidth:pictureButtonWidth],
																			 [self calculateYpositionWithPreviousView:obj.dateButton],
																			 pictureButtonWidth,
																			 pictureButtonHeight);
	if (iPhone) {
		CGFloat pictureImageViewWidth = obj.pictureImageView.frame.size.width;
		CGFloat pictureImageViewHeight = obj.pictureImageView.frame.size.height;
		obj.pictureImageView.frame =  CGRectMake([self centerFrameWithView:myView andWidth:pictureImageViewWidth],
																						 [self calculateYpositionWithPreviousView:obj.pictureButton],
																						 pictureImageViewWidth,
																						 pictureImageViewHeight);
	}else{
		obj.pictureImageView.frame = [self calculateImageFrameWithView:myView andPictureButton:obj.pictureButton];
	}
	
	obj.deleteButton.frame = CGRectMake([self centerFrameWithView:myView andWidth:deleteButtonWidth],
																			[self calculateYpositionWithPreviousView:obj.pictureImageView],
																			deleteButtonWidth,
																			deleteButtonHeight);
	
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

-(CGFloat)centerFrameWithView:(UIView *)myView andWidth:(CGFloat)width{
	return myView.frame.size.width/2-width/2;
}

-(CGFloat)calculateYpositionWithPreviousView:(UIView *)myView{
	//origin in y plus height plus a margin of 8points
	return myView.frame.origin.y+myView.frame.size.height+SPACE;
}

@end
