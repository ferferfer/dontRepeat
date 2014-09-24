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
	
	CGRect rectTitButton = obj.titleButton.frame;
	CGRect rectTit = obj.titleTextField.frame;
	CGRect rectDate = obj.dateButton.frame;
	CGRect rectDesc = obj.descriptionButton.frame;
	CGRect rectPic = obj.pictureButton.frame;
	CGRect rectImg = obj.pictureImageView.frame;
	
	rectTitButton.origin = CGPointMake(8, 0);
	rectTit.origin = CGPointMake(8, 58);
	rectDate.origin = CGPointMake(8, 96);
	rectDesc.origin = CGPointMake(8, 154);
	rectPic.origin = CGPointMake(8, 212);
	rectImg.origin = CGPointMake(8, 270);
	
	obj.titleButton.frame=rectTitButton;
	obj.titleTextField.frame=rectTit;
	obj.dateButton.frame = rectDate;
	obj.descriptionButton.frame = rectDesc;
	obj.pictureButton.frame = rectPic;
	obj.pictureImageView.frame = rectImg;
	
	obj.titleTextField.hidden=NO;
	obj.datePicker.hidden=YES;
	obj.descriptionTextView.hidden=YES;
	obj.pictureImageView.hidden=NO;
	
}
- (void)datePressed:(FERDontRepeatObjects *)obj {

	CGRect rectTitButton = obj.titleButton.frame;
	CGRect rectDate = obj.dateButton.frame;
	CGRect rectDatePicker = obj.datePicker.frame;
	CGRect rectDesc = obj.descriptionButton.frame;
	CGRect rectPic = obj.pictureButton.frame;
	CGRect rectImg = obj.pictureImageView.frame;
	
	rectTitButton.origin = CGPointMake(8, 0);
	rectDate.origin = CGPointMake(8,58);
	rectDatePicker.origin = CGPointMake(8,116);
	rectDesc.origin = CGPointMake(8,286);
	rectPic.origin = CGPointMake(8,344);
	rectImg.origin = CGPointMake(8,402);

	obj.titleButton.frame=rectTitButton;
	obj.dateButton.frame = rectDate;
	obj.datePicker.frame = rectDatePicker;
	obj.descriptionButton.frame = rectDesc;
	obj.pictureButton.frame = rectPic;
	obj.pictureImageView.frame = rectImg;
	
	obj.titleTextField.hidden=YES;
	obj.datePicker.hidden=NO;
	obj.descriptionTextView.hidden=YES;
	obj.pictureImageView.hidden=NO;
}
- (void)descriptionPressed:(FERDontRepeatObjects *)obj {
	
	CGRect rectTitButton = obj.titleButton.frame;
	CGRect rectDate = obj.dateButton.frame;
	CGRect rectDescText = obj.descriptionTextView.frame;
	CGRect rectDesc = obj.descriptionButton.frame;
	CGRect rectPic = obj.pictureButton.frame;
	CGRect rectImg = obj.pictureImageView.frame;
	
	rectTitButton.origin = CGPointMake(8, 0);
	rectDate.origin = CGPointMake(8,58);
	rectDesc.origin = CGPointMake(8,116);
	rectDescText.origin = CGPointMake(8, 174);
	rectPic.origin = CGPointMake(8,295);
	rectImg.origin = CGPointMake(8,353);

	obj.titleButton.frame=rectTitButton;
	obj.dateButton.frame = rectDate;
	obj.descriptionTextView.frame = rectDescText;
	obj.descriptionButton.frame = rectDesc;
	obj.pictureButton.frame = rectPic;
	obj.pictureImageView.frame = rectImg;
	
	obj.titleTextField.hidden=YES;
	obj.datePicker.hidden=YES;
	obj.descriptionTextView.hidden=NO;
	obj.pictureImageView.hidden=NO;
	
}
- (void)picturePressed:(FERDontRepeatObjects *)obj {
	
	CGRect rectTitButton = obj.titleButton.frame;
	CGRect rectDate = obj.dateButton.frame;
	CGRect rectDesc = obj.descriptionButton.frame;
	CGRect rectPic = obj.pictureButton.frame;
	CGRect rectPicView = obj.pictureImageView.frame;
	
	rectTitButton.origin = CGPointMake(8, 0);
	rectDate.origin = CGPointMake(8,58);
	rectDesc.origin = CGPointMake(8,116);
	rectPic.origin = CGPointMake(8,174);
	rectPicView.origin = CGPointMake(8, 232);
	
	obj.titleButton.frame=rectTitButton;
	obj.dateButton.frame = rectDate;
	obj.descriptionButton.frame = rectDesc;
	obj.pictureButton.frame = rectPic;
	obj.pictureImageView.frame = rectPicView;
	
	obj.titleTextField.hidden=YES;
	obj.datePicker.hidden=YES;
	obj.descriptionTextView.hidden=YES;
	obj.pictureImageView.hidden=NO;
	
}

-(void)originalPosition:(FERDontRepeatObjects *)obj{

	CGRect rectTitButton = obj.titleButton.frame;
	CGRect rectDate = obj.dateButton.frame;
	CGRect rectDesc = obj.descriptionButton.frame;
	CGRect rectPic = obj.pictureButton.frame;
	CGRect rectImage =obj.pictureImageView.frame;
	
	rectTitButton.origin = CGPointMake(8, 0);
	rectDate.origin = CGPointMake(8,58);
	rectDesc.origin = CGPointMake(8,116);
	rectPic.origin = CGPointMake(8,174);
	rectImage.origin = CGPointMake(8, 232);
	
	obj.titleButton.frame=rectTitButton;
	obj.dateButton.frame = rectDate;
	obj.descriptionButton.frame = rectDesc;
	obj.pictureButton.frame = rectPic;
	obj.pictureImageView.frame=rectImage;
	
	obj.titleTextField.hidden=YES;
	obj.datePicker.hidden=YES;
	obj.descriptionTextView.hidden=YES;
	obj.pictureImageView.hidden=NO;
	
}

-(void)hideFields:(FERDontRepeatObjects *)obj{
	obj.titleTextField.hidden=YES;
	obj.datePicker.hidden=YES;
	obj.descriptionTextView.hidden=YES;
	obj.pictureImageView.hidden=NO;
	
}


@end
