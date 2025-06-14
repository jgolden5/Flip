#!/bin/bash

prompt=""
ai="${ai:-$clipboard}"

flip() {
  if [[ $1 =~ ^- ]]; then
    ops="${1:1}"
    shift
    prompt="$@"
    execute_ops $ops
  else
    echo "First flip parameter \"$1\" was NOT a flag"
  fi
  echo "Flip Prompt = $prompt"
}

execute_ops() {
  first_op="${1:0:1}"
  execute_op $first_op
  remaining_ops="${1:1}"
  if [[ $remaining_ops ]]; then
    execute_ops $remaining_ops
  fi
}

execute_op() {
  op="$1"
  if [[ ${#op[@]} -gt 1 ]]; then
    echo "Op is too long"
    return 1
  else
    case $op in
      a)
        as_age "$prompt"
        ;;
      b)
        prompt="B + $prompt"
        ;;
      c)
        prompt="C = $prompt"
        ;;
      *)
        echo "Op not recognized"
        ;;
    esac
  fi
}

as_age() {
  read -p "What age should AI treat you as? " age
  prompt="Respond to the following as though I was $age years old: $prompt"
}
