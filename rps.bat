@echo off
REM *************************************

REM Script Name rps.bat
REM Author: Jonathan Almawi
REM Date
REM
REM Description: This is a windows shell script implementation of the popular
REM Child's game called "Rock, Paper, Scissors."
REM
REM *************************************
REM ****** Script Initialization Section *********
REM Display the name of the game in the windows command console's title bar
TITLE= R o c k, P a p e r, S c i s s o r s

REM Set the color scheme to yellow on black
COLOR 0e
REM Define globally used variables
SET /a NoWins = 0
SET /a NoLosses = 0
SET /a NoTies = 0
SET /a NoInvalid = 0

REM ****** Main Processing Section ******

REM Call the procedure that displays the main menu
CALL :DisplayMenu

REM This label provides a callable marker for restarting the game
:StartAgain

REM Call the procedure that collect the player's choice
CALL :CollectChoice

REM Call the procedure that randomly determines the computer's choice
CALL :GetComputerChoice

REM Call the procedure that determine if the player won, lost or tied
CALL :CompareChoices

REM Call the procedure that checks for an invalid choice
CALL :CheckForInvalid

REM Call the procedure that displays the results of the game
CALL :DisplayResults

REM Analyze the player's response and either start a new game or display
REM game statistics (assume an N if response is anything but a Y or y)
IF /I "%response:~,1%" EQU "y" (
  GOTO :StartAgain
) ELSE (
	CALL :DisplayStats
	GOTO :EOF
)
REM Terminate the script's execution
GOTO :EOF

REM ****** Procedure Section ******
REM This procedure displays the game's main menu
:DisplayMenu
  REM Clear the display
  CLS
  REM Add three blank lines to the display
  FOR /L %%i IN (1,1,3) DO ECHO.
  ECHO W E L C O M E TO
  ECHO.
  ECHO R O C K, P A P E R, S C I S S O R S !
  ECHO.
  ECHO.
  ECHO.
  ECHO Rules:
  ECHO.
  ECHO 1. Guess the same thing as the computer to tie.
  ECHO.
  ECHO 2. Paper covers rock and wins.
  ECHO.
  ECHO 3. Rock breaks scissors and wins.
  ECHO.
  ECHO 4. Scissors cut paper and wins.
  REM Add five blank lines to the display
  FOR /L %%i IN (1,1,5) DO ECHO.
  REM Make the player press a key to continue
  PAUSE
GOTO :EOF

REM This collects the player's choice
:CollectChoice
  REM Define variables needed to store and analyze the player's response
  SET answer="No Answer"
  SET response=N
  SET results=None
  REM Clear the display
  CLS
  REM Add eight blank lines to the display
  FOR /L %%i IN (1,1,8) DO ECHO.
  REM Ask the player to make their choice
  SET /p answer= Type either rock, paper, or scissors: 
GOTO :EOF
REM This procedure randomly determines the computer's choice
:GetComputerChoice
  REM Get a random number
  SET GetRandomNumber=%random%
  REM If the random number is greater than 22,000, the computer picked rock
  If %GetRandomNumber% GTR 22000 (
	SET CardImage=rock
	GOTO :Continue
  )

  REM If the random number is greater than 11,000, the computer picked scissors
  If %GetRandomNumber% GTR 11000 (
	SET CardImage=scissors
	GOTO :Continue
  )

  REM Otherwise, assign paper as the computer's choice
  SET CardImage=paper

  REM This label is used to skip unnecessary conditional tests in this procedure
  :Continue

GOTO :EOF

REM This procedure determines if the player won, lost, or tied
:CompareChoices

  REM Compare choices when the player selected rock
  IF /I %answer% == rock (
	IF %CardImage% == rock (
	  SET results="You Tie"
	  SET /a NoTies = NoTies + 1
	)
	IF %CardImage% == scissors (
	  SET results="You Win"
	  SET /a NoWins = NoWins + 1
	)
	IF %CardImage% == paper (
	  SET results="You Lose"
	  SET /a NoLosses = NoLosses + 1
	)
  )

  REM Compare choices when the player selected scissors
  IF /I %answer% == scissors (
	IF %CardImage% == rock (
	  SET results="You Lose"
	  SET /a NoLosses = NoLosses + 1
	)
	IF %CardImage% == scissors (
	  SET results="You Tie"
	  SET /a NoTies = NoTies + 1
	)
	IF %CardImage% == paper (
	  SET results="You Win"
	  SET /a NoWins = NoWins + 1
	)
  )

  REM Compare choices when the player selected paper
  IF /I %answer% == paper (
	IF %CardImage% == rock (
	  SET results="You Win"
	  SET /a NoWins = NoWins + 1
	)
	IF %CardImage% == scissors (
	  SET results="You Lose"
	  SET /a NoLosses = NoLosses + 1
	)
	IF %CardImage% == paper (
	  SET results="You Tie"
	  SET /a NoTies = NoTies + 1
	)
  )

GOTO :EOF

REM This procedure checks for an invalid choice
:CheckForInvalid

IF %results%==None (

  REM Clear the display
  CLS

  REM Keep a count of the total number of invalid player choices
  SET /a NoInvalid = NoInvalid + 1

  REM Add three blank lines to the display
  FOR /L %%i IN (1,1,3) DO ECHO.

  ECHO Sorry. Your answer was not recognized.
  ECHO.
  ECHO Use all lower case when you enter your choice.

  REM Add four blank lines to the display
  FOR /L %%i IN (1,1,4) DO ECHO.

  REM Make the player press a key to continue
  PAUSE

)

GOTO :EOF

REM This procedure displays the results of the game
:DisplayResults

  REM Clear the display
  CLS

  REM Add three blank lines to the display
  FOR /L %%i IN (1,1,3) DO ECHO.

  ECHO		 G A M E   R E S U L T S
  ECHO.
  ECHO -------------------------------------
  ECHO.
  ECHO  You picked:		%answer%
  ECHO.
  ECHO  The computer picked:	%CardImage%
  ECHO.
  ECHO -------------------------------------
  ECHO.
  ECHO  Results:		%Results%
  REM Add nine blank lines to the display
  FOR /L %%i IN (1,1,9) DO ECHO.

  REM Ask the player whether he would like to play another game
  SET /p response=Play another round (y/n)? 

GOTO :EOF

REM This procedure displays game statistics
:DisplayStats

  REM Clear the display
  CLS

  REM Add three blank lines to the display
  FOR /L %%i IN (1,1,3) DO ECHO.

  ECHO	  G A M E   S T A T I S T I C S
  ECHO.
  ECHO -------------------------------------
  ECHO.
  ECHO	  Category		 Results
  ECHO	  --------------------   -------
  ECHO.
  ECHO	  No of Ties	         %NoTies%
  ECHO.
  ECHO	  No of Wins		 %NoWins%
  ECHO.
  ECHO	  No of Losses		 %NoLosses%
  ECHO.
  ECHO	  No of Invalid Hands	 %NoInvalid%
  ECHO.
  ECHO -------------------------------------

  REM Add four blank lines to the display
  FOR /L %%i IN (1,1,4) DO ECHO.

  REM Pauses screen to show stats
  pause

  REM Resets the color and clears the screen
  color
  cls

GOTO :EOF
