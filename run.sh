#!/usr/bin/env bash 

# create a new conda env with python 3.9

# install pytorch 1.12.1 with cuda 11.6

# install DinkyTrain from source


<<\c
git clone https://github.com/princeton-nlp/DinkyTrain.git
cd DinkyTrain
pip install --editable ./
c

# skip fp16 adn deepspeed for now

# download gpt2 bpe encoder and vocab
<<\c
wget -O gpt2_bpe/encoder.json https://dl.fbaipublicfiles.com/fairseq/gpt2_bpe/encoder.json
wget -O gpt2_bpe/vocab.bpe https://dl.fbaipublicfiles.com/fairseq/gpt2_bpe/vocab.bpe
c

<<\c
# install git lfs 
sudo apt-get -y install git-lfs
# download preprocessed wikipedia+bookCorpus
git clone https://huggingface.co/datasets/princeton-nlp/wikibook_fairseq_format
c

DATA_DIR=$(seq 0 15 | sed -e 's/^/wikibook_fairseq_format\/bin-shard/' | sed -e 's/$/-8/' | paste -sd ':')
echo $DATA_DIR

#pre-training
#GPU={number of GPUs} DATA_DIR={data path} [DEEPSPEED=1] bash run_efficient_mlm_recipe.sh
GPU=1 DATA_DIR=${DATA_DIR} DEEPSPEED=0 bash run_efficient_mlm_recipe.sh
