# Readme 
## Upload App  
The purpose of this app is to upload files and show them to you and to other users of the app in an easy way.

In order to achieve this goal, will be necessary to have the next flows:
* Login: To identify users and the scope of functionalities that they can make.
* SignUp: To generate a new account.
* Upload file: To save new images from the photo library.
* Carousel of images: All the users' images are showed together
* Image detail: The image detail could be viewed by tapping on an image. The detail will show the user that uploads the image, the date where the image was uploaded and also have the opportunity to like the photo or delete it if you are the image owner. 
* Likes: You can like an image if it is your or not, the app will save the count of likes received and the reference to the user who has liked the image
* Delete: Only the owner can delete its own images when a user is on the detail of an image that is not yours, the delete button will not appear.

## DataBase 
### Database Design
![Database Relationship Diagram](/assets/upload_app_db.png)
### Datatypes
#### User

Type: Struct
Fields:
- email: String - required
- password: String - required
- userName: String - required
- images: [Image] - not required - default = 0

#### Image
Type: Struct
Fields:
- userId: String - String
- image: Base64 - required
- metadata: Struct - not required
- likesCount: Int - not required - default = 0
- likesUsers: [User] - not required - default = 0

## Functionalities detailed
### Upload file
* Take a photo from photo library
* Upload the photo to the fire base storage
* Save image and its metadata

### Download file
* Take all users photos and show them on a carousel 
* Show each image with its information: date, author, size, likes

### Like file
* Can like your images and others ones
* One like is an one increase counter
* Can like if press once or revert action pressing twice

### Delete file
* Can delete only your own images but not the others ones
* Use user Id for validate the owner

### Flows
* Log up
    1. Uses email and password to create and account
    2. Validate email schema
    3. Validates password schema 
    4. Manage existing user error by alert confirm
* Log in
    1. Validate email schema
    2. Validates password schema
    3. Manage errors on login account with firebase
* Main view
    1. Pre charge the images when load the app
        * Upload file
            1. If press upload button and select a valid image, upload it
            2. Show alert success when the image was uploaded
            3. If possible, show the detail view of the new image when was successfully uploaded
        * Carousel
            * Show the images on a carousel ordered by date
            * When touch and image, show its detailed view
			
* Detail view
    1. Uses the image data to be sanded to the new view
    2. Charge the like and delete button state depending on the user searching for
        * Show detail
            * Shows the image and its data
            * If wanted, return to the last view
        * Like or dislike 
            * If press, add one to likes count, and change button to active state. When press again an active button, rest count
        * Delete
            * Delete if confirm
            * Alert confirm
            * Alert success