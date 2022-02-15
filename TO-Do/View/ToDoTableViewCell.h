//
//  ToDoTableViewCell.h
//  TO-Do
//
//  Created by Ma7rous on 2/10/22.
//  Copyright © 2022 Ma7rous. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <DGActivityIndicatorView.h>

NS_ASSUME_NONNULL_BEGIN

@interface ToDoTableViewCell : UITableViewCell
{
    
}
@property (weak, nonatomic) IBOutlet UIButton *doneStateBtn;
@property (weak, nonatomic) IBOutlet UIButton *doItBtn;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UIImageView *pImgV;
@property (weak, nonatomic) IBOutlet UIView *cellCustomView;
@property (weak, nonatomic) IBOutlet UIView *podView;

-(void) setPodView;
-(void) setButtonCellView;

@end

NS_ASSUME_NONNULL_END
