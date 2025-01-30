# FilmFlow

**FilmFlow App**

<p align="middle">
  <img src="https://github.com/user-attachments/assets/b151bd02-7874-4e62-806a-51518d231593" width="300" height="300">
</p>
<br />
    
## Architecture

- UIKit and MVVM

## Splash Screen

<p align="middle">
  <img src="https://github.com/user-attachments/assets/2d97c961-7c02-474b-b119-ffe1558d03ae" width=20% height=20%>
  <img src="https://github.com/user-attachments/assets/274eaed6-50bc-4638-868a-835d1f7b489f" width=20% height=20%>
</p>
<br />

- Internet Connection Check: If no connection is available, an error message is shown and no navigation occurs.
- Firebase Remote Config: The "Loodos" text is fetched from Firebase and displayed.
- Text Display and Navigation: The "Loodos" text is shown for 3 seconds before navigating to the home screen.
- ViewModel Communication: Data is managed through the SplashViewModel.
- Navigation with Hero Animation: Transition to the next screen happens with a Hero animation after 3 seconds.

## Home Page
<p align="middle">
  <img src="https://github.com/user-attachments/assets/ecdef332-4053-4e31-8d91-8970c1edbe41" width=20% height=20%>
  <img src="https://github.com/user-attachments/assets/f73cdfaf-49e5-4158-9d0f-c48bb5e12d6c" width=20% height=20%>
  <img src="https://github.com/user-attachments/assets/1d3800a1-ad26-49fa-ae81-6d9b9166a82f" width=20% height=20%>
</p>
<br />

- Empty Home Page on Launch: Initially, the home page is blank, displaying only the UI components (such as the search bar and button).
- Film Search Area: The home page includes a search bar for users to input the name of a film.
- API Request for Film Search: Upon entering a film name and pressing the search button, an API request is triggered to fetch film data based on the entered name. The API URL and key should be customized (using Omdb API).
- Loading Animation: When the API request is being processed, a loading animation is shown to inform users that the data is being fetched.
- Display Search Results: The results from the API call (films) are displayed in a collection view. If no films are found, an alert is shown to inform the user.
- Handling Multiple or Single Film Results: The application supports various scenarios where the API might return either one or multiple films, and the UI is adjusted accordingly.
- Error Handling: If the API request fails or no films are found, the user will receive an error message.
- Navigation to Film Details: On selecting a film from the list, the user is taken to a detailed view of the film with Hero animations to transition between the views smoothly.


## Film Detail Page
<p align="middle">
  <img src="https://github.com/user-attachments/assets/8d62d978-a0fb-41a4-9491-829fd04c57fe" width=20% height=20%>
  <img src="https://github.com/user-attachments/assets/6e4ab47c-681d-43b7-ab4c-e8b721f1e1fe" width=20% height=20%>
  <img src="https://github.com/user-attachments/assets/3e42c484-20aa-403a-90b9-b3edccb9095f" width=50% height=50%>
</p>
<br />

- Film Detail Fetching: On view load, the viewModel fetches film details using the IMDb ID via an API request.
- Data Display: Upon successful data retrieval, labels are populated with film details, and Firebase Analytics logs the event.
- Error Handling: If the data fetch fails, an error alert is shown.
- Hero Animation: The controller supports Hero animation for transitions.
- Firebase Analytics Event: When the film detail screen is successfully loaded (fetchSuccess), Firebase Analytics logs an event called "film_detail_viewed" with parameters such as the film's title, year, IMDb rating, poster URL, runtime, genre, director, actors, plot, awards, and IMDb votes. This helps track user interactions with the film detail screen and provides insights into user behavior.

 ## Firebase Notification
<p align="middle">
  <img src="https://github.com/user-attachments/assets/1dc255d0-a75c-4277-aecc-c0eeba2e12bf" width=20% height=20%>
</p>
<br />

- Firebase is configured using FirebaseApp.configure(), and notification permissions are requested with UNUserNotificationCenter. The app registers for remote notifications and sets up the delegate for both receiving notifications and handling Firebase Cloud Messaging (FCM) token registration.
- Notifications are handled using methods like userNotificationCenter(_:willPresent:) for foreground notifications and didReceiveRemoteNotification for background notifications. The app subscribes to the "all_users" topic to receive messages sent to that group.

