## different options to train yolov5 model

.ONESHELL:

SHELL = /bin/bash
CONDA_ACTIVATE = source $$(conda info --base)/etc/profile.d/conda.sh ; conda activate ; conda activate

help:  ## Show this help.
	@sed -ne '/@sed/!s/## //p' $(MAKEFILE_LIST)

install: ## install yolov5 dependencies
	$(CONDA_ACTIVATE) yolov5
	pip install -r requirements.txt

tensorboard: ## run tensorboard
	$(CONDA_ACTIVATE) yolov5
	tensorboard --logdir runs/train --port 6006

train_yolov5l_basic: ## train yolov5 large model with default database
	$(CONDA_ACTIVATE) yolov5
	git checkout sampler_aneurysm
	git pull
	python train.py \
		--weights /mnt/new_ssd/projects/Anevrism/Models/pourmand/yolov5/runs/train/exp10/weights/best.pt \
		--data /mnt/new_ssd/projects/Anevrism/Data/brain_cta/output_folder/database.yaml \
		--hyp data/hyps/hyp.aneurisym.yaml \
		--epochs 200 --batch-size 50 --device 1 --save-period 5  \
		--weighted_sampler 

train_yolov5m_midlabel: ## train yolov5 medium model with 3dim database
	$(CONDA_ACTIVATE) yolov5
	git checkout sampler_aneurysm
	git pull
	python train.py \
		--weights /mnt/new_ssd/projects/Anevrism/Models/pourmand/yolov5/runs/train/exp49/weights/best.pt \
		--data /mnt/new_ssd/projects/Anevrism/Data/brain_cta/output_3dim/database.yaml \
		--hyp data/hyps/hyp.aneurisym.yaml \
		--epochs 200 --batch-size 60 --device 0 --save-period 5  \
		--weighted_sampler --resume
	