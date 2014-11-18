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
#import "FERFirstViewController.h"

@interface FERMainCollectionView () <UICollectionViewDataSource, UICollectionViewDelegate,FERDontRepeatViewControllerDelegate,UIGestureRecognizerDelegate,UISearchControllerDelegate,UISearchBarDelegate>

@property (nonatomic,strong)UICollectionView *collectionViewProperty;
@property	(nonatomic,strong)FERMomentLayout *momentLayout;
@property	(nonatomic,strong)FERDaysLayout *daysLayout;
@property (nonatomic,strong)NSMutableSet *selectedCells;
@property	(nonatomic,strong)FERFirebaseManager *firebaseManager;
@property	(nonatomic,strong)FERPlistManager *plistManager;
@property	(nonatomic,strong)FERFormatHelper	*formatHelper;
@property	(nonatomic,strong)FERFirstViewController *firstViewController;
@property (nonatomic,strong)NSMutableArray *dontRepeats;
@property (weak, nonatomic)IBOutlet UIBarButtonItem *addButton;
@property	(nonatomic,strong)FERImageDownloader *imageDownloader;
@property (nonatomic,strong)NSMutableArray *filteredDontRepeats;
@property	(nonatomic,strong)UISearchBar *searchBar;
@property	(nonatomic,strong)UISearchController *searchController;
@end

@implementation FERMainCollectionView {
	DontRepeat* dontRepeatSeleccionado;
	BOOL portrait;
}


-(void)viewWillAppear:(BOOL)animated{
	self.navigationController.navigationBarHidden=NO;
	[self comparePlistVsFireBase];
	[self loadPlistDontRepeats];
	[self.searchBar resignFirstResponder];
}

- (void)viewDidLoad{
	[super viewDidLoad];
	[self loadMomentLayout];
	[self loadDaysLayout];
	[self initializeCollectionView];
	[self configureSearch];
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

-(FERFirstViewController *)firstViewController{
	if (_firstViewController==nil) {
		_firstViewController=[[FERFirstViewController alloc]init];
	}
	return _firstViewController;
}
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
	
	[UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionAllowAnimatedContent
									 animations:^{
										 self.searchBar.frame=CGRectMake(0.0f, 64.0f, self.view.layer.bounds.size.width, 44.0f);
										 
										 self.collectionViewProperty.frame=CGRectMake(0.0f, 0.0f, self.view.layer.bounds.size.width, self.view.layer.bounds.size.height);
										 
										 
									 } completion:^(BOOL finished) {
									 }];
	
}

-(void)initializeCollectionView{
	
	if ([[UIDevice currentDevice] orientation]==UIInterfaceOrientationLandscapeLeft ||
			[[UIDevice currentDevice] orientation]==UIInterfaceOrientationLandscapeRight) {
		self.collectionViewProperty=[[UICollectionView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, self.view.layer.bounds.size.height, self.view.layer.bounds.size.width) collectionViewLayout:self.momentLayout];
	}else{
		self.collectionViewProperty=[[UICollectionView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, self.view.layer.bounds.size.width, self.view.layer.bounds.size.height) collectionViewLayout:self.momentLayout];
		
	}
	//ADDED THE SUBVIEW AND DATA SOURCE
	[self.view addSubview:self.collectionViewProperty];
	self.collectionViewProperty.dataSource=self;
	
	self.collectionViewProperty.backgroundColor=[UIColor clearColor];
	self.collectionViewProperty.contentInset=UIEdgeInsetsMake(108, 0, 0, 0);
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

#pragma-mark search
-(void)configureSearch{
	self.filteredDontRepeats = [[NSMutableArray alloc] init];
	
	if ([[UIDevice currentDevice] orientation]==UIInterfaceOrientationLandscapeLeft ||
			[[UIDevice currentDevice] orientation]==UIInterfaceOrientationLandscapeRight) {
		self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0.0f, 64.0f, self.view.layer.bounds.size.height, 44.0f)];
	}else{
		self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0.0f, 64.0f, self.view.layer.bounds.size.width, 44.0f)];
	}
	
	self.searchBar.showsCancelButton=NO;
	self.searchBar.returnKeyType=UIReturnKeyGo;
	self.searchBar.delegate = self;
	self.searchBar.backgroundColor=[UIColor clearColor];
	self.searchBar.placeholder=@"Search";
	[self.view addSubview:self.searchBar];
}

- (void) textFilter:(NSString *) searchText{
	self.filteredDontRepeats=[[NSMutableArray alloc]init];
	for (DontRepeat *dont in self.dontRepeats) {
		NSString *upperTitle=[dont.dontRepeatTitle uppercaseString];
		NSString *upperSearch=[searchText uppercaseString];
		if ([upperTitle containsString:upperSearch]) {
			if (![self.filteredDontRepeats containsObject:dont]) {
				[self.filteredDontRepeats addObject:dont];
			}
		}
	}
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
	[self textFilter:searchText];
	[UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionAllowAnimatedContent
									 animations:^{
										 [self.collectionViewProperty	reloadData];
									 } completion:^(BOOL finished) {
									 }];
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
	self.searchBar.showsCancelButton=YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
	searchBar.text=@"";
	self.filteredDontRepeats=[[NSMutableArray alloc]init];
	[self.collectionViewProperty reloadData];
	self.searchBar.showsCancelButton=NO;
	[searchBar resignFirstResponder];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
	[searchBar resignFirstResponder];
}

#pragma mark CollectionView

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
	return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
	if(![self.searchBar.text isEqualToString:@""]){
		return [self.filteredDontRepeats count];
	}else{
		return [self.dontRepeats count];
	}
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
	FERDontRepeatCell	*cell  = [[FERDontRepeatCell alloc ]init];
	cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"dontRepeatCell" forIndexPath:indexPath];
	
	DontRepeat *dont=[[DontRepeat alloc]init];
	if(![self.searchBar.text isEqualToString:@""]){
		dont = [self.filteredDontRepeats objectAtIndex:indexPath.row];
	}else{
		dont = [self.dontRepeats objectAtIndex:indexPath.row];
	}
	
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
	[self.authClient unauth];
	[self.plistManager removeUserFromUserList];
	[self.navigationController popToRootViewControllerAnimated:YES];
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
					if ([[dic objectForKey:@"Del"] isEqualToString:@"NO"]) {
					DontRepeat *dont = [[DontRepeat alloc] init];
					dont.dontRepeatTitle= [dic objectForKey:@"Title"];
					dont.dontRepeatDate = [dic objectForKey:@"Date"];
					dont.dontRepeatDesc = [dic objectForKey:@"Desc"];
					dont.dontRepeatPicture = [dic objectForKey:@"Pic"];
					dont.dontRepeatDeleted = [dic objectForKey:@"Del"];
					dont.dontRepeatID	= key;
					[self.dontRepeats addObject:dont];
					}
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
	self.dontRepeats=[self.formatHelper sortDontRepeatsByTitle:self.dontRepeats];
	[self.collectionViewProperty reloadData];
	
}

-(void)addDontRepeat:(DontRepeat *)dontRepeat {
	[self.firebaseManager saveDontRepeatToFirebase:dontRepeat forUser:self.user];
	[self.plistManager saveDontRepeatToPlist:dontRepeat forUser:self.user];
}

-(void)updateDontRepeat:(DontRepeat *)dontRepeat with:(DontRepeat *)newDontRepeat{
	[self.firebaseManager updateDontRepeatToFirebase:dontRepeat with:(DontRepeat *)newDontRepeat forUser:self.user];
	[self.plistManager updateDontRepeatToPlist:dontRepeat with:(DontRepeat *)newDontRepeat forUser:self.user];
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
					if ([[dic objectForKey:@"Del"] isEqualToString:@"NO"]) {
						DontRepeat *dont = [[DontRepeat alloc] init];
						dont.dontRepeatTitle= [dic objectForKey:@"Title"];
						dont.dontRepeatDate = [dic objectForKey:@"Date"];
						dont.dontRepeatDesc = [dic objectForKey:@"Desc"];
						dont.dontRepeatPicture = [dic objectForKey:@"Pic"];
						dont.dontRepeatDeleted = [dic objectForKey:@"Del"];
						dont.dontRepeatID	= key;
						[self.dontRepeats addObject:dont];
					}
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
