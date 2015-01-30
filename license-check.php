<?php
// This file is necessary for legacy copies of GestureKey Flash to stay
// unlocked.  It does not do any actual checking but returns a "valid license"
// code for any submitted license.

header('Content-Type: text/plain');
echo "t=".md5($_GET["l"].",ROBOT".",none");
