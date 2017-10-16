# QuinTypeInsta

1. Setting Up Git Repository:
   * Created Public Repository in Git Hub.
   * Created a xcode project and Pushed the code to repository before starting the work. Just to confirm Git setup.
   
2. Getting Users and Stories Data from local Json File:
   * Created Json File and inserted User List and Stories details into it.
   * Created Data model Class to Store Users List and Details
   * Parsed Data from local json file and stored in Local Array.
   * Created NetworkManager for getting Json Data and DataManager to Parse Data.

3. Showing User List with Profile Picture on Top of Screen.
   * Designed Custom CollectionView Cell for showing user with Profile picture with rounded corner and user name.
   * Based on number of users in User Local array displayed the list in collectionView.
   * When click on the particular User it will navigate to Story screen and starts showing his/her Stories.

4. Designing Story Screen with Status Bar.
   * Designed Custom CollectionView Cells for Image Story and Video Story.
   * I Implemented Stories screen Using CollectionView But we can try using PageViewController also.
   * Based on number of stories will get Status Bar View with small UIView segments equal to Stories count.
   * Status Bar timing is implemented based on Story type(Image or Video).
   * When Story is completed it will move to Next Story of the same user. If it is last story it will move to next User. If he is the Last
     user it will go back to Main Screen.
   * User Interaction to collectionView is disabled (Changing Stories with user interaction is not implemented).

Note: Video Status Bar is for 15 seconds But If video is of 10 seconds after 10 seconds It will show Black screen. Need to play video using loop. Can be Solved using Notification Center.



