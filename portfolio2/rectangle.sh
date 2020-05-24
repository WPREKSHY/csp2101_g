#Name : Prekshya Wagle
#Student number : 10493331

#!/bin/bash
if ! [ -f rectangle.txt ] ; then #Checks if the file is present or not
    echo "No file to process." #Displays error message if there is no such file
    exit 0
else #If the file is present the following commands execute
    #sed -e'1d'\ deletes the header line
    #sed -e 's/^/Name: /'\ replaces the starting line with Name:
    #sed -e 's/,/\tHeight: /'\ replaces the comma with Height: and uses tab for formatting the column
    #sed -e 's/,/\tWidth: /'\ replaces the comma with Width: and uses tab for formatting the column
    #sed -e 's/,/\tArea: /'\ replaces the comma with Area: and uses tab for formatting the column
    #sed -e 's/,/\tColour: /' rectangle.txt > rectangle_f.txt replaces the comma with Colour:,uses tab for formatting the column and stores the modified data in rectangle_f.txt
    
    sed -e '1d'\
        -e 's/^/Name: /'\
        -e 's/,/\tHeight: /'\
        -e 's/,/\tWidth: /'\
        -e 's/,/\tArea: /'\
        -e 's/,/\tColour: /' rectangle.txt > rectangle_f.txt 
    
    cat rectangle_f.txt #Displays the content of rectangle_f.txt file
    exit 0     
fi #Finishes the loop

