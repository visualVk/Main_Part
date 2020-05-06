//
//  RequestUtils.m
//  ReactiveCocoaTest
//
//  Created by blacksky on 2020/1/28.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "RequestUtils.h"
#import "DictUtils.h"
@implementation RequestUtils
+ (instancetype)shareManager {
  static dispatch_once_t onceToken;
  static RequestUtils *utils = nil;
  dispatch_once(&onceToken, ^{
    utils = [[RequestUtils alloc] initWithBaseURL:[NSURL URLWithString:MAINDOMAIN]];
    NSString *bearer = [[NSUserDefaults standardUserDefaults] valueForKey:@"Bearer"];
    if (bearer == nil || bearer.length == 0 || [bearer isEqualToString:@""]) {
      //      [NSThread sleepForTimeInterval:1.5];
    }
  });
  return utils;
}

- (void)reloadBearer:(NSString *)bearer {
  //  NSString *bearer = [[NSUserDefaults standardUserDefaults] valueForKey:@"Bearer"];
  [self.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@", bearer]
                forHTTPHeaderField:@"Authorization"];
  [self.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@", bearer]
                forHTTPHeaderField:@"akt"];
}

- (NSString *)urlConCatWithApi:(NSString *)apiUrl {
  return [NSString stringWithFormat:@"%@%@", [RequestUtils shareManager].baseURL, apiUrl];
}

- (instancetype)initWithBaseURL:(NSURL *)url {
  self = [super initWithBaseURL:url];
  if (self) {
    self.requestSerializer.timeoutInterval = 3;
    self.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    //    self.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    self.requestSerializer = [AFJSONRequestSerializer serializer];
    AFJSONResponseSerializer *response = [AFJSONResponseSerializer serializer];
    response.removesKeysWithNullValues = YES;
    self.responseSerializer = response;
    [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [self.responseSerializer
     setAcceptableContentTypes:[NSSet setWithObjects:@"text/plain", @"application/json",
                                @"text/json", @"text/javascript",
                                @"text/html", nil]];
  }
  return self;
}

#pragma mark - get with dictionary query
/// <#Description#>
/// @param urlStr <#urlStr description#>
/// @param params <#params description#>
/// @param success <#success description#>
/// @param failure <#failure description#>
- (void)RequestGetWithUrl:(NSString *)urlStr
                Parameter:(NSDictionary *)params
                  Success:(SuccessBlock)success
                  Failure:(FailureBlock)failure {
  urlStr = [self urlConCatWithApi:urlStr];
  [[RequestUtils shareManager] GET:urlStr
                        parameters:params
                          progress:nil
                           success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
    success(responseObject);
  }
                           failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) { failure(error); }];
}

#pragma mark - get with object query
/// <#Description#>
/// @param urlStr <#urlStr description#>
/// @param object <#object description#>
/// @param success <#success description#>
/// @param failure <#failure description#>
- (void)RequestGetWithUrl:(NSString *)urlStr
                   Object:(__autoreleasing id)object
                  Success:(SuccessBlock)success
                  Failure:(FailureBlock)failure {
  urlStr = [self urlConCatWithApi:urlStr];
  [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
  NSDictionary *dict = [DictUtils Object2Dict:object];
  [self GET:urlStr
 parameters:dict
   progress:nil
    success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
    success(responseObject);
  }
    failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
    NSLog(@"request utils error------{%@}", [error description]);
    failure(error);
  }];
}

#pragma mark - post with www-form-urlencoded
/// post with www-form-urlencoded
/// @param urlStr api
/// @param params dictionary paramaters
/// @param success success block
/// @param failure failure block
- (void)RequestPostWithUrl:(NSString *)urlStr
                 Parameter:(NSDictionary *)params
                   Success:(SuccessBlock)success
                   Failure:(FailureBlock)failure {
  urlStr = [self urlConCatWithApi:urlStr];
  [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
  NSData *body = [NSKeyedArchiver archivedDataWithRootObject:params];
  NSLog(@"dict:{%@}", [params description]);
  [[RequestUtils shareManager] POST:urlStr
                         parameters:params
                           progress:nil
                            success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
    success(responseObject);
  }
                            failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
    NSLog(@"request utils error------{%@,token:%@}", [error description],
          [self.requestSerializer.HTTPRequestHeaders description]);
    failure(error);
  }];
}

- (void)RequestPostWithUrl:(NSString *)urlStr
                    Object:(_Nullable id)object
                   Success:(SuccessBlock)success
                   Failure:(FailureBlock)failure {
  urlStr = [self urlConCatWithApi:urlStr];
  NSDictionary *dict = [DictUtils Object2Dict:object];
  [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
  [[RequestUtils shareManager] POST:urlStr
                         parameters:dict
                           progress:nil
                            success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
    success(responseObject);
  }
                            failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
    NSLog(@"request utils error------{%@}", [error description]);
    failure(error);
  }];
}

- (void)RequestPostJSONWithUrl:(NSString *)urlStr
                        Object:(_Nullable id)object
                       Success:(SuccessBlock)success
                       Failure:(FailureBlock)failure {
}
#pragma mark - post binary with application/octet-stream
/// post binary file with application/octet-stream
/// @param urlStr api
/// @param binaryData binary data
/// @param success success block
/// @param failure failure block
- (void)RequestPostBinaryWithUrl:(NSString *)urlStr
                       Parameter:(NSData *)binaryData
                         Success:(SuccessBlock)success
                         Failure:(FailureBlock)failure {
  urlStr = [self urlConCatWithApi:urlStr];
  [self.requestSerializer setValue:@"application/octet-stream" forHTTPHeaderField:@"Content-Type"];
  [self POST:urlStr
  parameters:@{
    @"binary" : binaryData
  }
    progress:nil
     success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
    success(responseObject);
  }
     failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
    NSLog(@"request utils error------{%@}", [error description]);
    failure(error);
  }];
}
#pragma mark - delete
- (void)RequestDeleteWithUrl:(NSString *)urlStr
                      Object:(id)object
                     Success:(SuccessBlock)success
                     Failure:(FailureBlock)failure {
  urlStr = [self urlConCatWithApi:urlStr];
}

#pragma mark - put
- (void)RequestPutWithUrl:(NSString *)urlStr
                   Object:(id)object
                  Success:(SuccessBlock)success
                  Failure:(FailureBlock)failure {
  urlStr = [self urlConCatWithApi:urlStr];
}

- (void)RequestPostWithURLManage:(NSString *)urlStr
                          Params:(NSDictionary *)params
                         Success:(SuccessBlock)success
                         Failure:(FailureBlock)failure {
  
  //  urlStr = [self urlConCatWithApi:urlStr];
  //  AFURLSessionManager *manager = [[AFURLSessionManager alloc]
  //                                  initWithSessionConfiguration:[NSURLSessionConfiguration
  //                                  defaultSessionConfiguration]];
  //  NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST"
  //                                                                               URLString:urlStr
  //                                                                              parameters:nil
  //                                                                                   error:nil];
  //  [request setHTTPBody:[NSJSONSerialization dataWithJSONObject:params
  //                                                       options:NSUTF8StringEncoding
  //                                                         error:nil]];
  //  AFHTTPResponseSerializer *response = [AFHTTPResponseSerializer serializer];
  //  response.acceptableContentTypes =
  //  [NSSet setWithObject:[NSSet setWithObjects:@"text/plain", @"application/json", @"text/json",
  //                        @"text/javascript", @"text/html", nil]];
  //  manager.responseSerializer = response;
  //  request.timeoutInterval = 10;
  //  [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
  //  [request setValue:[NSString stringWithFormat:@"Bearer %@", [[NSUserDefaults
  //  standardUserDefaults]
  //                                                              valueForKey:@"Bearer"]]
  // forHTTPHeaderField:@"Authorization"];
  //
  //  [[manager dataTaskWithRequest:request
  //                 uploadProgress:nil
  //               downloadProgress:nil
  //              completionHandler:^(NSURLResponse *_Nonnull response, id _Nullable responseObject,
  //                                  NSError *_Nullable error) {
  //    success([NSJSONSerialization JSONObjectWithData:responseObject
  //                                            options:NSJSONReadingMutableLeaves
  //                                              error:nil]);
  //  }] resume];
  NSError *writeError = nil;
  
  NSData *jsonData = [NSJSONSerialization dataWithJSONObject:params
                                                     options:NSJSONWritingPrettyPrinted
                                                       error:&writeError];
  NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
  
  urlStr = [self urlConCatWithApi:urlStr];
  NSMutableURLRequest *request =
  [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]
                          cachePolicy:NSURLRequestReloadIgnoringCacheData
                      timeoutInterval:120];
  
  [request setHTTPMethod:@"POST"];
  NSString *bear = [[NSUserDefaults standardUserDefaults] valueForKey:@"Bearer"];
  [request setValue:[NSString stringWithFormat:@"Bearer %@", bear] forHTTPHeaderField:@"akt"];
  [request setValue:@"application/json; encoding=utf-8" forHTTPHeaderField:@"Content-Type"];
  [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
  [request setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
  
  AFURLSessionManager *manager = [[AFURLSessionManager alloc]
                                  initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
  
  [[manager dataTaskWithRequest:request
                 uploadProgress:nil
               downloadProgress:nil
              completionHandler:^(NSURLResponse *_Nonnull response, id _Nullable responseObject,
                                  NSError *_Nullable error) {
    
    if (!error) {
      NSLog(@"Reply JSON: %@", responseObject);
      
      if ([responseObject isKindOfClass:[NSDictionary class]]) {
        // blah blah
        success(responseObject);
      }
    } else {
      
      NSLog(@"Error: %@", error);
      NSLog(@"Response: %@", response);
      NSLog(@"Response Object: %@", responseObject);
    }
  }] resume];
}
@end
