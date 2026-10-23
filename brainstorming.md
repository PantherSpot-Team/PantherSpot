# Group Project - App Brainstorming

## New App Ideas

### 1. PantherSpot
**Category:** Productivity / Education

PantherSpot would help FIU students find good places on or near campus to study, work on group projects, or relax between classes. Users could browse study locations on a map, see information about each place, save favorite locations, and possibly add ratings or notes about things such as noise level, outlets, seating, and Wi-Fi.

**Possible mobile features:** MapKit, current location, photos, favorites, and notifications.

---

### 2. PantryPal
**Category:** Lifestyle / Productivity

PantryPal would help users keep track of food they have at home and reduce food waste. Users could add grocery items manually or scan a barcode, keep track of expiration dates, and receive notifications when food is about to expire. The app could also display basic product information after scanning an item.

**Possible mobile features:** Camera/barcode scanning, local notifications, photo capture, and Open Food Facts API.

---

### 3. TrailMate
**Category:** Health & Fitness / Travel

TrailMate would help users discover walking, running, and hiking locations nearby. The app would show trails or parks on a map, allow users to save favorites, and record basic information about places they want to visit. Users could also view weather information before starting an outdoor activity.

**Possible mobile features:** GPS/location, MapKit, weather data, saved locations, and possibly activity tracking.

---

### 4. StudySprint
**Category:** Education / Productivity

StudySprint would help students organize focused study sessions using timers and study goals. A user could create subjects, start a focus session, track how much time they studied, and see their progress over time. The app could send reminders when it is time to study or take a break.

**Possible mobile features:** Local notifications, timers, progress tracking, widgets, and charts.

---

### 5. CampusBites
**Category:** Lifestyle / Social

CampusBites would help students discover restaurants and food options around campus. Users could browse nearby locations, save favorites, see them on a map, and keep a personal list of places they want to try. Users could also rate places they have visited.

**Possible mobile features:** Location, MapKit, photos, ratings, and restaurant/place search.

---

### 6. FitQuest
**Category:** Health & Fitness

FitQuest would turn basic exercise goals into small challenges. Users could choose daily goals such as walking a certain distance, completing a workout, or visiting a park. Completing challenges would build streaks and progress toward achievements.

**Possible mobile features:** Health/activity data, notifications, location, progress tracking, and achievements.

---

### 7. EventRadar
**Category:** Social / Entertainment

EventRadar would help users discover events happening nearby. Events could be shown as a list or on a map, and users could save events they are interested in. The app could also remind users before a saved event begins.

**Possible mobile features:** Location, maps, calendar integration, notifications, and an events API.

---

### 8. SnapJournal
**Category:** Lifestyle

SnapJournal would be a simple location-based photo journal. Users could create journal entries containing a photo, short description, date, and location. Previous memories could be viewed chronologically or displayed on a map showing where they were created.

**Possible mobile features:** Camera/photo library, location, MapKit, and local storage.

---

# Top Three Ideas

After comparing the initial ideas based on interest, usefulness, mobile functionality, and the amount of work required to build them, the top three ideas are:

1. **PantherSpot**
2. **PantryPal**
3. **TrailMate**

---

# App Idea Evaluation

## 1. PantherSpot

### Mobile
PantherSpot fits well as a mobile app because users would normally search for a study location while they are already on campus. The app can use the user's current location with **Core Location** and display study spots through **MapKit**. Users could also use their phone's camera or photo library when adding photos of locations.

### Story
College students frequently need somewhere to study between classes, especially when their usual location is crowded. PantherSpot gives students a quick way to find another nearby place based on characteristics such as noise level, seating, outlets, and general study environment. The purpose of the app is easy to explain and directly relates to a common student problem.

### Market
The first target audience would be FIU students, which gives the app a clearly defined group of users. The idea could later be expanded to other universities by allowing study locations for different campuses.

### Habit
Students could use the app several times during a normal school week, especially between classes or during exam periods. Favorites and recently viewed locations would encourage users to return to the app instead of searching for the same locations repeatedly.

### Scope
A basic version is realistic to complete during the course. The first version could include a list of study spots, map locations, details, and favorites. More advanced community features such as ratings or user-submitted locations could be added later if time permits. MapKit and Apple's location frameworks provide the main mapping functionality without requiring a paid third-party API.

**Overall:** Strong mobile experience, clearly defined audience, useful purpose, and manageable scope.

---

## 2. PantryPal

### Mobile
PantryPal takes advantage of mobile hardware through the camera for barcode scanning and local notifications for expiration reminders. Users would normally have their phone with them while grocery shopping or checking food in their kitchen.

### Story
Food is often thrown away because people forget what they purchased or when it expires. PantryPal would give users a simple way to keep track of their food and receive reminders before items expire.

### Market
The potential audience is very large because anyone who buys groceries could use the app. It could be especially useful to students, families, and people trying to reduce food waste.

### Habit
Users could open PantryPal whenever groceries are purchased, when planning meals, or when checking which items are close to expiring. Expiration notifications could also bring users back into the application.

### Scope
A simple version with manually entered food items, expiration dates, and notifications is achievable. Barcode scanning adds additional complexity but could be implemented after the basic functionality is working. **Open Food Facts** provides a free product database/API that could be used to obtain information about scanned grocery products.

**Overall:** Useful and habit-forming with strong mobile features, but barcode scanning and product data make it somewhat more technically complex than PantherSpot.

---

## 3. TrailMate

### Mobile
TrailMate strongly benefits from being mobile because location is central to the experience. The app could use GPS to determine the user's current location, MapKit to display nearby outdoor locations, and a weather service to provide current conditions.

### Story
People who want to exercise outdoors may not know which parks or trails are nearby or whether weather conditions are good for an activity. TrailMate would combine this information into a single mobile experience.

### Market
The app could appeal to walkers, runners, hikers, and people who simply want to spend more time outdoors. This provides a reasonably large target audience.

### Habit
Users could open the app whenever they plan outdoor exercise. Favorites and weather information could encourage repeated use throughout the week.

### Scope
A basic map showing outdoor locations, current location, weather, and favorites is achievable. More advanced features such as complete route tracking, elevation information, or social functionality could make the project significantly more difficult. MapKit can provide maps/location features, while a free weather API such as Open-Meteo could provide weather information.

**Overall:** Strong mobile use case and interesting features, but route and activity functionality could increase the project's complexity.

---

# Final App Decision

## PantherSpot

After evaluating the three ideas, I chose **PantherSpot** as the final app idea.

PantherSpot provides the best balance between usefulness, mobile-specific functionality, and a realistic development scope. The app solves a problem that is familiar to college students: finding a convenient place to study when they are on campus.

The first version of PantherSpot will focus on allowing users to:

- View available study spots.
- See study spots on a map.
- View information about each study spot.
- Use their current location to understand which locations are nearby.
- Save favorite study locations.
- View useful details such as noise level, seating, outlets, and Wi-Fi availability.

If time allows, additional features could include photos, user ratings, adding new study locations, filtering locations, or notifications.

The project takes advantage of native iOS functionality such as **MapKit**, **Core Location**, and local data storage while remaining small enough to complete within the remaining course schedule.
