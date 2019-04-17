#!/bin/sh

get_sgc() {
  column=$1;
  shift

  echo '  gsub(/"/, "", $'$column') \
  { gsub(/Halifax/, "205", $'$column') } \
  { gsub(/Montréal/, "462", $'$column') } \
  { gsub(/Ottawa/, "3506008", $'$column') } \
  { gsub(/Toronto/, "535", $'$column') } \
  { gsub(/Winnipeg/, "602", $'$column') } \
  { gsub(/Saskatoon/, "725", $'$column') } \
  { gsub(/Regina/, "705", $'$column') } \
  { gsub(/Calgary/, "825", $'$column') } \
  { gsub(/Edmonton/, "835", $'$column') } \
  { gsub(/Vancouver/, "933", $'$column') } \
  { gsub(/Canada?/, "01", $'$column') } \
  { gsub(/Newfoundland and Labrador?/, "10", $'$column') } \
  { gsub(/Prince Edward Island?/, "11", $'$column') } \
  { gsub(/Nova Scotia?/, "12", $'$column') } \
  { gsub(/New Brunswick?/, "13", $'$column') } \
  { gsub(/Quebec?/, "24", $'$column') } \
  { gsub(/Ontario?/, "35", $'$column') } \
  { gsub(/Manitoba?/, "46", $'$column') } \
  { gsub(/Saskatchewan?/, "47", $'$column') } \
  { gsub(/Alberta?/, "48", $'$column') } \
  { gsub(/British Columbia?/, "59", $'$column') } \
  { gsub(/Yukon?/, "60", $'$column') } \
  { gsub(/Northwest Territories including Nunavut?/, "61", $'$column') } \
  { gsub(/Northwest Territories?/, "61", $'$column') } \
  { gsub(/Nunavut?/, "62", $'$column') }'
}
