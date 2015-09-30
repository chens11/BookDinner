//
//  HNYTableView.m
//  VillageEducation
//
//  Created by chenzq on 4/24/14.
//  Copyright (c) 2014 hubei. All rights reserved.
//

#import "HNYTableView.h"
#import "HNYTableViewCell.h"

@interface HNYTableView()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation HNYTableView
- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
    }
    return self;
}
#pragma mark - UITableViewDataSource,UITableViewDelegate
- (NSInteger)numberOfSections{
    return 1;
}

- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentify = @"HNYTableViewCell";
    HNYTableViewCell *cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[HNYTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
    }
    NSDictionary *dictionary = [self.list objectAtIndex:indexPath.row];
    cell.textLabel.text = [dictionary objectForKey:self.nameKey];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.cutDelegate respondsToSelector:@selector(hnyTableView:didSelectRowAtIndexPath:)])
        [self.cutDelegate hnyTableView:self didSelectRowAtIndexPath:indexPath];
}

@end
