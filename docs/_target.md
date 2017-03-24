## Targeting

Customer segmentation is the practice of dividing a customer base into groups of individuals that are similar in specific ways relevant to marketing, such as age, gender, interests and spending habits. You can build custom (or use predefined) segments from your users. This is potentially increase your monetization. 

### Custom Parameters

The `HADAdRequest` object collects targeting information to be sent with an ad request.


* Keywords

If your app already knows a user's interests, it can provide that information in the ad request for targeting purposes.

```swift
let adRequest = HADAdRequest()
adRequest.setKeywords(value: "sport,cinema")
nativeAd.adRequest = adRequest
```

* Gender

If your app already knows a user's gender, it can provide that information in the ad request for targeting purposes. The information is also forwarded to ad network mediation adapters if mediation is enabled. `HADUserGender` enum contains two possible values.

```swift
adRequest.setGender(value: .male)
```

* Age

If your app already knows a user's age, it can provide that information in the ad request for targeting purposes. This information is also forwarded to ad network mediation adapters if mediation is enabled.

You can set year of birth:
```swift
adRequest.setYearOfBirth(value: 1983)
```

or just age:
```swift
adRequest.setAge(value: 33)
```

* Additional parameters

Also you can specify any additional parameters you want.

```swift
adRequest.setCustomParams(params: ["first_name":"John","last_name":"Doe"])
```

```swift
adRequest.setCustomParam(key: "full_name", value: "John Doe")
```
