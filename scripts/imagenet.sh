# --------
# ImageNet
# --------

python main_imagenet.py --epochs 90 --batch-size 256 --lr 0.08 --prune --cache-dataset --soft-keeping-ratio 0.5 --pretrained --target-flops 2 --global-pruning --data-path data/imagenet --model resnet50 --method random
python main_imagenet.py --epochs 90 --batch-size 256 --lr 0.08 --prune --cache-dataset --soft-keeping-ratio 0.5 --pretrained --target-flops 2 --global-pruning --data-path data/imagenet --model resnet50 --method l2
python main_imagenet.py --epochs 90 --batch-size 256 --lr 0.08 --prune --cache-dataset --soft-keeping-ratio 0.5 --pretrained --target-flops 2 --global-pruning --data-path data/imagenet --model resnet50 --method fpgm
python main_imagenet.py --epochs 90 --batch-size 256 --lr 0.08 --prune --cache-dataset --soft-keeping-ratio 0.5 --pretrained --target-flops 2 --global-pruning --data-path data/imagenet --model resnet50 --method obdc
python main_imagenet.py --epochs 90 --batch-size 256 --lr 0.08 --prune --cache-dataset --soft-keeping-ratio 0.5 --pretrained --target-flops 2 --global-pruning --data-path data/imagenet --model resnet50 --method lamp
python main_imagenet.py --epochs 90 --batch-size 256 --lr 0.08 --prune --cache-dataset --soft-keeping-ratio 0.5 --pretrained --target-flops 2 --global-pruning --data-path data/imagenet --model resnet50 --method slim
python main_imagenet.py --epochs 90 --batch-size 256 --lr 0.08 --prune --cache-dataset --soft-keeping-ratio 0.5 --pretrained --target-flops 2 --global-pruning --data-path data/imagenet --model resnet50 --method group_norm
python main_imagenet.py --epochs 90 --batch-size 256 --lr 0.08 --prune --cache-dataset --soft-keeping-ratio 0.5 --pretrained --target-flops 2 --global-pruning --data-path data/imagenet --model resnet50 --method group_sl
python main_imagenet.py --epochs 90 --batch-size 256 --lr 0.08 --prune --cache-dataset --soft-keeping-ratio 0.5 --pretrained --target-flops 2 --global-pruning --data-path data/imagenet --model resnet50 --method proj
python main_imagenet.py --epochs 90 --batch-size 256 --lr 0.08 --prune --cache-dataset --soft-keeping-ratio 0.5 --pretrained --target-flops 2 --global-pruning --data-path data/imagenet --model resnet50 --method proj_sl

python -m torch.distributed.launch --nproc_per_node=8 --master_port 18208 --use_env main_imagenet.py --model regnet_x_1_6gf --epochs 100 --batch-size 256 --wd 0.00005 --lr 0.08 --lr-scheduler=cosineannealinglr --lr-warmup-method=linear --lr-warmup-epochs=5 --lr-warmup-decay=0.1 --prune --cache-dataset --method group_norm --soft-keeping-ratio 0.6 --pretrained --output-dir run/imagenet/regnet_x_1_6gf_gnorm --target-flops 0.8 --global-pruning --workers 16 --print-freq 100 --amp
python -m torch.distributed.launch --nproc_per_node=4 --master_port 18211 --use_env main_imagenet.py --model regnet_x_1_6gf --epochs 60 --batch-size 256 --wd 0.00005 --lr 0.04 --lr-scheduler=cosineannealinglr --lr-warmup-method=linear --prune --cache-dataset --method group_sl --global-pruning --pretrained --output-dir run/imagenet/regnet_x_1_6gf_gsl --target-flops 0.8 --max-pruning-ratio 0.7 --sl-epochs 60 --sl-lr 0.04 --cache-dataset --reg 1e-4 --amp --data-path ~/Datasets/imagenet &>run/imagenet/regnet_gsl.log
python -m torch.distributed.launch --nproc_per_node=2 --master_port 18101 --use_env main_imagenet.py --model vgg19_nn --pretrained --epochs 90 --batch-size 64 --lr 0.01 --wd 0.00004 --lr-step-size 1 --lr-gamma 0.98 --prune --cache-dataset --method group_norm --global_pruning --soft_keeping_ratio 0.5 --pretrained --target_flops 2.0 --output-dir run/imagenet_log/mob_ckpt

CUDA_VISIBLE_DEVICES=4,5,6,7 OMP_NUM_THREADS=4 python -m torch.distributed.launch --nproc_per_node=4 --master_port 18122 --use_env main_imagenet.py --model mobilenet_v2 --pretrained --epochs 150 --batch-size 512 --lr 0.036 --wd 0.00004 --lr-step-size 1 --lr-gamma 0.98 --prune --cache-dataset --method group_sl --global-pruning --pretrained --target-flops 0.15 --output-dir run/imagenet/mobilenet_gsl --reg 1e-4 --sl-epochs 150 --sl-lr 0.036 --sl-lr-step-size 1 --print-freq 100 --amp --max-pruning-ratio 0.7
OMP_NUM_THREADS=4 python -m torch.distributed.launch --nproc_per_node=4 --master_port 18119 --use_env main_imagenet.py --model densenet121 --epochs 90 --batch-size 512 --lr-step-size 30 --lr 0.08 --prune --method group_sl --global-pruning --soft-keeping-ratio 0.25 --pretrained --output-dir run/imagenet/densenet121_sl --target-flops 1.38 --sl-epochs 30 --sl-lr 0.08 --sl-lr-step-size 10 --cache-dataset --reg 1e-4 --print-freq 100 --workers 16 --amp
OMP_NUM_THREADS=4 python -m torch.distributed.launch --nproc_per_node=8 --master_port 18101 --use_env main_imagenet.py --model mobilenet_v2 --pretrained --epochs 300 --batch-size 256 --lr 0.045 --wd 0.00004 --lr-step-size 1 --lr-gamma 0.98 --prune --cache-dataset --method group_norm --global_pruning --soft_keeping_ratio 0.5 --pretrained --target_flops 0.15 --output-dir run/imagenet/mobilenetv2_gnorm --amp
OMP_NUM_THREADS=4 python -m torch.distributed.launch --nproc_per_node=8 --master_port 18122 --use_env main_imagenet.py --model mobilenet_v2 --pretrained --epochs 150 --batch-size 32 --lr 0.0045 --wd 0.00004 --lr-step-size 1 --lr-gamma 0.98 --prune --cache-dataset --method group_sl --global-pruning --pretrained --target-flops 0.15 --output-dir run/imagenet/mobilenet_gsl --reg 1e-4 --sl-epochs 150 --sl-lr 0.0045 --sl-lr-step-size 1 --print-freq 100 --amp --max-pruning-ratio 0.7
OMP_NUM_THREADS=4 python -m torch.distributed.launch --nproc_per_node=8 --master_port 18113 --use_env main_imagenet.py --model resnext50_32x4d --epochs 100 --batch-size 256 --lr 0.08 --prune --cache-dataset --method group_norm --soft-keeping-ratio 0.5 --pretrained --output-dir run/imagenet/next50_gnorm --target-flops 2.11 --global-pruning --print-freq 100 --workers 8
OMP_NUM_THREADS=4 python -m torch.distributed.launch --nproc_per_node=4 --master_port 18113 --use_env main_imagenet.py --model resnext50_32x4d --epochs 100 --batch-size 512 --lr 0.08 --prune --cache-dataset --method group_sl --soft-keeping-ratio 0.25 --pretrained --output-dir run/imagenet/next50_gsl --target-flops 2.11 --global-pruning --print-freq 100 --workers 8
OMP_NUM_THREADS=4 python -m torch.distributed.launch --nproc_per_node=8 --master_port 18113 --use_env main_imagenet.py --model resnet50 --epochs 90 --batch-size 256 --lr 0.08 --prune --cache-dataset --method group_norm --soft-keeping-ratio 0.5 --pretrained --output-dir run/imagenet/resnet50_gnorm --target-flops 2.04 --global-pruning --print-freq 100 --workers 8
OMP_NUM_THREADS=4 python -m torch.distributed.launch --nproc_per_node=8 --master_port 18119 --use_env main_imagenet.py --model resnet50 --epochs 90 --batch-size 256 --lr-step-size 30 --lr 0.08 --prune --method group_sl --global-pruning --soft-keeping-ratio 0.5 --pretrained --output-dir run/imagenet/resnet50_sl --target-flops 2.04 --sl-epochs 30 --sl-lr 0.08 --sl-lr-step-size 10 --cache-dataset --reg 1e-4 --print-freq 100 --workers 16 --amp
OMP_NUM_THREADS=4 python -m torch.distributed.launch --nproc_per_node=8 --master_port 18101 --use_env main_imagenet.py --model vit_b_16 --epochs 300 --batch-size 512 --opt adamw --lr 0.003 --wd 0.3 --lr-scheduler cosineannealinglr --lr-warmup-method linear --lr-warmup-epochs 30 --lr-warmup-decay 0.033 --amp --label-smoothing 0.11 --mixup-alpha 0.2 --auto-augment ra --clip-grad-norm 1 --ra-sampler --cutmix-alpha 1.0 --model-ema --prune --cache-dataset --method group_norm --global_pruning --soft_keeping_ratio 0.5 --pretrained --target_flops 10 --output-dir run/imagenet/vit_norm --amp &>run/imagenet/vit_group_norm.log
