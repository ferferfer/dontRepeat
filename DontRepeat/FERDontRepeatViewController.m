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

@interface FERDontRepeatViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property	(nonatomic,strong)FERFirebaseManager *firebaseManager;
@property	(nonatomic,strong)FERFormatHelper *formatHelper;
@property	(nonatomic,strong)FERObjectsHelper *objectsHelper;
@property	(nonatomic,strong)FERDontRepeatObjects *dontRepeatObjects;

@end

@implementation FERDontRepeatViewController

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
	[self loadData];
	[self configure];
	
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

-(void)loadData{
	if (_dontRepeat==nil) {
		_dontRepeat=[[DontRepeat alloc]init];
		self.saveButton.enabled=YES;
	}else{
		self.titleTextField.text=self.dontRepeat.dontRepeatTitle;
		self.datePicker.date=[self.formatHelper returnDateFromString:self.dontRepeat.dontRepeatDate];
		self.descriptionTextView.text=self.dontRepeat.dontRepeatDesc;
		
		NSString *dataString =self.dontRepeat.dontRepeatPicture;
		NSData *stringData = [dataString dataUsingEncoding:NSUTF8StringEncoding];
		self.pictureImageView.image=[UIImage imageWithData:stringData];
		
		self.saveButton.enabled=NO;
	}
}

-(void)configure{
	self.scrollView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
	self.scrollView.contentSize = self.scrollView.frame.size;
	self.scrollView.frame = self.view.frame;
	[self.view addSubview:self.scrollView];
	
	
	//	self.dontRepeatObjects.titleButton= self.titleButton;
	self.dontRepeatObjects.titleTextField= self.titleTextField;
	self.dontRepeatObjects.dateButton= self.dateButton;
	self.dontRepeatObjects.datePicker= self.datePicker;
	self.dontRepeatObjects.descriptionButton=	self.descriptionButton;
	self.dontRepeatObjects.descriptionTextView=	self.descriptionTextView;
	self.dontRepeatObjects.pictureButton=	self.pictureButton;
	self.dontRepeatObjects.pictureImageView=	self.pictureImageView;
	
	[self.objectsHelper hideFields:self.dontRepeatObjects];
}



- (IBAction)savePressed:(id)sender {
	
	DontRepeat *dontRepeat=[[DontRepeat alloc]init];
	dontRepeat.dontRepeatTitle= self.titleTextField.text;
	dontRepeat.dontRepeatDate = [self.formatHelper returnStringFromDate:self.datePicker.date];
	dontRepeat.dontRepeatDesc = self.descriptionTextView.text;
	
	NSData *imageData = UIImageJPEGRepresentation(self.pictureImageView.image,0);
	NSString *dataString = [imageData base64EncodedStringWithOptions:0];
	dontRepeat.dontRepeatPicture = dataString;
	
	[self.delegate addDontRepeat:dontRepeat forUser:self.user];
	[self.navigationController popViewControllerAnimated:YES];
	
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
	
	if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
		UIImagePickerController *imagePicker =[[UIImagePickerController alloc] init];
		imagePicker.delegate = self;
		imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
		imagePicker.mediaTypes = @[(NSString *) kUTTypeImage];
		imagePicker.allowsEditing = NO;
		[self presentViewController:imagePicker animated:YES completion:nil];
	}
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
	
	NSString *mediaType = info[UIImagePickerControllerMediaType];
	[self dismissViewControllerAnimated:YES completion:nil];
	
	if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
		UIImage *image = info[UIImagePickerControllerOriginalImage];
		
		self.pictureImageView.image= image;
	}
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
