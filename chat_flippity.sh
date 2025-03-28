#!/bin/bash

full_prompt=""

chat_flippity() {
  welcome_to_chat_flippity
  full_prompt=""
  while true; do
    read -n1 -p "enter flippity command here: " command
    echo
    case $command in 
      a)
        age
        flippity_prompt && break
        ;;
      b)
        fill_blanks
        flippity_prompt && break
        ;;
      c)
        character
        flippity_prompt && break
        ;;
      d)
        delete_current_prompt
        ;;
      f)
        funny_lie
        flippity_prompt && break
        ;;
      g)
        get_prompt_from_gippity
        flippity_prompt && break
        ;;
      h|\?)
        help_chat_flippity
        ;;
      i)
        filibuster
        flippity_prompt && break
        ;;
      l)
        control_output_length
        flippity_prompt && break
        ;;
      m)
        make_metaphor
        flippity_prompt && break
        ;;
      n)
        best_n_answers
        flippity_prompt && break
        ;;
      o)
        code_response
        flippity_prompt && break
        ;;
      p)
        flippity_prompt && break
        ;;
      q)
        echo "quitting chat flippity..." && break
        ;;
      r)
        refresh_chat
        ;;
      s)
        read -p "How many sources do you want provided for your prompt? " number_of_sources
        get_sources $number_of_sources
        flippity_prompt && break
        ;;
      u)
        generate_quote
        flippity_prompt && break
        ;;
      v)
        verify_question_and_answer #get explanation AND 1-5 accuracy scale
        flippity_prompt -q && break
        ;;
      V)
        verify_question_and_answer -q #ONLY get accuracy of q/a on a scale of 1-5
        flippity_prompt -q && break
        ;;
      w)
        specify_question_type
        flippity_prompt && break
        ;;
      x)
        give_examples
        flippity_prompt && break
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

welcome_to_chat_flippity() {
  rand=$(echo $((RANDOM % 22 + 1)))
  random_char=
  case $rand in
    1)
      random_char="b"
      ;;
    2)
      random_char="ch"
      ;;
    3)
      random_char="d"
      ;;
    4)
      random_char="fl"
      ;;
    5)
      random_char="g"
      ;;
    6)
      random_char="h"
      ;;
    7)
      random_char="j"
      ;;
    8)
      random_char="sk"
      ;;
    9)
      random_char="l"
      ;;
    10)
      random_char="m"
      ;;
    11)
      random_char="n"
      ;;
    12)
      random_char="p"
      ;;
    13)
      random_char="qu"
      ;;
    14)
      random_char="r"
      ;;
    15)
      random_char="s"
      ;;
    16)
      random_char="t"
      ;;
    17)
      random_char="v"
      ;;
    18)
      random_char="w"
      ;;
    19)
      random_char="x"
      ;;
    20)
      random_char="y"
      ;;
    21)
      random_char="z"
      ;;
    22)
      random_char="sl"
      ;;
    *)
      random_char="fl"
      ;;
  esac
  echo "Are you ready to get ${random_char}ippity?"
}

age() {
  read -p "enter age here: " age
  full_prompt+="Answer the following question as though I was $age years old: "
}

fill_blanks() {
  full_prompt+="Fill in the blanks, and clearly define each of the terms you fill in the blanks with, for the following: "
  echo "Copying \"Fill in the blanks, and clearly define each of the terms you fill in the blanks with: \" to full_prompt (Note, make sure your prompt includes blanks if you want this to make any sense.)"
}

character() {
  read -p "What character do you want chat gippity to act like? " character
  full_prompt+="Respond to the following as though you were $character: "
}

get_prompt_from_gippity() {
  full_prompt+="Format the following question I have into a format that will be easy, summarized, and simple in order for chatgpt to understand it as best as it can: "
}

filibuster() {
  read -p "How long do you want chat gippity to filibuster for? " n units
  length_of_response=
  case $units in 
    seconds|second)
      length_of_response="$((n * 5)) words"
      ;;
    minutes|minute)
      length_of_response="$((n * 20)) long paragraphs"
      ;;
    hours|hour) #note that chat gippity is super not capable of filibustering for an hour, and hardly pulls off a small number of minutes
      length_of_response="$((n * 120)) noticeably long paragraphs"
      ;;
    *)
      echo "Unit $units not recognized"
      ;;
  esac
  full_prompt+="Respond to the following prompt in exactly $length_of_response, but don't mention the length at all in your response. Instead, treat it as though you were simply filibustering to take up time, and filibuster on the following subject: "
}

help_chat_flippity() {
  echo "here is a list of chat flippity commands:"
  echo "a = answer prompt as though I was a certain (a)ge"
  echo "b = answer prompt by filling in words and details for the (b)lank spaces"
  echo "c = answer prompt as though chatgpt was a certain (c)haracter"
  echo "d = (d)elete current prompt"
  echo "f = tell chatgpt a (f)unny lie about myself to spice things up a bit"
  echo "g = have chatgpt format my prompt in a way that would be optimized for chat(g)pt to answer"
  echo "h = generate this (h)elp prompt for a list of chat_flippity commands"
  echo "i = f(i)libuster chat gippity's response for n units of time"
  echo "l = explicitly control (l)ength of chatgpt's output"
  echo "m = specify a (m)etaphor to be used in an example in chatGPT's response"
  echo "n = respond to the prompt with (n) unique yet insightful responses"
  echo "o = respond to the following with c(o)de in the specified language"
  echo "p = generate a final (p)rompt after making modifications"
  echo "r = (r)efresh chat by forgetting all other things I entered into this chat"
  echo "q = (q)uit chat_flippity"
  echo "s = get n (s)ources and a brief summary of prompt"
  echo "u = generate a famous q(u)ote about the following prompt"
  echo "v = (v)erify whether the following question and answer is accurate with accuracy scale and explanation"
  echo "V = (V)erify whether the following question and answer is accurate in quiet mode--just with a 1-5 accuracy scale"
  echo "w = ask the following prompt formatted based on a specific q(w)estion focus"
  echo "x = get n e(x)amples based on prompt"
  echo "= = print entirety of full_prompt so far"
  echo "? = like 'h', generate this help prompt for a list of chat_flippity commands"
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
  g_lie="Gee whiz! You must be a whiz to think you could help me, golly gee! " 
  h_lie="Hey, how are you chat gippity? I am so hhhhhhhhhhhappy to see you! Do I hhhhave bad breath? I hhhhhhope not. " 
  i_lie="Ay ay ay = i i i. "
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
    g)
      full_prompt+="$g_lie"
      ;;
    h)
      echo "here is a list of tall tales you can lie about:"
      echo "a = $a_lie"
      echo "b = $b_lie"
      echo "c = $c_lie"
      echo "d = $d_lie"
      echo "e = $e_lie"
      echo "f = $f_lie"
      echo "g = $g_lie"
      echo "h = $h_lie"
      echo "i = $i_lie"
      funny_lie
      ;;
    H)
      full_prompt+="$h_lie"
      ;;
    i)
      full_prompt+="$i_lie"
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

best_n_answers() {
  read -p "How many answers do you want chat gippity to respond to your question with? " n
  full_prompt+="Respond to the following prompt with $n different, high-quality, uniquely-insightful answers: "
}

code_response() {
  read -p "What coding language do you want chatGPT to respond with in your answer? " language
  full_prompt+="Respond to the following with $language code: "
}

flippity_prompt() {
  if [[ $1 != "-q" ]]; then
    read -p "enter prompt here: " prompt
    full_prompt+=$prompt
  fi
  echo "Current prompt so far = \"${full_prompt}\""
  read -n1 -p "Ready to use prompt? " end_prompt
    echo
    if [[ $end_prompt == "y" ]]; then
      number_of_words=$(echo $full_prompt | wc -w)
      echo "$number_of_words words successfully copied into clipboard"
      echo $full_prompt | pbcopy
      return 0
    else
      full_prompt+=' '
      return 1
    fi
}

refresh_chat() {
  full_prompt+="Refresh anything I said in this chat previously, and start afresh from now on. "
  echo "Refresh message was added to prompt"
}

get_sources() {
  number_of_sources="$1"
  shift
  if [[ $number_of_sources == "1" ]]; then
    source_or_sources="source"
  else
    source_or_sources="sources"
  fi
  full_prompt+="Give a brief 2-4 sentence description of and $number_of_sources web $source_or_sources I can go to in order to get more relevant information about the following: "
}

generate_quote() {
  full_prompt+="Generate a famous quote about the following: "
}

verify_question_and_answer() {
  full_prompt+="Please rate how accurate the following answer(s) are to the following question(s) on a scale of 1-5, 1 being completely inaccurate, and 5 being completely accurate"
  if [[ $1 == "-q" ]]; then
    read -p "(quiet mode) Please enter the question(s) AND answer(s) you want chat gippity to verify (in the form: Question? answer) " question_and_answer
    full_prompt+=", and provide no explanation as to why: $question_and_answer"
  else
    read -p "Please enter the question(s) AND answer(s) you want chat gippity to verify (in the form: Question? answer. Question n? answer n.) " question_and_answer
    full_prompt+=". Then, verify if the following question and answer represent an answer that accurately answers the question, and add any clarification if needed.  $question_and_answer."
  fi
}

specify_question_type() {
  read -p "Pick a question to focus on in your prompt (such as what, when, where, how, and why): " question_focus
  full_prompt+="When answering the following prompt, really keep the question \"${question_focus}\" in mind: "
}

give_examples() {
  read -p "How many examples do you want on the topic you're about to ask about? " x
  full_prompt+="Please give $x examples to help clarify the following (note that if I give more than 1 example, that each example should provide unique yet relevant value): "
}

alias cf='chat_flippity'
alias ep="echo $full_prompt"
alias scf='source chat_flippity.sh'
