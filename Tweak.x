#import <UIKit/UIKit.h>
#import "NewSettingViewController.h"

%hook NewSettingViewController

- (void)viewDidAppear:(BOOL)animated {
    %orig;

    static char kWCTESTAddedKey;
    if (objc_getAssociatedObject(self, &kWCTESTAddedKey)) return;

    Ivar ivar = class_getInstanceVariable([self class], "m_tableViewMgr");
    if (!ivar) ivar = class_getInstanceVariable([self class], "_tableViewMgr");
    if (!ivar) ivar = class_getInstanceVariable([self class], "m_tableMgr");
    if (!ivar) ivar = class_getInstanceVariable([self class], "_tableMgr");
    if (!ivar) return;

    WCTableViewManager *mgr = object_getIvar(self, ivar);
    if (!mgr) return;

    WCTableViewSectionManager *section = [mgr getSectionAt:0];
    if (!section) return;

    WCTableViewNormalCellManager *cell =
        [objc_getClass("WCTableViewNormalCellManager")
            normalCellForSel:@selector(ontestCellClick)
                    target:self
                    title:@"WCTest"
                    rightValue:nil
                    accessoryType:1];
    [section addCell:cell];
    [mgr reloadTableView];

    objc_setAssociatedObject(self, &kWCTESTAddedKey, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

%new
- (void)ontestCellClick {
    NSLog(@"WCTEST clicked!");
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Test"
                                                                   message:@"你点击了单元格！"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

%end