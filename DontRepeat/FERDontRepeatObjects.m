//
//  FERDontRepeatObjects.m
//  DontRepeat
//
//  Created by Fernando Garcia Corrochano on 09/09/14.
//  Copyright (c) 2014 FernandoGarciaCorrochano. All rights reserved.
//

#import "FERDontRepeatObjects.h"
#import "UIColor+FERcolors.h"

@implementation FERDontRepeatObjects

- (instancetype)init{
	self = [super init];
	if (self) {
		_titleButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 304, 40)];
		[_titleButton setTitleColor:[UIColor appDefaultBlueColor] forState:UIControlStateNormal];
		[_titleButton setTitle:@"Title" forState:UIControlStateNormal];
		_titleButton.titleLabel.font=[UIFont fontWithName:@"Helvetica Neue" size:29.0];

		_descriptionButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 304, 40)];
		[_descriptionButton setTitleColor:[UIColor appDefaultBlueColor] forState:UIControlStateNormal];
		[_descriptionButton setTitle:@"Description" forState:UIControlStateNormal];
		_descriptionButton.titleLabel.font=[UIFont fontWithName:@"Helvetica Neue" size:29.0];
		
		_dateButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 304, 40)];
		[_dateButton setTitleColor:[UIColor appDefaultBlueColor] forState:UIControlStateNormal];
		[_dateButton setTitle:@"Date" forState:UIControlStateNormal];
		_dateButton.titleLabel.font=[UIFont fontWithName:@"Helvetica Neue" size:29.0];
		
		_pictureButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 304, 40)];
		[_pictureButton setTitleColor:[UIColor appDefaultBlueColor] forState:UIControlStateNormal];
		[_pictureButton setTitle:@"Add Picture" forState:UIControlStateNormal];
		_pictureButton.titleLabel.font=[UIFont fontWithName:@"Helvetica Neue" size:29.0];
		
		_titleTextField=[[UITextField alloc]initWithFrame:CGRectMake(8, 0, 304, 20)];
		[_titleTextField setBorderStyle:UITextBorderStyleLine];

		
		_descriptionTextView=[[UITextView alloc]initWithFrame:CGRectMake(8, 0, 304, 121)];
		[_descriptionTextView setBackgroundColor:[UIColor clearColor]];

		
		_datePicker=[[UIDatePicker alloc]initWithFrame:CGRectMake(8, 0, 304, 162)];
		_datePicker.datePickerMode=UIDatePickerModeDate;

		_pictureImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 304, 408)];
		[_pictureImageView setContentMode:UIViewContentModeScaleAspectFit];

		_deleteButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 304, 50)];
		[_deleteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		[_deleteButton setBackgroundColor:[UIColor appRedColor]];
		[_deleteButton setTitle:@"Delete" forState:UIControlStateNormal];
		_deleteButton.titleLabel.font=[UIFont fontWithName:@"Helvetica Neue" size:29.0];
		
	}
	return self;
}

@end
