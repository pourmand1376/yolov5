## different options to train yolov5 model
## we have some default arguments, device = 0, workers = 8. 
## you can change them like `make test_action task=train device=0 workers=5 `
## they should be all without any spaces before or after

.ONESHELL:

SHELL = /bin/bash
CONDA_ACTIVATE = source $$(conda info --base)/etc/profile.d/conda.sh ; conda activate ; conda activate

workers = 1
device = 0

.PHONY: help
help:
	@egrep -h '\s##\s' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m  %-30s\033[0m %s\n", $$1, $$2}'

update: ## pull git updates
	git pull

.PHONY:git
git: update ## pull git updates

.PHONY: install
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
		--img-size 512 \
		--weights /mnt/new_ssd/projects/Anevrism/Models/pourmand/yolov5/runs/train/exp10/weights/best.pt \
		--data /mnt/new_ssd/projects/Anevrism/Data/brain_cta/output_folder/database.yaml \
		--hyp data/hyps/hyp.aneurisym.yaml \
		--epochs 200 --batch-size 50 --device $(device) --save-period 5 --workers $(workers) \
		--weighted_sampler 

train_yolov5m: ## yolov5m without 3dim data
	$(CONDA_ACTIVATE) yolov5
	git checkout sampler_aneurysm
	git pull
	python train.py \
		--img-size 512 \
		--weights /mnt/new_ssd/projects/Anevrism/Models/pourmand/yolov5/runs/train/exp50/weights/last.pt \
		--data /mnt/new_ssd/projects/Anevrism/Data/brain_cta/output_folder/database.yaml \
		--hyp data/hyps/hyp.yolov5m_normal.yaml \
		--epochs 200 --batch-size 60 --device $(device) --save-period 5 --workers $(workers) \
		--weighted_sampler 
		
train_yolov5m_midlabel_mosaic: ## train yolov5 mid model with mosaic database
	$(CONDA_ACTIVATE) yolov5
	git checkout sampler_aneurysm
	git pull
	python train.py \
		--img-size 512 \
		--weights /mnt/new_ssd/projects/Anevrism/Models/pourmand/yolov5/runs/train/exp55/weights/last.pt \
		--data /mnt/new_ssd/projects/Anevrism/Data/brain_cta/output_mosaic/database.yaml \
		--hyp data/hyps/hyp.yolov5m_midlabel_mosaic.yaml \
		--epochs 200 --batch-size 60 --device $(device) --save-period 5 --workers $(workers) \
		--weighted_sampler 

train_yolov5m_midlabel: ## train yolov5 mid model with 3dim database
	$(CONDA_ACTIVATE) yolov5
	git checkout sampler_aneurysm
	git pull
	python train.py \
		--img-size 512 \
		--weights /mnt/new_ssd/projects/Anevrism/Models/pourmand/yolov5/runs/train/exp55/weights/last.pt \
		--data /mnt/new_ssd/projects/Anevrism/Data/brain_cta/output_3dim/database.yaml \
		--hyp data/hyps/hyp.yolov5m_midlabel.yaml \
		--epochs 200 --batch-size 60 --device $(device) --save-period 5 --workers $(workers) \
		--weighted_sampler 

task = val
val_yolov5m_midlabel: ## validation of yolov5 midlabel with 3dim database
	## for this one pass task=train or task=val or task=test 
	## default is val
	$(CONDA_ACTIVATE) yolov5
	git checkout sampler_aneurysm
	git pull
	python val.py \
		--data /mnt/new_ssd/projects/Anevrism/Data/brain_cta/output_3dim/database.yaml \
		--weight /mnt/new_ssd/projects/Anevrism/Models/pourmand/yolov5/runs/train/exp49/weights/last.pt \
		--batch-size 40 --device $(device) --img-size 512 \
		--task $(task) \
		--save-txt \
		--workers $(workers)
