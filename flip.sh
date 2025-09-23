#!/bin/bash

prompt=""
messenger=clipboard

cp ~/flip/flip.1 /usr/share/man/man1/flip.1 && echo "Copied flip man page to local machine. You can view this page with: 'man flip'"

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
  messenger=clipboard
}

print_flip_help() {
  echo "Usage:  flip [OPTIONS...] [ARG...]"
  echo
  echo "Fine-tune AI prompts to maximize effectiveness of responses"
  echo
  echo -e "Flag:\t\tName of function:\t\tHow prompt is modified:"
  echo -e "\t-a,\t\tai_perspective   \t\t\"Respond to the following as though you were [param]: [prompt]\""
  echo
  echo -e "\t-i,\t\tprompt_ideas     \t\t\"Respond to this prompt AND the previous [param] prompts with 5 relevant follow-up prompt ideas: [prompt]\""
  echo
  echo -e "\t-l,\t\tcontrol_length   \t\t\"Respond to the following prompt in exactly [param]: [prompt]\""
  echo
  echo -e "\t-m,\t\tchoose_messenger \t\t Options:"
  echo -e "\t\t\t                    \t\t   0/clipboard/* (default)"
  echo -e "\t\t\t                    \t\t   1/chat(gpt)"
  echo -e "\t\t\t                    \t\t   2/grok/(x)ai"
  echo -e "\t\t\t                    \t\t   3/(gem)ini/google"
  echo -e "\t\t\t                    \t\t   4/claude/anthropic/cld"
  echo -e "\t\t\t                    \t\t   5/(mis)tral/french"
  echo -e "\t\t\t                    \t\t   6/meta/facebook/fb"
  echo -e "\t\t\t                    \t\t   7/microsoft/copilot/co"
  echo -e "\t\t\t                    \t\t   8/perplexity/perp"
  echo -e "\t\t\t                    \t\t   * (all of the above)"
  echo
  echo -e "\t-n,\t\tget_n_responses  \t\t\"[prompt]. Give [param] responses.\""
  echo
  echo -e "\t-o,\t\tformat_output  \t\t\"This prompt will be encapsulated in double backticks. I want you to format the response/output as follows: [param]. Here is the prompt: ``[prompt]``\""
  echo
  echo -e "\t-q,\t\tclarifying_questions  \t\t\"Ask [param] clarifying questions about the following prompt in order to understand my intent and optimize it for an LLM response: [prompt]\""
  echo
  echo -e "\t-s,\t\tget_sources  \t\t\"Please provide [param] clickable sources about the following: [prompt]\""
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
      i)
        prompt_ideas "$param"
        ;;
      l)
        control_length "$param"
        ;;
      m)
        choose_messenger "$param"
        ;;
      n)
        get_n_responses "$param"
        ;;
      o)
        format_output "$param"
        ;;
      q)
        clarifying_questions "$param"
        ;;
      s)
        get_sources "$param"
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

control_length() {
  length="$1"
  prompt="Respond to the following prompt in exactly $length: $prompt"
}

choose_messenger() {
  if [[ $1 == "*" ]]; then
    for i in {0..8}; do
      flip -m "$i" "$prompt"
    done
  else
    messenger="$1"
  fi
}

get_n_responses() {
  local n="$1"
  prompt="$prompt. Give $n responses."
}

format_output() {
  local output="$1"
  prompt="This prompt will be encapsulated in double backticks. I want you to format the response/output as follows: $output. Here is the prompt: \`\`$prompt\`\`"
}

clarifying_questions() {
  local n="$1"
  prompt="Ask $n clarifying questions about the following prompt in order to understand my intent and optimize it for an LLM response: $prompt"
}

get_sources() {
  local n="$1"
  prompt="Please provide $n clickable sources about the following: $prompt"
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
    7|microsoft|copilot|co)
      open "https://copilot.microsoft.com/"
      echo $prompt | pbcopy && echo "The following prompt was successfully copied to the clipboard for you to paste into Microsoft Copilot's chat: $prompt"
      ;;
    8|perplexity|perp)
      open "https://www.perplexity.ai/?q=$prompt"
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

prompt_ideas() {
  local number_of_prompts_back="$1"
  prompt="Respond to this prompt AND the previous $number_of_prompts_back prompts with 5 relevant follow-up prompt ideas: $prompt"
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
alias vf='vim flip.sh'
alias mai='flip -m "*"' #Mass AI send
