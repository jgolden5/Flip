#!/bin/bash

prompt=""
ai="${ai:-$clipboard}"

flip() {
  local ops="$1" # options: eg. "-abc"
  if [[ $ops == '--help' ]]; then
    print_flip_help "$2"
  else
    local param_index=$((${#ops} + 1))
    prompt="${!param_index}"
    param_index=$((param_index - 1))
    local op_index=$((${#ops} - 1))
    while [[ $op_index -gt 0 ]]; do
      local op="${ops:$op_index:1}"
      local param="${!param_index}"
      execute_op "$op" "$param"
      ((op_index--))
      ((param_index--))
    done
    choose_messanger
  fi
}

print_flip_help() {
  echo "Usage:  flip [OPTIONS...] [ARG...]"
  echo
  echo "Fine-tune AI prompts to maximize effectiveness of responses"
  echo
  echo -e "Flag:\t\tName of function:\t\tHow prompt is modified:"
  echo -e "\t-a,\t\tai_perspective   \t\t\"You are [param]. [prompt]\""
  echo
  echo -e "\t-u,\t\tuser_perspective \t\t\"I am [param]. [prompt]\""
  echo
  echo "Command's source code: https://github.com/jgolden5/Flip/blob/main/flip.sh"
}

execute_op() { #this function is generified like this so that the user may choose a unique order for the options, and flip will behave differently based on chosen order
  op="$1"
  param="$2"
  if [[ ${#op[@]} -gt 1 ]]; then
    echo "Op is too long"
    return 1
  else
    case "$op" in
      a)
        ai_perspective "$param"
        ;;
      u)
        user_perspective "$param"
        ;;
      *)
        echo "Op \"$op\" not recognized"
        ;;
    esac
  fi
}

choose_messanger() {
  echo "0 = Clipboard"
  echo "1 = ChatGPT"
  echo "2 = Grok"
  echo "3 = Gemini"
  read -n1 -p "Which of the above messangers would you like to choose (default 0)? " messanger
  case $messanger in
    *)
      echo $prompt | pbcopy && echo "The following prompt was successfully copied to the clipboard: $prompt"
      ;;
  esac
}

ai_perspective() {
  local role="$1"
  if [[ $role ]]; then
    prompt="You are $role. $prompt"
  else
    read -p "Please describe AI's role: " role
    user_perspective "$role"
  fi
}

user_perspective() {
  local role="$1"
  if [[ $role ]]; then
    prompt="I am $role. $prompt"
  else
    read -p "Please describe who you are/want to be treated as to AI: " role
    user_perspective "$role"
  fi
}

alias sf='source flip.sh'
