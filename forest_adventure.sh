#!/bin/bash

clear
echo "🌲 Welcome to the Forest Adventure! 🌲"
echo

player_alive=true
found_treasure=false

function forest_path {
  echo "You stand at a fork in the forest trail."
  echo "1) Take the left path, which leads deeper into the dense woods."
  echo "2) Take the right path, where you hear a gentle stream."
  read -p "Choose 1 or 2: " choice

  case $choice in
    1)
      echo "You venture deeper into the thick trees..."
      bear_encounter
      ;;
    2)
      echo "You follow the sound of water and find a peaceful stream."
      stream_side
      ;;
    *)
      echo "Invalid choice, try again."
      forest_path
      ;;
  esac
}

function bear_encounter {
  echo "A wild bear appears! What do you do?"
  echo "1) Climb a nearby tree."
  echo "2) Try to scare the bear away."
  read -p "Choose 1 or 2: " action

  case $action in
    1)
      echo "You climb the tree just in time. The bear loses interest and wanders off."
      found_treasure=true
      ;;
    2)
      echo "You shout loudly, but the bear charges! You run and barely escape with your life."
      player_alive=false
      ;;
    *)
      echo "Invalid choice, try again."
      bear_encounter
      ;;
  esac
}

function stream_side {
  echo "By the stream, you spot a shiny object under the water."
  echo "1) Reach in to grab it."
  echo "2) Ignore it and rest by the stream."
  read -p "Choose 1 or 2: " action

  case $action in
    1)
      echo "You find a precious gem! This might be your lucky day."
      found_treasure=true
      ;;
    2)
      echo "You rest peacefully but find nothing of interest."
      ;;
    *)
      echo "Invalid choice, try again."
      stream_side
      ;;
  esac
}

# Start game
forest_path

echo
if $player_alive && $found_treasure; then
  echo "🎉 Congratulations! You survived the forest and found treasure!"
elif $player_alive; then
  echo "You survived the forest adventure but found no treasure. Try again?"
else
  echo "💀 You did not survive the forest adventure. Game over."
fi

