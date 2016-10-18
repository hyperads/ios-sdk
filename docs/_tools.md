# Tools

## Link rotator

With link rotator you can easily rotate most performing offers and redirect user to it

<aside class="notice">
You must replace <code>PLACEMENT_ID</code> with your placement's ID.
</aside>

`http://ad.dispply.com/v2/link/PLACEMENT_ID`

## Traffic distribution system (TDS)

You can easily customize traffic distribution across different rules

## Events (iOS)
You can send the events very easy. Just call the method sendEvent(type: HADEventType) from HADEvent class.

Swift 2.2 example:
```swift
HADEvent.sendEvent(.AchievementUnlocked)
```

Swift 3.0 example:
```swift
HADEvent.send(event: .achievementUnlocked)
```

Objective-C example:
```objective_c
[HADEvent sendEvent:HADEventTypeAchievementUnlocked];
```

That's all!

## Events (Android)
You can send the events very easy. Just call the method sendEvent(Context, event_code) from HADEvent class.
Example:
```java
HADEvent.sendEvent(this, Event.GAMING_ACHIEVEMENT_UNLOCKED);
```

That's all!


> **Event codes:**
> 
 	Authenticate events
> - 101 Registration
> - 102 Login
> - 103 Open
> 
 	 eCommerce events
> - 201 Add to Wishlist
> - 202 Add to Cart
> - 203 Added Payment Info
> - 204 Reservation
> - 205 Checkout Initiated
> - 206 Purchase
> 
 	Content events
> - 301 Search
> - 302 Content View
> 
 	Gaming events
> - 401 Tutorial Completed
> - 402 Level Achieved
> - 403 Achievement Unlocked
> - 404 Spent Credit
> 
 	Social events
> - 501 Invite
> - 502 Rated
> - 504 Share
