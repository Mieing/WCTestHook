#import <UIKit/UIKit.h>

@class WCTableViewManager, WCTableViewSectionManager, WCTableViewNormalCellManager;

@interface WCTableViewManager : NSObject
- (WCTableViewSectionManager *)getSectionAt:(NSInteger)index;
- (void)reloadTableView;
@end

@interface WCTableViewSectionManager : NSObject
- (void)addCell:(WCTableViewNormalCellManager *)cell;
@end

@interface WCTableViewNormalCellManager : NSObject
+ (instancetype)normalCellForSel:(SEL)sel
                          target:(id)target
                           title:(NSString *)title
                      rightValue:(NSString *)rightValue
                   accessoryType:(int)type;
@end

@interface NewSettingViewController : UIViewController {
    WCTableViewManager *m_tableViewMgr;
    WCTableViewNormalCellManager *_pluginCellInfo;
}

@property(nonatomic, weak) WCTableViewNormalCellManager *pluginCellInfo;
- (void)viewDidAppear:(BOOL)animated;

@end