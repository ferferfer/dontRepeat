//
//  FERMainCollectionView.m
//  DontRepeat
//
//  Created by Fernando Garcia Corrochano on 20/08/14.
//  Copyright (c) 2014 FernandoGarciaCorrochano. All rights reserved.
//

#import "FERMainCollectionView.h"
#import "FERDontRepeatCell.h"

@interface FERMainCollectionView () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic,strong)UICollectionView *collectionViewProperty;
@property	(nonatomic,strong)UICollectionViewFlowLayout *horizontalFlowLayout;
@property (nonatomic,strong)NSMutableSet *selectedCells;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *trash;



@end

@implementation FERMainCollectionView

- (void)viewDidLoad{
	[super viewDidLoad];
	[self cargaHorizontalLayout];
	self.trash.enabled=NO;
	
	self.navigationItem.leftBarButtonItem = self.editButtonItem;

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


-(NSMutableSet*)selectedCells{
	if(!_selectedCells){
		_selectedCells=[[NSMutableSet alloc]init];
	}
	return _selectedCells;
}

-(void)cargaHorizontalLayout{
	self.horizontalFlowLayout=[[UICollectionViewFlowLayout alloc]init];
	self.horizontalFlowLayout.itemSize=CGSizeMake(100, 100);
	self.horizontalFlowLayout.sectionInset=UIEdgeInsetsMake(30, 30, 30, 30);
	self.horizontalFlowLayout.minimumLineSpacing=30;
	self.horizontalFlowLayout.minimumInteritemSpacing=10;

	self.horizontalFlowLayout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
}



-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
	return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

	return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
	
	FERDontRepeatCell	*cell  = [[FERDontRepeatCell alloc ]init];
	cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"dontRepeatCell" forIndexPath:indexPath];
	
	UIImage	*imagen=[UIImage imageNamed:@"newDress"];
	cell.thumbnail.image=imagen;
	cell.title.text=@"reuninon con telefonica";
	cell.dateLabel.text=@"02/02/20";
	
	return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

	if([self.editButtonItem.title isEqualToString:@"Done"]){
		[self.selectedCells addObject:indexPath];
		self.trash.enabled=YES;
	}else{
		[self performSegueWithIdentifier:@"detailSegue" sender:self];
	}

}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
	if([self.editButtonItem.title isEqualToString:@"Done"]){
		[self.selectedCells removeObject:indexPath];
		if(self.selectedCells.count==0){
			self.trash.enabled=NO;
		}
	}
}

- (IBAction)delete:(id)sender {
	[self.collectionViewProperty performBatchUpdates:^{
		[self.collectionViewProperty deleteItemsAtIndexPaths:self.selectedCells.allObjects];
		for (int c=0;c<7;c++){
			NSMutableIndexSet *indexSet=[[NSMutableIndexSet alloc]init];
			for(NSIndexPath *indexPath in self.selectedCells){
				if (indexPath.section==c) {
					[indexSet addIndex:indexPath.row];
				}
			}
		}
		self.selectedCells=[[NSMutableSet alloc]init];
		self.trash.enabled=NO;
	}completion:nil];
	
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
	
	if ([segue.identifier isEqualToString:@"pasarPajaro"]){
	
	}
	
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
