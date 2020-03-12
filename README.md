# GistView

A simple GitHub public gist viewer

## Introduction
This project was created to consume the public GitHUb Gistd API and displays some simple information.

### Functionality

 - Shows a public gists
 - Caches the list of gists locally
 - Favorite gists locally
 - Swipe refresh
 - infinite scrolling
    
### Project Architecture

This project was builded using MVP pattern and dependecy injection for easy testing

 ### Technologies
This project makes use of some third parties libs for the Network layer and native class for storaging

 - Alamofire
 - AlamofireImage
 - NSUserDefaults
 
### API
https://api.github.com/

### Tests
 - MainViewTest
 - FavoriteViewTest
 
 ### Improvements
  - Make search feature for gist owner name inside Gist List
