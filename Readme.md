# MemorizeGame

Hello! I'm Eugene.
This is my educational project for the ***Spring 2021 version of Stanford University's course CS193p***.

The goal of this assignment is to recreate the demonstration given in the first two lectures and then make some small enhancements.

# MemorizeGame. Assignment I.
**Required Tasks**
1. I have implemented a game called "Memorize" that works as shown in lectures 1 and 2. Enter all the code. 
2. I added the caption "Memorize!" to the top of the screen.
3. Add at least 3 "Select Theme" buttons to the interface, each of which will replace all cards with new ones containing emojis that match the selected theme.
4. The number of cards in each of the 3 themes is different, but in no case less than 8.
5. The cards that appear when you click the theme button are in an unpredictable (i.e. random) order.
6. The topic buttons contain an image representing the topic and text describing the topic, arranged vertically above each other.
7. The image of the topic buttons should be created using the SF symbol associated with the topic that is selected (e.g., the car symbol and the topic "Vehicles" as shown in the "Screenshots" section below).
8. The text description of the topic selection buttons is written in a noticeably smaller font than the font chosen for the emoji on the cards.

Also I also did an Extra credit assignment.
I made a random number of cards appear each time a theme button is chosen. Always shows at least 4 cards though. I created the randomaizer() function specifically for this purpose

<img width="285" alt="214946374-84c678df-cdc0-4072-bed4-e48fe8523ab8" src="https://user-images.githubusercontent.com/110675494/220786122-24170ab5-400c-4cb3-be56-4bde1803be36.png">


# MemorizeGame. Assignment II.

The goal of this assignment is to continue to recreate the demonstrations given in the first four lectures and then make some bigger enhancements. 
**MVVM** was used to improve the previous project.
    - MemoryGame(Model);
    - EmojiMemoryGame(ViewModel); 
    - ContentView(View).

**Required Tasks**
1. I have implemented the Memorize game working as demonstrated in lectures 1 through 4.
2. Remove the buttons for selecting a theme and (optionally) the name of the game(see in Assignment I).  
3. Added a formal concept of "Theme" to the model. A theme is a structure and consists of a theme name, a set of emojis to use, the number of pairs of cards to show, and the appropriate color for drawing cards.
4. At least 6 different themes are supported in your game.
5. Added a "New Game" button to my interface that starts a brand new game.
6. The new game uses a randomly selected theme, and clicking the "New Game" button causes a new random theme to be selected again.
7. The cards in the new game are completely shuffled using *randomCase*. This means that they are not in any predictable order, that they are chosen from any emoticon in the theme.
8. Entered the score of my game, deducting 1 point for each previously seen card involved in the mismatch and giving 2 points for each match (regardless of whether or not the cards were "previously seen"). The score may be negative if the user has poor memorization.
    If you first flip 🐧 + 👻, then flip 🤖 + 🏀, then flip two 👻, your score will be 2 because you scored a match (and you will not receive any penalty for flipping 🐧, ✏, or 🏀 because they have not (yet) been involved in a match and 👻 have never been involved in a match). If you flip 🐧 + 🐼 again and then flip 🏀 + 🐧, your score will be reduced by 3 full points to -1 because this 🐧 card was already seen (during the first flip) and subsequently participated in two separate discrepancies (-1 point for each discrepancy), and the 🏀 card was a discrepancy after it was already seen (-1). If you flip the 🐧 + the other 🐧 that you finally found, you get 2 points for the match and go back to 1 total point.

9. The score displayed in the interface

   
# MemorizeGame. Assignment III.
<div align="center">
     <img src = "MemorizeGame/2023-06-26 20.09.26.gif" width = "40%">
</div>
add animation and a new "Shuffle" button. When the pictures are matched, the card frame shows the match as an identifier and is accompanied by an animation

This project is built on Xcode 14.2 with use Swift 5.7 and SwiftUI 4

My email: demenkoeugene@icloud.com


![Запис екрана 2023-02-22 о 17 56 19](https://user-images.githubusercontent.com/110675494/220786090-722a1762-f0d4-46dd-93bf-7fdc07dcf529.gif)




