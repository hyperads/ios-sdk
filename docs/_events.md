#  User segmentation

Customer segmentation is the practice of dividing a customer base into groups of individuals that are similar in specific ways relevant to marketing, such as age, gender, interests and spending habits. You can build custom (or use predefined) segments from your users. This is potentially increase your monetization.

For building segments based on in-app events you need to notify our backend for every event occured in your app.

First of all you must set your token with `HADEventManager.sharedInstance.setup(token: "TOKEN")`

Next, you can send events. Just call the method `send(type: HADEventType)` of HADEventManager class.

Swift example: `HADEventManager.sharedInstance.send(.achievementUnlocked)`

Objective-C example: `[[HADEventManager sharedInstance] send:HADEventTypeAchievementUnlocked];`

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
