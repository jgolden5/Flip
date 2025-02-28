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
        prompt && break
        ;;
      c)
        character
        prompt && break
        ;;
      d)
        delete_current_prompt
        ;;
      f)
        funny_lie
        prompt && break
        ;;
      h)
        help_chat_flippity
        ;;
      l)
        control_output_length
        prompt && break
        ;;
      m)
        make_metaphor
        prompt && break
        ;;
      p)
        prompt && break
        ;;
      r)
        refresh_chat
        ;;
      s)
        read -p "How many sources do you want provided for your prompt? " number_of_sources
        get_n_sources $number_of_sources
        prompt && break
        ;;
      w)
        specify_question_type
        prompt && break
        ;;
      =)
        echo "current prompt = \"$full_prompt\""
        ;;
      *)
        echo "command not recognized. Please try again, and hit 'h' for help on chat_flippity commands"
        ;;
    esac
  done
}

age() {
  read -p "enter age here: " age
  full_prompt+="Answer the following question as though I was $age years old: "
}

character() {
  read -p "What character do you want chat gippity to act like? " character
  full_prompt+="Respond to the following as though you were $character: "
}

help_chat_flippity() {
  echo "here is a list of chat flippity commands:"
  echo "a = answer prompt as though I was a certain (a)ge"
  echo "c = answer prompt as though chatgpt was a certain (c)haracter"
  echo "d = (d)elete current prompt"
  echo "f = tell chatgpt a (f)unny lie about myself to spice things up a bit"
  echo "h = generate this (h)elp prompt for a list of chat_flippity commands"
  echo "l = explicitly control (l)ength of chatgpt's output"
  echo "m = specify a (m)etaphor to be used in an example in chatGPT's response"
  echo "p = generate a final (p)rompt after making modifications"
  echo "r = (r)efresh chat by forgetting all other things I entered into this chat"
  echo "s = get n (s)ources and a brief summary of prompt"
  echo "w = ask the following prompt formatted based on a specific q[w]estion focus"
  echo "= = print entirety of full_prompt so far"
}

delete_current_prompt() {
  full_prompt=""
  echo "Prompt deleted"
}

funny_lie() {
  a_lie="I am an albatross. " 
  b_lie="I am a beautiful Russian Warlord. " 
  c_lie="I am chatgpt and you are Jonathan. " 
  d_lie="DAYNG! I am Daniel, and I just got out of the lion's den. " 
  e_lie="I am an elephant, and an excellent one that loves to eat eggs. " 
  f_lie="I am FAMISHED and boy am I craving a delicious AI CHATBOT right now--that would hit the spot. "
  read -n1 -p "enter funny lie here: " lie
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

control_output_length() {
  read -p "How long exactly do you want your prompt's response to be? (eg. 8 words or less, 1-3 sentences, 2 paragraphs, etc.) " explicit_output_length
  full_prompt+="Respond to the following prompt in exactly $explicit_output_length: "
}

make_metaphor() {
  read -p "What do you want a metaphor about in your answer? " metaphor
  full_prompt+="Respond to the following prompt with a metaphor about $metaphor: "
}

prompt() {
  read -p "enter prompt here: " prompt
  full_prompt+=$prompt
  echo "Current prompt so far = \"${full_prompt}\""
  read -n1 -p "Ready to use prompt? " end_prompt
    echo
    if [[ $end_prompt == "y" ]]; then
      number_of_words=$(echo $full_prompt | wc -w)
      echo "$number_of_words words successfully copied into clipboard"
      echo $full_prompt | pbcopy
      return 0
    else
      full_prompt+=$'\n'
      return 1
    fi
}

refresh_chat() {
  full_prompt+="Refresh anything I said in this chat previous, and start afresh from now on. "
  echo "Refresh message was added to prompt"
}

get_n_sources() {
  number_of_sources="$1"
  shift
  if [[ $number_of_sources == "1" ]]; then
    source_or_sources="source"
  else
    source_or_sources="sources"
  fi
  full_prompt+="Give a brief 2-4 sentence description of and $number_of_sources $source_or_sources I can go to in order to get more relevant information about the following: "
}

specify_question_type() {
  read -p "Pick a question to focus on in your prompt (such as what, when, where, how, and why): " question_focus
  full_prompt+="When answering the following prompt, really keep the question \"${question_focus}\" in mind: "
}

alias cf='chat_flippity'
alias ep="echo $full_prompt"
alias scf='source chat_flippity.sh'
