//
//  AddTdodoViewController.m
//  TO-Do
//
//  Created by Ma7rous on 1/31/22.
//  Copyright © 2022 Ma7rous. All rights reserved.
//

#import "AddTodoViewController.h"

@interface AddTodoViewController ()
{
    TodoTask* task;
    TabBarViewController* tab;
    BOOL editing;
}
#pragma mark - Outlet Connections For Add ToDo
@property (weak, nonatomic) IBOutlet UIDatePicker *datPicker;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTV;
@property (weak, nonatomic) IBOutlet UIButton *selectPriorityBtn;
@property (weak, nonatomic) IBOutlet UITableView *priorityTableView;
@property (weak, nonatomic) IBOutlet UIImageView *priorityImg;
@property (weak, nonatomic) IBOutlet UISwitch *switchState;
@property (weak, nonatomic) IBOutlet UIButton *addAndSaveBtn;
/*=================================================*/
#pragma mark - Outlet Connections For State ToDo
@property (weak, nonatomic) IBOutlet UIView *editView;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLbl;
@property (weak, nonatomic) IBOutlet UILabel *priorityLbl;
@property (weak, nonatomic) IBOutlet UIImageView *priorityImgLbl;
@property (weak, nonatomic) IBOutlet UILabel *dateLbl;
@property (weak, nonatomic) IBOutlet UILabel *reminderLbl;
@property (weak, nonatomic) IBOutlet UILabel *attachedLbl;
@property (weak, nonatomic) IBOutlet UIButton *editBtn;

/*=================================================*/
@property NSArray* priorities;
@property NSArray* prioritiesImg;

@end

@implementation AddTodoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    task = [TodoTask new];
    tab = [TabBarViewController new];
    hasReminder = NO;
    _priorityTableView.delegate = self;
    _priorityTableView.dataSource = self;
    _priorityTableView.hidden = YES;
    [_datPicker setMinimumDate:_datPicker.date];
    _priorities =[[NSArray alloc]initWithObjects:@"LOW",@"MEDIUM",@"HIGH", nil];
    _prioritiesImg =[[NSArray alloc]initWithObjects:@"P-low",@"P-medium",@"P-high", nil];
    if ([todoState isEqualToString:@"fromAddBtn"]) {
        [self intializeFromAddBtn];
    } else if ([todoState isEqualToString:@"fromInProgressCell"] || [todoState isEqualToString:@"fromDoneCell"] || [todoState isEqualToString:@"fromTodoListCell"]) {
        [self intializeFromTodoListCell];
    }
}

/*===============================================*/
#pragma mark - TableView Functions
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_priorities count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [_priorityTableView dequeueReusableCellWithIdentifier:@"priorityCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"priorityCell"];
    }
    cell.textLabel.text = [_priorities objectAtIndex: indexPath.row];
    [cell.textLabel setTextColor:[UIColor whiteColor]];
    cell.imageView.image = [UIImage imageNamed:[_prioritiesImg objectAtIndex: indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath: indexPath animated: YES];
    UITableViewCell* cell = [_priorityTableView cellForRowAtIndexPath:indexPath];
    _priorityImg.image = [UIImage imageNamed:[_prioritiesImg objectAtIndex:indexPath.row]];
    [_selectPriorityBtn setTitle:cell.textLabel.text forState:UIControlStateNormal];
    [_selectPriorityBtn setTitleColor: [UIColor whiteColor] forState: UIControlStateNormal];
    //_selectPriorityBtn.backgroundColor = [UIColor whiteColor];
    
    _priorityTableView.hidden = YES;
}

/*==============================================*/
#pragma mark - Action Connections For Add ToDo
- (IBAction)selectPriorityClick:(id)sender {
    if (_priorityTableView.hidden == YES) {
        _priorityTableView.hidden = NO;
        [_selectPriorityBtn setTitle:@"Select Priority" forState:UIControlStateNormal];
        [_selectPriorityBtn setTitleColor: [UIColor whiteColor] forState: UIControlStateNormal];
        _priorityImg.image = NULL;
    } else {
        _priorityTableView.hidden = YES;
        [_selectPriorityBtn setTitle:@"Select Priority" forState:UIControlStateNormal];
        [_selectPriorityBtn setTitleColor: [UIColor whiteColor] forState: UIControlStateNormal];
        _priorityImg.image = NULL;
    }
    
}

- (IBAction)setReminderSwtch:(id)sender {
    if (_switchState.on) {
        hasReminder = YES;
        
    } else {
        hasReminder = NO;
    }
}

- (IBAction)addTodoClicked:(id)sender {
    if (editing == YES) {
        if ([_nameTF.text isEqualToString:@""]){
            [self emptyNameAlert];
        } else if ([tab checkNameValidation:_nameTF.text] == YES) {
            //TODO: show alert to notify that this name is already exist check the list or enter another name
            [self nameAlert];
        }else{
            [self setData];
            [tab updateDbAtTodo:task];
            [self dismissViewControllerAnimated:YES completion:NULL];
            [_addAndSaveBtn setTitle:@"Add ToDo" forState:UIControlStateNormal];
            editing = NO;
        }
         
    } else {
       if ([_nameTF.text isEqualToString:@""]){
           [self emptyNameAlert];
       } else if ([tab checkNameValidation:_nameTF.text] == YES){
           //TODO: show alert to notify that this name is already exist check the list or enter another name
           [self nameAlert];
       } else {
           [self setData];
           [_delegate addToDo:task];
           [self dismissViewControllerAnimated:YES completion:NULL];
       }
    }
   
    
}

/*==============================================*/
#pragma mark - Action Connections For State ToDo
- (IBAction)editTodoClicked:(id)sender {
    _editView.hidden = YES;
    editing = YES;
    [_addAndSaveBtn setTitle:@"Save" forState:UIControlStateNormal];
    [self setReverseData];
}

/*==============================================*/
#pragma mark - Services Functions For Add ToDo
-(void) setData {
   
    task.name = _nameTF.text;
    task.Description = _descriptionTV.text;
    if ([_selectPriorityBtn.titleLabel.text  isEqual: @"LOW"]) {
        task.priority = @"LOW";
        task.img = [_prioritiesImg objectAtIndex:0];
    } else if ([_selectPriorityBtn.titleLabel.text  isEqual: @"MEDIUM"]) {
        task.priority = @"MEDIUM";
        task.img = [_prioritiesImg objectAtIndex:1];
    }else if ([_selectPriorityBtn.titleLabel.text  isEqual: @"HIGH"]) {
        task.priority = @"HIGH";
        task.img = [_prioritiesImg objectAtIndex:2];
    }else{
        task.priority = @"";
        task.img = @"placeholder";
    }
    NSDateFormatter* df = [NSDateFormatter new];
    [df setFormatterBehavior:NSDateFormatterBehavior10_4];
    [df setTimeStyle:NSDateFormatterShortStyle];
    [df setDateStyle:NSDateFormatterShortStyle];
    task.date = [df stringFromDate:_datPicker.date];
    if (hasReminder == YES) {
        task.reminder = @"yes";
    }else{
        task.reminder = @"no";
    }
    task.inProgress = @"no";
    task.done = @"no";
    task.attachedFile = @"";
    task.targetDate = [_datPicker date];
}

-(void) emptyNameAlert{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"TO-DO App" message:@"You Must Enter The NAME of ToDo task!!" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* action = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
       
    }];
    [alert addAction:action];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:NULL];
}

-(void) nameAlert{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"TO-DO App" message:@"This name is already exist check the list or enter another name!!" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* action = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

    }];
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
       
    }];
    [alert addAction:action];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:NULL];
}
/*==============================================*/
#pragma mark - Services Functions For State ToDo
-(void) showDataOfTodo {
    task = [tab getTodosFromDbWithIndex:_str];
    _nameLbl.text = task.name;
    _descriptionLbl.text = task.Description;
    _priorityLbl.text = task.priority;
    _priorityImgLbl.image = [UIImage imageNamed:task.img];
    _dateLbl.text = task.date;
    _reminderLbl.text = task.reminder;
    _attachedLbl.text = task.attachedFile;
}

-(void) setReverseData {
   
    _nameTF.text = task.name;
    _descriptionTV.text = task.Description;
    if ([task.priority  isEqual: @"LOW"]) {
        [_selectPriorityBtn setTitle: @"LOW" forState:UIControlStateNormal];
        [_selectPriorityBtn setTitleColor: [UIColor blackColor] forState: UIControlStateNormal];
        _selectPriorityBtn.backgroundColor = [UIColor whiteColor];
        _priorityImg.image = [UIImage imageNamed:[_prioritiesImg objectAtIndex:0]];
    } else if ([task.priority isEqual: @"MEDIUM"]) {
        [_selectPriorityBtn setTitle: @"MEDIUM" forState:UIControlStateNormal];
        [_selectPriorityBtn setTitleColor: [UIColor blackColor] forState: UIControlStateNormal];
        _selectPriorityBtn.backgroundColor = [UIColor whiteColor];
        _priorityImg.image = [UIImage imageNamed:[_prioritiesImg objectAtIndex:1]];
    }else if ([task.priority isEqual: @"HIGH"]) {
        [_selectPriorityBtn setTitle: @"HIGH" forState:UIControlStateNormal];
        [_selectPriorityBtn setTitleColor: [UIColor blackColor] forState: UIControlStateNormal];
        _selectPriorityBtn.backgroundColor = [UIColor whiteColor];
        _priorityImg.image = [UIImage imageNamed:[_prioritiesImg objectAtIndex:2]];
    }else if ([task.priority isEqual: @""]) {
        [_selectPriorityBtn setTitle:@"Select Priority" forState:UIControlStateNormal];
        [_selectPriorityBtn setTitleColor: [UIColor whiteColor] forState: UIControlStateNormal];
        _selectPriorityBtn.backgroundColor = [UIColor darkGrayColor];
        _priorityImg.image = NULL;
    }
    NSDateFormatter* df = [NSDateFormatter new];
    [df setFormatterBehavior:NSDateFormatterBehavior10_4];
    [df setTimeStyle:NSDateFormatterShortStyle];
    [df setDateStyle:NSDateFormatterShortStyle];
    [_datPicker setDate:[df dateFromString:task.date]];
    if ([task.reminder isEqualToString:@"yes"]) {
        hasReminder = YES;
        [_switchState setOn:YES];
    }else{
        hasReminder = NO;
    }
    task.inProgress = @"no";
    task.done = @"no";
    task.attachedFile = @"";
}

/*==============================================*/
#pragma mark - Functions For Check State
-(void) intializeFromAddBtn {
    _editView.hidden = YES;
    todoState = @"";
}

-(void) intializeFromTodoListCell {
    _editView.hidden = NO;
    [self showDataOfTodo];
    if ([task.inProgress isEqualToString:@"yes"] || [task.done isEqualToString:@"yes"]) {
        _editBtn.hidden = YES;
    }
    todoState = @"";
}
@end
