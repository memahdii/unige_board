# unige_board

A new Flutter project.

## Getting Started

Application Functionality and Technologies Used:

I developed an application called Unige Board, a digital platform for the University of Genoa community. It allows users to post and view plans for entertainment, such as going to the cinema on Monday, July 29th. When users launch the application, they are greeted with a welcome screen featuring color shading animation along with logo and title animations. 

From there, users can navigate to the login or registration page. Based on their preferences, they will see different pages.

Upon successful login or registration, users are taken to the board screen after showing a purple loading spinner, where they can view all posts and create new ones. 

The board displays posts in a column list view, with each post containing four widgets:

Attend Icon

Email of the writer

Number of participants

Description of the plan

Users can log out in three different ways:

Up navigation ensures users remain within the application, navigating based on the explicit hierarchical relationship between screens. Down navigation, which is an Android system functionality. Logout icon, which navigates the user back to the welcome screen.

For developing this application, I used Flutter because I preferred its syntax over other options. Additionally, being a cross-platform framework, it allows us to develop the app for different platforms using the same source code. For user authentication, I used Firebase Auth, and for storing user data, I utilized Firebase Database. I tested the application on both Android and web platforms, and it performed well on both.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
