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
      A)
        choose_your_own_adventure && break
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
      e)
        elephant && break
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
      t)
        translate
        flippity_prompt && break
        ;;
      u)
        specify_question_type
        flippity_prompt && break
        ;;
      v)
        verify_question_and_answer #get explanation AND 1-5 accuracy scale
        flippity_prompt "-q" && break
        ;;
      V)
        verify_question_and_answer -q #ONLY get accuracy of q/a on a scale of 1-5
        flippity_prompt "-q" && break
        ;;
      w)
        define_word_in_prompt
        flippity_prompt && break
        ;;
      x)
        levels_of_explanation_by_complexity
        flippity_prompt && break
        ;;
      z)
        possible_outcomes
        flippity_prompt && break
        ;;
      0)
        ai=
        echo "AI was unset (clipboard)"
        ;;
      1)
        ai=chatgpt
        echo "AI was set to chatgpt"
        ;;
      2)
        ai=grok
        echo "AI was set to grok"
        ;;
      %)
        percentage_prompt
        flippity_prompt && break
        ;;
      \*)
        random_prompt
        ;;
      -)
        condense_text
        flippity_prompt && break
        ;;
      =)
        echo "current prompt = \"$full_prompt\""
        ;;
      \")
        find_quote
        flippity_prompt && break
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

choose_your_own_adventure() {
  full_prompt+='Present me with a situation, let me type in an exact response as a prompt, and then constantly continue the story from there, and give me a "choose your own adventure"-style story with that format. Ask me for (1) the setting, (2) the characters, and (3) the role I play in the story, then begin telling the story.'
  echo "Choose your own adventure prompt was copied to the clipboard"
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
  full_prompt+="Respond to the following prompt in exactly $length_of_response, but don't mention the length at all in your response. Instead, generate the full amount of text all at once, treating it as though you were simply filibustering to take up time, and filibuster on the following subject: "
}

help_chat_flippity() {
  echo "here is a list of chat flippity commands:"
  echo "a = answer prompt as though I was a certain (a)ge"
  echo "b = answer prompt by filling in words and details for the (b)lank spaces"
  echo "c = answer prompt as though chatgpt was a certain (c)haracter"
  echo "d = (d)elete current prompt"
  echo "e = (e)lephant challenge--based on elephant principle, gives user practice breaking large problems into smaller ones"
  echo "f = tell chatgpt a (f)unny lie about myself to spice things up a bit"
  echo "g = have chatgpt format my prompt in a way that would be optimized for chat(g)pt to answer"
  echo "h = generate this (h)elp prompt for a list of chat_flippity commands"
  echo "i = f(i)libuster chat gippity's response for n units of time"
  echo "l = explicitly control (l)ength of chatgpt's output"
  echo "m = specify a (m)etaphor to be used in an example in chatGPT's response"
  echo "n = respond to the prompt with (n) unique yet insightful responses"
  echo "o = respond to the following with c(o)de in the specified language"
  echo "p = generate a final (p)rompt after making modifications"
  echo "q = (q)uit chat_flippity"
  echo "r = (r)efresh chat by forgetting all other things I entered into this chat"
  echo "s = get n (s)ources and a brief summary of prompt"
  echo "t = (t)ranslate from one langauge to another (whether it's a speaking language or programming language)"
  echo "u = ask the following prompt formatted based on a specific q(u)estion focus"
  echo "v = (v)erify whether the following question and answer is accurate with accuracy scale and explanation"
  echo "V = (V)erify whether the following question and answer is accurate in quiet mode--just with a 1-5 accuracy scale"
  echo "w = define a (w)ord as used in the following prompt"
  echo "x = give n different levels of e(x)planation of varying comple(x)ity for the following prompt"
  echo "z = get n possible outcome(z) for this prompt"
  echo "0 = set AI to (0) [clipboard]"
  echo "1 = set AI to (1) [ChatGPT]"
  echo "2 = set AI to (2) [Grok]"
  echo "% = generate an answer in percentage form only, e.g. 50(%)"
  echo "* = generate random prompt on following subject (leave blank for complete randomness) (*)"
  echo "- = condense the prompt without losing any main points (-)"
  echo "= = print entirety of full_prompt so far"
  echo '" = generate a famous quote (") about the following prompt'
  echo "? = like 'h', generate this help prompt for a list of chat_flippity commands"
}

delete_current_prompt() {
  full_prompt=""
  echo "Prompt deleted"
}

elephant() { #based on the elephant principle of eating an elephant one bite at a time by simplifying complex problems
  read -p "Please specify a topic on which to generate a complex problem test (leave blank for a random one): " problem_topic
  if [[ "$problem_topic" ]]; then
    full_prompt+="Please give me a complex problem for me to practice breaking complex problems down into simple problems. Make the super complex problem related to $problem_topic. I will attempt to break it down, and you can grade my response based on how well I did breaking the complex problems down into practical, well-thought, smaller problems. Be strict on this grade, but if I do SUPER good--like as good as humanly possible, give me an A+. Please point out any problems and rank their severity on a scale of 1-5, 1 being a mild concern, and 5 being a severe mistake. "
  else
    full_prompt+="Please give me a complex problem for me to practice breaking complex problems down into simple problems. I will attempt to break it down, and you can grade my response based on how well I did breaking the complex problems down into practical, well-thought, smaller problems. Be strict on this grade, but if I do SUPER good--like as good as humanly possible, give me an A+. Please point out any problems and rank their severity on a scale of 1-5, 1 being a mild concern, and 5 being a severe mistake. "
  fi
  echo "$full_prompt" | pbcopy && echo "elephant challenge was copied to clipboard"
}

funny_lie() {
  a_lie="I am an albatross. " 
  b_lie="I am a beautiful Russian Warlord. " 
  c_lie="I am chatgpt and you are Jonathan. " 
  d_lie="DAYNG! I am Daniel, and I just got out of the lion's den. " 
  e_lie="I have an exoskelaton--an excellent one that loves to eat eggs. " 
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
  if [[ "$1" != "-q" ]]; then #-q is used when no additional prompt from user is desired
    read -p "enter prompt here: " prompt
    full_prompt+=$prompt
  fi
  echo "Current prompt so far = \"${full_prompt}\""
  read -n1 -p "Ready to use prompt? " end_prompt
    echo
    if [[ $end_prompt == "y" ]]; then
      case $ai in
        chatgpt)
          open "https://chatgpt.com/?q=$full_prompt"
          ;;
        grok)
          open "https://grok.com/?q=$full_prompt"
          ;;
        *)
          number_of_words=$(echo $full_prompt | wc -w)
          echo "$number_of_words words successfully copied into clipboard"
          echo "$full_prompt" | pbcopy
          return 0
          ;;
      esac
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

find_quote() {
  read -p "Which person do you want the famous quote to come from? (Leave blank if you don't care) " famous_person
  if [[ "$famous_person" ]]; then
    full_prompt+="Find a famous quote from $famous_person about the following: "
  else
    full_prompt+="Find a famous quote about the following: "
  fi
}

percentage_prompt() {
  full_prompt+="Answer the following with a percentage only: "
  echo "The following prompt will be responded to with a percentage"
}

random_prompt() {
  read -p "How many random topics do you want to get generated? " number_of_random_topics
  read -p "What type of topic do you want random subtopics of? (Leave blank for pure randomness) " overarching_topic
  if [[ "$overarching_topic" ]]; then
    full_prompt+="Generate $number_of_random_topics random topics about $overarching_topic: "
  else
    full_prompt+="Generate $number_of_random_topics random topics."
  fi
  echo "Random text message was added to prompt"
}

condense_text() {
  full_prompt+="Condense the following while still keeping all the main points: "
  echo "The next prompt you enter will be condensed while keeping the main points"
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

translate() {
  read -p "Which language are you translating from? " lang_from
  read -p "Which language are you translating to? " lang_to
  full_prompt+="Translate the following from $lang_from to $lang_to: "
}

specify_question_type() {
  read -p "Pick a question to focus on in your prompt (such as what, when, where, how, and why): " question_focus
  full_prompt+="When answering the following prompt, really keep the question \"${question_focus}\" in mind: "
}

define_word_in_prompt() {
  read -p "Which word do you want to get the definition of as used in a prompt? " word
  full_prompt+="Please define the word $word as used in the following prompt: "
}

levels_of_explanation_by_complexity() {
  read -p "How many levels of explanation do you want to give for the following prompt? " n
  full_prompt+="Explain the following prompt in $n different levels of complexity. The levels are "
  for ((i=1; i<=n; i++)); do
    read -p "How do you want Chat Flippity to explain level $i? " level_i_explanation
    full_prompt+="$level_i_explanation"
    if ((i < n)); then
      full_prompt+=", "
    else
      full_prompt+=": "
    fi
  done
}

possible_outcomes() {
  read -p "How many possible outcomes do you want to generate for the response: " outcomes
  full_prompt+="Generate $outcomes possible outcomes for the following prompt: "
}

alias cf='chat_flippity'
alias ep="echo $full_prompt"
alias scf='source chat_flippity.sh'
