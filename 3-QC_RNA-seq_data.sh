#!/usr/bin/env bash

threads=4
env="work_comp"

source activate $env

## Se crea carpeta pal output

mkdir qc

## Comando pal fastqc

fastqc -t $threads -o qc/ data/*.fastq.gz

## Comando pal multiqc en la carpeta donde estan todos los fastqc results

mkdir qc/multiqc

multiqc ./qc/ -o ./qc/multiqc/
