#!/usr/bin/env bash

threads=4
env="work_comp"
source activate $env

mkdir ./DEseq/qc
mkdir ./DEseq/out
mkdir ./DEseq/norm_counts

Rscript DEseq2_analysis_script.R
