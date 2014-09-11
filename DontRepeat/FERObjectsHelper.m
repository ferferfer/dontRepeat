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
	CGRect rectTit = obj.titleTextField.frame;
	CGRect rectDate = obj.dateButton.frame;
	CGRect rectDesc = obj.descriptionButton.frame;
	CGRect rectPic = obj.pictureButton.frame;
	
	rectTit.origin = CGPointMake(8, 123);
	rectDate.origin = CGPointMake(8, 161);
	rectDesc.origin = CGPointMake(8, 219);
	rectPic.origin = CGPointMake(8, 277);
	
	obj.titleTextField.frame=rectTit;
	obj.dateButton.frame = rectDate;
	obj.descriptionButton.frame = rectDesc;
	obj.pictureButton.frame = rectPic;
	
	obj.titleTextField.hidden=NO;
	obj.datePicker.hidden=YES;
	obj.descriptionTextView.hidden=YES;
	obj.pictureImageView.hidden=[self hidePictureIfIsNull:obj];
	
}
- (void)datePressed:(FERDontRepeatObjects *)obj {
	
	CGRect rectDate = obj.dateButton.frame;
	CGRect rectDatePicker = obj.datePicker.frame;
	CGRect rectDesc = obj.descriptionButton.frame;
	CGRect rectPic = obj.pictureButton.frame;
	
	rectDate.origin = CGPointMake(8,123);
	rectDatePicker.origin = CGPointMake(8,181);
	rectDesc.origin = CGPointMake(8,351);
	rectPic.origin = CGPointMake(8,409);
	
	
	obj.dateButton.frame = rectDate;
	obj.datePicker.frame = rectDatePicker;
	obj.descriptionButton.frame = rectDesc;
	obj.pictureButton.frame = rectPic;
	
	obj.titleTextField.hidden=YES;
	obj.datePicker.hidden=NO;
	obj.descriptionTextView.hidden=YES;
	obj.pictureImageView.hidden=[self hidePictureIfIsNull:obj];
}
- (void)descriptionPressed:(FERDontRepeatObjects *)obj {
	
	CGRect rectDate = obj.dateButton.frame;
	CGRect rectDescText = obj.descriptionTextView.frame;
	CGRect rectDesc = obj.descriptionButton.frame;
	CGRect rectPic = obj.pictureButton.frame;
	
	rectDate.origin = CGPointMake(8,123);
	rectDesc.origin = CGPointMake(8,181);
	rectDescText.origin = CGPointMake(8, 239);
	rectPic.origin = CGPointMake(8,360);
	
	obj.dateButton.frame = rectDate;
	obj.descriptionTextView.frame = rectDescText;
	obj.descriptionButton.frame = rectDesc;
	obj.pictureButton.frame = rectPic;
	
	obj.titleTextField.hidden=YES;
	obj.datePicker.hidden=YES;
	obj.descriptionTextView.hidden=NO;
	obj.pictureImageView.hidden=[self hidePictureIfIsNull:obj];
	
}
- (void)picturePressed:(FERDontRepeatObjects *)obj {
	
	CGRect rectDate = obj.dateButton.frame;
	CGRect rectDesc = obj.descriptionButton.frame;
	CGRect rectPic = obj.pictureButton.frame;
	CGRect rectPicView = obj.pictureImageView.frame;
	
	rectDate.origin = CGPointMake(8,123);
	rectDesc.origin = CGPointMake(8,181);
	rectPic.origin = CGPointMake(8,239);
	rectPicView.origin = CGPointMake(8, 297);
	
	obj.dateButton.frame = rectDate;
	obj.descriptionButton.frame = rectDesc;
	obj.pictureButton.frame = rectPic;
	obj.pictureImageView.frame = rectPicView;
	
	obj.titleTextField.hidden=YES;
	obj.datePicker.hidden=YES;
	obj.descriptionTextView.hidden=YES;
	obj.pictureImageView.hidden=[self hidePictureIfIsNull:obj];
	
}

-(void)originalPosition:(FERDontRepeatObjects *)obj{
	
	CGRect rectDate = obj.dateButton.frame;
	CGRect rectDesc = obj.descriptionButton.frame;
	CGRect rectPic = obj.pictureButton.frame;
	
	rectDate.origin = CGPointMake(8,123);
	rectDesc.origin = CGPointMake(8,181);
	rectPic.origin = CGPointMake(8,239);
	
	obj.dateButton.frame = rectDate;
	obj.descriptionButton.frame = rectDesc;
	obj.pictureButton.frame = rectPic;
	
	obj.titleTextField.hidden=YES;
	obj.datePicker.hidden=YES;
	obj.descriptionTextView.hidden=YES;
	obj.pictureImageView.hidden=[self hidePictureIfIsNull:obj];
	
}

-(void)hideFields:(FERDontRepeatObjects *)obj{
	obj.titleTextField.hidden=YES;
	obj.datePicker.hidden=YES;
	obj.descriptionTextView.hidden=YES;
	obj.pictureImageView.hidden=[self hidePictureIfIsNull:obj];
	
}

-(BOOL)hidePictureIfIsNull:(FERDontRepeatObjects *)obj{
	CIImage *cim = [obj.pictureImageView.image CIImage];
	if (cim == nil ) {
		return YES;
	}
	return NO;
}


@end
