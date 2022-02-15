//
//  DoneTableViewCell.h
//  TO-Do
//
//  Created by Ma7rous on 2/13/22.
//  Copyright © 2022 Ma7rous. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DoneTableViewCell : UITableViewCell

/*=============================================================*/
#pragma mark - Outlet Connections
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UIImageView *dImgV;
@property (weak, nonatomic) IBOutlet UIView *cellCustomView;
@property (weak, nonatomic) IBOutlet UIButton *doneStateBtn;
/*=============================================================*/
-(void) setViewCellView;
@end

NS_ASSUME_NONNULL_END
