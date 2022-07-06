//
//  PostCell.m
//  Instagram
//
//  Created by Trang Dang on 6/29/22.
//

#import "PostCell.h"
#import "Post.h"
@implementation PostCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    UITapGestureRecognizer *usernameTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTapUsername:)];
    [self.usernameLabel addGestureRecognizer:usernameTapGestureRecognizer];
    [self.usernameLabel setUserInteractionEnabled:YES];
}

- (void)didTapUsername:(UITapGestureRecognizer *)sender {
    [self.delegate didTapUsername:self.post];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
