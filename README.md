
**Synopsis**

This app allows the user to register an account, with an optional profile picture, and upload and delete food recipes from the cloud. The user can pick a food photo from either their library or get a placeholder through an online search.

A text file titled AppFlow in the Documentation folder will given a more thorough walkthrough of the app.

**App Architecture**

The app uses a personally-created enum oriented variant of Clean Architecture that uses a unidirectional ViewController-Allocator-Producer-Presenter flow so as to follow the Single Responsibility Principle.

Furthermore, the architecture uses extensive use of protocols and generics with protocol constraints to best conform to SOLID principles, as well as for better reusability, scalability, and refactoring. 

Please look at the App Architecture text file in the Documentation folder for more information on the architecture.

Setup Before Running the App

Please read the RequiredSetup text file in the Documentation folder to properly setup the app and run it.

**Future Plans**

Current Improvements:
- Create an Edit Recipe Scene
- Create an Edit Profile Scene
- Add "Delete User" Functionality
- Customize Image Picker Controller
- Verify and Reset Email Login
- Improve Concurrancy

Version 0.2:
- Create Social Aspect
- Add iMessage Extension
- Add Unit Testing
- Start Using Instruments
- Add Facebook and Phone Authentication
- Unique Username Verification

Version 0.3:
- Add Core Animation
- Add UIKit Dynamics
- Upgrade UI Design

Version 0.4:
- Add Audio and Video Streaming
- Add Ability to Buy and Sell Recipes
- Add Optional Nutrition Facts Scene
