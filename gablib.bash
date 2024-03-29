#!/usr/bin/bash

# This bash script/library will allow you to log into Gab using your account and perform
# API calls as if you were using a browser.
#
# (c) 2024 TechSavage. MIT license.

# Place your credentials in env values, for example in .profile or .bashrc
# export MASTODON_USEREMAIL="your@gab.email"
# export MASTODON_PASSWORD="yourPassword"

BASEURL="https://gab.com"
TMP="/tmp"
TMPCOOKIEJAR="$TMP/gab--cookies-$(date +%N)"

if [ -z $(which curl) ]; then
  echo "This script requires curl"
  exit 1
fi

# This function will try to obtain your access token needed as bearer token for
# most of the API calls.
#
# It will fist load the sign_in page and extract a authentication token which is
# required for the form. It will then POST your credentials. Gab will then redirect
# to a html file which will contain a JSON section including your access token which
# is then returned. You can store this token and reuse it without having to log back
# in; until it expires.
function getAccessToken() {
  local TMPSIGNIN="$TMP/gab--signin-$(date +%N).html"
  local TMPAUTH="$TMP/gab--auth-$(date +%N).html"

  curl -c "$TMPCOOKIEJAR" "$BASEURL/auth/sign_in" > "$TMPSIGNIN" 2>/dev/null
  local FORMTOKEN=$(sed -n '/token/s/.*name="authenticity_token"\s\+value="\([^"]\+\).*/\1/p' "$TMPSIGNIN")

  curl "$BASEURL/auth/sign_in" \
     -L \
     --location-trusted \
     -b "$TMPCOOKIEJAR" -c "$TMPCOOKIEJAR" \
     -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:109.0) Gecko/20100101 Firefox/124.0" \
     -H "Content-Type: application/x-www-form-urlencoded" \
     --data-urlencode "authenticity_token=$FORMTOKEN" \
     --data-urlencode "user[email]=$MASTODON_USEREMAIL" \
     --data-urlencode "user[password]=$MASTODON_PASSWORD" > "$TMPAUTH" 2>/dev/null

  local HTML="$(sed 's:^ *::g' < "$TMPAUTH" | tr -d \\n)"
  ACCESSTOKEN=$(sed 's/.*"access_token":"\{0,1\}\([^,"]*\)"\{0,1\}.*/\1/' <<<"$HTML")
}

function fetch.get() {
  local URL="$BASEURL/$1"
  RESPONSE=$(curl "$URL" \
                  -b "$TMPCOOKIEJAR" -c "$TMPCOOKIEJAR" \
                  -H "Content-Type: application/json" \
                  -H "Authorization: Bearer $ACCESSTOKEN" 2>/dev/null)
}
