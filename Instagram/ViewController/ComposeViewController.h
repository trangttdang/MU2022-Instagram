//
//  ComposeViewController.h
//  Instagram
//
//  Created by Trang Dang on 6/27/22.
//

#import <UIKit/UIKit.h>
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ComposeViewControllerDelegate

- (void)didPost:(Post *)post;

@end
@interface ComposeViewController : UIViewController


@property (nonatomic, weak) id<ComposeViewControllerDelegate> delegate;

@end
NS_ASSUME_NONNULL_END
