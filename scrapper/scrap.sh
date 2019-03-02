#!/bin/bash

echo Reading Economic Times
python3 parser_ecotimes.py
echo Reading The Hindu
python3 parser_hindu.py
echo Reading NDTV
python3 parser_ndtv.py
echo Reading TOI
python3 parser_toi.py