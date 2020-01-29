#!/bin/bash

sort versions.txt | uniq -c | sort -rn | head -n 1
