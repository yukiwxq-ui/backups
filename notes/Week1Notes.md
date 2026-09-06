**My CMEE Coursework Repository**

**PART 1 UNIX AND LINUX**


**PART 2 SHELL SCRIPTING**

# boilerplate.sh: the script provides a template for creating new shell scripts. It shows:
1. structured header information
    # Author: ...
    # Script: ...
    # Desc: ...
    # Arguments: ...
    # Date: ...
2. echo: print formatted text to the terminal
3. \n: blank line
4. #exit: an optional exit command

# myscript.sh: two ways of running a shell script
1. bash myscript.sh: run directly
2. 'chmod +x myscript.sh' **+** ./ myscript,sh: make the script executable
## the $PATH environmental variable
3. echo $PATH: show search paths, where path is a list of directories that the shell searches when you type a command, each directory is separated by a colon (:)
4. find/home/ n-maxdepth 3 -name 'bin' -type d: find bin folders
5. mkdir ~/.local/bin: create local bin
6. export PATH=$PATH: $HOME/.local/bin: temporarily update PATH
7. ~/.bashrc **or** ~/.zshrc: permanently update PATH
8. source ~/.bashrc: reload config

#Variables.sh: shows how variables and user input work in shell scripting (sh). It covers special variables, assigned variables, reading input, and command substitution. The script:
1. Prints details about how it was executed and its arguments
    **some important special variables**
    $0: The filename (basename) of the current script, including any extension
    $n ($1...$9): Here n is an integer corresponding to the position of an argument (the first argument is $1, the second is $2, etc).
    $1: represents the first argument passed to the script
    $#: The number of arguments (parameters) supplied to a script (the script was “called” with)
    $@: All the arguments are individually printed. For example, if a script receives two arguments, $@ is equivalent to $1 $2
2. MY_VAR='some string': assigning and reassigning variable values
3. read MY_VAR: prompts the user to type a new string, stores and prints it.
4. MY_SUM=$(expr $a + $b): Calculates and displays the sum of the two entered numbers

#MyExamplesScript.sh: the script illustrates basic variable assignment, variable substitution, and printing output with echo in shell scripting (sh). This script prints a personalised greeting using the current user's name. 
1. VariableName=: assign shell variable
2. $USER: user name (get access to the environment variables)
3. echo "Hello $USER": displays variable values and text together

- tr -s " ": squeeze repeated character in "" into a single one    
- tr -d " ": delete the character in " "  
- tr [:lower:] [:upper:]: converts each lowercase letter to uppercase
- tr -d [:alpha:] | tr -s " " ",": remove letter and replace spaces with commas

-e enables interpretation of escape sequences like \t(tab) and \n(newline)

# tabtocsv.sh: shell script that substitute all tabs with commas
- $1: represents the first argument passed to the script
- cat $1: reads the content of the file $1 (the input file)
- tr -s "\t" ",": squeeze repeated tab character and replace tab with cammas
- >> $1.csv: appends the converted text to a new file named after the input file with .csv appended

# CountLines.sh: counts how many lines in a file when the user input the targeted file name
- wc -l counts the number of lines in a file
- <$1 redirects the content of the file given as the first argument ($1) into wc

# ConcatenateTwoFiles.sh: create a new file with first file and then second file content at the end
- Cat $1 > $3: reads the content of first input file and redirects the output to the third file (creates the merged file with the content of the first file)
- cat $2 >> $3: reads the content of the second input file and appends this content to the third file (adds the content of the second file to the end of the merged file)

# tiff2png.sh: convert tiff to png using a for loop, where $f represents the current filename from the loop. 
- convert "cat.tif" "$(basename "$f" .tif).png" : deletes the .tif and adds .png


**VERSION CONTROL WITH GIT**

**SCIENTIFIC DOCUMENTS WITH LATEX**









