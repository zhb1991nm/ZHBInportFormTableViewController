//
//  ZHBInputFormTableViewController.h
//  ZHBInputFormTableView
//
//  Created by zhb on 15/6/12.
//  Copyright (c) 2015年 zhb. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ZHBInputViewFormCell.h"
#import "ZHBInputFormCellModel.h"
#import "ZHBInputFormCellFramesModel.h"

typedef void(^ClickFormButtonBlock)(NSInteger buttonIndex);

typedef NSInteger (^NumberOfSection) (UITableView *tableView);

typedef NSInteger (^NumberOfRows)(UITableView *tableView,NSInteger section);

typedef CGFloat (^HeightForRow)(UITableView *tableView,NSIndexPath *indexPath);

typedef ZHBInputFormCellFramesModel* (^CellFrameForRow)(UITableView *tableView,NSIndexPath *indexPath);

@interface ZHBInputFormTableViewController : UITableViewController

@property (nonatomic,copy) ClickFormButtonBlock clickFormButtonBlock;

@property (nonatomic,copy) NumberOfSection numberOfSectionBlock;

@property (nonatomic,copy) NumberOfRows numberOfRowsBlock;

@property (nonatomic,copy) HeightForRow heightForRowBlock;

@property (nonatomic,copy) CellFrameForRow cellFrameForRowBlock;

@property (nonatomic,strong,readonly) NSDictionary *commitParamDictionary;//生成提交字典

@property (nonatomic,strong) NSArray *inputCellFrameArray;

@property (nonatomic,assign) BOOL getRequest;

@property (nonatomic,copy) NSString *getUrl;

@property (nonatomic,copy) NSString *postUrl;

-(instancetype)initWithCommitButtonTitle:(NSString *)commitButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...;

-(instancetype)initWithDefaultTypeCommitButtonTitle:(NSString *)commitButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...;

-(BOOL)checkRequired;//YES 验证通过 NO 有未填项目

-(void)clearAllInputView;

@end
