# GitHub Followers Mobile App

This project is to practice and learn how to do programmatic UI in Swift. This app shows the list of followers of a specific github account and shows some basic information about the github follower.

## Mobile App Screenshot (in progress)
<img width="576" alt="Screen Shot 2022-06-24 at 4 46 47 PM" src="https://user-images.githubusercontent.com/22863383/175665160-e6f33b2c-3791-45a8-b679-0a5e830d98d4.png">

## Comparing programmatic UI vs Storyboard design

### Storyboard Design (via Interface Builder)

#### Pros

- Storyboard is beginner friendly and it is faster to launch a simple app
- Due to the visual design, it is easier to layout the elements and add constraints
- Less boilderplate code

#### Cons

- As the number of view controllers grow bigger, it might be harder to navigate around the screen.

- As the project gets larger, there will be some delays when loading the storyboard which could slow down the development time. This could also lead to increase compile time

- Compared to Android Studio XML files which is more readble and where you can edit the layout directly in the XML file, for XCode storyboards, you will rely on the menus most of the time since the auto generated XML file is not easy to understand and interpret. And as the view controllers get bigger, there is a risk of unintentionally modifying other view controllers.

- Performing code review when there is a merge conflict is harder since the XML files are not readable

- Accidentally changing something in storyboard could return some inrecognizable errors

- It is harder to reuse UI components and UI properties such as colors, sizes, fonts, etc.

- It is harder to determine which UI properties has been changed. These properties can be overwritten in code and it is harder to track do

### Programmatic UI

#### Pros

- It is easy to reuse code and UI components

- Since there is a single source of truth, it is easier to verify the code changes in case of merge conflict. It is easier also to know which properties were changed

- It is easier to reuse UI properties among different UI elements

- Basically most of the cons in the usage of storyboard can be resolved by programmatic UI

#### Cons

- Requires more code to layout the elements and add constraints (unless you are using a third-party framework)
- There is a steeper learning curve and might be hard to use for beginners 

### Which one should I use?

This could depend on many factors such as the app you are building and your current level of skillset. For prototyping purposes, maybe storyboard usage is better. If you foresee in the future that the app could be more complex, then use programmatic UI. If you are working as a team, I guess it is better to develop programatically to avoid issue when reviewing merge conflicts. Based on some reviews, developers can also try to use both in a single project (i.e., instead of storyboard, create separate individual views and controllers which can be reused). These are more of just my opinion since I haven't really tried working in a team and I haven't develop a very complex UI yet.
