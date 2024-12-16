#!/bin/bash

mkdir -p HEAD
git fetch --all --tags
tags_string=$(git tag)
echo got tag string
echo $tags_string
tags_array=($tags_string)
mv * HEAD
for tag in "${tags_array[@]}"
do
  echo starting with tag $tag
  mkdir $tag
  cd $tag
  git clone https://github.com/arnoweiss/decentralized-claims-protocol.git --depth 1 --branch ${tag} --quiet
  pwd
  mv ./decentralized-claims-protocol/* .
  if [ -f "index.html" ]; then
      echo "index exists."
      mkdir -p resources
      cp -r artifacts/src/main/resources/* resources
      rm -rf artifacts
  else
    echo "index does not exist. No copy operations"
  fi
  cd ..
done