//
//  ZHBInputFormTableViewController.m
//  ZHBInputFormTableView
//
//  Created by zhb on 15/6/12.
//  Copyright (c) 2015年 zhb. All rights reserved.
//

#import "ZHBInputFormTableViewController.h"
#import "ZHBInputFormConstants.h"
#import "ZHBInputFormAccessoryView.h"
#import "NSString+Utils.h"

@interface ZHBInputFormTableViewController()

@property (nonatomic,strong) UIView *footerView;

@property (nonatomic,strong) NSMutableArray *buttonTitleArray;

@property (nonatomic,strong) NSMutableArray *responsArray;

@end

@implementation ZHBInputFormTableViewController{
    ZHBInputFormAccessoryView *_inputAccessoryView;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        _responsArray = [NSMutableArray array];
        self.buttonTitleArray = [NSMutableArray array];
        self.tableView.allowsSelection = NO;
    }
    return self;
}

-(instancetype)initWithCommitButtonTitle:(NSString *)commitButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...{
    self = [self init];
    if (self) {
        [self.buttonTitleArray addObject:commitButtonTitle];
        va_list params; //定义一个指向个数可变的参数列表指针;
        va_start(params,otherButtonTitles);//va_start 得到第一个可变参数地址,
        id arg;
        if (otherButtonTitles){
            id prev = otherButtonTitles;
            [self.buttonTitleArray addObject:prev];
            while((arg = va_arg(params,id))){
                if (arg){
                    [self.buttonTitleArray addObject:arg];
                }
            }
            va_end(params);
        }
        self.tableView.tableFooterView = self.footerView;
    }
    return self;
}

-(instancetype)initWithDefaultTypeCommitButtonTitle:(NSString *)commitButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...{
    self = [self init];
    if (self) {
        [self.buttonTitleArray addObject:commitButtonTitle];
        va_list params; //定义一个指向个数可变的参数列表指针;
        va_start(params,otherButtonTitles);//va_start 得到第一个可变参数地址,
        id arg;
        if (otherButtonTitles){
            id prev = otherButtonTitles;
            [self.buttonTitleArray addObject:prev];
            while((arg = va_arg(params,id))){
                if (arg){
                    [self.buttonTitleArray addObject:arg];
                }
            }
            va_end(params);
        }
        self.tableView.tableFooterView = self.footerView;
        __weak typeof(self) weakSelf = self;
        self.numberOfSectionBlock = ^NSInteger (UITableView *tableView){
            return 1;
        };
        self.numberOfRowsBlock =^NSInteger (UITableView *tableView,NSInteger section){
            return weakSelf.inputCellFrameArray.count;
        };
        self.heightForRowBlock = ^CGFloat(UITableView *tableView,NSIndexPath *indexPath){
            ZHBInputFormCellFramesModel *cellFrame = weakSelf.inputCellFrameArray[indexPath.row];
            return cellFrame.cellHeight;
        };
        self.cellFrameForRowBlock = ^ZHBInputFormCellFramesModel* (UITableView *tableView,NSIndexPath *indexPath){
            return weakSelf.inputCellFrameArray[indexPath.row];
        };
    }
    return self;
}

#pragma mark - life cycle
-(void)viewDidLoad{
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.heightForRowBlock) {
        return  self.heightForRowBlock(self.tableView,indexPath);
    }else{
        return 44;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.numberOfRowsBlock) {
        return self.numberOfRowsBlock(self.tableView,section);
    }else{
        return 0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.cellFrameForRowBlock) {
        ZHBInputFormCellFramesModel *cellFrame = self.cellFrameForRowBlock(self.tableView,indexPath);
        NSString *identifier = [NSString stringWithFormat:@"%ld-%ld",(long)indexPath.section,(long)indexPath.row];
        ZHBInputViewFormCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[ZHBInputViewFormCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            cell.tableView = self.tableView;
            if (cellFrame.cellModel.longText) {
                [_responsArray addObject:cell.inputTextView];
            }else{
                [_responsArray addObject:cell.inputTextField];
            }
        }
        cell.cellFrame = cellFrame;
        return cell;
    }else{
        return nil;
    }
}

#pragma mark - event response
-(void)formButtonOnClick:(UIButton *)sender{
    if (self.clickFormButtonBlock) {
        self.clickFormButtonBlock(sender.tag);
    }
}

#pragma mark - getter & setter
-(UIView *)footerView{
    if (!_footerView) {
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
        _footerView.backgroundColor = [UIColor clearColor];
        NSInteger index = 0;
        CGFloat originX = ZHBInputFormContentOriginX;
        CGFloat originY = (_footerView.frame.size.height - ZHBInputFormButtonHeight) * 0.5f;
        for (NSString *buttonTitle in self.buttonTitleArray) {
            UIButton *button = [[UIButton alloc] init];
            button.layer.borderColor = [UIColor lightGrayColor].CGColor;
            button.layer.borderWidth = 0.8f;
            button.layer.cornerRadius = 4.0f;
            if (index == 0) {
                button.backgroundColor = UIColorFromRGB(0x418BCA);
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            }else{
                button.backgroundColor = [UIColor whiteColor];
                [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }
            [button setTitle:buttonTitle forState:UIControlStateNormal];
            button.frame = CGRectMake(originX, originY, ZHBInputFormButtonWidth, ZHBInputFormButtonHeight);
            button.tag = index;
            [button addTarget:self action:@selector(formButtonOnClick:) forControlEvents:UIControlEventTouchUpInside];
            [_footerView addSubview:button];
            index ++;
            originX = CGRectGetMaxX(button.frame) + ZHBInputFormButtonMargin;
        }
        
    }
    return _footerView;
}

-(NSDictionary *)commitParamDictionary{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    for (ZHBInputFormCellFramesModel *cellFrame in self.inputCellFrameArray) {
        if (cellFrame.cellModel && cellFrame.cellModel.inputString.trimmedString.length > 0) {
            [dict setObject:cellFrame.cellModel.inputString.trimmedString forKey:cellFrame.cellModel.propertyTag];
        }
    }
    return dict;
}

//-(ZHBInputFormAccessoryView *)inputAccessoryView{
//    if (!_inputAccessoryView) {
//        _inputAccessoryView = [[ZHBInputFormAccessoryView alloc] init];
//    }
//    return _inputAccessoryView;
//}

- (UIView *) inputAccessoryView{
    if (!_inputAccessoryView)
    {
        _inputAccessoryView = [[ZHBInputFormAccessoryView alloc] initWithResponders:_responsArray];
        //_inputAccessoryView = [[XCDFormInputAccessoryView alloc] init];
        //_inputAccessoryView = [[NSClassFromString(@"UIWebFormAccessory") alloc] init];
    }
    return _inputAccessoryView;
}

#pragma mark - public method

-(BOOL)checkRequired{
    NSInteger requiredNotInputCount = 0;
    for (ZHBInputFormCellFramesModel *cellFrame in self.inputCellFrameArray) {
        if (cellFrame.cellModel.required && (!cellFrame.cellModel.inputString || [@"" isEqualToString:cellFrame.cellModel.inputString.trimmedString])) {
            cellFrame.cellModel.errorString = @"请填写此字段";
            cellFrame.cellModel.error = YES;
            [cellFrame calculateFrames];
            requiredNotInputCount ++;
        }
    }
    [self.tableView reloadData];
    return requiredNotInputCount == 0;
}

-(void)clearAllInputView{
    for (ZHBInputFormCellFramesModel *cellFrame in self.inputCellFrameArray) {
        cellFrame.cellModel.inputString = @"";
        [cellFrame calculateFrames];
    }
    [self.tableView reloadData];
}

@end
