#!/bin/bash

prompt=""
ai="${ai:-$clipboard}"

flip() {
  local ops="$1" # options: eg. "-abc"
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
  echo "$prompt" | pbcopy && echo "Prompt \"$prompt\" was successfully copied to the clipboard"
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

ai_perspective() {
  local role="$1"
  if [[ $role ]]; then
    prompt="You are $role: $prompt"
  else
    read -p "Please describe AI's role: " role
    user_perspective "$role"
  fi
}

user_perspective() {
  local role="$1"
  if [[ $role ]]; then
    prompt="I am $role: $prompt"
  else
    read -p "Please describe who you are/want to be treated as to AI: " role
    user_perspective "$role"
  fi
}

alias sf='source flip.sh'
