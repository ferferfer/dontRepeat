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

@interface FERMainCollectionView () <UICollectionViewDataSource, UICollectionViewDelegate,FERDontRepeatViewControllerDelegate>

@property (nonatomic,strong)UICollectionView *collectionViewProperty;
@property	(nonatomic,strong)UICollectionViewFlowLayout *horizontalFlowLayout;
@property (nonatomic,strong)NSMutableSet *selectedCells;
@property	 (nonatomic, strong)FERFirebaseManager *firebaseManager;
@property (nonatomic,strong)	NSMutableArray *dontRepeats;

@end

@implementation FERMainCollectionView

- (void)viewDidLoad{
	[super viewDidLoad];
	
	[self loadDontRepeatsFromUser:self.user];
	NSLog(@"%@",self.dontRepeats);
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
	
	return [self.dontRepeats count]+1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
	FERDontRepeatCell	*cell  = [[FERDontRepeatCell alloc ]init];
	cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"dontRepeatCell" forIndexPath:indexPath];
	if (indexPath.item!=[self.dontRepeats count]) {
		DontRepeat *dont=[[DontRepeat alloc]init];
		dont = [self.dontRepeats objectAtIndex:indexPath.item];
		if (dont.dontRepeatPicture.length==0) {
			UIImage	*image=[UIImage imageNamed:@"dress"];
			cell.thumbnail.image=image;
		}else{
			cell.thumbnail.image=[UIImage imageWithData:dont.dontRepeatPicture];
		}
		cell.title.text=dont.dontRepeatTitle;
		cell.dateLabel.text=dont.dontRepeatDate;
	}else{
		UIImage	*image=[UIImage imageNamed:@"newDress"];
		cell.thumbnail.image=image;
		cell.title.text=@"";
		cell.dateLabel.text=@"";
	}
	return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
	[self performSegueWithIdentifier:@"detailSegue" sender:self];
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
}

- (IBAction)reloadPressed:(id)sender {
	[self loadDontRepeatsFromUser:self.user];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
	
	if ([segue.identifier isEqualToString:@"detailSegue"]){
		FERDontRepeatViewController *dontRepeatViewController=[segue destinationViewController];
		dontRepeatViewController.user=self.user;
		dontRepeatViewController.delegate=self;
	}
	
}

- (IBAction)logoutPressed:(id)sender {
	[self.authClient logout];
	[self.navigationController popViewControllerAnimated:YES];
}

-(void)loadDontRepeatsFromUser:(FERUser *)user{
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
					
					[self.dontRepeats addObject:dont];
				}
			}
		}
		[self.collectionViewProperty reloadData];
	}];
}

-(void)addDontRepeat:(DontRepeat *)dontRepeat forUser:(FERUser *)user {

	[self.firebaseManager saveDontRepeat:dontRepeat forUser:user];

}

-(void)removeDontRepeat{
	
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
