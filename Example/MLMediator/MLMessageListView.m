//
//  MLMessageListView.m
//  MLMediator_Example
//
//  Created by 林志武 on 2019/7/5.
//  Copyright © 2019 linzhiwu. All rights reserved.
//

#import "MLMessageListView.h"
#import "MLMessageCell.h"

@interface MLMessageListView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *messages;

@end

@implementation MLMessageListView

#pragma mark - 生命周期

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
//        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.45];
        
        [self addSubview:self.tableView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.tableView.frame = self.bounds;
}

#pragma mark - 数据源、代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.messages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MLMessageCell *messageCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MLMessageCell class]) forIndexPath:indexPath];
    messageCell.message = self.messages[indexPath.row];
    
    return messageCell;
}

#pragma mark - 公共方法

- (void)addMessage:(NSString *)message {
    [self.messages addObject:message];
    [self.tableView reloadData];
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.messages.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:YES];
}

#pragma mark - getter

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 30;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.backgroundColor = [UIColor clearColor];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MLMessageCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([MLMessageCell class])];
    }
    return _tableView;
}

- (NSMutableArray *)messages {
    if (_messages == nil) {
        _messages = [NSMutableArray array];
    }
    return _messages;
}

@end
