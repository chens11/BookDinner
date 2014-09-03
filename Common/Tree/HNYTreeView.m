//
//  HNYTreeView.m
//  HBSmartCity
//
//  Created by chenzq on 6/10/14.
//  Copyright (c) 2014 cndatacom. All rights reserved.
//

#import "HNYTreeView.h"

@interface HNYTreeView ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) NSMutableArray *list;

@end

@implementation HNYTreeView
@synthesize originalList = _originalList;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.singleChoice = YES;
        self.showCheckMark = NO;
        self.treeCellClassName = @"HNYTreeCell";
        
        self.table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width,self.frame.size.height) style:UITableViewStylePlain];
        self.table.delegate = self;
        self.table.dataSource = self;
        self.table.backgroundColor = [UIColor clearColor];
        [self addSubview:self.table];
        
        // Initialization code
    }
    return self;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */
- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect frame = self.frame;
    self.table.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
}



#pragma mark - ini subView 
- (void)createTreeTable{
}
#pragma mark - UITableViewDataSource,UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.list.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(treeView:heightForRowAtIndexPath:)]) {
        return [self.delegate treeView:self heightForRowAtIndexPath:indexPath];
    }
    return 44.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentify = @"HNYTreeCell";
    HNYTreeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        if ([self.delegate respondsToSelector:@selector(treeView:cellForRowAtIndexPath:withReuseIdentifier:)])
            cell = [self.delegate treeView:self cellForRowAtIndexPath:indexPath withReuseIdentifier:cellIdentify];
        else
            cell = [[HNYTreeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
    }
    [cell iniDataWithModel:[self getOriginalModelWithIndexPath:indexPath]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HNYTreeModel *model = [self.list objectAtIndex:indexPath.row];
    //是否有子节点
    if ([model hasSons]) {
        HNYTreeCell *cell = (HNYTreeCell*)[tableView cellForRowAtIndexPath:indexPath];
        NSArray *sons = [model sons];

        //已展开 收起子节点
        if ([cell expanded]) {
            [self.list removeObjectsInArray:sons];
            [tableView reloadData];
        }
        //为展开
        else{
            //如果sons为0 请求数据
            if (sons.count == 0) {
                
            }else{
                int index = [self.list indexOfObject:model];
                for (NSObject *object in sons) {
                    int offset = [sons indexOfObject:object];
                    [self.list insertObject:object atIndex:index + offset];
                }
                [tableView reloadData];
            }
 
        }
        
    }
    else{
        [self.delegate treeView:self didSelectRowAtIndexPath:indexPath];
    }
}

#pragma mark - instance fun
- (void)setOriginalList:(NSArray *)originalList{
    _originalList = originalList;
    self.list = [originalList mutableCopy];
    [self.table reloadData];
}

- (void)reloadData{
    [self.table reloadData];
}

- (HNYTreeModel *)getOriginalModelWithIndexPath:(NSIndexPath *)indexPath{
   return [self.list objectAtIndex:indexPath.row];
}
@end
