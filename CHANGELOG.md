# Changelog

## [Released] - [2021-04-12]
### Next Steps
- Like images according to the desing exponed on README.md file
    - Like and dislike
    - Save like count number on a realtime database or in the image metadata
- Authenticate users on the app
    - Only the user who upload an image can delte its own images. The button wil not be shown to the other users
    - The list of users who like an image will be saved to the real time database or on the metatada of the image
    - The name of the user who like a photo will be showed on the image detail
### Added
- Upload app allows to upload files to a Firebase Storage by using the "UPLOAD IMAGE" button
- Upload app allows to show all images by navigating between the right and left buttons
- Upload app allows to show an image detail by clicking on the "👀" button
- Once on the detail view you can:
    - View some of the metadata info of each image like: name, ipload datetime and size
    - Also view the image
    - Return on to the main view by using the back navigation button
    - Delete an image. The image will be uploaded and return to the main view
- The the main view is shown next: ![Main view](/assets/photos.png)
- The detailed view is shown next: ![Detail view](/assets/detail.png)