#!/usr/bin/python

Usage = """
Print the length of each fasta sequence in a file
by default prints to the stdout
Usage:
  fasta_length.py inputfile.fasta > seq_length.txt

Arun Seetharam
arnstrm@iastate.edu
fasta_length.py -version 1.0
07/01/2015
"""
from Bio import SeqIO
import sys
if len(sys.argv)<2:
    print Usage
else:
    cmdargs = str(sys.argv)
    for seq_record in SeqIO.parse(str(sys.argv[1]), "fasta"):
        output_line = '%s\t%i' % \
        (seq_record.id, len(seq_record)) 
        print(output_line)
