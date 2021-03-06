#!/bin/bash

# These are some common environment variables

ENVDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

export PROJECT_NAME=webrtcbuilds
export REPO_URL="https://chromium.googlesource.com/external/webrtc"

export UNAME=`uname`
if [ "$UNAME" != "Darwin" -a "$UNAME" != "Linux" ]; then
  if [ "$OS" = 'Windows_NT' ]; then
    export UNAME='Windows_NT'
  else
    echo "Building on unsupported platform"
    exit 1
  fi
fi

if [ "$UNAME" = "Linux" ]; then
  export PLATFORM=linux64
  export OUT_DIR=$ENVDIR/out
  export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64
elif [ "$UNAME" = "Windows_NT" ]; then
  export PLATFORM=windows
  export OUT_DIR=$ENVDIR/out
elif [ "$UNAME" = "Darwin" ]; then
  export PLATFORM=osx
  export OUT_DIR=$ENVDIR/out
fi

mkdir -p $OUT_DIR

export DEPOT_TOOLS=$ENVDIR/depot_tools
export PATH=$DEPOT_TOOLS:$PATH
if [ "$UNAME" = "Windows_NT" ]; then
  export DEPOT_TOOLS_WIN_TOOLCHAIN=0
  export PATH=$DEPOT_TOOLS/python276_bin:$PATH
  if [ -d $DEPOT_TOOLS ]; then
    export WIN_DEPOT_TOOLS=`cd $DEPOT_TOOLS; pwd -W`
  else
    export WIN_DEPOT_TOOLS=""
  fi
fi

# for extensibility
if [ -f $ENVDIR/environment.local ]; then
  source $ENVDIR/environment.local
fi
