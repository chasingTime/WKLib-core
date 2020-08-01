//
//  BasedUsingTabBarVC.m
//  AxcAE_TabBar
//
//  Created by Axc on 2018/6/2.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "BasedUsingTabBarVC.h"

@interface BasedUsingTabBarVC ()<AxcAE_TabBarDelegate>

@end

@implementation BasedUsingTabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)addChildViewControllers:(NSArray*) VCArray
{
    
    // 1.遍历这个集合
    // 1.1 设置一个保存构造器的数组
    NSMutableArray *tabBarConfs = @[].mutableCopy;
    // 1.2 设置一个保存VC的数组
    NSMutableArray *tabBarVCs = @[].mutableCopy;
    /*
      * enumerateObjectsUsingBlock是一种循环的方法
      * ObjectType obj：这里声明数组里面你放入的是什么类型的东西，不确定的话就直接id类型最靠谱。
      * NSUInteger idx:数组的下标
      * BOOL *stop：这是一个bool值，决定是否继续循环。如果有NO,继续循环下去。如果为YES ,停止循环
      */
    [VCArray enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        // 2.根据集合来创建TabBar构造器
        AxcAE_TabBarConfigModel* model = [AxcAE_TabBarConfigModel new];
        
        // 3.item基础数据三连
        
        model.itemTitle = [obj objectForKey:@"itemTitle"]; //标题
        [self setNormalTintColor:[obj objectForKey:@"normalTitleColor"] withModel:model];//设置正常时标题颜色
        [self setSelectTitleColor:[obj objectForKey:@"selectTitleColor"] withModel:model];// 4.设置单个选中item标题状态下的颜色,默认为橙色
        
        model.selectImageName = [obj objectForKey:@"selectImg"];//选中时图片
        model.normalImageName = [obj objectForKey:@"normalImg"];//正常时图片
        
        //设置单个选中item背影颜色
        model.selectBackgroundColor=[obj objectForKey:@"selectBackground"];
        
       
        
        // 备注 如果一步设置的VC的背景颜色，VC就会提前绘制驻留，优化这方面的话最好不要这么写
        // 示例中为了方便就在这写了
        UIViewController *vc = [obj objectForKey:@"vc"];
        vc.view.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.f
                                                  green:arc4random()%255/255.f
                                                   blue:arc4random()%255/255.f alpha:1];
        // 5.将VC添加到系统控制组
        [tabBarVCs addObject:vc];
        // 5.1添加构造Model到集合
        [tabBarConfs addObject:model];
    }];
    // 5.2 设置VCs -----
    // 一定要先设置这一步，然后再进行后边的顺序，因为系统只有在setViewControllers函数后才不会再次创建UIBarButtonItem，以免造成遮挡
    // 大意就是一定要让自定义TabBar遮挡住系统的TabBar
    self.viewControllers = tabBarVCs;
    //////////////////////////////////////////////////////////////////////////
    // 注：这里方便阅读就将AE_TabBar放在这里实例化了 使用懒加载也行
    // 6.将自定义的覆盖到原来的tabBar上面
    // 这里有两种实例化方案：
    // 6.1 使用重载构造函数方式：
//    self.axcTabBar = [[AxcAE_TabBar alloc] initWithTabBarConfig:tabBarConfs];
    // 6.2 使用Set方式：
    self.axcTabBar = [AxcAE_TabBar new] ;
    self.axcTabBar.tabBarConfig = tabBarConfs;
    // 7.设置委托
    self.axcTabBar.delegate = self;
    // 8.添加覆盖到上边
    [self.tabBar addSubview:self.axcTabBar];
    [self addLayoutTabBar]; // 10.添加适配
}

// 9.实现代理，如下：
- (void)axcAE_TabBar:(AxcAE_TabBar *)tabbar selectIndex:(NSInteger)index{
    // 通知 切换视图控制器
    [self setSelectedIndex:index];
    // 自定义的AE_TabBar回调点击事件给TabBarVC，TabBarVC用父类的TabBarController函数完成切换
}
- (void)setSelectedIndex:(NSUInteger)selectedIndex{
    [super setSelectedIndex:selectedIndex];
    if(self.axcTabBar){
        self.axcTabBar.selectIndex = selectedIndex;
    }
}

// 10.添加适配
- (void)addLayoutTabBar{
    // 使用重载viewDidLayoutSubviews实时计算坐标 （下边的 -viewDidLayoutSubviews 函数）
    // 能兼容转屏时的自动布局
}
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.axcTabBar.frame = self.tabBar.bounds;
    [self.axcTabBar viewDidLayoutItems];
}
-(void)setTabbarBackgImage:(NSString*) backgroundImage
{
    self.axcTabBar.backgroundImageView.image = [UIImage imageNamed:backgroundImage];
}
//设置单个item选中时标题颜色
-(void)setSelectTitleColor:(UIColor*)color withModel:(AxcAE_TabBarConfigModel*) model
{
  
    if(color == nil)
    {
        color = [UIColor orangeColor];
    }
    model.selectColor = color;
}
-(void)setNormalTintColor:(UIColor*)color withModel:(AxcAE_TabBarConfigModel*) model
{
    if(color !=nil)
    {
     model.normalColor = color;
    }
    
}
@end
