#!/bin/bash
openssl rand -out large_random.txt -base64 $(( 2**30 * 3/4 ))
