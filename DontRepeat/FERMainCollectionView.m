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

@interface FERMainCollectionView () <UICollectionViewDataSource, UICollectionViewDelegate,FERDontRepeatViewControllerDelegate>

@property (nonatomic,strong)UICollectionView *collectionViewProperty;
@property	(nonatomic,strong)UICollectionViewFlowLayout *horizontalFlowLayout;
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
	
	NSLog(@"viewDidLoad%@",self.dontRepeats);
	[self cargaHorizontalLayout];
	
	self.collectionViewProperty=[[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:self.horizontalFlowLayout];
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

-(void)cargaHorizontalLayout{
	self.horizontalFlowLayout=[[UICollectionViewFlowLayout alloc]init];
	self.horizontalFlowLayout.itemSize=CGSizeMake(200, 200);
	self.horizontalFlowLayout.sectionInset=UIEdgeInsetsMake(20, 20, 20, 20);
	self.horizontalFlowLayout.minimumLineSpacing=20;
	self.horizontalFlowLayout.minimumInteritemSpacing=10;
	
	self.horizontalFlowLayout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
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
			UIImage	*image=[UIImage imageNamed:@"dress"];
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

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
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
			self.dontRepeats=[self.formatHelper orderDontRepeatsByDate:self.dontRepeats];
		}
		[self.collectionViewProperty reloadData];
	}];
}

-(void)loadPlistDontRepeats{
	
	self.dontRepeats=[self.plistManager loadDontRepeatsFromUser:self.user];
	DontRepeat *fer=[self.dontRepeats firstObject];
	NSLog(@"viewDidAppear%@",fer.dontRepeatID);
	self.dontRepeats=[self.formatHelper orderDontRepeatsByDate:self.dontRepeats];
	[self.collectionViewProperty reloadData];
	
}


-(void)addDontRepeatToFirebase:(DontRepeat *)dontRepeat forUser:(FERUser *)user {

	[self.firebaseManager saveDontRepeatToFirebase:dontRepeat forUser:user];

}

-(void)addDontRepeatToPlist:(DontRepeat *)dontRepeat {
	
	[self.plistManager saveDontRepeatToPlist:dontRepeat forUser:self.user];
	
}
-(void)removeDontRepeat{
	
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
