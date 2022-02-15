//
//  InProgressViewController.m
//  TO-Do
//
//  Created by Ma7rous on 1/31/22.
//  Copyright © 2022 Ma7rous. All rights reserved.
//
#import "InProgressViewController.h"

@interface InProgressViewController ()
{
    TabBarViewController* tab;
    NSMutableArray <TodoTask*>*inProgressList;
    NSMutableArray <TodoTask*>*inProgressSearch;
    
    NSMutableArray <TodoTask*>*highList;
    NSMutableArray <TodoTask*>*mediumList;
    NSMutableArray <TodoTask*>*lowList;
    NSMutableArray <TodoTask*>*otherList;
    
    BOOL isFiltered;
    BOOL isSorted;
}
#pragma mark - Outlet Connections
@property (weak, nonatomic) IBOutlet UITableView *inProgressTableView;
@property (weak, nonatomic) IBOutlet UISearchBar *inProgressSearchBar;
@property (weak, nonatomic) IBOutlet UIButton *sortBtnOutlet;
/*==============================================================*/
@end

@implementation InProgressViewController

- (void)viewWillAppear:(BOOL)animated {
    [self intialization];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //Set delegate and data source
    _inProgressTableView.delegate = self;
    _inProgressTableView.dataSource = self;
    _inProgressSearchBar.delegate = self;
    /*==========================================================*/
    tab = [TabBarViewController new];
    inProgressList = [NSMutableArray new];
    highList = [NSMutableArray new];
    mediumList = [NSMutableArray new];
    lowList = [NSMutableArray new];
    otherList = [NSMutableArray new];
}
/*========================================================================*/
#pragma mark - TableView Functions
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (isSorted == YES) {
        return 4;
    } else {
        return 1;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger num = 0;
    if (isSorted) {
         switch (section) {
                 case 0:
                    num = [highList count];
                    break;
                 case 1:
                    num = [mediumList count];
                    break;
                 case 2:
                    num = [lowList count];
                    break;
                 case 3:
                    num = [otherList count];
                    break;
               default:
                   break;
        }
        return num;
    } else {
        if (isFiltered) {
            num = [inProgressSearch count];
        }else{
            num = [inProgressList count];
        }
        return num;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString* title;
    if (isSorted) {
     switch (section) {
             case 0:
             if ([highList count]>0) {
                 title = @"High";
             }
                break;
             case 1:
             if ([mediumList count]>0) {
                 title = @"Medium";
             }
                break;
             case 2:
             if ([lowList count]>0) {
                 title = @"Low";
                }
                break;
             case 3:
             if ([otherList count]>0) {
                 title = @"Others";
             }
                break;
           default:
               break;
     }
    }
    return title;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    InProgressTableViewCell* cell = [_inProgressTableView dequeueReusableCellWithIdentifier:@"inProgressCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[InProgressTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"inProgressCell"];
    }
    
    if (isSorted) {
        switch (indexPath.section) {
                case 0:
                    cell.nameLbl.text = highList[indexPath.row].name;
                    cell.dImgV.image = [UIImage imageNamed:highList[indexPath.row].img];
                    break;
                case 1:
                    cell.nameLbl.text = mediumList[indexPath.row].name;
                    cell.dImgV.image = [UIImage imageNamed:mediumList[indexPath.row].img];
                    break;
                case 2:
                    cell.nameLbl.text = lowList[indexPath.row].name;
                    cell.dImgV.image = [UIImage imageNamed:lowList[indexPath.row].img];
                    break;
                case 3:
                    cell.nameLbl.text = otherList[indexPath.row].name;
                    cell.dImgV.image = [UIImage imageNamed:otherList[indexPath.row].img];
                    break;
               default:
                    if (isFiltered) {
                        cell.nameLbl.text = inProgressSearch[indexPath.row].name;
                        cell.dImgV.image = [UIImage imageNamed:inProgressSearch[indexPath.row].img];
                    }else{
                        cell.nameLbl.text = inProgressList[indexPath.row].name;
                        cell.dImgV.image = [UIImage imageNamed:inProgressList[indexPath.row].img];
                    }
                   break;
        }
    } else {
        if (isFiltered) {
            cell.nameLbl.text = inProgressSearch[indexPath.row].name;
            cell.dImgV.image = [UIImage imageNamed:inProgressSearch[indexPath.row].img];
        }else{
            cell.nameLbl.text = inProgressList[indexPath.row].name;
            cell.dImgV.image = [UIImage imageNamed:inProgressList[indexPath.row].img];
        }
    }
    
    cell.doneBtn.tag = indexPath.row;
    cell.doneBtn.hidden = NO;
    [cell.doneBtn addTarget:self action:@selector(doneBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [cell setButtonCellView];
    cell.layer.masksToBounds = TRUE;
    cell.cellCustomView.layer.cornerRadius = cell.cellCustomView.frame.size.height / 2;
    cell.dImgV.layer.cornerRadius = cell.dImgV.frame.size.height / 2;
    cell.layer.shadowOffset = CGSizeMake(0, 5);
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath: indexPath animated: YES];
    todoState = @"fromInProgressCell";
    TodoTask* temp = [inProgressList objectAtIndex:indexPath.row];
    AddTodoViewController *VC = [self.storyboard instantiateViewControllerWithIdentifier:@"addTodo"];
    [VC setStr:temp.name];
    [self presentViewController:VC animated:YES completion:NULL];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Deletion" message:@"Do you want to delete This Todo?" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSString* temp = [self->inProgressList objectAtIndex:indexPath.row].name;
            [self->inProgressList removeObjectAtIndex:indexPath.row];
            [self->tab deleteFromDbAtTodo:temp];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            
        }];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:NULL];
        [alert addAction:action];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:NULL];
        
    }
    [_inProgressTableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

/*========================================================================*/
#pragma mark - SearchBar Functions
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (searchText.length == 0) {
        isFiltered = NO;
        [self.inProgressSearchBar endEditing:YES];
    } else {
        isFiltered = YES;
        inProgressSearch = [NSMutableArray new];
        for (TodoTask* task in inProgressList) {
            NSRange nameRange = [task.name rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if (nameRange.location != NSNotFound) {
                [inProgressSearch addObject:task];
            }
        }
    }
    [self.inProgressTableView reloadData];
}

/*========================================================================*/
#pragma mark - Action Connections
- (IBAction)sortBtnClicked:(id)sender {
    if (isSorted == YES) {
        isSorted = NO;
    } else {
        isSorted = YES;
    }
    [self sortTodos];
}

- (void)doneBtnClicked:(UIButton*)sender {
    NSIndexPath* indexpath = [NSIndexPath indexPathForRow:sender.tag inSection:0];
    TodoTask* todo = [inProgressList objectAtIndex:indexpath.row];
    [tab updateDbToDoneAtTodo:todo];
    sender.hidden = YES;
    [self intialization];
    [_inProgressTableView reloadData];
}

/*========================================================================*/
#pragma mark - Services Functions
-(void) intialization {
    [inProgressList removeAllObjects];
    //Variables initialization
    [inProgressList addObjectsFromArray:[tab displayInProgressFromDb]];
    [_inProgressTableView reloadData];
    //make tableView in a good view
    _inProgressTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _inProgressTableView.showsVerticalScrollIndicator = NO;
}

-(void) sortTodos {
    [highList removeAllObjects];
    [mediumList removeAllObjects];
    [lowList removeAllObjects];
    [otherList removeAllObjects];
    for (TodoTask* obj in inProgressList) {
        if ([obj.priority isEqualToString:@"HIGH"]) {
            [highList addObject:obj];
        } else if ([obj.priority isEqualToString:@"MEDIUM"]) {
            [mediumList addObject:obj];
        } else if ([obj.priority isEqualToString:@"LOW"]) {
            [lowList addObject:obj];
        } else {
            [otherList addObject:obj];
        }
    }
    [_inProgressTableView reloadData];
}
@end
