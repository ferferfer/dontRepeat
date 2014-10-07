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
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		// Custom initialization
	}
	return self;
}

- (void)viewDidLoad{
	[super viewDidLoad];
	self.scrollView.delegate=self;
	self.takeController.delegate=self;
	newPicture=NO;
	UIBarButtonItem *barButtonItemAtras = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil];
	[self.navigationItem setBackBarButtonItem:barButtonItemAtras];
	[self configure];
	[self loadData];
	
	
	// Do any additional setup after loading the view.
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
	}else{
		self.titleTextField.text=self.dontRepeat.dontRepeatTitle;
		self.datePicker.date=[self.formatHelper returnDateFromString:self.dontRepeat.dontRepeatDate];
		self.descriptionTextView.text=self.dontRepeat.dontRepeatDesc;
		
		NSString *dataString =self.dontRepeat.dontRepeatPicture;
		//This is to compare in case of update for not to compress twice
		NSData *stringData = [[NSData alloc]initWithBase64EncodedString:dataString
																														options:NSDataBase64DecodingIgnoreUnknownCharacters];
		self.pictureImageView.image=[UIImage imageWithData:stringData];
		
		[self disableControls];
	}
}

-(void)disableControls{
	self.saveButton.title=@"Update";
	self.deleteButton.hidden=NO;
}

-(void)configure{
	self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundOrange"]];
	
	self.scrollView.frame = self.view.frame;
	self.scrollView.contentSize = self.scrollView.frame.size;
	[self.view addSubview:self.scrollView];
	
	self.dontRepeatObjects.titleButton= self.titleButton;
	self.dontRepeatObjects.titleTextField= self.titleTextField;
	self.dontRepeatObjects.dateButton= self.dateButton;
	self.dontRepeatObjects.datePicker= self.datePicker;
	self.dontRepeatObjects.descriptionButton=	self.descriptionButton;
	self.dontRepeatObjects.descriptionTextView=	self.descriptionTextView;
	self.dontRepeatObjects.pictureButton=	self.pictureButton;
	self.dontRepeatObjects.pictureImageView=	self.pictureImageView;
	
	[self.objectsHelper originalPosition:self.dontRepeatObjects];
	[self.objectsHelper hideFields:self.dontRepeatObjects];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
	[self.objectsHelper hideFields:self.dontRepeatObjects];
}

-(BOOL)checkFields{
	if ([self.titleTextField.text isEqualToString:@""]) {
		[self.titleButton shakeAnimate];
		[UIView animateWithDuration:0.6 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
			[self.titleButton setBackgroundColor:[UIColor colorWithRed:1.000 green:0.000 blue:0.000 alpha:0.19]];
			[self.titleButton setBackgroundColor:[UIColor clearColor]];
		} completion:^(BOOL finished) {
		}];
		
		return NO;
	}
	if ([self.descriptionTextView.text isEqualToString:@""]) {
		if (self.pictureImageView.image==nil) {
			[self.descriptionButton shakeAnimate];
			[self.pictureButton shakeAnimate];
			[UIView animateWithDuration:0.6 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
				[self.descriptionButton setBackgroundColor:[UIColor colorWithRed:1.000 green:0.000 blue:0.000 alpha:0.19]];
				[self.pictureButton setBackgroundColor:[UIColor colorWithRed:1.000 green:0.000 blue:0.000 alpha:0.19]];
				[self.descriptionButton setBackgroundColor:[UIColor clearColor]];
				[self.pictureButton setBackgroundColor:[UIColor clearColor]];
			} completion:^(BOOL finished) {
			}];
			return NO;
		}
	}
	return YES;
}

- (IBAction)savePressed:(id)sender {
	[self.titleTextField resignFirstResponder];
	[self.descriptionTextView resignFirstResponder];
	if([self checkFields]){
		DontRepeat *dontRepeat=[[DontRepeat alloc]init];
		dontRepeat.dontRepeatTitle= self.titleTextField.text;
		dontRepeat.dontRepeatDate = [self.formatHelper returnStringFromDate:self.datePicker.date];
		dontRepeat.dontRepeatDesc = self.descriptionTextView.text;
		NSString *ID=[NSString stringWithFormat:@"%@%@",dontRepeat.dontRepeatTitle,dontRepeat.dontRepeatDate];
		dontRepeat.dontRepeatID =[self.formatHelper removeSpacesAndSlashes:ID];
		
		if (newPicture) {
			UIImage *compressedImage=[self.pictureImageView.image imageScaledToQuarter];
			
			NSData *imageData = UIImageJPEGRepresentation(compressedImage,0.1);
			NSString *dataString = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
			dontRepeat.dontRepeatPicture = dataString;
		}else{
			dontRepeat.dontRepeatPicture=self.dontRepeat.dontRepeatPicture;
		}
		
		if ([self.saveButton.title isEqualToString:@"Save"]) {
			[self.delegate addDontRepeat:dontRepeat];
			[self.navigationController popViewControllerAnimated:YES];
		}else if ([self.saveButton.title isEqualToString:@"Update"]){
			[self.delegate updateDontRepeat:dontRepeat with:self.dontRepeat];
			[self.navigationController popViewControllerAnimated:YES];
		}
	}
}



- (IBAction)titlePressed:(id)sender {
	if (self.titleTextField.hidden) {
		[self.objectsHelper titlePressed:self.dontRepeatObjects];
	}else{
		[self.objectsHelper originalPosition:self.dontRepeatObjects];
	}
}

- (IBAction)datePressed:(id)sender {
	if (self.datePicker.hidden) {
		[self.objectsHelper datePressed:self.dontRepeatObjects];
	}else{
		[self.objectsHelper originalPosition:self.dontRepeatObjects];
	}
}

- (IBAction)descriptionPressed:(id)sender {
	if (self.descriptionTextView.hidden) {
		[self.objectsHelper descriptionPressed:self.dontRepeatObjects];
	}else{
		[self.objectsHelper originalPosition:self.dontRepeatObjects];
	}
}

- (IBAction)picturePressed:(id)sender {
	[self.objectsHelper picturePressed:self.dontRepeatObjects];
	[self.takeController takePhotoOrChooseFromLibrary];
}

-(void)takeController:(FDTakeController *)controller
						 gotPhoto:(UIImage *)photo
						 withInfo:(NSDictionary *)info{
	self.pictureImageView.backgroundColor =[[UIColor whiteColor]colorWithAlphaComponent:0.65f];
	[self.pictureImageView setImage:photo];
	newPicture=YES;
}

- (IBAction)deletePressed:(id)sender {
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Delete Don't Repeat"
																									message:@"Are you sure to want to delete?"
																								 delegate:self
																				cancelButtonTitle:@"No"
																				otherButtonTitles:@"Of course",nil];
	[alert show];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
	if (buttonIndex == 1) {
		[self.delegate removeDontRepeat:self.dontRepeat];
		[self.navigationController popViewControllerAnimated:YES];
	}
}

@end
