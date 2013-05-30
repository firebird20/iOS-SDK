//
//  PayoneImagePicker.h
//  Payone App
//
//  Created by Rainer Grinninger on 14.11.12.
//
//

#import <Foundation/Foundation.h>

@interface PayoneImagePicker : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>


@property (nonatomic, retain) UIViewController* viewController;
//@property (nonatomic, assign) id delegate;
//- (id) initWithDelegate: (id) delegate;
-(void) showModalViewForViewController:(UIViewController*) viewController;


@end
