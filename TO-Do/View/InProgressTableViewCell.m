//
//  InProgressTableViewCell.m
//  TO-Do
//
//  Created by Ma7rous on 2/13/22.
//  Copyright © 2022 Ma7rous. All rights reserved.
//

#import "InProgressTableViewCell.h"

@implementation InProgressTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void) setViewCellView {
    
}
-(void) setButtonCellView {
    _doneBtn.layer.borderWidth = 2.0;
    _doneBtn.layer.borderColor = [[UIColor clearColor] CGColor];

    _doneBtn.layer.shadowColor = [UIColor colorWithRed:(53.0f) green:80.0 blue:161.0 alpha:1.0].CGColor;
    _doneBtn.layer.shadowOpacity = 1.0f;
    _doneBtn.layer.shadowRadius = 1.0f;
    _doneBtn.layer.shadowOffset = CGSizeMake(1, 2);
}
@end
