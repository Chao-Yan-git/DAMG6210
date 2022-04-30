## 1.MongoDB Atlas Input
- "_id": {
    "$oid": "620552d8cb6703aceedaa5ef"
  },
  "CustomerID": 11008,
  "SalesOrderID": 53765,
  "OrderValue": 2673,
  "TotalQuantityInOrder": 2
- "_id": {
    "$oid": "620552fcf70f3b2496c8e855"
  },
  "CustomerID": 11008,
  "SalesOrderID": 51282,
  "OrderValue": 2555,
  "TotalQuantityInOrder": 4
- "_id": {
    "$oid": "620553233fcc7fe65ef8f677"
  },
  "CustomerID": 11008,
  "SalesOrderID": 43826,
  "OrderValue": 3729,
  "TotalQuantityInOrder": 1
- "_id": {
    "$oid": "6205533b249ff365446d8260"
  },
  "CustomerID": 11007,
  "SalesOrderID": 54705,
  "OrderValue": 2673,
  "TotalQuantityInOrder": 2
- "_id": {
    "$oid": "620553492aaabf6cac0adb74"
  },
  "CustomerID": 11007,
  "SalesOrderID": 51581,
  "OrderValue": 2643,
  "TotalQuantityInOrder": 5
- "_id": {
    "$oid": "620553588dc8141487089f16"
  },
  "CustomerID": 11007,
  "SalesOrderID": 43743,
  "OrderValue": 3757,
  "TotalQuantityInOrder": 1
- "_id": {
    "$oid": "62055375e5eb37a84454e69d"
  },
  "CustomerID": 11006,
  "SalesOrderID": 58007,
  "OrderValue": 2634,
  "TotalQuantityInOrder": 1
- "_id": {
    "$oid": "62055384161822ef9b222aac"
  },
  "CustomerID": 11006,
  "SalesOrderID": 51198,
  "OrderValue": 2580,
  "TotalQuantityInOrder": 3
- "_id": {
    "$oid": "6205538e5ebee439addc35f6"
  },
  "CustomerID": 11006,
  "SalesOrderID": 43819,
  "OrderValue": 3757,
  "TotalQuantityInOrder": 1
- "_id": {
    "$oid": "62055397118a057918c70c93"
  },
  "CustomerID": 11005,
  "SalesOrderID": 57361,
  "OrderValue": 2634,
  "TotalQuantityInOrder": 1
- "_id": {
    "$oid": "620553a868cdcc31fcbcd4a9"
  },
  "CustomerID": 11005,
  "SalesOrderID": 51612,
  "OrderValue": 2610,
  "TotalQuantityInOrder": 4
- "_id": {
    "$oid": "620553b309bffd78beb7bab1"
  },
  "CustomerID": 11005,
  "SalesOrderID": 43704,
  "OrderValue": 3729,
  "TotalQuantityInOrder": 1
## 2.MongoDB $group  Aggregation


 * _id: The id of the group.
 * fieldN: The first field name.

>{_id: "$CustomerID", averageOrderValue: {$avg: "$OrderValue"}}
## 3.MongoDB Result
- _id:11005
- averageOrderValue:2991


- _id:11006
- averageOrderValue:2990.3333333333335

- _id:11007
- averageOrderValue:3024.3333333333335

- _id:11008
- averageOrderValue:2985.6666666666665