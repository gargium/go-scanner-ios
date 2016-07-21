//
//  SearchViewController.h
//  GoScanner
//
//  Created by Gargium on 7/20/16.
//  Copyright © 2016 Gargium. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) IBOutlet UICollectionViewFlowLayout *flowLayout;


@end
