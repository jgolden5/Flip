#!/bin/bash

full_prompt=""
ai="${ai:-$clipboard}"

if [[ $1 =~ ^- ]]; then
  echo "First flip parameter \"$1\" WAS a flag"
else
  echo "First flip parameter \"$1\" was NOT a flag"
fi
