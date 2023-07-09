# MemorizeGame

Hello! I'm Eugene.
This is my educational project for the ***Spring 2021 version of Stanford University's course CS193p***.

The goal of this assignment is to recreate the demonstration given in the first two lectures and then make some small enhancements.

# MemorizeGame. Assignment VI. Memorize Themes
<hr>

**Completed tasks**
1. My game from A2 should no longer select a random theme, but instead, its ViewModel should have a theme var variable that can be set.
2. The New button has been changed to restart the game instead of selecting a new theme.
3. Now my Memorize Game application shows the "theme selection" interface at startup. 
4. I was using a list to display the topics.
5. Each line in the list shows the name of the theme, the color of the theme, the number of how many cards in the theme, and some sample emojis in the theme.
6. Clicking on a theme in the list takes you (i.e. the list is in navigation mode) to the game with that theme.
7. Switching from the game to the theme selection and then back to the game does not restart the game unless the game theme has been changed 
8. A user interface for adding a new theme to the list in the theme selection window has been provided.
10. The selector supports an editing mode where themes can be deleted and where clicking on a row brings up the modally presented (i.e., in the form of a sheet or pop-up window) theme editor interface for that theme, rather than navigating to the game with that theme.
11. The theme editor uses a form.
12. The theme editor allows the user to edit the theme name, add emoticons to the theme, remove emoticons from the theme, specify the number of cards in the theme, and specify the theme colour.
13. Themes are persistent (i.e., restarting the application does not cause all the changes made in the theme to be lost).

Below is a list of the concepts I practiced within this assignment.
1. List
2. Form
3. NavigationView
4. Modal presentation
5. TextField
6. EditMode
7. Multiple MVVMs
8. UserDefaults
9. Using new API (Stepper, ColorPicker, etc.)


<div align="center">
     <img src = "2023-07-09 19.43.10.gif" width = "40%">
</div>

   
# MemorizeGame. Assignment III.
<hr>
add animation and a new "Shuffle" button. When the pictures are matched, the card frame shows the match as an identifier and is accompanied by an animation

<div align="center">
     <img src = "MemorizeGame/2023-06-26 20.09.26.gif" width = "40%">
</div>



# MemorizeGame. Assignment II.
<hr>

The goal of this assignment is to continue to recreate the demonstrations given in the first four lectures and then make some bigger enhancements. 
**MVVM** was used to improve the previous project.
    - MemoryGame(Model);
    - EmojiMemoryGame(ViewModel); 
    - ContentView(View).

**Completed tasks**
1. I have implemented the Memorize game working as demonstrated in lectures 1 through 4.
2. Remove the buttons for selecting a theme and (optionally) the game's name (see Assignment I).  
3. Added a formal concept of "Theme" to the model. A theme is a structure and consists of a theme name, a set of emojis to use, the number of pairs of cards to show, and the appropriate color for drawing cards.
4. At least 6 different themes are supported in your game.
5. Added a "New Game" button to my interface that starts a brand new game.
6. The new game uses a randomly selected theme, and clicking the "New Game" button causes a new random theme to be selected again.
7. The cards in the new game are completely shuffled using *randomCase*. This means that they are not in any predictable order, that they are chosen from any emoticon in the theme.
8. Entered the score of my game, deducting 1 point for each previously seen card involved in the mismatch and giving 2 points for each match (regardless of whether or not the cards were "previously seen"). The score may be negative if the user has poor memorization.
    If you first flip 🐧 + 👻, then flip 🤖 + 🏀, then flip two 👻, your score will be 2 because you scored a match (and you will not receive any penalty for flipping 🐧, ✏, or 🏀 because they have not (yet) been involved in a match and 👻 have never been involved in a match). If you flip 🐧 + 🐼 again and then flip 🏀 + 🐧, your score will be reduced by 3 full points to -1 because this 🐧 card was already seen (during the first flip) and subsequently participated in two separate discrepancies (-1 point for each discrepancy), and the 🏀 card was a discrepancy after it was already seen (-1). If you flip the 🐧 + the other 🐧 that you finally found, you get 2 points for the match and return to 1 total point.

9. The score displayed in the interface
<div align="center">
     <img src = "https://user-images.githubusercontent.com/110675494/220786090-722a1762-f0d4-46dd-93bf-7fdc07dcf529.gif" width = "60%">
</div>

# MemorizeGame. Assignment I.
<hr>

**Completed tasks**
1. I have implemented a game called "Memorize" that works as shown in lectures 1 and 2. Enter all the codes. 
2. I added the caption "Memorize!" to the top of the screen.
3. Add at least 3 "Select Theme" buttons to the interface, each of which will replace all cards with new ones containing emojis that match the selected theme.
4. The number of cards in each of the 3 themes is different but in no case less than 8.
5. The cards that appear when you click the theme button are in an unpredictable (i.e. random) order.
6. The topic buttons contain an image representing the topic and text describing the topic, arranged vertically above each other.
7. The image of the topic buttons should be created using the SF symbol associated with the topic that is selected (e.g., the car symbol and the topic "Vehicles" as shown in the "Screenshots" section below).
8. The text description of the topic selection buttons is written in a noticeably smaller font than the font chosen for the emoji on the cards.

Also, I also did an Extra credit assignment.
I made a random number of cards appear each time a theme button is chosen. It always shows at least 4 cards though. I created the randomizer() function specifically for this purpose
<div align="center">
    <img width="285" alt="214946374-84c678df-cdc0-4072-bed4-e48fe8523ab8" src="https://user-images.githubusercontent.com/110675494/220786122-24170ab5-400c-4cb3-be56-4bde1803be36.png">
</div>


<br>
<br>
<br>
<br>

This project is built on Xcode 14.2 with the use of Swift 5.7 and SwiftUI 4

My email: demenkoeugene@icloud.com





