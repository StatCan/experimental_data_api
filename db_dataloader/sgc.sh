#!/bin/sh

get_sgc() {
  column=$1;
  shift

  echo '  gsub(/"/, "", $'$column') \
  { gsub(/St. John\x27s Newfoundland and Labrador/, "001", $'$column') } \
  { gsub(/Charlottetown and Summerside Prince Edward Island/, "199", $'$column') } \
  { gsub(/Halifax/, "205", $'$column') } \
  { gsub(/Halifax Nova Scotia/, "205", $'$column') } \
  { gsub(/Saint John New Brunswick/, "310", $'$column') } \
  { gsub(/Québec Quebec/, "421", $'$column') } \
  { gsub(/Montréal/, "462", $'$column') } \
  { gsub(/Montréal Quebec/, "462", $'$column') } \
  { gsub(/Ottawa-Gatineau Ontario part Ontario\/Quebec/, "35505", $'$column') } \
  { gsub(/Ottawa/, "3506008", $'$column') } \
  { gsub(/Toronto/, "535", $'$column') } \
  { gsub(/Toronto Ontario/, "535", $'$column') } \
  { gsub(/Thunder Bay Ontario/, "595", $'$column') } \
  { gsub(/Winnipeg/, "602", $'$column') } \
  { gsub(/Winnipeg Manitoba/, "602", $'$column') } \
  { gsub(/Saskatoon/, "725", $'$column') } \
  { gsub(/Regina/, "705", $'$column') } \
  { gsub(/Regina Saskatchewan/, "705", $'$column') } \
  { gsub(/Saskatoon Saskatchewan/, "725", $'$column') } \
  { gsub(/Calgary/, "825", $'$column') } \
  { gsub(/Calgary, Alberta/, "825", $'$column') } \
  { gsub(/Edmonton/, "835", $'$column') } \
  { gsub(/Edmonton, Alberta/, "835", $'$column') } \
  { gsub(/Vancouver/, "933", $'$column') } \
  { gsub(/Vancouver British Columbia/, "933", $'$column') } \
  { gsub(/Victoria British Columbia/, "935", $'$column') } \
  { gsub(/Whitehorse Yukon/, "6001009", $'$column') } \
  { gsub(/Yellowknife Northwest Territories/, "6106023", $'$column') } \
  { gsub(/Iqaluit Nunavut/, "6204003", $'$column') } \
  { gsub(/Canada/, "01", $'$column') } \
  { gsub(/Newfoundland and Labrador/, "10", $'$column') } \
  { gsub(/Prince Edward Island/, "11", $'$column') } \
  { gsub(/Nova Scotia/, "12", $'$column') } \
  { gsub(/New Brunswick/, "13", $'$column') } \
  { gsub(/Quebec/, "24", $'$column') } \
  { gsub(/Ontario/, "35", $'$column') } \
  { gsub(/Manitoba/, "46", $'$column') } \
  { gsub(/Saskatchewan/, "47", $'$column') } \
  { gsub(/Alberta/, "48", $'$column') } \
  { gsub(/British Columbia/, "59", $'$column') } \
  { gsub(/Yukon/, "60", $'$column') } \
  { gsub(/Northwest Territories including Nunavut/, "61", $'$column') } \
  { gsub(/Northwest Territories/, "61", $'$column') } \
  { gsub(/Nunavut/, "62", $'$column') }'
}
