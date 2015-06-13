//
//  ZHBInputViewFormCell.h
//  ZHBInputFormTableView
//
//  Created by zhb on 15/6/12.
//  Copyright (c) 2015年 zhb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHBInputFormCellFramesModel.h"

@interface ZHBInputViewFormCell : UITableViewCell

@property (nonatomic,strong) UILabel *titleLabel;

@property (nonatomic,strong) UILabel *starLabel;

@property (nonatomic,strong) UITextView *inputTextView;

@property (nonatomic,strong) UITextField *inputTextField;

@property (nonatomic,strong) UILabel *noticeLabel;

@property (nonatomic,strong) UILabel *placeHolderLabel;

@property (nonatomic,strong) ZHBInputFormCellFramesModel *cellFrame;

@property (nonatomic,weak) UITableView *tableView;

@end
