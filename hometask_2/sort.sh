#!/bin/bash
sort --version-sort versions.txt | uniq | sed G | less
