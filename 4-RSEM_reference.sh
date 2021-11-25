#!/usr/bin/env bash

env="work_comp"
source activate $env

mkdir rsem_ref

rsem-prepare-reference --gtf ./genome/Galdieria_sulphuraria.gtf --bowtie2 ./genome/Galdieria_sulphuraria.fasta ./rsem_ref/Galdieria_sulphuraria_rsem