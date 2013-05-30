//
//  PayoneImagePicker.m
//  Payone App
//
//  Created by Rainer Grinninger on 14.11.12.
//
//

#import "PayoneImagePicker.h"
#import "PayoneCustomUISettingsManager.h"


@interface PayoneImagePicker (private)

-(void) hide;

@end

@implementation PayoneImagePicker


-(void) dealloc
{
    self.viewController = nil;
    [super dealloc];
}

-(void) showModalViewForViewController:(UIViewController*) viewController
{
    self.viewController = viewController;
    UIImagePickerController* imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [viewController presentViewController:imagePicker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage* image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [[PayoneCustomUISettingsManager sharedInstance] setImage:image withPath:[info objectForKey:UIImagePickerControllerReferenceURL]];
    [self hide];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self hide];
}

-(void) hide
{
    [self.viewController dismissViewControllerAnimated:YES completion:nil];
    // deactivate button in settings
    [[PayoneCustomUISettingsManager sharedInstance] switchOffUserDefaultsButton];
}

@end
