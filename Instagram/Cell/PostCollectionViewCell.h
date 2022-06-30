//
//  PostCollectionViewCell.h
//  Instagram
//
//  Created by Trang Dang on 6/30/22.
//

#import <UIKit/UIKit.h>
#import "Parse/PFImageView.h"

NS_ASSUME_NONNULL_BEGIN

@interface PostCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet PFImageView *postImageView;


@end

NS_ASSUME_NONNULL_END
