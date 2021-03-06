//
//  FERDontRepeatViewController.m
//  DontRepeat
//
//  Created by Fernando Garcia Corrochano on 03/09/14.
//  Copyright (c) 2014 FernandoGarciaCorrochano. All rights reserved.
//

#import <MobileCoreServices/MobileCoreServices.h>
#import "FERDontRepeatViewController.h"
#import "FERFirebaseManager.h"
#import "FERFormatHelper.h"
#import "FERObjectsHelper.h"
#import "FERDontRepeatObjects.h"
#import "UIImage+Scale.h"
#import "UIButton+FERAnimations.h"
#import <FDTake/FDTakeController.h>

@interface FERDontRepeatViewController () <UIScrollViewDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate,FDTakeDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property	(nonatomic,strong)FERFirebaseManager *firebaseManager;
@property	(nonatomic,strong)FERFormatHelper *formatHelper;
@property	(nonatomic,strong)FERObjectsHelper *objectsHelper;
@property	(nonatomic,strong)FERDontRepeatObjects *dontRepeatObjects;
@property (nonatomic,strong)UIImagePickerController *imagePicker;
@property	(nonatomic,strong)FDTakeController *takeController;

@end

@implementation FERDontRepeatViewController{
	BOOL newPicture;
	BOOL isiPhone;
	BOOL portrait;
}

-(void)viewWillAppear:(BOOL)animated{
	self.dontRepeatObjects.titleButton.center = CGPointMake(self.view.frame.size.width/2, self.dontRepeatObjects.titleButton.frame.origin.y);
	self.dontRepeatObjects.descriptionButton.center = CGPointMake(self.view.frame.size.width/2, self.dontRepeatObjects.descriptionButton.frame.origin.y);
	self.dontRepeatObjects.dateButton.center = CGPointMake(self.view.frame.size.width/2, self.dontRepeatObjects.dateButton.frame.origin.y);
	self.dontRepeatObjects.pictureButton.center = CGPointMake(self.view.frame.size.width/2, self.dontRepeatObjects.pictureButton.frame.origin.y);
	self.dontRepeatObjects.titleTextField.center = CGPointMake(self.view.frame.size.width/2, self.dontRepeatObjects.titleTextField.frame.origin.y);
	self.dontRepeatObjects.descriptionTextView.center = CGPointMake(self.view.frame.size.width/2, self.dontRepeatObjects.descriptionTextView.frame.origin.y);
	self.dontRepeatObjects.datePicker.center = CGPointMake(self.view.frame.size.width/2, self.dontRepeatObjects.datePicker.frame.origin.y);
	if (!isiPhone) {
		self.dontRepeatObjects.pictureImageView.frame=[self.objectsHelper calculateImageFrameWithView:self.view andPictureButton:self.dontRepeatObjects.pictureButton];
	}
	self.dontRepeatObjects.deleteButton.center = CGPointMake(self.view.frame.size.width/2, self.dontRepeatObjects.deleteButton.frame.origin.y+self.dontRepeatObjects.deleteButton.frame.size.height/2);
}

-(void)viewDidLayoutSubviews {
	[super viewDidLayoutSubviews];
	self.scrollView.frame = CGRectMake(self.view.frame.origin.x,
																		 self.view.frame.origin.y,
																		 self.view.frame.size.width,
																		 self.view.frame.size.height);
	self.scrollView.contentInset = UIEdgeInsetsMake(75, 0, 300, 0);
	self.scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(64, 0, 0, 0);
	self.scrollView.contentSize = self.scrollView.frame.size;
}

- (void)viewDidLoad{
	[super viewDidLoad];
	self.scrollView.delegate=self;
	self.takeController.delegate=self;
	newPicture=NO;
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
		isiPhone=NO;
		self.dontRepeatObjects.deleteButton.hidden=YES;
	}else{
		isiPhone=YES;
	}
	[self addTargets];
	[self addSubviewsForDevice:isiPhone];
	[self configure];
	[self loadData];
	
}

-(void)addTargets{
	[self.dontRepeatObjects.titleButton addTarget:self action:@selector(titlePressed:) forControlEvents:UIControlEventTouchUpInside];
	
	[self.dontRepeatObjects.descriptionButton addTarget:self action:@selector(descriptionPressed:) forControlEvents:UIControlEventTouchUpInside];
	
	[self.dontRepeatObjects.dateButton addTarget:self action:@selector(datePressed:) forControlEvents:UIControlEventTouchUpInside];
	
	[self.dontRepeatObjects.pictureButton addTarget:self action:@selector(picturePressed:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)addSubviewsForDevice:(BOOL)iPhone{
	UIView *myView=self.view;
	if (iPhone) {
		myView=self.scrollView;
	}
	[myView addSubview:self.dontRepeatObjects.titleButton];
	[myView addSubview:self.dontRepeatObjects.titleTextField];
	[myView addSubview:self.dontRepeatObjects.descriptionButton];
	[myView addSubview:self.dontRepeatObjects.descriptionTextView];
	[myView addSubview:self.dontRepeatObjects.dateButton];
	[myView addSubview:self.dontRepeatObjects.datePicker];
	[myView addSubview:self.dontRepeatObjects.pictureButton];
	[myView addSubview:self.dontRepeatObjects.pictureImageView];
	[myView addSubview:self.dontRepeatObjects.deleteButton];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
	portrait = UIInterfaceOrientationIsPortrait(toInterfaceOrientation);
	
	if (portrait) {
		NSLog(@"PORTRAIT self.view.frame: %@",NSStringFromCGRect(self.view.frame));
		[self.objectsHelper originalPosition:self.dontRepeatObjects foriPhone:isiPhone forView:self.view];
	}else{
		NSLog(@"LANDSCAPE self.view.frame: %@",NSStringFromCGRect(self.view.frame));
		[self.objectsHelper originalPosition:self.dontRepeatObjects foriPhone:isiPhone forView:self.view];
	}
	
}

-(FERFirebaseManager *)firebaseManager{
	if(_firebaseManager==nil){
		_firebaseManager=[[FERFirebaseManager alloc]init];
	}
	return _firebaseManager;
}

-(FERFormatHelper *)formatHelper{
	if (_formatHelper==nil) {
		_formatHelper=[[FERFormatHelper alloc]init];
	}
	return _formatHelper;
}

-(FERObjectsHelper	*)objectsHelper{
	if (_objectsHelper==nil) {
		_objectsHelper=[[FERObjectsHelper alloc]init];
	}
	return _objectsHelper;
}

-(FERDontRepeatObjects *)dontRepeatObjects{
	if(_dontRepeatObjects==nil){
		_dontRepeatObjects=[[FERDontRepeatObjects alloc]init];
	}
	return _dontRepeatObjects;
}

-(UIImagePickerController *)imagePicker{
	if (_imagePicker==nil) {
		_imagePicker=[[UIImagePickerController alloc]init];
	}
	return _imagePicker;
}

-(FDTakeController *)takeController{
	if (_takeController==nil) {
		_takeController=[[FDTakeController alloc]init];
	}
	return _takeController;
}

-(void)loadData{
	if (_dontRepeat==nil) {
		_dontRepeat=[[DontRepeat alloc]init];
		self.saveButton.enabled=YES;
		self.dontRepeatObjects.deleteButton.hidden=YES;
	}else{
		self.dontRepeatObjects.titleTextField.text=self.dontRepeat.dontRepeatTitle;
		self.dontRepeatObjects.datePicker.date=[self.formatHelper returnDateFromString:self.dontRepeat.dontRepeatDate];
		self.dontRepeatObjects.descriptionTextView.text=self.dontRepeat.dontRepeatDesc;
		
		NSString *dataString =self.dontRepeat.dontRepeatPicture;
		//This is to compare in case of update for not to compress twice
		NSData *stringData = [[NSData alloc]initWithBase64EncodedString:dataString
																														options:NSDataBase64DecodingIgnoreUnknownCharacters];
		self.dontRepeatObjects.pictureImageView.image=[UIImage imageWithData:stringData];
		
		[self enableControls];
	}
}

-(void)enableControls{
	self.saveButton.title=@"Update";
	self.deleteButton.hidden=NO;
}

-(void)configure{
	self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundOrange"]];
	[self.objectsHelper originalPosition:self.dontRepeatObjects foriPhone:isiPhone forView:self.view];
}


-(BOOL)checkFields{
	if ([self.dontRepeatObjects.titleTextField.text isEqualToString:@""]) {
		[self.dontRepeatObjects.titleButton shakeAnimate];
		[UIView animateWithDuration:0.6 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
			[self.dontRepeatObjects.titleButton setBackgroundColor:[UIColor colorWithRed:1.000 green:0.000 blue:0.000 alpha:0.19]];
			[self.dontRepeatObjects.titleButton setBackgroundColor:[UIColor clearColor]];
		} completion:^(BOOL finished) {
		}];
		
		return NO;
	}
	if ([self.dontRepeatObjects.descriptionTextView.text isEqualToString:@""]) {
		if (self.dontRepeatObjects.pictureImageView.image==nil) {
			[self.dontRepeatObjects.descriptionButton shakeAnimate];
			[self.dontRepeatObjects.pictureButton shakeAnimate];
			[UIView animateWithDuration:0.6 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
				[self.dontRepeatObjects.descriptionButton setBackgroundColor:[UIColor colorWithRed:1.000 green:0.000 blue:0.000 alpha:0.19]];
				[self.dontRepeatObjects.pictureButton setBackgroundColor:[UIColor colorWithRed:1.000 green:0.000 blue:0.000 alpha:0.19]];
				[self.dontRepeatObjects.descriptionButton setBackgroundColor:[UIColor clearColor]];
				[self.dontRepeatObjects.pictureButton setBackgroundColor:[UIColor clearColor]];
			} completion:^(BOOL finished) {
			}];
			return NO;
		}
	}
	return YES;
}

- (IBAction)savePressed:(id)sender {
	[self.dontRepeatObjects.titleTextField resignFirstResponder];
	[self.dontRepeatObjects.descriptionTextView resignFirstResponder];
	if([self checkFields]){
		DontRepeat *dontRepeat=[[DontRepeat alloc]init];
		dontRepeat.dontRepeatTitle= self.dontRepeatObjects.titleTextField.text;
		dontRepeat.dontRepeatDate = [self.formatHelper returnStringFromDate:self.dontRepeatObjects.datePicker.date];
		dontRepeat.dontRepeatDesc = self.dontRepeatObjects.descriptionTextView.text;
		dontRepeat.dontRepeatDeleted=@"NO";
		NSString *ID=[NSString stringWithFormat:@"%@%@",dontRepeat.dontRepeatTitle,dontRepeat.dontRepeatDate];
		dontRepeat.dontRepeatID =[self.formatHelper removeSpacesAndSlashes:ID];
		if (newPicture) {
			UIImage *compressedImage=[self.dontRepeatObjects.pictureImageView.image imageScaledToHalf];
			
			NSData *imageData = UIImageJPEGRepresentation(compressedImage,0.4);
			NSString *dataString = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
			dontRepeat.dontRepeatPicture = dataString;
		}else{
			dontRepeat.dontRepeatPicture=self.dontRepeat.dontRepeatPicture;
		}
		
		if ([self.saveButton.title isEqualToString:@"Save"]) {
			[self.delegate addDontRepeat:dontRepeat];
			[self.navigationController popViewControllerAnimated:YES];
		}else if ([self.saveButton.title isEqualToString:@"Update"]){
			[self.delegate updateDontRepeat:self.dontRepeat with:dontRepeat];
			[self.navigationController popViewControllerAnimated:YES];
		}
	}
}



- (IBAction)titlePressed:(id)sender {
	if (self.dontRepeatObjects.titleTextField.hidden) {
		[self.objectsHelper titlePressed:self.dontRepeatObjects foriPhone:isiPhone forView:self.view];
	}else{
		[self.view endEditing:YES];
		[self.objectsHelper originalPosition:self.dontRepeatObjects foriPhone:isiPhone forView:self.view];
	}
}

- (IBAction)datePressed:(id)sender {
	[self.view endEditing:YES];
	if (self.dontRepeatObjects.datePicker.hidden) {
		[self.objectsHelper datePressed:self.dontRepeatObjects foriPhone:isiPhone forView:self.view];
	}else{
		[self.objectsHelper originalPosition:self.dontRepeatObjects foriPhone:isiPhone forView:self.view];
	}
}

- (IBAction)descriptionPressed:(id)sender {
	if (self.dontRepeatObjects.descriptionTextView.hidden) {
		[self.objectsHelper descriptionPressed:self.dontRepeatObjects foriPhone:isiPhone forView:self.view];
	}else{
		[self.view endEditing:YES];
		[self.objectsHelper originalPosition:self.dontRepeatObjects foriPhone:isiPhone forView:self.view];
	}
}

- (IBAction)picturePressed:(id)sender {
	[self.view endEditing:YES];
	[self.objectsHelper picturePressed:self.dontRepeatObjects foriPhone:isiPhone forView:self.view];
	[self.takeController takePhotoOrChooseFromLibrary];
}

-(void)takeController:(FDTakeController *)controller
						 gotPhoto:(UIImage *)photo
						 withInfo:(NSDictionary *)info{
	self.dontRepeatObjects.pictureImageView.backgroundColor =[[UIColor whiteColor]colorWithAlphaComponent:0.65f];
	[self.dontRepeatObjects.pictureImageView setImage:photo];
	[self.dontRepeatObjects.pictureArray addObject:self.dontRepeatObjects.pictureImageView];
	newPicture=YES;
}

- (IBAction)deletePressed:(id)sender {
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Delete Don't Repeat"
																									message:@"Are you sure to want to delete?"
																								 delegate:self
																				cancelButtonTitle:@"No"
																				otherButtonTitles:@"Yes",nil];
	[alert show];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
	if (buttonIndex == 1) {
		DontRepeat *dont=[[DontRepeat alloc]init];
		dont.dontRepeatDesc=self.dontRepeat.dontRepeatDesc;
		dont.dontRepeatTitle=self.dontRepeat.dontRepeatTitle;
		dont.dontRepeatDate=self.dontRepeat.dontRepeatDate;
		dont.dontRepeatPicture=@"";
		dont.dontRepeatID=self.dontRepeat.dontRepeatID;
		dont.dontRepeatDeleted=@"YES";
		[self.delegate updateDontRepeat:self.dontRepeat with:dont];
		[self.navigationController popViewControllerAnimated:YES];
	}
}


@end
