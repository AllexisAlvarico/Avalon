    org $1000

*-------------------------------------------------------
*Title      : Private Military Simulator
*Written by : Allexis Alvarico
*Date       : 21/01/19
*Descrition : Text-base game project
*Bugs       : The consumption is not working as intended
*           : the selected item won't decrease and give
*           : its effects to the player
*-------------------------------------------------------
*-------------------------------------------------------
* Starting memory address for the programme $1000
*-------------------------------------------------------
    
    org $1000

*-------------------------------------------------------
*Validation values to be used, modify as needed
*Add additional validation values as required
*-------------------------------------------------------
exit        EQU 0      used to exit assembly program
win_point   EQU 5      points accumilated on win
lose_point  EQU 8      points deducted on a lossrea
Iraq        EQU 1      Iraq play area   
Iran        EQU 2      Iran play area   
Syria       EQU 3      Syria play area  
Hospital    EQU 1      Medical shop
Black_Market EQU 2     Weapon shop
Contractors EQU 3      Mission shop
leaveTown EQU 4        leave the town

mine_loc    EQU 100    used below for some simple collision detection using CMP
                       * example for a hit


*Start of Game
start:
    move.b  #100,$4000 put score/health in memory location $4000
    lea     $4000,A3   assign address A3 to that memory location


    bsr     welcome    branch to the welcome subroutine
    bsr     playerName
    bsr     input      branch to the input subroutine
    bsr     game       branch to the game subroutine
*Game loop
    org     $2000      the rest of the program is to be located from 3000 onwards

*-------------------------------------------------------
*-------------------Game Subroutine---------------------
*-------------------------------------------------------
game:
    bsr     gameloop   branch to gameloop subroutine
    rts                return from game: subroutine
          
end:
    simhalt
*------------------------------------------------------
*----------------------Address data--------------------
*------------------------------------------------------    
NAME EQU $9000 ; stores the name to an adress
COMPANY_NAME EQU $9500 ; stores the player's company name

*-------------------------------------------------------
*-------------------Welcome Subroutine------------------
*-------------------------------------------------------
welcome:
    bsr     endl            branch to endl subroutine
    lea     welcome_msg,A1  assign message to address register A1
    move.b  #14,D0          move literal 14 to DO
    trap    #15             trap and interpret value in D0
    
    move.b  #4, D0          stops the continuing to the next msg 
    trap    #15             trap and interpret value in D0
    
    ;creates the data for the player and enemies
    move #2000, $10000 *Player Money data address
    move #100,$10050    *player Health data address
    move #50, $10100 * Player's might data address
    move #500,$10200 * Deserters fighting power
    move #1000,$10300 * Militia camp fighting power
    move #1500,$10400 * Rebel mercenery camp fighting power
    move #2000,$10500 * Mercs fighting power
    move #0,   $10600 * -Medical supply-
    move #0,   $10610 * Bandage
    move #0,   $10620 * Pills
    move #0,   $10630 * Medkits
    move #0,   $10700 * -Weapons-
    move #0,   $10710 * Ak-47s
    move #0,   $10720 * M4s
    move #0,   $10730 * Sniper-rife
    
    bsr     endl            branch to endl subroutine
    rts                     return from welcome: subroutine
*------------------------------------------------------
*---------Gameplay Input Values Subroutine--------------
*-------------------------------------------------------    
input:
    bsr     location        branch to location input subroutine
    bsr clear_screen    ;clears the screen
    bsr     Town         branch to potion input subroutine
    bsr clear_screen    ;clears the screen
    rts

*-------------------------------------------------------
*----------------Gameloop (main loop)-------------------
*------------------------------------------------------- 
gameloop:
    bsr     gameplay        branch to gameplay subroutine
    bsr     clear_screen    clears the screen

    bsr     replay          branch to replay game subroutine
    bsr     clear_screen    clears the screen
    rts                     return from gameloop: subroutine

*-------------------------------------------------------
*------------ Player name and Company name---------------
*-------------------------------------------------------
playerName:
    bsr clear_screen ;clears the screen
    lea     name_msg,A1 ; creates the message
    move.b  #14,D0 ; display the message
    trap    #15 ; trap and interpret value in D0
    
    lea     NAME,a1 ; creates the message
    move.b  #2,D0 ; stops the message from continuing to the next msg
    trap    #15 ; trap and interpret value in D0
    
    lea     passport_msg,A1 ; creates the message
    move.b  #14,D0 ; display the message
    trap    #15 ; trap and interpret value in D0
    
    lea     company_msg,a1 ; creates the message
    move.b  #2,D0 ; display the message
    trap    #15 ; trap and interpret value in Dsg,

    lea     certificate_msg,A1 ; creates the message
    move.b  #14,D0 ; display the message
    trap    #15 ; trap and interpret value in D0
    
    move.b #4,d0 ; stops the texts from conutining on
    trap    #15 ; trap and interpret value in D0
    


    rts
   
*-------------------------------------------------------
*--------------------Location---------------------------
* where you staring place is
*------------------------------------------------------- 
location: 
    bsr     clear_screen ; clears the screen
    lea     location_msg,A1 ; sends the msg to a1
    move.b  #14,D0  ; displays the message
    trap    #15     ;trap and interpret value in D0
    lea     location_text,a1
    move.b  #14,D0  ;display the message
    trap    #15     ;trap and interpret value in D0
    move.b  #4,D0        stops the continuing to the next msg   
    trap    #15          trap and interpret value in D0
    
    cmp     #Iraq,d1 ;checks the number
    beq     LocationA ; go to this branch
    cmp     #Iran, d1 ;checks the number
    beq     LocationB ; go to this branch
    cmp     #Syria,d1 ;checks the number
    beq     LocationC ; go to this branch
    bsr     location ; go to this branch if none of the three is pressed
    rts

*-------------------------------------------------------
*--------------------Iraq-------------------------------
* Iraq Actions
*------------------------------------------------------- 

LocationA:

    bsr     clear_screen ; clears the screen
    lea     Iraq_msg,A1 ; sends the msg to a1
    move.b  #14,d0 ; display the text
    trap    #15 ;trap and interpret value in D0
    lea     startStats_msg,A1 ; sends the msg to a1
    move.b  #14,d0 ; display the text
    trap    #15 ;trap and interpret value in D0
    move.b  #4,d0 ; stops the texts from conutining on
    trap    #15 ;trap and interpret value in D0
    rts ; returns
*-------------------------------------------------------
*--------------------Iran-------------------------------
* Iran Actions
*------------------------------------------------------- 

LocationB:

    bsr     clear_screen ; clears the screen
    lea     Iran_msg,A1 ; sends the msg to a1
    move.b  #14,d0 ; display the text
    trap    #15 ;trap and interpret value in D0
    lea     startStats_msg,A1 ; sends the msg to a1
    move.b  #14,d0 ; display the text
    trap    #15 ;trap and interpret value in D0
    move.b  #4,d0 ; stops the texts from conutining on
    trap    #15 ;trap and interpret value in D0
    rts ; returns

*-------------------------------------------------------
*--------------------Syria-----------------------------
* Syria Actions
*------------------------------------------------------- 

LocationC

    bsr     clear_screen ; clears the screen
    lea     Syria_msg,A1 ;sends the msg to a1
    move.b  #14,d0 ; display the text
    trap    #15 ;trap and interpret value in D0
    lea     startStats_msg,A1 ; sends the msg to a1
    move.b  #14,d0 ; display the text
    trap    #15 ;trap and interpret value in D0
    move.b  #4,d0  ; stops the texts from conutining on
    trap    #15 ;trap and interpret value in D0
    rts ; returns
*-------------------------------------------------------
*--------------------Town-----------------------------
* town Actions
*------------------------------------------------------- 

Town:

    bsr     clear_screen ; clears the screen
    lea     town_msg,A1 ;sends the msg to a1
    move.b  #14,d0 ; display the text
    trap    #15 ;trap and interpret value in D0
    move.b  #4,d0 ; stops the texts from conutining on
    trap    #15 ;trap and interpret value in D0
    
    cmp     #Hospital,d1 ; checks 
    beq     Shop1 ; go to this branch
    cmp     #Black_Market, d1 ; checks 
    beq     Shop2 ; go to this branch
    cmp     #Contractors,d1 ; checks 
    beq     Shop3 ; go to this branch
    cmp     #leaveTown,d1 ; checks 
    beq     Leave ; go to this branch
    cmp     #5,d1 ; checks 
    beq     Inventory ; go to this branch
    bsr     clear_screen    clears the screen
    bsr     town ; if none of the is selected reset
    rts
    
*-------------------------------------------------------
*--------------------Hospital-----------------------------
* Hospital Actions
*------------------------------------------------------- 

Shop1:
    bsr     clear_screen ; clears the screen
    lea     Hospital_msg,A1 ;sends the msg to a1
    move.b  #14,d0 ; display the text
    trap    #15 ;trap and interpret value in D0
      
    move.b  #4,d0 ; stops the texts from conutining on
    trap    #15 ;trap and interpret value in D0
    
    move.b  #0,d2 ; resets the resgister d2 to 0
    
    cmp     #1,d1 ; checks
    beq     Bandages ; branch to this
    
    cmp     #2,d1 ; checks
    beq     Pills ; branch to this
    
    cmp     #3,d1 ; checks
    beq     Medkits ; branch to this
   
    cmp     #4,d1 ; checks
    beq     Town ; branch to this
    bsr     Shop1 ; if none is selected to reset
    bsr     clear_screen    clears the screen
    
Bandages:
    bsr     display_stat  ;displays the stat of the player
    lea     bandage_msg,a1  ;sends the msg to a1
    move.b  #14,d0 ; display the text
    trap    #15 ;trap and interpret value in D0
   
    move.b  #4,d0 ; stops the texts from conutining on
    trap    #15 ;trap and interpret value in D0
    
    add D1, ($10600) ; adds to the medical supply
    add D1, ($10610) ; adds to the bandage supply
   
    add #40, d2 ; add 40 to d2
    mulu  d1,d2 ; then mulitply it by the user input
    sub d2, ($10000) ; subtract it to the money


    bsr Shop1 ; branch to this
Pills:
    bsr     display_stat ; displays the player stat 
    lea     pills_msg,a1 ;sends the msg to a1
    move.b  #14,d0 ; display the text
    trap    #15 ;trap and interpret value in D0
   
    move.b  #4,d0 ; stops the texts from conutining on
    trap    #15 ;trap and interpret value in D0
    
    add D1, ($10600) ; adds to the medical supply
    add D1, ($10620) ; adds to the pill supply
   
    add #60, d2 ; add 60 to d2
    mulu  d1,d2 ; multiply d2 to d1
    sub d2, ($10000) ; subtract it to the money
    bsr Shop1

Medkits:
    bsr     display_stat ; display the stat of the player
    lea     medkits_msg,a1  ;sends the msg to a1
    move.b  #14,d0 ; display the text
    trap    #15 ;trap and interpret value in D0
   
    move.b  #4,d0 ; stops the texts from conutining on
    trap    #15 ;trap and interpret value in D0
    
    add D1, ($10600) ; adds to the medical supply
    add D1, ($10630) ; adds to medkit supply
   
    add #100, d2 ; add 100 to d2
    mulu  d1,d2 ; ; multiply d2 to d1
    sub d2, ($10000)  ; subtract it to the money

    bsr Shop1
        
    
*-------------------------------------------------------
*--------------------Black Market-----------------------------
* Black Market Actions
*------------------------------------------------------- 

Shop2:
    bsr     clear_screen ;clears the screen
    lea     BlackMarket_msg,A1 ;sends the msg to a1
    move.b  #14,d0 ; display the text
    trap    #15 ;trap and interpret value in D0
    
    move.b  #4,d0 ; stops the texts from conutining on
    trap    #15 ;trap and interpret value in D0
    
    move.b  #0,d2 ; resets the d2 to 0
    
    cmp     #1,d1 ; checks
    beq     AK47
    
    cmp     #2,d1 ; checks
    beq     M4
    
    cmp     #3,d1 ; checks
    beq     SniperRife
    
    cmp     #4,d1 ; checks
    beq     Town
    bsr     Shop2

    bsr     clear_screen    clears the screen
    
    
AK47:
    bsr     display_stat  ; displays the player stats
    lea     ak47_msg,a1 ;sends the msg to a1
    move.b  #14,d0 ; display the text
    trap    #15 ;trap and interpret value in D0
   
    move.b  #4,d0 ; stops the texts from conutining on
    trap    #15 ;trap and interpret value in D0
    
    add D1, ($10700) ;weapon supply
    add D1, ($10710) ;AK47 supply
   
    add #50, d2 ; add 50 to d2
    mulu  d1,d2 ; multiply d2 to d1
    sub d2, ($10000)  ; subtract it to the money
    
    bsr     Shop2 ; branch to this
M4:
    bsr     display_stat  ;display the player's stats
    lea     m4_msg,a1 ;sends the msg to a1
    move.b  #14,d0 ; display the text
    trap    #15 ;trap and interpret value in D0
   
    move.b  #4,d0 ; stops the texts from conutining on
    trap    #15 ;trap and interpret value in D0
    
    add D1, ($10700) ; weapon supply
    add D1, ($10720)  ; m4 supply
   
    add #100, d2 ; add 100 to d2
    mulu  d1,d2 ; multiply d2 to d1
    sub d2, ($10000)  ; subtract it to the money
    
    bsr     Shop2 ; branch to this

SniperRife:
    bsr     display_stat  ; displays the stats of the player
    lea     sniper_msg,a1 ;sends the msg to a1
    move.b  #14,d0 ; display the text
    trap    #15 ;trap and interpret value in D0
   
    move.b  #4,d0 ; stops the texts from conutining on
    trap    #15 ;trap and interpret value in D0
    
    add D1, ($10700) ; weapon supply
    add D1, ($10730) ; sniper rife
   
    add #150, d2 ; add 150 to d2
    mulu  d1,d2 ; multiply d2 to d1
    sub d2, ($10000)  ; subtract it to the money

    bsr     Shop2 ; branch to this
    
*-------------------------------------------------------
*--------------------Contractors office-----------------
* Contractors office Actions
*------------------------------------------------------- 

Shop3:
    bsr     clear_screen ; clears the screen
    lea     contractors_msg,A1 ;sends the msg to a1
    move.b  #14,d0 ; display the text
    trap    #15 ;trap and interpret value in D0
    

    move.b  #4,d0 ; stops the texts from conutining on
    trap    #15 ;trap and interpret value in D0
    
    move.b  #0,d1 reset the value
    
    
    cmp     #1,d1 ; checks
    beq     Recruit ; branch to this

    cmp     #2,d1 ; checks
    beq     Town ; branch to this
    bsr     Shop3 ; branch
    bsr     clear_screen    clears the screen
    
*-------------------------------------------------------
*--------------------Contractors office-----------------
* Recruitment office
*------------------------------------------------------- 
Recruit:  
    bsr     display_stat  ;displays the player stats
    lea     recruit_msg,a1 ;sends the msg to a1
    move.b  #14,d0 ; display the text
    trap    #15 ;trap and interpret value in D0
   
    move.b  #4,d0 ; stops the texts from conutining on
    trap    #15 ;trap and interpret value in D0
    
    mulu #100, D1 :mulitply 100 to regiseter d1
 
    sub D1, ($10000)  : sub d2, ($10000)  ; subtract it to the money
    add D1, ($10100)  ; subtract it to the money

    bsr Shop3 branch to this
   
    
*-------------------------------------------------------
*--------------------Leave the town-----------------
*Leave town Actions
*------------------------------------------------------- 

Leave:
    bsr     clear_screen ;clears the screen
    lea     location_msg,A1 ;sends the msg to a1
    move.b  #14,D0 ; display the text
    trap    #15 ;trap and interpret value in D0
    lea     action_msg,A1 ;sends the msg to a1
    move.b  #14,d0 #14,D0 ; display the text
    trap    #15 ;trap and interpret value in D0
    move.b  #4,d0 ; stops the texts from conutining on
    trap    #15 ;trap and interpret value in D0
    
    cmp     #1,d0 ; checks
    beq     gameplay ;noy playable in terms of combant
    
    cmp     #2,d1 ; checks
    beq     Town branch

    bsr     clear_screen    clears the screen
    
*-------------------------------------------------------
*--------------------Display stats-----------------
* Display stats
*-------------------------------------------------------    

display_stat:
    lea health_msg,A1 ;sends the msg to a1
    move.b #14, D0 ; display the text
    trap #15 ;trap and interpret value in D0
    
    move ($10050),D1 ; player heatlh
    move.b #3, D0 ; show its value
    trap #15 ;trap and interpret value in D0
    
    lea money_msg,A1 ;sends the msg to a1
    move.b #14, D0 ; display the text
    trap #15 ;trap and interpret value in D0
    
    move ($10000),D1 ; heatlh data
    move.b #3, D0 ; show its value
    trap #15 ;trap and interpret value in D0
     
    lea might_msg,A1 ;sends the msg to a1
    move.b #14, D0 ; display the text
    trap #15 ;trap and interpret value in D0
    
    move ($10100),D1
    move.b #3, D0 ; show its value
    trap #15 ;trap and interpret value in D0
    
    lea medical_msg,A1 ;sends the msg to a1
    move.b #14, D0 ; display the text
    trap #15 ;trap and interpret value in D0
    
    move ($10600),D1
    move.b #3, D0 ; show its value
    trap #15 ;trap and interpret value in D0
    
    lea weapons_msg,A1 ;sends the msg to a1
    move.b #14, D0 ; display the text
    trap #15 ;trap and interpret value in D0
    
    move ($10700),D1
    move.b #3, D0 ; show its value
    trap #15 ;trap and interpret value in D0
    
    rts
*--------------------------------------------------------
*--------------------Inventory-----------------
* Inventory
*-------------------------------------------------------    

Inventory:

    bsr     display_stat ; displays the player stats
    
    lea item1_msg,A1 ;sends the msg to a1
    move.b #14, D0 ; display the text
    trap #15 ;trap and interpret value in D0
    
    move ($10610),D1 ; move to d1
    move.b #3, D0 ; show its value
    trap #15 ;trap and interpret value in D0
    
    lea item2_msg,A1 ;sends the msg to a1
    move.b #14, D0 ; display the text
    trap #15 ;trap and interpret value in D0
    
    move ($10620),D1 ; move to d1
    move.b #3, D0 ; show its value
    trap #15 ;trap and interpret value in D0
     
    lea item3_msg,A1 ;sends the msg to a1
    move.b #14, D0 ; display the text
    trap #15 ;trap and interpret value in D0
    
    move ($10630),D1 ; move to d1
    move.b #3, D0 ; show its value
    trap #15 ;trap and interpret value in D0
    
    lea item4_msg,A1 ;sends the msg to a1
    move.b #14, D0 ;displays the text
    trap #15 ;trap and interpret value in D0
    
    move ($10710),D1 ; move to d1
    move.b #3, D0 ; show its value
    trap #15 ;trap and interpret value in D0
    
    lea item5_msg,A1 ;sends the msg to a1
    move.b #14, D0 ;displays the text
    trap #15 ;trap and interpret value in D0
    
    move ($10720),D1 ; move to d1
    move.b #3, D0  ;displays the value
    trap #15 ;trap and interpret value in D0
    
    lea item6_msg,A1 ;sends the msg to a1
    move.b #14, D0 ;displays the text
    trap #15 ;trap and interpret value in D0
    
    move ($10720),D1 ; move to d1
    move.b #3, D0 ; show its value
    trap #15 ;trap and interpret value in D0
    
    lea inventory_msg,a1 ;sends the msg to a1
    move.b  #14,d0 ; display the text
    trap    #15 ;trap and interpret value in D0
    
    move.b  #4,d0 ; stops the text from continuing 
    trap    #15 ;trap and interpret value in D0
    
    cmp     #1,d1 ; checks
    beq     Consumption ; branch to this
    
    cmp     #2,d1 ; checks
    beq     Town ;branch to this
    
    add #0,D1 ; reset the resigster d1 to 0

*--------------------------------------------------------
*--------------------Consumption-----------------
* Consumption - Not Working as intended
*-------------------------------------------------------   

Consumption:

    
    lea     choice_msg,a1 ;sends the msg to a1
    move.b  #14,d0 ; display the text
    trap    #15 ;trap and interpret value in D0
    
    move.b  #4,d0 ; stops the texts from conutining on
    trap    #15 ;trap and interpret value in D0
    
    cmp #1,d0 ; checks
    beq medUse1 ; branch to this
    cmp #2,d0 ; checks
    beq medUse2 ; branch to this
    cmp #3,d0 ; checks
    beq medUse3 ; branch to this
    cmp #4,d0 ; checks
    beq weapUse1 ; branch to this
    cmp #5,d0 ; checks
    beq weapUse2 ; branch to this
    cmp #6,d0 ; checks
    beq weapUse3 ; branch to this

medUse1:
    lea consumption_msg,a1 ;sends the msg to a1
    move.b  #14,d0 ; display the text
    trap    #15 ;trap and interpret value in D0
    
    move.b  #4,d0 ; stops the texts from conutining on
    trap    #15 ;trap and interpret value in D0
    
    sub D1, ($10600) ;subtract medical supply
    sub D1, ($10610) ;subtract bandage supply
   
    add d2, ($10000) ;subtract money
    bsr Inventory ; branch to this
medUse2:
    lea consumption_msg,a1 ;sends the msg to a1
    move.b  #14,d0 ; display the text
    trap    #15 ;trap and interpret value in D0
    
    move.b  #4,d0 ; stops the texts from conutining on
    trap    #15 ;trap and interpret value in D0
    
    add #100, ($10050) ;player heals
    sub D1, ($10600) ;subtract medical supply
    sub D1, ($10620) subtract pills supply
    bsr Inventory ; branch to this
medUse3:
    lea consumption_msg,a1 ;sends the msg to a1
    move.b  #14,d0 ; display the text
    trap    #15 ;trap and interpret value in D0
    
    move.b  #4,d0 ; stops the texts from conutining on
    trap    #15 ;trap and interpret value in D0
    
    add #150, ($10050) ; give health to the player
    sub D0, ($10600) ;subtract medical supply
    sub D0, ($10630) subtract medkits supply
    bsr Inventory ; branch to this
weapUse1:
    lea consumption_msg,a1 ;sends the msg to a1
    move.b  #14,d0 ; display the text
    trap    #15 ;trap and interpret value in D0
    
    move.b  #4,d0 ; stops the texts from conutining on
    trap    #15 ;trap and interpret value in D0
    
    add #50, ($10100) ;subtract weapon supply
    sub D1, ($10700) ;subtract weapon supply
    sub D1, ($10710) ;subtract  ak-47 weapon supply
    bsr Inventory ; branch to this
weapUse2:
    lea consumption_msg,a1 ;sends the msg to a1
    move.b  #14,d0 ; display the text
    trap    #15 ;trap and interpret value in D0
    
    move.b  #4,d0 ; stops the texts from conutining on
    trap    #15 ;trap and interpret value in D0
    
    add #100, ($10100) ;subtract weapon supply
    sub D1, ($10700) ;subtract weapon supply
    sub D1, ($10720) ;subtract  m4 weapon supply
    bsr Inventory ; branch to this
weapUse3:
    lea consumption_msg,a1 ;sends the msg to a1
    move.b  #14,d0 ; display the text
    trap    #15 ;trap and interpret value in D0
    
    move.b  #4,d0 ; stops the texts from conutining on
    trap    #15 ;trap and interpret value in D0
    
    add #150, ($10100) ; add might to player stats
    sub D1, ($10700) ;subtract weapon supply
    sub D1, ($10730) ; subtrct sniper rife supply
    bsr Inventory ; branch to this
*-------------------------------------------------------
*---Game Play (Quest Progress)--------------------------
*------------------------------------------------------- 
gameplay:
    bsr     endl ; next line
    lea     gameplay_msg,A1 ;sends the msg to a1
    move.b  #14,D0 ; display the text
    trap    #15 ;trap and interpret value in D0
    move.b  #4,D0       stops the continuing to the next msg 
    trap    #15         trap and interpret value in D0
    rts

*-------------------------------------------------------
*------------------Screen Decoration--------------------
*-------------------------------------------------------
out:
    lea     loop_msg,A1 ;sends the msg to a1
    move.b  #14,D0 ; display the text
    trap    #15 ; trap and interpret value in D0
	sub     #1,D3   decrement loop counter
    bne     out	    repeat until D0=0
    bsr     endl ; next line
    rts ; return
    
clear_screen: 
    move.b  #11,D0      clear screen
    move.w  #$ff00,D1 ; ?????
    trap    #15 ;trap and interpret value in D0
    rts
*-------------------------------------------------------
*------------------------Replay-------------------------
*-------------------------------------------------------
replay:

    cmp     #exit,D1 ;Checks
    beq     end         if SR Z register contains 1 beq => Branch Equals
    bsr     gameloop ; game loop

endl:
    movem.l D0/A1,-(A7)
    move    #14,D0 ; display the text
    lea     crlf,A1
    trap    #15 ;trap and interpret value in D0
    movem.l (A7)+,D0/A1
    rts
    
*-------------------------------------------------------
*-------------------Data Delarations--------------------
*-------------------------------------------------------

crlf:           dc.b    $0D,$0A,0
welcome_msg:    dc.b   '********************************************************************************',$0D,$0A       
                dc.b   ' _____        _               _          __  __  _  _  _  _      '  ,$0D,$0A
                dc.b   '|  __ \      (_)             | |        |  \/  |(_)| |(_)| |  ',$0D,$0A
                dc.b   '| |__) |_ __  _ __   __ __ _ | |_  ___  | \  / | _ | | _ | |_   _ _  _ _  _   _ -',$0D,$0A
                dc.b   '|  ___/|  __|| |\ \ / // _` || __|/ _ \ | |\/| || || || || __|/ _` || __|| | | |',$0D,$0A
                dc.b   '| |    | |   | | \ V /| (_| || |_|  __/ | |  | || || || || |_| (_| || |  | |_| |',$0D,$0A
                dc.b   '|_|    |_|   |_|  \_/  \__,_| \__|\___| |_|  |_||_||_||_| \__|\__,_||_|   \__, |',$0D,$0A
                dc.b    '                                                                          __/ /',$0D,$0A
                dc.b    '                                                                         |___/',$0D,$0A
                dc.b    'Welcome to Private Military Simulator',$0D,$0A
                dc.b    '********************************************************************************',$0D,$0A
                dc.b    'Where you lead and control a Private Military Company or for short PMCs.',$0D,$0A
                dc.b    'Your job is to create havoc or create peace for a price.',$0D,$0A
                dc.b    'Train men to their fullest potential to have the',$0D,$0A
                dc.b    'strongest Private Military Company. Upgrade your weapons',$0D,$0A
                dc.b    'and military might through technologies or buying equipments.',$0D,$0A
                dc.b    'Earning funds for your PMC is by taking Agency missions',$0D,$0A
                dc.b    'or by selling and arming rebels or terrorist cells in different countries.',$0D,$0A
                dc.b    '********************************************************************************',$0D,$0A
                dc.b    '                                  Press enter                                   ',0
name_msg:       dc.b    '********************************************************************************',$0D,$0A 
                dc.b    'Type:    Country code:     Citizen of XXXXXXX XX XXXXX         Passport No:     ',$0D,$0A 
                dc.b    'X        XXX                                                   XX329546'
                dc.b    '                                Passport Details                             ',$0D,$0A,$0D,$0A
                dc.b    'Given First Name: ',0
passport_msg:   dc.b    'Given Surname: XXXXXXXX',$0D,$0A
                dc.b    'Date of Birth: XX/XX/XXXX      Record No: XXXXXXXXXXX',$0D,$0A 
                dc.b    'Nationality: XXXXXXX',$0D,$0A 
                dc.b    'SEX M/F: X     Place of Birth: XXXXXX,XXXXX',$0D,$0A 
                dc.b    'Date issue: XX/XX/XXXX         Authority: XXXXX',$0D,$0A
                dc.b    'Date of expiry: XX/XX/XXXX',$0D,$0A 
company_msg:    dc.b   '********************************************************************************',$0D,$0A 
                dc.b    '                          XXXXXXXXXXXXXXXXXXXXXX                        ',$0D,$0A
                dc.b    '                  Voluntary certification system <<XXXXXXXXX>>          ',$0D,$0A
                dc.b    '  is registered with the federal agency of technical regulation and metrology',$0D,$0A 
                dc.b    '  Central certification body LLC <<Independent Certificaion Center <<Alliance>>',$0D,$0A
                dc.b    '         Address: X XXXXXXXXXXX  XX, XXXXXXX, 5X, XXXXXXXX.13208,XXXXXXX       ',$0D,$0A
                dc.b    '                           CONFORMANCE CERTIFICATE                      ',$0D,$0A
                dc.b    '                         NO SMK.XX/XX.XX - 00172/00554                  ',$0D,$0A
                dc.b    '                               Granted to:                              ',$0D,$0A
                dc.b    '                            ',0
certificate_msg: dc.b   '            56,XXXXXXX Rd, Third Floor, XXXX City,XXXXXX, XXXXXXXXX     ',$0D,$0A             
                dc.b    '                           Register Number 82,630                       ',$0D,$0A 
                dc.b    '                        THIS CERTIFICATE CERTIFIES THAT:                ',$0D,$0A
                dc.b    '                         THE QUALITY MANAGEMENT SYSTEM                  ',$0D,$0A
                dc.b    '                                 as applied to                                       ',$0D,$0A
                dc.b    'maritime security, including arm security of the merchant fleet and escorting   ',$0D,$0A
                dc.b    'protection of sea ports, protection of sea platforms and pipelines, installation',$0D,$0A
                dc.b    'of special equipment on vessels boards in the condition of piracy activity, land',$0D,$0A                                                                    ',$0D,$0A
                dc.b    'security, including armed guaeding of stationary objects, oil and gas pipelines,',$0D,$0A
                dc.b    'physical persons, cargoes convoy; demining; consultion services and audit in    ',$0D,$0A
                dc.b    'security affairs; security training of personnel for land and sea operations.   ',$0D,$0A
                dc.b    '********************************************************************************',$0d,$0A
                dc.b    '                                 Press Enter                                    ',0
location_msg:   dc.b    '&,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,&',$0d,$0A
                dc.b    '%*.....#.  **                  ,      ...,,..  ,. .*         ..        (       %',$0d,$0A
                dc.b    '%.*.*(...........,.    ..               (...,(         (                    *( %',$0d,$0A
                dc.b    '%........(...* ,((.  3.Syria     (                      ((.            (    .  %',$0d,$0A
                dc.b    '%*................ (             ,           2.Iran                   (      . %',$0d,$0A
                dc.b    '% #............./%    #                                              #         %',$0d,$0A
                dc.b    '%     ## , %...#&          1.Iraq /                     ,          *         . %',$0d,$0A
                dc.b    '%          .    *                                                /          (  %',$0d,$0A
                dc.b    '%              (  (,        .(      *                          *.          *   %',$0d,$0A
                dc.b    '%           * #               .,,.. *...*                 ,             /.     %',$0d,$0A
                dc.b    '%            ...                     ....#                  *           ,      %',$0d,$0A
                dc.b    '%            (...                     #.....     ,(         (                  %',$0d,$0A
                dc.b    '%             *...                      ##.,,,*..*,.          ((/*(..    .*    %',$0d,$0A
                dc.b    '%              ...#                     ( ....** ,#**...,............*/        %',$0d,$0A
                dc.b    '% .(.          ......                     .#        .(*/*........(......(    , %',$0d,$0A
                dc.b    '%          ,     ....                      ,(,  ,       #..*//./..........% #. %',$0d,$0A
                dc.b    '%                /...                            *     *.,..............*(*... %',$0d,$0A
                dc.b    '%                (*...#                              *,..(*(*.....*........... %',$0d,$0A
                dc.b    '%                #......                     /       (...*........*........*.. %',$0d,$0A
                dc.b    '%                 */.*..(            ./            (.................**,**.... %',$0d,$0A
                dc.b    '%              .    .(.... *( (             .    ...........................*. %',$0d,$0A
                dc.b    '%                   *@....,                 .......................#(*........ %',$0d,$0A
                dc.b    '%             (.* (%* .,..(             ,%(**.............(................... %',$0d,$0A
                dc.b    '%            (         , ..        #*.....................*.........         ( %',$0d,$0A
                dc.b    '%                        ( .*...,..,,.........#(.*.................. .,,    ,( %',$0d,$0A
                dc.b    '%,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,%',$0d,$0A,0
location_text:  dc.b    '                 Pick your starting point: 1. Iraq 2. Iran 3. Syria           ',$0d,$0A
                dc.b    '********************************************************************************',$0d,$0A,0
Iraq_msg:       dc.b    '********************************************************************************',$0d,$0A
                dc.b    '                      Welcome to the to the nation of Iraq.                     ',$0d,$0A  
                dc.b    '           You have landed in the aitport, you went to the city/town centre.    ',$0d,$0A,0
Iran_msg:       dc.b    '********************************************************************************',$0d,$0A
                dc.b    '                      Welcome to the to the nation of Iran.                     ',$0d,$0A
                dc.b    '           You have landed in the aitport, you went to the city/town centre.    ',$0d,$0A,0                
Syria_msg:      dc.b    '********************************************************************************',$0d,$0A
                dc.b    '                        Welcome to thee nation of Syria.                        ',$0d,$0A
                dc.b    '         You have landed on the air strip, you went to the city/town centre.    ',$0d,$0A,0
startStats_msg: dc.b    '                      You Currently have $2000 marked money.                    ',$0d,$0A
                dc.b    '                       You Currently have 50 trained men.                       ',$0d,$0A
                dc.b    '                    This is the starting point of your PMC.                     ',$0d,$0A
                dc.b    '                               Create History.                                  ',$0d,$0A
                dc.b    '                            Create Peace or Chaos.                              ',$0d,$0A
                dc.b    '                            Be Famous or infamous.                              ',$0d,$0A
                dc.b    '                         Your future is in your hand                            ',$0d,$0A
                dc.b    '********************************************************************************',$0d,$0A
                dc.b    '                                   Press Enter                                  ',$0d,$0A,0
town_msg:       dc.b    '********************************************************************************',$0d,$0A
                dc.b    '                       Welcome to the city/town centre.                         ',$0D,$0A
                dc.b    '********************************************************************************',$0d,$0A
                dc.b    '+I??I+?+||~~~~~I|000000000???=000000???+,000000000000I??????????????????????????',$0D,$0A
                dc.b    '?+????+?+|||~~~~~|~000000|||||||||:=:I_____0000000000.?????????????????????????',$0D,$0A
                dc.b    '+?+?I??+?+||||~~~~~|=00:|||||||||=000|11111|000000000000????????????????????????',$0D,$0A
                dc.b    '?+?+I???+?+|||||~~~~~|,000I|||||00.00|11111|?:0=00000000=???????????????????????',$0D,$0A
                dc.b    '+?=I?I?+?+|||||||+?~~~=|000,||,.00000|11111|000?~000000?????????????????????????',$0D,$0A
                dc.b    '?+I+????+I+I=||||||00~~~=|00:000,00=I0-----000=000,I,????________???????????????',$0D,$0A
                dc.b    'I???+????+?:000=,||||=0~~0|00~0=00.?.+~,00000.000000?___|44444444|??????????????',$0D,$0A
                dc.b    '???+?+?????,000000=00||~~~~||.0000?=0000,00000:00000|4444444444|_???????????????',$0D,$0A
                dc.b    '????+?+??______00000000|I~~~~|00?00000=,0,0,000:.0??|444444444444|??????????????',$0D,$0A
                dc.b    '?+???+?+|333333|__00000?|~~~~~~|I0000,=____=000000.?|4444444444|_???????????????',$0D,$0A
                dc.b    '???+???_|333333333|_00~~00|~~~~~|.+?00|2222|____00I??---|44444444|??????????????',$0D,$0A
                dc.b    '??????|3333333333333|_?0000||=~~~|????|2222222||?.???????--------???????????????',$0D,$0A
                dc.b    '??=??I?|33333333333333|000000|?~~~|???|2222222||???+=?????????????????????I~????',$0D,$0A
                dc.b    '??+?II+?--------------0000000======???|---------00.??????????????????=I?????????',$0D,$0A
                dc.b    '?=I?????I????????I00?I0000000|~~~~|????.=??????.00000000000:I???????????????????',$0D,$0A
                dc.b    '?+???+I???+??????????000000000|~~~~|????????I000000000000000000,I???????????????',$0D,$0A
                dc.b    '+????+II?+???????????0000000000|~~~|?????????00000000000000000=I????????????????',$0D,$0A
                dc.b    '???I+?????????+?????=000000========+???????=0000000000000000??+?????????????????',$0D,$0A
                dc.b    '????+??I+??I??+I????00000000|~~~~~~~|????I~00000000000000.??~???????????????????',$0D,$0A
                dc.b    '??I=?????II???+?+?????|==000=000~~|00000000000=.I??I?,??????????????????????????',$0D,$0A
                dc.b    '********************************************************************************',$0d,$0A
                dc.b    'Actions: 1. Hospital, 2. Black market 3. Contractors office 4. Leave town       ',$0D,$0A
                dc.b    'Actions: 5. check Inventory      ',$0D,$0A
                dc.b    '********************************************************************************',$0d,$0A,0
hospital_msg    dc.b    '                                               _________________                ',$0d,$0A
                dc.b    '                                              /_________________\               ',$0d,$0A
                dc.b    '                                              |====#=#===#=#====|               ',$0d,$0A
                dc.b    '     _________________________________________|       +H+       |               ',$0d,$0A
                dc.b    '    /                                         |_____________    |               ',$0d,$0A
                dc.b    '   /________________________________________________________\   |               ',$0d,$0A
                dc.b    '   |  [+] [+] [+] [+] [+] [+]  [+] [+] [+] [+] [+] [+] [+]  |   |               ',$0d,$0A
                dc.b    '  :==============================================================:|             ',$0d,$0A
                dc.b    '  | [+] [+] [+] [+] [+] [+] [+]  [+] [+] [+] [+] [+] [+] [+] [+] ||             ',$0d,$0A
                dc.b    '  |--------------------------------------------------------------||             ',$0d,$0A
                dc.b    '  | [+] [+]:[+]:[+]:[+]:[+] [+]  [+] [+] [+] [+] [+] [+] [+] [+] ||             ',$0d,$0A
                dc.b    '  |        :::::::::::::                                         ||             ',$0d,$0A
                dc.b    '  | [+] [+]:[+]:[+]:[+]:[+] [+]  ( ) [+] [+] [+] [+] [+] [+] [+] ||             ',$0d,$0A
                dc.b    '  |         :::::::::::(  )      (   )                           ||             ',$0d,$0A
                dc.b    '  ()[+] ()]:[():[():[( )  ) [( |     )+] [+] [+] [+] [+] [+] [+] ||             ',$0d,$0A
                dc.b    '  (  )  (  ):( ))(  )(      )(  |   )  )  ( ) ()  ( )        (  ))|             ',$0d,$0A
                dc.b    '  (   )(   ))( )( ( ) (   )  )  | (     )(  )(  )(   )[+] [+]( (  ))            ',$0d,$0A
                dc.b    '  ( ))  (  )( ( )(  )(  (   ) ( |   )  )(    )  )( ) )---:::::(  ) )            ',$0d,$0A
                dc.b    '  ============================= | (  )    ( ) )   ( )    ::::::( )              ',$0d,$0A
                dc.b    '  -----------------------------=====================================            ',$0d,$0A
                dc.b    '********************************************************************************',$0d,$0A
                dc.b    'You have entered the hospital and you see an abundance of medical supplies',$0D,$0A
                dc.b    '********************************************************************************',$0d,$0A
                dc.b    'The hospital stocks: 1.Bandages($40), 2.Pills($60) 3.Medkits($100) 4. Leave',$0D,$0A,0
BlackMarket_msg dc.b    '                     _._._                       _._._                     ',$0D,$0A
                dc.b    '                    _|   |_                     _|   |_                    ',$0D,$0A
                dc.b    '                    | ... |_._._._._._._._._._._| ... |                    ',$0D,$0A
                dc.b    '                    | ||| |  o  Black Market o  | ||| |                    ',$0D,$0A
                dc.b    '                    | """ |  """    """    """  | """ |                    ',$0D,$0A
                dc.b    '               ())  |[-|-]| [-|-]  [-|-]  [-|-] |[-|-]|  ())               ',$0D,$0A
                dc.b    '              (())) |     |---------------------|     | (()))              ',$0D,$0A
                dc.b    '             (())())| """ |  """    """    """  | """ |(())())             ',$0D,$0A
                dc.b    '             (()))()|[-|-]|  :::   .-"-.   :::  |[-|-]|(()))()             ',$0D,$0A
                dc.b    '             ()))(()|     | |~|~|  |_|_|  |~|~| |     |()))(()             ',$0D,$0A
                dc.b    '                ||  |_____|_|_|_|__|_|_|__|_|_|_|_____|  ||                ',$0D,$0A
                dc.b    '********************************************************************************',$0d,$0A
                dc.b    'You have entered the Black Market and see alot of weapons',$0D,$0A
                dc.b    '********************************************************************************',$0d,$0A
                dc.b    'Black Market stock: 1.AK47s($50), 2.M4($120)3.Sniper rife($150) or 4. Leave',$0D,$0A
                dc.b    '********************************************************************************',$0d,$0A,0
contractors_msg: 
                dc.b '                 ^                   |~                                              ',$0d,$0A
                dc.b '               ^     ^  ^        _|__|__|_           ^   ^                           ',$0d,$0A
                dc.b '                 ___________    _|  | |  |_    ___________   ^                       ',$0d,$0A
                dc.b '                (__IXIXIXIXI___|_|__|_|__|_|___IXIXIXIXI__)                          ',$0d,$0A
                dc.b '                (__|"|"|"|"| [=][=] [=] [=][=] |"|"|"|"|__)                          ',$0d,$0A
                dc.b '                (__|"|"|"|"| [=][=] [=] [=][=] |"|"|"|"|__)                           ',$0d,$0A
                dc.b '                (__|"|"|"|"| [=][=] [=] [=][=] |"|"|"|"|__)                          ',$0d,$0A
                dc.b '                (__|"|"|"|"| [=][=] [=] [=][=] |"|"|"|"|__)                          ',$0d,$0A
                dc.b '                (__|"|"|"|"| [=][=] [=] [=][=] |"|"|"|"|__)                          ',$0d,$0A
                dc.b '              /)(__|"|"|"|"| [=][=] [=] [=][=] |"|"|"|"|__)                          ',$0d,$0A
                dc.b '            _/ )(__|"|"|"|"| [=][=] [=] [=][=] |"|"|"|"|__)_/)_                      ',$0d,$0A
                dc.b '             ~^^(__|"|"|"|"| [=][=] [=] [=][=] |"|"|"|"|__) ~~^                      ',$0d,$0A
                dc.b '            ^~~ (__|"|"|"|"| [=][=] [=] [=][=] |"|"|"|"|__)~~^                       ',$0d,$0A
                dc.b '           """""IXI~IXI~IXI~IXI~=I=I=I=I=~IXI~IXI~IXI~IXI""""""                      ',$0d,$0A
                dc.b '               """"""""""""""""""|   |""""""""""""""""""                             ',$0d,$0A
                dc.b    '********************************************************************************',$0d,$0A
                dc.b    'You enter the contractors office and see brunch of paper work on the desk',$0D,$0A
                dc.b    '********************************************************************************',$0d,$0A
                dc.b    '                             1. Recruit men 2. Leave                            ',$0D,$0A,0
recruit_msg:    dc.b    $0D,$0A,'              How many Contractors do you want? ($100 for 100)          ',$0D,$0A
                dc.b    '********************************************************************************',$0d,$0A,0
action_msg      dc.b    '                           1.Move out 2.Back to town.                           ',$0D,$0A
                dc.b    '********************************************************************************',$0d,$0A,0
money_msg       dc.b    $0D,$0A,'Money: ',0
health_msg      dc.b    $0D,$0A,'Health: ',0
might_msg       dc.b    $0D,$0A,'Might: ',0
medical_msg     dc.b    $0D,$0A,'Medical Supply: ',0
weapons_msg     dc.b    $0D,$0A,'Weapon Supply: ',0
item1_msg       dc.b    $0D,$0A,'Bandage Supply: ',0
item2_msg       dc.b    $0D,$0A,'Pill Supply: ',0
item3_msg       dc.b    $0D,$0A,'Medkits Supply: ',0
item4_msg       dc.b    $0D,$0A,'Ak-47Supply: ',0
item5_msg       dc.b    $0D,$0A,'M4 Supply: ',0
item6_msg       dc.b    $0D,$0A,'Sniper rifes Supply: ',0
inventory_msg   dc.b    $0D,$0A,'1.Use 2.Back'
                dc.b    $0D,$0A,0
bandage_msg:    dc.b    $0D,$0A,'                    How many Bandage do you want? ($40 each)            ',$0D,$0A,0
pills_msg:      dc.b    $0D,$0A,'                    How many Pills do you want? ($60 each)             ',$0D,$0A,0
medkits_msg:    dc.b    $0D,$0A,'                    How many Medkits do you want? ($100 each)           ',$0D,$0A,0
ak47_msg:       dc.b    $0D,$0A,'                    How many AK-47s do you want? ($40 each)             ',$0D,$0A,0
m4_msg:         dc.b    $0D,$0A,'                    How many M4s do you want? ($100 each)               ',$0D,$0A,0
sniper_msg:     dc.b    $0D,$0A,'                    How many Sniper rifes do you want? ($150 each)      ',$0D,$0A,0 
choice_msg:     dc.b    $0D,$0A,'1.Bandage(50HP) 2.Pills(100HP) 3.Medkits(150HP) 4.AK47(50MP) 5.M4(100MP)'
                dc.b    $0D,$0A,'6.Sniper rife (150MP)'
                dc.b    $0D,$0A,0
consumption_msg: dc.b   $0D,$0A,'How many item do you want to consumption',$0D,$0A,0
gameplay_msg    dc.b    $0D,$0A,'                             No Gameplay of combat                      ' ,$0D,$0A,0 
loop_msg        dc.b    $0D,$0A,'Loop',$0D,$0A,0 

    end start











*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
