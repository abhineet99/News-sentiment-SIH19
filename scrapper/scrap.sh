#!/bin/bash


echo "Scrapping news at ..."
date +"Date : %d/%m/%Y Time : %H.%M.%S"
echo Initialising CSV File...Created Headers
echo Reading Economic Times
python3.6 parser_ecotimes.py
echo Reading The Hindu
python3.6 parser_hindu.py
echo Reading NDTV
python3.6 parser_ndtv.py
# echo Reading TOI
# python3.6 parser_toi.py
echo Reading Fin Express
python3.6 parser_finexpress.py

echo Done Searching....Checkout news_from_scrapper.csv for output!