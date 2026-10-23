# PantherSpot

## Table of Contents

1. [Overview](#Overview)
2. [Product Spec](#Product-Spec)
3. [Wireframes](#Wireframes)
4. [Schema](#Schema)

---

## Overview

### Description

**PantherSpot** is an iOS app designed to help college students find convenient places to study on and around campus.

Students often have time between classes but may not know where they can find a quiet place with seating, Wi-Fi, outlets, or enough space to work with a group. PantherSpot brings this information together in one mobile app.

Users will be able to browse available study locations, view them on a map, see useful details about each location, and save their favorite study spots for quick access later.

The first version of PantherSpot will focus on FIU study locations, but the idea could later be expanded to other college campuses.

### App Evaluation

- **Category:** Education / Productivity / Lifestyle

- **Mobile:** PantherSpot is especially useful as a mobile app because students are likely to search for a study location while already walking around campus. The app can use **Core Location** to determine the user's location and **MapKit** to display nearby study spots. Mobile features such as maps, location services, saved favorites, and possibly photos make the experience more useful than a basic website.

- **Story:** Students frequently need somewhere to study between classes, especially when libraries or their usual locations are crowded. PantherSpot solves this problem by giving students one place to discover study locations and quickly compare useful information such as noise level, seating, outlets, and Wi-Fi availability.

- **Market:** The initial target audience is FIU students, which gives PantherSpot a clearly defined user base. The concept could later expand to other universities by supporting study locations for multiple campuses.

- **Habit:** Students could use PantherSpot several times per week when deciding where to study before or after class. Favorites and nearby-location features encourage users to return instead of repeatedly searching for the same locations.

- **Scope:** PantherSpot has a manageable MVP that can be completed during the course. The required version will focus on browsing locations, viewing details, displaying locations on a map, and saving favorites. More complex features such as ratings, filters, photos, user-submitted locations, or notifications can be added later if time allows.

---

## Product Spec

### 1. User Stories (Required and Optional)

### Required Must-have Stories

- [ ] User can view a list of available study spots.
- [ ] User can tap a study spot to view detailed information about that location.
- [ ] User can view study spots on a map.
- [ ] User can view useful information for each study spot such as noise level, seating, Wi-Fi availability, and outlet availability.
- [ ] User can save a study spot as a favorite.
- [ ] User can view a list of their saved favorite study spots.
- [ ] User can see their current location in relation to study spots on the map.

### Optional Nice-to-have Stories

- [ ] User can filter study spots by characteristics such as noise level, outlets, Wi-Fi, or group-study availability.
- [ ] User can search for a study spot by name.
- [ ] User can view photos of study locations.
- [ ] User can add a rating or personal note to a study spot.
- [ ] User can submit a new study location.
- [ ] User can sort study spots based on distance from their current location.
- [ ] User can receive a notification reminding them about a saved study location.
- [ ] User can view additional information such as building hours when available.

---

### 2. Screen Archetypes

- [ ] **Explore / Study Spot List Screen**
  - User can view a list of available study spots.
  - Each list item displays basic information such as the study spot name, location, and general study environment.
  - User can tap a study spot to open its detail screen.
  - Optional search and filtering controls can be added to this screen.

- [ ] **Study Spot Detail Screen**
  - User can view detailed information about a selected study spot.
  - Information may include the spot's name, description, building or area, noise level, seating, Wi-Fi, and outlet availability.
  - User can add or remove the study spot from their favorites.
  - User can view the study spot's location on a map.

- [ ] **Map Screen**
  - User can view study spots as annotations on a map.
  - User can see their current location.
  - User can tap a map annotation to view information about a study spot.
  - User can navigate from a selected annotation to the Study Spot Detail Screen.

- [ ] **Favorites Screen**
  - User can view study spots they previously saved.
  - User can tap a favorite study spot to open its detail screen.
  - User can remove a study spot from favorites.

### Optional Screens

- [ ] **Filter Screen / Filter Sheet**
  - User can select filters such as quiet locations, outlets, Wi-Fi, or group-study spaces.
  - The selected filters update the study spots shown in Explore.

- [ ] **Add Study Spot Screen**
  - User can enter information about a new study location.
  - User can optionally attach a photo and location.
  - This screen would be implemented only if time allows.

---

### 3. Navigation

### Tab Navigation (Tab to Screen)

PantherSpot will use a bottom tab bar with three main sections:

- [ ] **Explore**
  - Opens the Study Spot List Screen.

- [ ] **Map**
  - Opens the Map Screen.

- [ ] **Favorites**
  - Opens the Favorites Screen.

---

### Flow Navigation (Screen to Screen)

- [ ] **Explore / Study Spot List Screen**
  - Tapping a study spot leads to the **Study Spot Detail Screen**.
  - Tapping optional filter controls opens the **Filter Screen / Sheet**.

- [ ] **Study Spot Detail Screen**
  - User can return to the previous screen.
  - User can add or remove the study spot from favorites.
  - User can view the location of the study spot on a map.

- [ ] **Map Screen**
  - Tapping a study spot annotation displays information about that location.
  - Selecting the location leads to the **Study Spot Detail Screen**.

- [ ] **Favorites Screen**
  - Tapping a saved study spot leads to the **Study Spot Detail Screen**.
  - Removing a favorite updates the Favorites Screen.

- [ ] **Filter Screen / Sheet**
  - Applying filters returns the user to the **Explore Screen** with updated results.
  - Canceling returns the user to the **Explore Screen** without changing the current results.

- [ ] **Add Study Spot Screen** *(Optional)*
  - Saving a new study spot returns the user to the **Explore Screen**.
  - Canceling returns the user to the previous screen.

---

## Wireframes

The following wireframe shows the main PantherSpot screens and navigation flow.

![PantherSpot Wireframe](wireframes/pantherspot-wireframe.png)

### [BONUS] Digital Wireframes & Mockups

The digital wireframe shows the Explore, Study Spot Detail, Map, Favorites,
and optional Filter screens, along with the main tab and flow navigation.

### [BONUS] Interactive Prototype

Not implemented at this milestone.

---

## Schema

The data models and networking requirements will be finalized in the next project milestone after the product design is complete.

### Models

To be completed in a later milestone.

### Networking

To be completed in a later milestone.
