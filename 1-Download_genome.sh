#!/usr/bin/env bash

mkdir ./genome

wget -O ./genome/Galdieria_sulphuraria.fasta.gz https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/341/285/GCF_000341285.1_ASM34128v1/GCF_000341285.1_ASM34128v1_genomic.fna.gz
wget -O ./genome/Galdieria_sulphuraria.gtf.gz https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/341/285/GCF_000341285.1_ASM34128v1/GCF_000341285.1_ASM34128v1_genomic.gtf.gz

gzip -d ./genome/*
