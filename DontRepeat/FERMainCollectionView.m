//
//  FERMainCollectionView.m
//  DontRepeat
//
//  Created by Fernando Garcia Corrochano on 20/08/14.
//  Copyright (c) 2014 FernandoGarciaCorrochano. All rights reserved.
//

#import "FERMainCollectionView.h"
#import "FERDontRepeatCell.h"
#import "DontRepeat.h"
#import "FERDontRepeatViewController.h"
#import "FERFirebaseManager.h"
#import "FERPlistManager.h"
#import "FERFormatHelper.h"
#import "FERImageDownloader.h"
#import "FERMomentLayout.h"
#import "FERDaysLayout.h"

@interface FERMainCollectionView () <UICollectionViewDataSource, UICollectionViewDelegate,FERDontRepeatViewControllerDelegate,UIGestureRecognizerDelegate>

@property (nonatomic,strong)UICollectionView *collectionViewProperty;
@property	(nonatomic,strong)FERMomentLayout *momentLayout;
@property	(nonatomic,strong)FERDaysLayout *daysLayout;
@property (nonatomic,strong)NSMutableSet *selectedCells;
@property	 (nonatomic, strong)FERFirebaseManager *firebaseManager;
@property	 (nonatomic, strong)FERPlistManager *plistManager;
@property	 (nonatomic, strong)FERFormatHelper	*formatHelper;
@property (nonatomic,strong)	NSMutableArray *dontRepeats;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addButton;
@property	(nonatomic,strong)FERImageDownloader *imageDownloader;

@end

@implementation FERMainCollectionView {
	DontRepeat* dontRepeatSeleccionado;
}


-(void)viewDidAppear:(BOOL)animated{
	self.navigationController.navigationBarHidden=NO;
	[self comparePlistVsFireBase];
	[self loadPlistDontRepeats];
}

- (void)viewDidLoad{
	[super viewDidLoad];
	
	[self loadMomentLayout];
	[self loadDaysLayout];
	[self initializeCollectionView];
	
}

-(FERFirebaseManager *)firebaseManager{
	if (_firebaseManager==nil) {
		_firebaseManager=[[FERFirebaseManager alloc]init];
	}
	return _firebaseManager;
}

-(FERPlistManager *)plistManager{
	if (_plistManager==nil) {
		_plistManager=[[FERPlistManager alloc]init];
	}
	return _plistManager;
}

-(FERFormatHelper *)formatHelper{
	if (_formatHelper==nil) {
		_formatHelper=[[FERFormatHelper alloc]init];
	}
	return _formatHelper;
}

-(FERImageDownloader *)imageDownloader{
	if(_imageDownloader==nil){
		_imageDownloader=[[FERImageDownloader alloc]init];
	}
	return _imageDownloader;
}

-(void)initializeCollectionView{
	
	self.collectionViewProperty=[[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:self.momentLayout];
	//ADDED THE SUBVIEW AND DATA SOURCE
	[self.view addSubview:self.collectionViewProperty];
	self.collectionViewProperty.dataSource=self;
	
	self.collectionViewProperty.backgroundColor=[UIColor clearColor];
	self.collectionViewProperty.contentInset=UIEdgeInsetsMake(64, 0, 0, 0);
	[self.collectionViewProperty registerClass:[FERDontRepeatCell class] forCellWithReuseIdentifier:@"dontRepeatCell"];
	
	//For the selection
	self.collectionViewProperty.allowsMultipleSelection=YES;
	self.collectionViewProperty.delegate=self;
	
}

-(void)loadMomentLayout{
	self.momentLayout=[[FERMomentLayout alloc]init];
}

-(void)loadDaysLayout{
	self.daysLayout=[[FERDaysLayout alloc]init];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
	return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
	
	return [self.dontRepeats count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
	FERDontRepeatCell	*cell  = [[FERDontRepeatCell alloc ]init];
	cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"dontRepeatCell" forIndexPath:indexPath];
	
	NSLog(@"index: %li",(long)indexPath.item);
	DontRepeat *dont=[[DontRepeat alloc]init];
	dont = [self.dontRepeats objectAtIndex:indexPath.row];
	if (dont.dontRepeatPicture.length==0) {
		UIImage	*image=[UIImage imageNamed:@"NoPic"];
		cell.thumbnail.image=image;
	}else{
		NSString *dataString =dont.dontRepeatPicture;
		NSData *stringData = [[NSData alloc]initWithBase64EncodedString:dataString
																														options:NSDataBase64DecodingIgnoreUnknownCharacters];
		cell.thumbnail.image=[UIImage imageWithData:stringData];
	}
	
	cell.title.text=dont.dontRepeatTitle;
	cell.dateLabel.text=dont.dontRepeatDate;
	NSLog(@"index: %li - %@",(long)indexPath.item,dont.dontRepeatTitle);
	return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
	
	DontRepeat *dont=[[DontRepeat alloc]init];
	dont = [self.dontRepeats objectAtIndex:indexPath.item];
	dontRepeatSeleccionado=dont;
	
	[self performSegueWithIdentifier:@"detailSegue" sender:self];
}


- (IBAction)addPressed:(id)sender {
	
	[self performSegueWithIdentifier:@"detailSegue" sender:self];
	
}


- (IBAction)logoutPressed:(id)sender {
	[self.authClient logout];
	[self.navigationController popViewControllerAnimated:YES];
}

-(void)loadFirebasesDontRepeatsFromUser:(FERUser *)user{
	Firebase *ref = [self.firebaseManager arriveToUserFolder:user];
	self.dontRepeats=[[NSMutableArray alloc]init];
	[ref observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
		NSDictionary *snap = snapshot.value;
		if (snap) {
			NSArray *allKeys = [snap allKeys];
			
			for (NSString *key in allKeys) {
				NSDictionary *dic = [snap objectForKey:key];
				if(![key isEqualToString:@"mail"]){
					DontRepeat *dont = [[DontRepeat alloc] init];
					dont.dontRepeatTitle= [dic objectForKey:@"Title"];
					dont.dontRepeatDate = [dic objectForKey:@"Date"];
					dont.dontRepeatDesc = [dic objectForKey:@"Desc"];
					dont.dontRepeatPicture = [dic objectForKey:@"Pic"];
					dont.dontRepeatID	= key;
					[self.dontRepeats addObject:dont];
				}
			}
			self.dontRepeats=[self.formatHelper sortDontRepeatsByTitle:self.dontRepeats];
		}
		[self.collectionViewProperty reloadData];
	}];
}

- (IBAction)changeLayout:(id)sender {
	UISegmentedControl *segControl=sender;
	switch (segControl.selectedSegmentIndex) {
		case 0:
			self.dontRepeats=[self.formatHelper sortDontRepeatsByTitle:self.dontRepeats];
			[self.collectionViewProperty reloadData];
			[self.collectionViewProperty setCollectionViewLayout:self.momentLayout animated:YES];
			break;
		case 1:
			self.dontRepeats=[self.formatHelper sortDontRepeatsByDate:self.dontRepeats];
			[self.collectionViewProperty reloadData];
			[self.collectionViewProperty setCollectionViewLayout:self.daysLayout animated:YES];
			break;
		default:
			break;
	}
}


-(void)loadPlistDontRepeats{
	
	self.dontRepeats=[self.plistManager loadDontRepeatsFromUser:self.user];
	DontRepeat *fer=[self.dontRepeats firstObject];
	NSLog(@"viewDidAppear%@",fer.dontRepeatID);
	self.dontRepeats=[self.formatHelper sortDontRepeatsByTitle:self.dontRepeats];
	[self.collectionViewProperty reloadData];
	
}

-(void)addDontRepeat:(DontRepeat *)dontRepeat {
	[self.firebaseManager saveDontRepeatToFirebase:dontRepeat forUser:self.user];
	[self.plistManager saveDontRepeatToPlist:dontRepeat forUser:self.user];
}

-(void)updateDontRepeat:(DontRepeat *)dontRepeat {
	[self.firebaseManager updateDontRepeatToFirebase:dontRepeat forUser:self.user];
	[self.plistManager updateDontRepeatToPlist:dontRepeat forUser:self.user];
}

-(void)removeDontRepeat:(DontRepeat *)dontRepeat {
	[self.firebaseManager removeDontRepeatToFirebase:dontRepeat forUser:self.user];
	[self.plistManager removeDontRepeatToPlist:dontRepeat forUser:self.user];
}

-(void)comparePlistVsFireBase{
	Firebase *ref = [self.firebaseManager arriveToUserFolder:self.user];
	
	[ref observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
		
		NSDictionary *snap = snapshot.value;
		
		NSUInteger numberFirebase=snap.count-1;
		NSUInteger numberPlist=[self.plistManager numberOfDontRepeatsInPlistForUser:self.user];
		
		if (numberFirebase>numberPlist) {
			self.dontRepeats=[[NSMutableArray alloc]init];
			NSArray *allKeys = [snap allKeys];
			for (NSString *key in allKeys) {
				NSDictionary *dic = [snap objectForKey:key];
				if(![key isEqualToString:@"mail"]){
					DontRepeat *dont = [[DontRepeat alloc] init];
					dont.dontRepeatTitle= [dic objectForKey:@"Title"];
					dont.dontRepeatDate = [dic objectForKey:@"Date"];
					dont.dontRepeatDesc = [dic objectForKey:@"Desc"];
					dont.dontRepeatPicture = [dic objectForKey:@"Pic"];
					dont.dontRepeatID	= key;
					[self.dontRepeats addObject:dont];
				}
			}
			[self.plistManager saveAllDontRepeatToPlistFromArray:self.dontRepeats forUser:self.user];
		}else if (numberPlist>numberFirebase){
			NSArray	*arrayPlist=[self.plistManager loadDontRepeatsFromUser:self.user];
			NSArray *allKeys = [snap allKeys];
			for (DontRepeat *dont in arrayPlist) {
				if (![allKeys containsObject:dont.dontRepeatID]) {
					[self.firebaseManager saveDontRepeatToFirebase:dont forUser:self.user];
				}
			}
		}
		[self.collectionViewProperty reloadData];
	}];
	
	
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
	
	if ([segue.identifier isEqualToString:@"detailSegue"]){
		FERDontRepeatViewController *dontRepeatViewController=[segue destinationViewController];
		dontRepeatViewController.user=self.user;
		dontRepeatViewController.delegate=self;
		dontRepeatViewController.dontRepeat=dontRepeatSeleccionado;
	}
	if ([segue.identifier isEqualToString:@"newSegue"]){
		FERDontRepeatViewController *dontRepeatViewController=[segue destinationViewController];
		dontRepeatViewController.user=self.user;
		dontRepeatViewController.delegate=self;
	}
}

@end
