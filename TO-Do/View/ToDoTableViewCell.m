//
//  ToDoTableViewCell.m
//  TO-Do
//
//  Created by Ma7rous on 2/10/22.
//  Copyright © 2022 Ma7rous. All rights reserved.
//

#import "ToDoTableViewCell.h"

@implementation ToDoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void) setPodView {
    DGActivityIndicatorView *activityIndicatorView = [[DGActivityIndicatorView alloc] initWithType:DGActivityIndicatorAnimationTypeDoubleBounce tintColor:[UIColor yellowColor] size:40.0f];
       activityIndicatorView.frame = CGRectMake(_podView.bounds.origin.x , _podView.bounds.origin.y , 40.0f, 40.0f);
    [activityIndicatorView setUserInteractionEnabled:NO];
    [activityIndicatorView setExclusiveTouch:NO];
    [_podView addSubview:activityIndicatorView];
    [activityIndicatorView startAnimating];
}
-(void) setButtonCellView {
    _doItBtn.layer.borderWidth = 2.0;
    _doItBtn.layer.borderColor = [[UIColor clearColor] CGColor];

    _doItBtn.layer.shadowColor = [UIColor colorWithRed:(53.0f) green:80.0 blue:161.0 alpha:1.0].CGColor;
    _doItBtn.layer.shadowOpacity = 1.0f;
    _doItBtn.layer.shadowRadius = 1.0f;
    _doItBtn.layer.shadowOffset = CGSizeMake(1, 2);
}
@end
