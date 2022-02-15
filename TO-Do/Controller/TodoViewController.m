//
//  TodoViewController.m
//  TO-Do
//
//  Created by Ma7rous on 1/31/22.
//  Copyright © 2022 Ma7rous. All rights reserved.
//

#import "TodoViewController.h"

@interface TodoViewController ()
{
    TabBarViewController* tab;
    
    //View Controller variables
    NSMutableArray <TodoTask*>*todosSearch;
    NSMutableArray <TodoTask*>*todosList;
    BOOL isFiltered;
    BOOL inProgress;
}
@end

@implementation TodoViewController

- (void)viewWillAppear:(BOOL)animated {
    [self intialization];
    [_todosTableView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //Set delegate and data source
    _todosTableView.delegate =self;
    _todosTableView.dataSource = self;
    _todoSearchBar.delegate = self;
    /*==============================*/
    tab = [TabBarViewController new];
    todosList = [NSMutableArray new];
    [tab createSqliteDatabase];
    
}
/*========================================================================*/
#pragma mark - Table View Functions
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (isFiltered) {
        return [todosSearch count];
    }else{
        return [todosList count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ToDoTableViewCell* cell = [_todosTableView dequeueReusableCellWithIdentifier:@"todoCell" forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[ToDoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"todoCell"];
    }
    if (isFiltered) {
        cell.nameLbl.text = todosSearch[indexPath.row].name;
        cell.pImgV.image = [UIImage imageNamed:todosSearch[indexPath.row].img];
        
    } else {
        cell.nameLbl.text = todosList[indexPath.row].name;
        cell.pImgV.image = [UIImage imageNamed:todosList[indexPath.row].img];
    }
    
    [cell.doneStateBtn setHidden:YES];
    [cell.podView setHidden:YES];
    if ([todosList[indexPath.row].inProgress isEqualToString:@"yes"]) {
        [cell.podView setHidden:NO];
        [cell setPodView];
        [cell.doItBtn setHidden:YES];
        [cell.doneStateBtn setHidden:YES];
       }

    if ([todosList[indexPath.row].done isEqualToString:@"yes"]) {
        [cell.doItBtn setHidden:YES];
        [cell.doneStateBtn setHidden:NO];
        [cell.doneStateBtn setBackgroundColor:[UIColor greenColor]];
       }
    
    cell.doItBtn.tag = indexPath.row;
    [cell.doItBtn addTarget:self action:@selector(doItBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [cell setButtonCellView];
    cell.layer.masksToBounds = TRUE;
    cell.cellCustomView.layer.cornerRadius = cell.cellCustomView.frame.size.height / 2;
    cell.pImgV.layer.cornerRadius = cell.pImgV.frame.size.height / 2;
    cell.layer.shadowOffset = CGSizeMake(0, 5);
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath: indexPath animated: YES];
    todoState = @"fromTodoListCell";
    TodoTask* temp = [todosList objectAtIndex:indexPath.row];
    AddTodoViewController *VC = [self.storyboard instantiateViewControllerWithIdentifier:@"addTodo"];
    [VC setDelegate:self];
    [VC setStr:temp.name];
    [self presentViewController:VC animated:YES completion:NULL];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Deletion" message:@"Do you want to delete This Todo?" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            TodoTask* temp = [self->todosList objectAtIndex:indexPath.row];
            [self->todosList removeObjectAtIndex:indexPath.row];
            [self->tab deleteFromDbAtTodo:temp.name];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            
        }];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:NULL];
        [alert addAction:action];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:NULL];
        
    }
    [_todosTableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}
/*========================================================================*/
#pragma mark - SearchBar Functions
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (searchText.length == 0) {
        isFiltered = NO;
        [_todoSearchBar endEditing:YES];
    } else {
        isFiltered = YES;
        todosSearch = [NSMutableArray new];
        for (TodoTask* task in todosList) {
            NSRange nameRange = [task.name rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if (nameRange.location != NSNotFound) {
                [todosSearch addObject:task];
            }
        }
    }
    [_todosTableView reloadData];
}

/*========================================================================*/
#pragma mark - Action Connections
- (IBAction)addTodoClicked:(id)sender {
    todoState = @"fromAddBtn";
    AddTodoViewController *VC = [self.storyboard instantiateViewControllerWithIdentifier:@"addTodo"];
    [VC setDelegate:self];
    [self presentViewController:VC animated:YES completion:NULL];
}
- (void)doItBtnClicked:(UIButton*)sender {
    NSIndexPath* indexpath = [NSIndexPath indexPathForRow:sender.tag inSection:0];
    TodoTask* todo = [todosList objectAtIndex:indexpath.row];
    [tab updateDbToInProgressAtTodo:todo];
    sender.hidden = YES;
    [self intialization];
    [_todosTableView reloadData];
    
}

/*=======================================================================*/
#pragma mark - Delegation Function
- (void)addToDo:(TodoTask *)todo {
    [todosList addObject:todo];
    [tab insertInDBTodoTask:todo];
    [_todosTableView reloadData];
}

/*========================================================================*/
#pragma mark - Services Functions
-(void) intialization {
    [todosList removeAllObjects];
    //Variables initialization
    [todosList addObjectsFromArray:[tab displayTodosFromDb]];
    [_todosTableView reloadData];
    //make tableView in a good view
    _todosTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _todosTableView.showsVerticalScrollIndicator = NO;
    
    //set add Button view
    _addBtnOutlet.layer.borderWidth = 2.0;
    _addBtnOutlet.layer.borderColor = [[UIColor clearColor] CGColor];

    _addBtnOutlet.layer.shadowColor = [UIColor colorWithRed:5.0 green:28.0 blue:85.0 alpha:1.0].CGColor;
    _addBtnOutlet.layer.shadowOpacity = 0.8;
    _addBtnOutlet.layer.shadowRadius = 5;
    _addBtnOutlet.layer.shadowOffset = CGSizeMake(0, 3);
   
}

@end
