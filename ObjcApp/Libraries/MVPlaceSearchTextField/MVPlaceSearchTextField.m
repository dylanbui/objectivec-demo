//
//  MVPlaceSearchTextField.m
//  PlaceSearchAPIDEMO
//
//  Created by Mrugrajsinh Vansadia on 26/04/14.
//  Copyright (c) 2014 Mrugrajsinh Vansadia. All rights reserved.
//

#import "MVPlaceSearchTextField.h"
//#import "Macro.h"
#import "PlaceDetail.h"
#import "PlaceObject.h"
#import "MLPAutoCompleteTextField.h"


@interface MVPlaceSearchTextField ()<MLPAutoCompleteFetchOperationDelegate,MLPAutoCompleteSortOperationDelegate,MLPAutoCompleteTextFieldDataSource,MLPAutoCompleteTextFieldDelegate,PlaceDetailDelegate>{
    GMSPlacesClient *_placesClient;
}

@end


@implementation MVPlaceSearchTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
*/



-(void)awakeFromNib{
    [super awakeFromNib];
    self.autoCompleteDataSource=self;
    self.autoCompleteDelegate=self;
    self.autoCompleteFontSize=14;
    self.autoCompleteTableBorderWidth=0.0;
    self.showTextFieldDropShadowWhenAutoCompleteTableIsOpen=NO;
    self.autoCompleteShouldHideOnSelection=YES;
    self.maximumNumberOfAutoCompleteRows= 100;
    self.autoCompleteShouldHideClosingKeyboard = YES;
    _placesClient = [GMSPlacesClient sharedClient];
    
}
#pragma mark - Datasource Autocomplete
//example of asynchronous fetch:
- (void)autoCompleteTextField:(MLPAutoCompleteTextField *)textField
 possibleCompletionsForString:(NSString *)string
            completionHandler:(void (^)(NSArray *))handler
{
        NSString *aQuery=textField.text;
        [NSObject cancelPreviousPerformRequestsWithTarget:_placesClient selector:@selector(autocompleteQuery:bounds:filter:callback:) object:self];
    
        if(aQuery.length>0){
            GMSAutocompleteFilter *filter = [[GMSAutocompleteFilter alloc] init];
//            filter.type = kGMSPlacesAutocompleteTypeFilterNoFilter;
            filter.type = kGMSPlacesAutocompleteTypeFilterAddress;
            filter.country = @"VN";
            
            [_placesClient autocompleteQuery:aQuery
                                      bounds:nil
                                      filter:filter
                                    callback:^(NSArray *results, NSError *error) {
                                        if (error != nil) {
                                            NSLog(@"Autocomplete error %@", [error localizedDescription]);
                                            handler(nil);
                                            return;
                                        }
                                        if(results.count>0){
                                        NSMutableArray *arrfinal=[NSMutableArray array];
                                        for (GMSAutocompletePrediction* result in results) {
                                            NSDictionary *aTempDict =  [NSDictionary dictionaryWithObjectsAndKeys:result.attributedFullText.string,@"description",result.placeID,@"reference", nil];
                                            PlaceObject *placeObj=[[PlaceObject alloc]initWithPlaceName:[aTempDict objectForKey:@"description"]];
                                            placeObj.userInfo=aTempDict;
                                            [arrfinal addObject:placeObj];

                                        }
                                            handler(arrfinal);
                                        }else{
                                            handler(nil);
                                        }
                                    }];
        }else{
            handler(nil);
        }
}


#pragma mark - AutoComplete Delegates
-(void)autoCompleteTextField:(MLPAutoCompleteTextField *)textField didSelectAutoCompleteString:(NSString *)selectedString withAutoCompleteObject:(id<MLPAutoCompletionObject>)selectedObject forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PlaceObject *placeObj=(PlaceObject*)selectedObject;
    NSString *aStrPlaceReferance=[placeObj.userInfo objectForKey:@"reference"];
    PlaceDetail *placeDetail=[[PlaceDetail alloc]initWithApiKey:_strApiKey];
    placeDetail.delegate=self;
    [placeDetail getPlaceDetailForReferance:aStrPlaceReferance];
    
}
-(BOOL)autoCompleteTextField:(MLPAutoCompleteTextField *)textField
         shouldConfigureCell:(UITableViewCell *)cell
      withAutoCompleteString:(NSString *)autocompleteString
        withAttributedString:(NSAttributedString *)boldedString
       forAutoCompleteObject:(id<MLPAutoCompletionObject>)autocompleteObject
           forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"autocompleteString = %@", autocompleteString);
    if([_placeSearchDelegate respondsToSelector:@selector(placeSearch:ResultCell:withPlaceObject:atIndex:)]){
        return [_placeSearchDelegate placeSearch:self ResultCell:cell withPlaceObject:autocompleteObject atIndex:indexPath.row];
    }else{
        cell.contentView.backgroundColor=[UIColor whiteColor];
    }
    return YES;
}

-(void)autoCompleteTextField:(MLPAutoCompleteTextField *)textField willShowAutoCompleteTableView:(UITableView *)autoCompleteTableView{
    if([_placeSearchDelegate respondsToSelector:@selector(placeSearchWillShowResult:)]){
        [_placeSearchDelegate placeSearchWillShowResult:self];
    }
}
-(void)autoCompleteTextField:(MLPAutoCompleteTextField *)textField willHideAutoCompleteTableView:(UITableView *)autoCompleteTableView{
    if([_placeSearchDelegate respondsToSelector:@selector(placeSearchWillHideResult:)]){
        [_placeSearchDelegate placeSearchWillHideResult:self];
    }
}


#pragma mark - PlaceDetail Delegate

-(void)placeDetailForReferance:(NSString *)referance didFinishWithResult:(GMSPlace*)resultDict{
        //Respond To Delegate
    [_placeSearchDelegate placeSearch:self ResponseForSelectedPlace:resultDict];
}


#pragma mark - URL Operation
- (NSDictionary *)stringWithUrl:(NSURL *)url
{
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url
                                                cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                            timeoutInterval:30];
    // Fetch the JSON response
    NSData *urlData;
    NSURLResponse *response;
    NSError *error;
    
    // Make synchronous request
//    urlData = [NSURLConnection sendSynchronousRequest:urlRequest
//                                    returningResponse:&response
//                                                error:&error];
    urlData = [self sendSynchronousRequest:urlRequest               
                         returningResponse:&response
                                     error:&error];
    
    if(urlData){
        // Construct a Dictionary around the Data from the response
        NSDictionary *aDict=[NSJSONSerialization JSONObjectWithData:urlData options:NSJSONReadingAllowFragments error:&error];
        return aDict;
    }else{return nil;}
    
}

- (NSData *)sendSynchronousRequest:(NSURLRequest *)request
                 returningResponse:(NSURLResponse **)response
                             error:(NSError **)error
{
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter(group);
    
    
    NSError __block *err = NULL;
    NSData __block *data;
    NSURLResponse __block *resp;
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request
                                     completionHandler:^(NSData* _data, NSURLResponse* _response, NSError* _error) {
                                         resp = _response;
                                         err = _error;
                                         data = _data;
                                         dispatch_group_leave(group);
                                         
                                     }] resume];
    
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    
    if (response)
    {
        *response = resp;
    }
    if (error)
    {
        *error = err;
    }
    
    return data;
}


@end