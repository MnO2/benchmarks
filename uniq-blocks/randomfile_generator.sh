#!/bin/bash
dd if=/dev/urandom of=large_random.txt bs=1024 count=0 seek=$[1000*1000]
