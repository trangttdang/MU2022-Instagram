//
//  PostCell.h
//  Instagram
//
//  Created by Trang Dang on 6/29/22.
//

#import <UIKit/UIKit.h>
#import "Post.h"
#import "Parse/PFImageView.h"

NS_ASSUME_NONNULL_BEGIN
@protocol PostCellDelegate
- (void)didPost:(Post *)post;

@end

@interface PostCell : UITableViewCell
@property (weak, nonatomic) IBOutlet PFImageView *imagePostImageView;
@property (weak, nonatomic) IBOutlet UILabel *captionPostLabel;
@property (nonatomic,weak) id<PostCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *datePostedLabel;


@end

NS_ASSUME_NONNULL_END
