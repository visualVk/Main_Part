//
//  DomainDefine.h
//  ReactiveCocoaTest
//
//  Created by blacksky on 2020/1/28.
//  Copyright © 2020 blacksky. All rights reserved.
//

#ifndef DomainDefine_h
#define DomainDefine_h
#import <UIKit/UIKit.h>
#define MAINDOMAIN @"http://120.26.235.201:8799"
#define UserLogin @"/api/user/login/pas"
#define UserRegister @"/api/register/userinsert"
#define FindAllHotel @"/api/hotel/findhotel"
#define FindRoomByHotelId @"/api/hotel/findroombyhotelid"
#define FindAppreaiseByHotelId @"/api/hotel/findAllappreaise"
#define FindDiscussByHotelId @"/api/hotel/selectAllDiscuss"
#define PostDiscuss @"/api/hotel/disscuss"
#define PostPay @"/api/hotel/bookroom"
//#define Bearer                                                                                     \
//@"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9."                                                         \
//@"eyJhdWQiOlsicmVzMSJdLCJleHAiOjE1ODQzNzU2NDgsInVzZXJfbmFtZSI6IntcImlkXCI6XCIyNVwiLFwibG9naW5j"  \
//@"b2RlXCI6XCJhNDYzODA2MDE3XCIsXCJwYXNzd29yZFwiOlwiJDJhJDEwJC4vQXZDbmdyUXVWTW9iOWJCcVFxN3Vzczdt"  \
//@"QmhFV3d2ak1zTzFEZEN5UWlRWC5xMlBSZGIyXCIsXCJ1c2VybmFtZVwiOlwiMTIzNDU2XCJ9IiwianRpIjoiMjUzMDlj"  \
//@"YTAtNzI2YS00M2FhLWI1MjQtOGUyNThhZDBlMGIwIiwiY2xpZW50X2lkIjoiYzEiLCJzY29wZSI6WyJST0xFX0FETUlO"  \
//@"IiwiUk9MRV9VU0VSIiwiUk9MRV9BUEkiXX0.JDs92u9XAUQvl1ILbsAGfKeVe4JaM2xjwzuTfkcYjRg"

static NSString *Bearer = @"";
static NSInteger imageIndex = 0;

#endif /* DomainDefine_h */
