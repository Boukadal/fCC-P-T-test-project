#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [[ -z $1 ]]
then
echo Please provide an element as an argument.
elif [[ -n $1 ]]
then
  # get all variables
  if [[ $1 =~ ^[0-9]+$ ]]
  then
    ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number = $1")
  else
    SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE symbol = '$1'")
    NAME=$($PSQL "SELECT name FROM elements WHERE name = '$1'")
  fi

  # if not found
  if [[ -z $ATOMIC_NUMBER && -z $SYMBOL && -z $NAME ]]
  then
    echo "I could not find that element in the database."
  else
    # test if a correct element
    # atomic number test
    if [[ $1 == $ATOMIC_NUMBER ]]
    then
      NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number = $1")
      SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number = $1")
      ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM elements INNER JOIN properties USING(atomic_number) LEFT JOIN types USING(type_id) WHERE atomic_number = $1")
      MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM elements INNER JOIN properties USING(atomic_number) LEFT JOIN types USING(type_id) WHERE atomic_number = $1")
      BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM elements INNER JOIN properties USING(atomic_number) LEFT JOIN types USING(type_id) WHERE atomic_number = $1")
      TYPE=$($PSQL "SELECT types.type FROM elements INNER JOIN properties USING(atomic_number) LEFT JOIN types USING(type_id) WHERE atomic_number = $1")

      echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
    # symbol test
    elif [[ $1 == $SYMBOL ]]
    then
      ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE symbol = '$1'")
      NAME=$($PSQL "SELECT name FROM elements WHERE symbol = '$1'")
      ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM elements INNER JOIN properties USING(atomic_number) LEFT JOIN types USING(type_id) WHERE symbol = '$1'")
      MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM elements INNER JOIN properties USING(atomic_number) LEFT JOIN types USING(type_id) WHERE symbol = '$1'")
      BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM elements INNER JOIN properties USING(atomic_number) LEFT JOIN types USING(type_id) WHERE symbol = '$1'")
      TYPE=$($PSQL "SELECT types.type FROM elements INNER JOIN properties USING(atomic_number) LEFT JOIN types USING(type_id) WHERE symbol = '$1'")

      echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
    # name test
    elif [[ $1 == $NAME ]]
    then 
      ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE name = '$1'")
      SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE name = '$1'")
      ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM elements INNER JOIN properties USING(atomic_number) LEFT JOIN types USING(type_id) WHERE name = '$1'")
      MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM elements INNER JOIN properties USING(atomic_number) LEFT JOIN types USING(type_id) WHERE name = '$1'")
      BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM elements INNER JOIN properties USING(atomic_number) LEFT JOIN types USING(type_id) WHERE name = '$1'")
      TYPE=$($PSQL "SELECT types.type FROM elements INNER JOIN properties USING(atomic_number) LEFT JOIN types USING(type_id) WHERE name = '$1'")
      
      echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
    fi

  fi
   
fi 
