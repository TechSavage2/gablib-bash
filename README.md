gablib for bash
===============

See [this repository](https://github.com/TechSavage2/gablib) for details. This repository contains files that
can be 'imported' into your bash script to provide functions making
it easier to handle API calls towards the Mastodon server.

Getting Started
---------------

Make sure you have a registered and active account with the Mastodon site you want to log on to ( unless you only want to use the public APIs.)

Make sure to initialize environmental variables on your system.

For Linux and macOS, you can use:

```bash
export MASTODON_USEREMAIL='your@mastodon.email'
export MASTODON_PASSWORD='yourSecretPassword'
```

Add this in, for example, your ~/.profile file on Linux (or ~/.bashrc if you're using Wayland,) and to the ~/.bash_profile on macOS.

Windows (cmd)

```bash
setx MASTODON_USEREMAIL "your@mastodon.email"
setx MASTODON_PASSWORD "yourSecretPassword"
```

Remember to restart the shell for the changes to take effect.

Prerequisites
--------------

You will need the `curl` and `tr` command installed. 

(`tr` usually comes preinstalled on linux systems.)


Example
-------

Import the library into your bash script:

```bash
. ./gablib.bash --source-only
```

You can now call the functions it comes with:

```bash
getAccessToken;

echo $ACCESSTOKEN
```

Output your notifications:

```bash
fetch.get "/api/v1/notifications"
echo $RESPONSE | jq
```

**NOTE** this is a very (!) early version and only contain the basic
function to get the access token. You can however use the access token
and call the API "manually" by setting the `Authorization` header for requests:

```http request
Authorization: Bearer ACCESSTOKEN
```

The token can be reused between calls, and you don't have to log in every time, at least until the token expires.

License
-------

MIT

Copyright 2024 TechSavage

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
