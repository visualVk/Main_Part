//
//	OrderCheckInfo.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "OrderCheckInfo.h"

NSString *const kOrderCheckInfoCheckInfo = @"checkInfo";
NSString *const kOrderCheckInfoDinnerAddress = @"dinnerAddress";
NSString *const kOrderCheckInfoEdDate = @"edDate";
NSString *const kOrderCheckInfoHotelAddress = @"hotelAddress";
NSString *const kOrderCheckInfoHotelId = @"hotelId";
NSString *const kOrderCheckInfoHotelName = @"hotelName";
NSString *const kOrderCheckInfoOrderDate = @"orderDate";
NSString *const kOrderCheckInfoOrderId = @"orderId";
NSString *const kOrderCheckInfoOrderStatus = @"orderStatus";
NSString *const kOrderCheckInfoRoomCombo = @"roomCombo";
NSString *const kOrderCheckInfoRoomPrice = @"roomPrice";
NSString *const kOrderCheckInfoRoomTypeId = @"roomTypeId";
NSString *const kOrderCheckInfoRoomTypeName = @"roomTypeName";
NSString *const kOrderCheckInfoStDate = @"stDate";

@interface OrderCheckInfo ()
@end
@implementation OrderCheckInfo




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(dictionary[kOrderCheckInfoCheckInfo] != nil && [dictionary[kOrderCheckInfoCheckInfo] isKindOfClass:[NSArray class]]){
		NSArray * checkInfoDictionaries = dictionary[kOrderCheckInfoCheckInfo];
		NSMutableArray * checkInfoItems = [NSMutableArray array];
		for(NSDictionary * checkInfoDictionary in checkInfoDictionaries){
			CheckInfo * checkInfoItem = [[CheckInfo alloc] initWithDictionary:checkInfoDictionary];
			[checkInfoItems addObject:checkInfoItem];
		}
		self.checkInfo = checkInfoItems;
	}
	if(![dictionary[kOrderCheckInfoDinnerAddress] isKindOfClass:[NSNull class]]){
		self.dinnerAddress = dictionary[kOrderCheckInfoDinnerAddress];
	}	
	if(![dictionary[kOrderCheckInfoEdDate] isKindOfClass:[NSNull class]]){
		self.edDate = dictionary[kOrderCheckInfoEdDate];
	}	
	if(![dictionary[kOrderCheckInfoHotelAddress] isKindOfClass:[NSNull class]]){
		self.hotelAddress = dictionary[kOrderCheckInfoHotelAddress];
	}	
	if(![dictionary[kOrderCheckInfoHotelId] isKindOfClass:[NSNull class]]){
		self.hotelId = [dictionary[kOrderCheckInfoHotelId] integerValue];
	}

	if(![dictionary[kOrderCheckInfoHotelName] isKindOfClass:[NSNull class]]){
		self.hotelName = dictionary[kOrderCheckInfoHotelName];
	}	
	if(![dictionary[kOrderCheckInfoOrderDate] isKindOfClass:[NSNull class]]){
		self.orderDate = dictionary[kOrderCheckInfoOrderDate];
	}	
	if(![dictionary[kOrderCheckInfoOrderId] isKindOfClass:[NSNull class]]){
		self.orderId = dictionary[kOrderCheckInfoOrderId];
	}	
	if(![dictionary[kOrderCheckInfoOrderStatus] isKindOfClass:[NSNull class]]){
		self.orderStatus = [dictionary[kOrderCheckInfoOrderStatus] integerValue];
	}

	if(![dictionary[kOrderCheckInfoRoomCombo] isKindOfClass:[NSNull class]]){
		self.roomCombo = dictionary[kOrderCheckInfoRoomCombo];
	}	
	if(![dictionary[kOrderCheckInfoRoomPrice] isKindOfClass:[NSNull class]]){
		self.roomPrice = dictionary[kOrderCheckInfoRoomPrice];
	}	
	if(![dictionary[kOrderCheckInfoRoomTypeId] isKindOfClass:[NSNull class]]){
		self.roomTypeId = [dictionary[kOrderCheckInfoRoomTypeId] integerValue];
	}

	if(![dictionary[kOrderCheckInfoRoomTypeName] isKindOfClass:[NSNull class]]){
		self.roomTypeName = dictionary[kOrderCheckInfoRoomTypeName];
	}	
	if(![dictionary[kOrderCheckInfoStDate] isKindOfClass:[NSNull class]]){
		self.stDate = dictionary[kOrderCheckInfoStDate];
	}	
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.checkInfo != nil){
		NSMutableArray * dictionaryElements = [NSMutableArray array];
		for(CheckInfo * checkInfoElement in self.checkInfo){
			[dictionaryElements addObject:[checkInfoElement toDictionary]];
		}
		dictionary[kOrderCheckInfoCheckInfo] = dictionaryElements;
	}
	if(self.dinnerAddress != nil){
		dictionary[kOrderCheckInfoDinnerAddress] = self.dinnerAddress;
	}
	if(self.edDate != nil){
		dictionary[kOrderCheckInfoEdDate] = self.edDate;
	}
	if(self.hotelAddress != nil){
		dictionary[kOrderCheckInfoHotelAddress] = self.hotelAddress;
	}
	dictionary[kOrderCheckInfoHotelId] = @(self.hotelId);
	if(self.hotelName != nil){
		dictionary[kOrderCheckInfoHotelName] = self.hotelName;
	}
	if(self.orderDate != nil){
		dictionary[kOrderCheckInfoOrderDate] = self.orderDate;
	}
	if(self.orderId != nil){
		dictionary[kOrderCheckInfoOrderId] = self.orderId;
	}
	dictionary[kOrderCheckInfoOrderStatus] = @(self.orderStatus);
	if(self.roomCombo != nil){
		dictionary[kOrderCheckInfoRoomCombo] = self.roomCombo;
	}
	if(self.roomPrice != nil){
		dictionary[kOrderCheckInfoRoomPrice] = self.roomPrice;
	}
	dictionary[kOrderCheckInfoRoomTypeId] = @(self.roomTypeId);
	if(self.roomTypeName != nil){
		dictionary[kOrderCheckInfoRoomTypeName] = self.roomTypeName;
	}
	if(self.stDate != nil){
		dictionary[kOrderCheckInfoStDate] = self.stDate;
	}
	return dictionary;

}

/**
 * Implementation of NSCoding encoding method
 */
/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
- (void)encodeWithCoder:(NSCoder *)aCoder
{
	if(self.checkInfo != nil){
		[aCoder encodeObject:self.checkInfo forKey:kOrderCheckInfoCheckInfo];
	}
	if(self.dinnerAddress != nil){
		[aCoder encodeObject:self.dinnerAddress forKey:kOrderCheckInfoDinnerAddress];
	}
	if(self.edDate != nil){
		[aCoder encodeObject:self.edDate forKey:kOrderCheckInfoEdDate];
	}
	if(self.hotelAddress != nil){
		[aCoder encodeObject:self.hotelAddress forKey:kOrderCheckInfoHotelAddress];
	}
	[aCoder encodeObject:@(self.hotelId) forKey:kOrderCheckInfoHotelId];	if(self.hotelName != nil){
		[aCoder encodeObject:self.hotelName forKey:kOrderCheckInfoHotelName];
	}
	if(self.orderDate != nil){
		[aCoder encodeObject:self.orderDate forKey:kOrderCheckInfoOrderDate];
	}
	if(self.orderId != nil){
		[aCoder encodeObject:self.orderId forKey:kOrderCheckInfoOrderId];
	}
	[aCoder encodeObject:@(self.orderStatus) forKey:kOrderCheckInfoOrderStatus];	if(self.roomCombo != nil){
		[aCoder encodeObject:self.roomCombo forKey:kOrderCheckInfoRoomCombo];
	}
	if(self.roomPrice != nil){
		[aCoder encodeObject:self.roomPrice forKey:kOrderCheckInfoRoomPrice];
	}
	[aCoder encodeObject:@(self.roomTypeId) forKey:kOrderCheckInfoRoomTypeId];	if(self.roomTypeName != nil){
		[aCoder encodeObject:self.roomTypeName forKey:kOrderCheckInfoRoomTypeName];
	}
	if(self.stDate != nil){
		[aCoder encodeObject:self.stDate forKey:kOrderCheckInfoStDate];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.checkInfo = [aDecoder decodeObjectForKey:kOrderCheckInfoCheckInfo];
	self.dinnerAddress = [aDecoder decodeObjectForKey:kOrderCheckInfoDinnerAddress];
	self.edDate = [aDecoder decodeObjectForKey:kOrderCheckInfoEdDate];
	self.hotelAddress = [aDecoder decodeObjectForKey:kOrderCheckInfoHotelAddress];
	self.hotelId = [[aDecoder decodeObjectForKey:kOrderCheckInfoHotelId] integerValue];
	self.hotelName = [aDecoder decodeObjectForKey:kOrderCheckInfoHotelName];
	self.orderDate = [aDecoder decodeObjectForKey:kOrderCheckInfoOrderDate];
	self.orderId = [aDecoder decodeObjectForKey:kOrderCheckInfoOrderId];
	self.orderStatus = [[aDecoder decodeObjectForKey:kOrderCheckInfoOrderStatus] integerValue];
	self.roomCombo = [aDecoder decodeObjectForKey:kOrderCheckInfoRoomCombo];
	self.roomPrice = [aDecoder decodeObjectForKey:kOrderCheckInfoRoomPrice];
	self.roomTypeId = [[aDecoder decodeObjectForKey:kOrderCheckInfoRoomTypeId] integerValue];
	self.roomTypeName = [aDecoder decodeObjectForKey:kOrderCheckInfoRoomTypeName];
	self.stDate = [aDecoder decodeObjectForKey:kOrderCheckInfoStDate];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	OrderCheckInfo *copy = [OrderCheckInfo new];

	copy.checkInfo = [self.checkInfo copy];
	copy.dinnerAddress = [self.dinnerAddress copy];
	copy.edDate = [self.edDate copy];
	copy.hotelAddress = [self.hotelAddress copy];
	copy.hotelId = self.hotelId;
	copy.hotelName = [self.hotelName copy];
	copy.orderDate = [self.orderDate copy];
	copy.orderId = [self.orderId copy];
	copy.orderStatus = self.orderStatus;
	copy.roomCombo = [self.roomCombo copy];
	copy.roomPrice = [self.roomPrice copy];
	copy.roomTypeId = self.roomTypeId;
	copy.roomTypeName = [self.roomTypeName copy];
	copy.stDate = [self.stDate copy];

	return copy;
}
@end