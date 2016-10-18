#  User's segmentation events

With sending in-app events triggered by your users you can improve your monetization and get higher earnings.

Our platform automatically build audiences using your in-app data (provided by your events) and assigns high performing campaigns individually to each segment.

Also our advertisers and mediabuying department make higher bids for more engaged users.

You can send the events very easy. Just call the method `sendEvent(type: HADEventType)` from HADEvent class.

Swift example: `HADEvent.sendEvent(.AchievementUnlocked)`

Objective-C example: `[HADEvent sendEvent:HADEventTypeAchievementUnlocked];`

## Event codes

**Authenticate events**

* __101__ Registration
* __102__ Login
* __103__ Open

**eCommerce events**

* __201__ Add to Wishlist
* __202__ Add to Cart
* __203__ Added Payment Info
* __204__ Reservation
* __205__ Checkout Initiated
* __206__ Purchase

**Content events**

* __301__ Search
* __302__ Content View

**Gaming events**

* __401__ Tutorial Completed
* __402__ Level Achieved
* __403__ Achievement Unlocked
* __404__ Spent Credit

**Social events**

* __501__ Invite
* __502__ Rated
* __504__ Share
