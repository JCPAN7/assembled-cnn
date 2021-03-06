#!/usr/bin/env bash

set -e

# Where the ImageNet2012 TFR is stored to. Replace this with yours
DATA_DIR=/home1/irteam/user/jklee/food-fighters/models/tensorflow/ETHZ-food-101

# Where the the fine-tuned checkpoint is saved to. Replace this with yours
MODEL_DIR=hdfs://c3/user/tapi/sweaterr/train_food101_3/Assemble-R50

# Where the pretrained checkpoint is saved to. Replace this with yours
PRETRAINED_PATH=hdfs://c3/user/tapi/sweaterr/train_imagenet/m13blskaa_mixupaa_drbl_kd_ep600

CUDA_VISIBLE_DEVICES=0,1,2,3 python main_classification.py \
--dataset_name=food101 \
--data_dir=${DATA_DIR} \
--model_dir=${MODEL_DIR} \
--pretrained_model_checkpoint_path=${PRETRAINED_PATH} \
--num_gpus=4 \
--mixup_type=1 \
--autoaugment_type=good \
--label_smoothing=0.1 \
--resnet_version=2 \
--resnet_size=50 \
--anti_alias_filter_size=3 \
--anti_alias_type=sconv \
--use_sk_block=True \
--use_dropblock=True \
--dropblock_kp="0.9,0.7" \
--batch_size=256 \
--base_learning_rate=0.01 \
--learning_rate_decay_type=cosine \
--lr_warmup_epochs=5 \
--train_epochs=100 \
--bn_momentum=0.966 \
--weight_decay=0.001 \
--keep_checkpoint_max=0 \
--ratio_fine_eval=0.9 \
--epochs_between_evals=10 \
--clean
