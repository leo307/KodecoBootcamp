# Welcome to my capstone project!

### Background
* This app/platform was designed for dental practices to store their training and other materials in a secure conveniant way.
* The parent to the IOS app, is https://app.vtmapp.com
* It is under construction at the moment, but the backend is live, and has an API in which my capstone app can communicate with.
* I redesigned and recreated the app on ios devices

### Functionality
* This app functions like a media player app.
* There is a functional login screen.
* Uses keychain to store a logged in users token.
* Users are presented with videos (training material) and can click from the list to get more information and watch the material.
* Users may sign out, or download videos at any time.
* Videoplayer tab, as well as an information tab, with a summary, title, uuid, team id, and a youtube watch url.
* Animated download button.
* Looks pleasing in light or dark mode.

### Improvements
* Overall styling, may revise and implement a more uniform design.
* Would like to allow users to create accounts, etc, but that would require work on the backend to allow for this.
* Would like to add comments, shares, likes dislikes, and views, to the video page.

### Miscellenous
* Username & password on the login screen are linked with a live database in which the password has been changed for the sake of the project. As of 07/17/24 the values have been prefilled so no typing of the username & password is necessary, this may change to a more secure method in the future, but works for the sake of the project.
* You'll find that if you open the app and login once, you will not be asked to do so again when closing and reopening the app, that is because a unique token is stored in the users keychain.
