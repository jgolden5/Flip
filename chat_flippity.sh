#!/bin/bash

full_prompt=""

chat_flippity() {
  full_prompt=""
  read -n1 -p "enter flippity command here: " command
  echo
  case $command in 
    a)
      age
      ;;
    l)
      lie
      ;;
    *)
      echo "command not recognized. Entering basic prompt"
  esac
  prompt
}

age() {
  read -p "enter age here: " age
  full_prompt+="Answer the following question as though I was $age years old: "
}

lie() {
  a_lie="I am an albatross. " 
  b_lie="I am a beautiful Russian Warlord. " 
  c_lie="I am chatgpt and you are Jonathan. " 
  d_lie="DAYNG! I am Daniel, and I just got out of the lion's den. " 
  e_lie="I am an elephant, and an excellent one that loves to eat eggs. " 
  f_lie="I am FAMISHED and boy am I craving a delicious AI CHATBOT right now--that would hit the spot. "
  echo "here is a list of tall tales you can lie about:"
  echo "a = $a_lie"
  echo "b = $b_lie"
  echo "c = $c_lie"
  echo "d = $d_lie"
  echo "e = $e_lie"
  echo "f = $f_lie"
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
