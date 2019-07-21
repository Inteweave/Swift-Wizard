# Wizard
Pattern used for set-by-step instructions. Sometimes called a Wizard or Assistant.

## Concept
Inteweave has developed many self-install kits since 2004 and has used this method for all of them. It has been coded in C++, Actionscript, Swift, Kotlin, Java and Objective-C.

What we are aiming for is to have each screen and it's coordinator independent of any other screen. The UX flow shows how the screens should be linked and the wizard code represents that directly. The order of the steps can be coded or input as a data file. The wizard definition is *Viewing screen X, on event Y, go to screen Z*

For example, we have the following steps to choose a snack:
```- choose snack
   - icecream
     - cone
     - soft serve
       - choc dip
       - sprinkles
   - nuts
```
The UX flow is coded as:
```ScreenNavigation(from: SnacksScreen.selectType, event: Event.userDidChooseIceCream, to: SnacksScreen.iceCreamServe),

ScreenNavigation(from: SnacksScreen.iceCreamServe, event: Event.userDidChooseSoftServe, to: SnacksScreen.chooseTopping),
ScreenNavigation(from: SnacksScreen.iceCreamServe, event: Event.userDidChooseIceCreamCone, to: SnacksScreen.cone),

ScreenNavigation(from: SnacksScreen.chooseTopping, event: Event.userDidChooseChocDip, to: SnacksScreen.softServeChocDip),
ScreenNavigation(from: SnacksScreen.chooseTopping, event: Event.userDidChooseSprinkles, to: SnacksScreen.softServeSprinkles),

ScreenNavigation(from: SnacksScreen.selectType, event: Event.userDidChooseNuts, to: SnacksScreen.nuts)
```
