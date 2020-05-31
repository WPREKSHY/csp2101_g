#Name : Prekshya Wagle
#Student Number: 10493331
#!/bin/bash
url=https://www.ecu.edu.au/service-centres/MACSC/gallery/gallery.php?folder=152 #storing the web address in the variable called url

curl $url > thumbnail.txt #saving the contents of url in a text file named thumbnail.txt
awk '/jpg/ { print $3 }' thumbnail.txt | sed -e 's/"\(.*\)".*/\1/g' | sed 's/alt=DSC//g' | sed 's/.jpg$//g' > imgs.txt 
#In the above line awk first prints the third character separated by space of url that is stored in thumbnail.txt and sed filters out all the line by leaving only numeric value in imgs.txt file
downloadspecificone() #creating a function called downloadspecificone
{
    while true; do #starts continuous loop
    read -p "Enter the four digit thumbnail number between 1533 and 2042: " usernum #prompting user to enter the thumbnail number
       if [[ $usernum =~ ^[0-9]+$ ]] && [[ "$usernum" -ge 1533 ]] && [[ "$usernum" -le 2042 ]]; then #this line makes sure that the user input is an integer between 1533 and 2042
           test="$(grep $usernum imgs.txt)" #this line grabs the number that matches the user input from imgs.txt file
           if [[ $test ]]; then #this line makes sure that the thumbnail number entered by the user is present in imgs.txt file and if its true carries out following commands
              f1size="$(curl -sI "https://secure.ecu.edu.au/service-centres/MACSC/gallery/152/DSC0$usernum.jpg" | grep -i Content-Length | awk '{print $2/1024}' | sed 's/\r//p')" 
              #The above line determines the file size in KB
              echo "Downloading DSC0$usernum, with the file name DSC0$usernum.jpg, with a file size of $f1size KB...... File Download Complete." #Displays the downloading message
              echo "PROGRAM FINISHED" #Displays program finished message
              wget -q -c -P downloads "https://secure.ecu.edu.au/service-centres/MACSC/gallery/152/DSC0$usernum.jpg" #Downloads the image chosen by the user by using wget command
              break #if everything thing is fine it breaks from the loop
           else 
             echo "File does not exist. Please try again." #Displays error message if the number entered by the user is not present in imgs.txt file
            fi #finishes the loop
        else
          echo "Invalid value entered. Please try again." #Displays error message if user enters value other than integer
       fi #finishes the loop
    done #ends continuous loop
} 

downloadallimages() #creating a function called downloadallimages
{
while read src #read a variable src
do 
  f2size="$(curl -sI "https://secure.ecu.edu.au/service-centres/MACSC/gallery/152/DSC$src.jpg" | grep -i Content-Length | awk '{print $2/1024}' | sed 's/\r//p')" #determine the size of file
  echo "Downloading DSC$src, with the file name DSC$src.jpg, with a file size of $f2size KB...... File Download Complete." #Display downloading message
  wget -q -c -P downloads "https://secure.ecu.edu.au/service-centres/MACSC/gallery/152/DSC$src.jpg" #download all the images from the url
done < imgs.txt 
echo "PROGRAM FINISHED" #Display program finished messsage
} 

downloadimageinrange() #creating a function called downloadimageinrange
{
    while true; do #starting endless loop
    read -p "Enter the starting range, for example 1533: " startrange #prompting user to enter the starting range
    read -p "Enter the ending range, for example 2042: " endrange #prompting user to enter the ending range
        if [[ $startrange =~ ^[0-9]+$ ]] &&  [[ "$startrange" -ge 1533 ]] && [[ $endrange =~ ^[0-9]+$ ]] && [[ "$endrange" -le 2042 ]]; then #This line makes sure the user enters integer between 1533 and 2042
            while [ $startrange != $endrange ] #mthis line makes sure starting range is not equal to ending range
            do
              check="$(grep $startrange imgs.txt)" #this line grabs the starting number that matches the user input from imgs.txt file
              if [[ $check ]]; then #this line checks if the number entered by user is present in imgs.txt and if it is present carries out the following commands
             
                  f3size="$(curl -sI "https://secure.ecu.edu.au/service-centres/MACSC/gallery/152/DSC0$startrange.jpg" | grep -i Content-Length | awk '{print $2/1024}' | sed 's/\r//p')" 
                  #the above line determines the size of file
                  echo "Downloading DSC0$startrange, with the file name DSC0$startrange.jpg, with a file size of $f3size KB...... File Download Complete." #this line displays downloading message
                  wget -q -c -P downloads "https://secure.ecu.edu.au/service-centres/MACSC/gallery/152/DSC0$startrange.jpg" #this line downloads the image in the range specified by the user
                  let startrange+=1 #this line increments the starting range
              else 
                 let startrange+=1 #if the above condition is not met the starting range is incremented by 1
              fi #finishes the if statement
            done 
            echo "PROGRAM FINISHED" #displays program finished message
            break #breaks out of the loop
        else 
          echo "Invalid value entered. Please try again." #displays error message if user enters invalid input
        fi #finishes the loop
    done #terminates the continuous loop
} 

downloadrandomimage() #creating a function called downloadrandomimage
{ 
  while true; do #start continuous loop
  read -p "Enter the number of images that you want to view: " userchoice #prompting user to enter the number of images they want to view
    if [[ $userchoice =~ ^[+]?[0-9]$ ]]; then #this line makes sure that the user input is integer
      for image in `shuf -n $userchoice imgs.txt` #this line makes sure the random number generated by shuf matches the number of images that user want to view
      do
        f4size="$(curl -sI "https://secure.ecu.edu.au/service-centres/MACSC/gallery/152/DSC$image.jpg" | grep -i Content-Length | awk '{print $2/1024}' | sed 's/\r//p')"
        # the above line determines the size of file
        echo "Downloading DSC$image, with the file name DSC$image.jpg, with a file size of $f4size KB...... File Download Complete."
         # the above line displays downloading message
        wget -q -c -P downloads "https://secure.ecu.edu.au/service-centres/MACSC/gallery/152/DSC$image.jpg" 
        #the above line downloads the random images as per the user input 
      done 
      echo "PROGRAM FINISHED" #displays program finished message
      break #breaks out of loop
    else 
      echo "Invalid input. Please try again." #displays error message if user enters invalid input
    fi #finishes the loop
  done #the continuous loop terminates
} 

while true; do
read -p "Enter your choice number between 1 and 4: " userselection #prompt user to enter the choice number
    if [[ $userselection =~ ^[1-4] ]]; then #this line makes sure user enters any integer between 1 and 4
        echo "You selected choice number $userselection." #displays the choice selected by the user
        break #breaks out of loop
    else
        echo "Invalid choice number entered. Please try again." #displays error message if invalid input is entered.
    fi #finishes the loop
done #terminates continuous loop

case $userselection in #starting case statement
    1) 
      downloadspecificone ;; #For option 1 downloadspecificone function is called
    2)
      downloadallimages ;; #For option 2 downloadallimages function is called
    3)
      downloadimageinrange ;; #For option 3 downloadimageinrange function is called
    4)
      downloadrandomimage;; #For option 4 downloadrandomimage function is called
    *)
      echo "Invalid choice number selected." ;; #for any othe input error message is displayed
esac #this line ends the case statement
      
      
      