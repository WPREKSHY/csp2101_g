#!/bin/bash

#Name : Prekshya Wagle
#Student Number : 10493331

#Generating the random number
a=20; # Variable used to store the minimum value for the range
b=70; # Variable used to store the maximum value for the range
DIFF=$(($b-$a+1)) # this line calculates the difference between maximum and minimum value and adds 1
RANDOM=$$ # the RANDOM variable is initialized
for i in 'seq 1'# a for loop with variable i starts here for a single iteration 
do
      random_number=$(($(($RANDOM%DIFF))+$a)) #generates the random number between the range
      
done

echo "Welcome to the age guessing game." #displays the welcome message
#start a while loop
while true; do 
read -p "Guess the age: " guess #ask the user to enter their guess and stores their input in the guess variable
    if [[ $guess =~ ^[0-9] ]]; then # This line makes sure that the user enters the appropriate value
       
           if [[ "$guess" -eq "$random_number" ]]; then # checks if the user input matches the random number that is generated 
               echo "Your guess is correct. You win!" #displays the correct message if the user input matches the random number
               break #break out of the loop
   
           elif [[ "$guess" -lt "$random_number" ]]; then # if the first condition is not satisfied then it checks whether the user input is less than the random number
                echo "Your guess is too low. Try again."  #displays the too low message if the user input is less than the random number
              
           elif [[ "$guess" -gt "$random_number" ]]; then # checks if the user input is greater than the random number that is generated 
                echo "Your guess is too high. Try again." #displays too high message if the user input is greater than random number
           fi #finishes if else statement
    else
        echo "Invalid value entered. Please try again." #displays error message for invalid value entered
        
    fi 
done 







