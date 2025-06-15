#!/bin/bash

prompt=""
messenger=clipboard

flip() {
  local ops="$1" # options: eg. "-abc"
  if [[ $ops == '--help' ]]; then
    print_flip_help "$2"
  else
    if [[ $ops =~ ^- ]]; then
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
    else
      prompt="$1"
    fi
    send_request
  fi
}

print_flip_help() {
  echo "Usage:  flip [OPTIONS...] [ARG...]"
  echo
  echo "Fine-tune AI prompts to maximize effectiveness of responses"
  echo
  echo -e "Flag:\t\tName of function:\t\tHow prompt is modified:"
  echo -e "\t-a,\t\tai_perspective   \t\t\"Respond to the following as though you were [param]: [prompt]\""
  echo
  echo -e "\t-f,\t\tformat_output    \t\t\"Respond to the following prompt using [param] as the format for the response. [prompt]\""
  echo
  echo -e "\t-m,\t\tchoose_messenger \t\t Options:"
  echo -e "\t\t\t                    \t\t   0/clipboard/* (default)"
  echo -e "\t\t\t                    \t\t   1/chat(gpt)"
  echo -e "\t\t\t                    \t\t   2/grok/(x)ai"
  echo -e "\t\t\t                    \t\t   3/(gem)ini/google"
  echo -e "\t\t\t                    \t\t   4/claude/anthropic/cld"
  echo -e "\t\t\t                    \t\t   5/(mis)tral/french"
  echo -e "\t\t\t                    \t\t   6/meta/facebook/fb"
  echo -e "\t\t\t                    \t\t   7/yi"
  echo
  echo -e "\t-u,\t\tuser_perspective \t\t\"Respond to the following as though I was [param]: [prompt]\""
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
      f)
        format_output "$param"
        ;;
      m)
        choose_messenger "$param"
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

choose_messenger() {
  messenger="$1"
}

send_request() {
  case "${messenger,,}" in
    1|chatgpt|gpt)
      open "https://chatgpt.com/?q=$prompt"
      ;;
    2|grok|xai|x)
      open "https://grok.com/?q=$prompt"
      ;;
    3|gemini|gem|google)
      open "https://gemini.google.com/app"
      echo $prompt | pbcopy && echo "The following prompt was successfully copied to the clipboard for you to paste into Gemini's chat: $prompt"
      ;;
    4|claude|anthropic|cld)
      open "https://claude.ai/new?q=$prompt"
      ;;
    5|mistral|french|mis)
      open "https://chat.mistral.ai/chat/?q=$prompt"
      ;;
    6|meta|facebook|fb)
      open "https://meta.ai/"
      echo $prompt | pbcopy && echo "The following prompt was successfully copied to the clipboard for you to paste into Meta ai's chat: $prompt"
      ;;
    7|yi)
      open "https://app.chathub.gg/chat/cloud-yi-large"
      echo $prompt | pbcopy && echo "The following prompt was successfully copied to the clipboard for you to paste into Yi's chat: $prompt"
      ;;
    *)
      if [[ $messenger != clipboard ]] && [[ $messenger != 0 ]]; then
        echo "Messenger \"$messenger\" not recognized. Using default messenger: Clipboard"
      fi
      echo $prompt | pbcopy && echo "The following prompt was successfully copied to the clipboard: $prompt"
      ;;
  esac
}

ai_perspective() {
  local role="$1"
  if [[ $role ]]; then
    prompt="Respond to the following as though you were $role: $prompt"
  else
    read -p "Please describe AI's role: " role
    user_perspective "$role"
  fi
}

format_output() {
  local format="$1"
  if [[ "$format" ]]; then
    prompt="Respond to the following prompt using $format as the format for the response. $prompt"
  else
    read -p "Please describe the format you want your response in: " format
    format_output "$format"
  fi
}

user_perspective() {
  local role="$1"
  if [[ $role ]]; then
    prompt="Respond to the following as though I was $role: $prompt"
  else
    read -p "Please describe who you are/want to be treated as to AI: " role
    user_perspective "$role"
  fi
}

alias sf='source flip.sh'
