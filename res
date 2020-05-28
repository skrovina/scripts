#!/bin/bash

File="/Users/martinskrovina/Downloads/Users 7/travis/artifacts/UnitTests.test_result-21310-0.xcresult"

if ! test "$File"
then
   >&2 echo "File does not exist"
fi

xcrun xcresulttool $@ --path "$File"
