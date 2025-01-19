#!/bin/bash

full_prompt=""

chat_flippity() {
  full_prompt=""
  while true; do
    read -n1 -p "enter flippity command here: " command
    echo
    case $command in 
      a)
        age
        ;;
      c)
        character
        ;;
      h)
        help_chat_flippity
        ;;
      l)
        lie
        ;;
      p)
        prompt
        break
        ;;
      *)
        echo "command not recognized. Please try again, and hit 'h' for help on chat_flippity features"
        prompt
        break
        ;;
    esac
  done
}

age() {
  read -p "enter age here: " age
  full_prompt+="Answer the following question as though I was $age years old: "
}

character() {
  a_character="Abraham Lincoln as US president during the Civil War. " 
  b_character="Babe the pig from the movie Babe. " 
  c_character="Crush from Finding Nemo. " 
  d_character="Daryl the Pony from the clip from Bad Lip Reading about High School musical--the one where he's looking for a gifted young rider. " 
  e_character='Ella Enchanted from the movie "Ella Enchanted". ' 
  f_character="Fix-it Felix. "
  read -n1 -p "enter character here: " character
  echo
  case $character in
    a)
      full_prompt+="Talk and act like $a_character"
      ;;
    b)
      full_prompt+="Talk and act like $b_character"
      ;;
    c)
      full_prompt+="Talk and act like $c_character"
      ;;
    d)
      full_prompt+="Talk and act like $d_character"
      ;;
    e)
      full_prompt+="Talk and act like $e_character"
      ;;
    f)
      full_prompt+="Talk and act like $f_character"
      ;;
    h)
      echo "here is a list of characters to make chatgpt act like:"
      echo "a = $a_character"
      echo "b = $b_character"
      echo "c = $c_character"
      echo "d = $d_character"
      echo "e = $e_character"
      echo "f = $f_character"
      character
      ;;
    *)
      echo "command not recognized. Entering basic prompt"
      ;;
  esac
}

help_chat_flippity() {
  echo "here is a list of chat flippity features:"
  echo "a = answer prompt as though I was a certain (a)ge"
  echo "c = answer prompt as though chatgpt was a certain (c)haracter"
  echo "h = generate this (h)elp prompt for a list of chat_flippity features"
  echo "l = tell chatgpt a (l)ie about myself to spice things up a bit"
  echo "p = generate a final (p)rompt after making modifications"
}

lie() {
  a_lie="I am an albatross. " 
  b_lie="I am a beautiful Russian Warlord. " 
  c_lie="I am chatgpt and you are Jonathan. " 
  d_lie="DAYNG! I am Daniel, and I just got out of the lion's den. " 
  e_lie="I am an elephant, and an excellent one that loves to eat eggs. " 
  f_lie="I am FAMISHED and boy am I craving a delicious AI CHATBOT right now--that would hit the spot. "
  read -n1 -p "enter lie here: " lie
  echo
  case $lie in
    a)
      full_prompt+="$a_lie"
      ;;
    b)
      full_prompt+="$b_lie"
      ;;
    c)
      full_prompt+="$c_lie"
      ;;
    d)
      full_prompt+="$d_lie"
      ;;
    e)
      full_prompt+="$e_lie"
      ;;
    f)
      full_prompt+="$f_lie"
      ;;
    h)
      echo "here is a list of tall tales you can lie about:"
      echo "a = $a_lie"
      echo "b = $b_lie"
      echo "c = $c_lie"
      echo "d = $d_lie"
      echo "e = $e_lie"
      echo "f = $f_lie"
      lie
      ;;
    *)
      echo "command not recognized. Entering basic prompt"
      ;;
  esac
}

prompt() {
  read -p "enter prompt here: " prompt
  full_prompt+="$prompt"
  echo "$full_prompt" | pbcopy
  number_of_words=$(echo "$full_prompt" | wc -w)
  echo "$number_of_words words successfully copied into clipboard"
}

alias cf='chat_flippity'
alias scf='source chat_flippity.sh'
