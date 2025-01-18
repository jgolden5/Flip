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
    *)
      echo "input not recognized"
  esac
  prompt
}

age() {
  read -p "enter age here: " age
  full_prompt+="Answer the following question as though I was $age years old: "
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
