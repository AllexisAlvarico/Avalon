    org $1000

*-------------------------------------------------------
*Title      : Private Military Simulator
*Written by : Allexis Alvarico
*Date       : 21/01/19
*Descrition : Text-base game project
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
    org     $3000      the rest of the program is to be located from 3000 onwards

*-------------------------------------------------------
*-------------------Game Subroutine---------------------
*-------------------------------------------------------
game:
    bsr     gameloop   branch to gameloop subroutine
    rts                return from game: subroutine
          
end:
    simhalt
NAME EQU $6000 ; stores the name to an adress
COMPANY_NAME EQU $7000 ; stores the player's company name
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
    
    bsr     endl            branch to endl subroutine
    rts                     return from welcome: subroutine
*------------------------------------------------------
*---------Gameplay Input Values Subroutine--------------
*-------------------------------------------------------    
input:
    bsr     location        branch to location input subroutine
    bsr clear_screen
    bsr     Town         branch to potion input subroutine
    bsr clear_screen
   ;bsr     weapons         branch to weaponss input subroutine
   ; bsr clear_screen
    rts

*-------------------------------------------------------
*----------------Gameloop (main loop)-------------------
*------------------------------------------------------- 
gameloop:
    bsr     update          branch to update game subroutine 
    bsr     clear_screen    clears the screen         
    bsr     draw            branch to draw screen subroutine
    bsr     clear_screen    clears the screen
    bsr     gameplay        branch to gameplay subroutine
    bsr     clear_screen    clears the screen
    bsr     hud             branch to display HUD subroutine
    bsr     clear_screen    clears the screen
    bsr     replay          branch to replay game subroutine
    bsr     clear_screen    clears the screen
    rts                     return from gameloop: subroutine

*-------------------------------------------------------
*----------------Update Quest Progress------------------
*  Complete Quest
*------------------------------------------------------- 
update:
    bsr     endl            print a CR and LF
    bsr     decorate        decorate with dots using a loop
    lea     update_msg,A1   
    move.b  #14,D0
    trap    #15
    bsr     decorate
    rts
*-------------------------------------------------------
*-----------------Draw Quest Updates--------------------
* Draw the game progress information, status regarding
* quest
*------------------------------------------------------- 
draw:
    bsr     endl
    bsr     decorate
    lea     draw_msg,A1
    move.b  #14,D0
    trap    #15
    bsr     decorate
    rts
    
*-------------------------------------------------------
*--------------------Location---------------------------
* where you staring place is
*------------------------------------------------------- 
location: 
    bsr     clear_screen 
    bsr     decorate
    lea     location_msg,A1
    move.b  #14,D0
    trap    #15
    move.b  #4,D0        stops the continuing to the next msg   
    trap    #15          trap and interpret value in D0
    
    cmp     #Iraq,d1
    beq     LocationA
    cmp     #Iran, d1
    beq     LocationB
    cmp     #Syria,d1
    beq     LocationC
    bsr     location
    rts

*-------------------------------------------------------
*--------------------Iraq-------------------------------
* Iraq Actions
*------------------------------------------------------- 

LocationA:

    bsr     decorate
    lea     Iraq_msg,A1
    move.b  #14,d0
    trap    #15
    move.b  #4,d0
    trap    #15
    bsr     decorate
    bsr     clear_screen    clears the screen
    rts
*-------------------------------------------------------
*--------------------Iran-------------------------------
* Iran Actions
*------------------------------------------------------- 

LocationB:

    bsr     decorate
    lea     Iran_msg,A1
    move.b  #14,d0
    trap    #15
    move.b  #4,d0
    trap    #15
    bsr     decorate
    bsr     clear_screen    clears the screen
    rts

*-------------------------------------------------------
*--------------------Syria-----------------------------
* Syria Actions
*------------------------------------------------------- 

LocationC

    bsr     decorate
    lea     Syria_msg,A1
    move.b  #14,d0
    trap    #15
    move.b  #4,d0
    trap    #15
    bsr     decorate
    bsr     clear_screen    clears the screen
    bsr     town
    rts
*-------------------------------------------------------
*--------------------Town-----------------------------
* town Actions
*------------------------------------------------------- 

Town:

    bsr     decorate
    lea     town_msg,A1
    move.b  #14,d0
    trap    #15
    move.b  #4,d0
    trap    #15
    
    cmp     #Hospital,d1
    beq     Shop1
    cmp     #Black_Market, d1
    beq     Shop2
    cmp     #Contractors,d1
    beq     Shop3
    cmp     #leaveTown,d1
    beq     Leave
    bsr     decorate
    bsr     clear_screen    clears the screen
    bsr     town
    rts
    
*-------------------------------------------------------
*--------------------Hospital-----------------------------
* Hospital Actions
*------------------------------------------------------- 

Shop1:
    bsr     clear_screen 
    bsr     decorate
    lea     Hospital_msg,A1
    bsr     decorate
    move.b  #14,d0
    trap    #15
    lea     medical_items_msg,a1
    move.b  #14,d0
    trap    #15
    move.b  #4,d0
    trap    #15
    bsr     decorate
    
    cmp     #4,d1
    beq     Town
    bsr     clear_screen    clears the screen
*-------------------------------------------------------
*--------------------Black Market-----------------------------
* Black Market Actions
*------------------------------------------------------- 

Shop2:
    bsr     clear_screen 
    bsr     decorate
    lea     BlackMarket_msg,A1
    bsr     decorate
    move.b  #14,d0
    trap    #15
    lea     weapon_items_msg,a1
    move.b  #14,d0
    trap    #15
    move.b  #4,d0
    trap    #15
    
    cmp     #4,d1
    beq     Town

    bsr     decorate
    bsr     clear_screen    clears the screen
    
*-------------------------------------------------------
*--------------------Contractors office-----------------
* Contractors office Actions
*------------------------------------------------------- 

Shop3:
    bsr     clear_screen 
    bsr     decorate
    lea     contractors_msg,A1
    bsr     decorate
    move.b  #14,d0
    trap    #15
    lea     contractors_mission_msg,a1
    move.b  #14,d0
    trap    #15
    move.b  #4,d0
    trap    #15
    
    cmp     #2,d1
    beq     Town

    bsr     decorate
    bsr     clear_screen    clears the screen

*-------------------------------------------------------
*--------------------Leave the town-----------------
*Leave town Actions
*------------------------------------------------------- 

Leave:
    bsr     clear_screen 
    bsr     decorate
    lea     action_msg,A1
    bsr     decorate
    move.b  #14,d0
    trap    #15
    move.b  #4,d0
    trap    #15
    
    cmp     #2,d1
    beq     Town

    bsr     decorate
    bsr     clear_screen    clears the screen
    
    
*-------------------------------------------------------
*------------ layer name and Company name---------------
*-------------------------------------------------------
playerName:
    bsr     decorate
    bsr clear_screen
    lea     name_msg,A1 ; creates the message
    move.b  #14,D0 ; display the message
    trap    #15 ; trap and interpret value in D0
    
    lea     NAME,a1 
    move.b  #2,D0 ; stops the message from continuing to the next msg
    trap    #15 ; trap and interpret value in D0
        
    lea     company_msg,a1
    move.b  #14,D0 ; display the message
    trap    #15 ; trap and interpret value in Dsg,
    
    move.b  #4,D0 ; stops the message from continuing to the next msg
    trap    #15 ; trap and interpret value in D0
    bsr     decorate
    
    
    
    rts
*-------------------------------------------------------
*-------------------------------------------------------
*---Game Play (Quest Progress)--------------------------
*------------------------------------------------------- 
gameplay:
    bsr     endl
    bsr     decorate
    lea     gameplay_msg,A1
    move.b  #14,D0
    trap    #15
    move.b  #4,D0       stops the continuing to the next msg 
    trap    #15         trap and interpret value in D0
    bsr     decorate
    bsr     collision
    rts

*-------------------------------------------------------
*-----------------Heads Up Display (Score)--------------
* Retrieves the score from memory location
*-------------------------------------------------------   
hud:

    bsr     endl
    bsr     decorate
    lea     hud_msg,A1
    move.b  #14,D0
    trap    #15
    move.b  (A3),D1     retrieve the value A3 point to and move to D1
    move.b  #3,D0       move literal 3 to D0
    trap    #15         intrepret value in D0, which 3 which displays D1
    bsr     decorate
    rts

*-------------------------------------------------------
*-----------------------Being Attacked------------------
* This could be used for collision detection
*-------------------------------------------------------
collision:
    move.b  #mine_loc,D1
    cmp     #100,D1 is( x == 100)?
	bne     collision_miss if x is equal to 100, then hit
collision_hit:
    *hit
    lea     hit_msg,A1
    move    #14,D0
    trap    #15
    rts
    
collision_miss:
    *miss
    lea     miss_msg,A1
    move    #14,D0
    trap    #15
    rts

*-------------------------------------------------------
*--------------------------Loop-------------------------
*-------------------------------------------------------
loop:
    move.b  #5, D3 loop counter D3=5
next:
    lea     loop_msg,A1
    move.b  #14,D0
    trap    #15
	sub     #1,D3   decrement loop counter
    bne     next    repeat until D0=0

*-------------------------------------------------------
*------------------Screen Decoration--------------------
*-------------------------------------------------------
decorate:
    move.b  #60, D3
    bsr     endl
out:
    lea     loop_msg,A1
    move.b  #14,D0
    trap    #15
	sub     #1,D3   decrement loop counter
    bne     out	    repeat until D0=0
    bsr     endl
    rts
    
clear_screen: 
    move.b  #11,D0      clear screen
    move.w  #$ff00,D1
    trap    #15
    rts
*-------------------------------------------------------
*------------------------Replay-------------------------
*-------------------------------------------------------
replay:
    bsr     endl
    lea     replay_msg,A1
    move.b  #14,D0
    trap    #15
    
    move.b  #4,D0
    trap    #15

    cmp     #exit,D1
    beq     end         if SR Z register contains 1 beq => Branch Equals
    bsr     gameloop

endl:
    movem.l D0/A1,-(A7)
    move    #14,D0
    lea     crlf,A1
    trap    #15
    movem.l (A7)+,D0/A1
    rts
    
*-------------------------------------------------------
*-------------------Data Delarations--------------------
*-------------------------------------------------------

crlf:           dc.b    $0D,$0A,0
welcome_msg:    dc.b    '************************************************************************'
                dc.b    $0D,$0A         
                dc.b   ' _____        _               _          __  __  _  _  _  _      '  
                dc.b    $0D,$0A               
                dc.b   '|  __ \      (_)             | |        |  \/  |(_)| |(_)| |  '
                dc.b    $0D,$0A
                dc.b   '| |__) |_ __  _ __   __ __ _ | |_  ___  | \  / | _ | | _ | |_   _ _  _ _  _   _ -'
                dc.b    $0D,$0A
                dc.b   '|  ___/|  __|| |\ \ / // _` || __|/ _ \ | |\/| || || || || __|/ _` || __|| | | |'
                dc.b    $0D,$0A
                dc.b   '| |    | |   | | \ V /| (_| || |_|  __/ | |  | || || || || |_| (_| || |  | |_| |'
                dc.b    $0D,$0A
                dc.b   '|_|    |_|   |_|  \_/  \__,_| \__|\___| |_|  |_||_||_||_| \__|\__,_||_|   \__, |'
                dc.b    $0D,$0A 
                dc.b    '                                                                          __/ /'
                dc.b    $0D,$0A 
                dc.b    '                                                                         |___/'
                dc.b    $0D,$0A
                dc.b    'Welcome to Private Military Simulator'
                dc.b    $0D,$0A
                dc.b    '************************************************************************'
                dc.b    $0D,$0A
                dc.b    'Where you lead and control a Private Military Company or for short PMCs.'
                dc.b    $0D,$0A
                dc.b    'Your job is to create havoc or create peace for a price.'
                dc.b    $0D,$0A
                dc.b    'Train men to their fullest potential to have the'
                dc.b    $0D,$0A
                dc.b    'strongest Private Military Company. Upgrade your weapons'
                dc.b    $0D,$0A
                dc.b    'and military might through technologies or buying equipments.'
                dc.b    $0D,$0A
                dc.b    'Earning funds for your PMC is by taking Agency missions'
                dc.b    $0D,$0A
                dc.b    'or by selling and arming rebels or terrorist cells in different countries.'
                dc.b    $0D,$0A
                dc.b    '************************************************************************'
                dc.b    $0D,$0A
                dc.b    'Press enter.........'
                dc.b    $0D,$0A,0
name_msg:       dc.b    'What is your name?'
                dc.b    $0D,$0A 
                dc.b    '',0
                dc.b    $0D,$0A 
company_msg:    dc.b    'And your company name?'
                dc.b    $0D,$0A
                dc.b    '',0
                dc.b    $0D,$0A,0
location_msg:   dc.b    'Pick your starting point: 1. Iraq 2. Iran 3. Syria'
                dc.b    $0D,$0A  
                dc.b    '',0
                dc.b    $0D,$0A,0  
Iraq_msg:       dc.b    'Welcome to the to the nation of Iraq,'   
                dc.b    $0D,$0A,0  
                dc.b    'After you landed in the aitport you when to the city/town centre'
                dc.b    $0D,$0A,0  
                dc.b    'After you landed in the aitport you when to the city/town centre'
                dc.b    $0D,$0A,0  
Iran_msg:       dc.b    'Welcome to the to the nation of Iran.'
                dc.b    $0D,$0A,0    
Syria_msg:      dc.b    'welcome to thee nation of syria where civil war is ongoing.'  
                dc.b    $0D,$0A,0        
                dc.b    'After you landed in the air strip you when to the city/town centre'
                dc.b    $0D,$0A,0   
town_msg:       dc.b    'Welcome to the city/town centre.'
                dc.b    $0D,$0A
                dc.b    'Actions: 1. Visit the hospital, 2. Visit the black market'
                dc.b    $0D,$0A
                dc.b    '3. Visit the contractors office or 4. Leave town'
                dc.b    $0D,$0A,0
hospital_msg    dc.b    'You have entered the hospital and you see an abundance'
                dc.b    $0D,$0A,0
                dc.b    'of medical supplies'
                dc.b    $0D,$0A    
medical_items_msg dc.b   'The hospital  is selling: 1.Bandages($40), 2.Pills($60)'
                dc.b    $0D,$0A 
                dc.b    '3.Medkits($100) 4. leave the hospital'       
                dc.b    $0D,$0A,0   
BlackMarket_msg dc.b    'You have entered the Black Market and see alot of weapons'
                dc.b    $0D,$0A,0 
weapon_items_msg dc.b    'The Black Market is selling: 1.AK47s($50), 2.M4($120)'
                dc.b    $0D,$0A
                dc.b    '3.Sniper rife($100) or 4. leave the black market'  
                dc.b    $0D,$0A,0
contractors_msg dc.b    'You enter the contractors office and see brunch of paper'
                dc.b    'work on the desk'
contractors_mission_msg dc.b 'Missions 1.Hunt Terrorist outskirt of town reward $100'
                dc.b    $0D,$0A
action_msg      dc.b    '1.Move out or go back to town.'
                dc.b    $0D,$0A
                dc.b    '2. leave the office',0
gameplay_msg:   dc.b    'Add Gameplay !',0
update_msg:     dc.b    'Update Gameplay !',0
draw_msg:       dc.b    'Draw Screen !',0
hit_msg:        dc.b    'Strike!',0
miss_msg:       dc.b    'Miss!',0
loop_msg:       dc.b    '.',0
replay_msg:     dc.b    'Enter 0 to Quit any other number to replay : ',0
hud_msg:        dc.b    'Score : ',0

health:     ds.w    1   Players Health
score:      ds.w    1   Reserve space for score

    end start







*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
