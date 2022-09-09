.ONESHELL:

SHELL = /bin/bash
CONDA_ACTIVATE = source $$(conda info --base)/etc/profile.d/conda.sh ; conda activate ; conda activate

device=0

.PHONY: help
help: update
	@egrep -h '\s##\s' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m  %-30s\033[0m %s\n", $$1, $$2}'

update:
	git pull

install: ## install yolov5 dependencies
	$(CONDA_ACTIVATE) yolov5
	pip install -r requirements.txt

batch=40
train_yolov5s: ## train simple yolov5s
	$(CONDA_ACTIVATE) yolov5
	git checkout polyp_kumc
	git pull
	python train.py --weights yolov5s.pt --data /mnt/new_ssd/projects/Polyp/kumc_project/KUMC/KUMC_Converted/dataset.yaml \
		--batch-size $(batch) --device $(device) --save-period 5  --name kumc_yolov5s_
batch=20
task=val
device=0
val_yolov5s: ## val yolov5s 
	$(CONDA_ACTIVATE) yolov5
	git checkout polyp_kumc
	git pull
	python val.py --data /mnt/new_ssd/projects/Polyp/kumc_project/KUMC/KUMC_Converted/dataset.yaml \
		--weights /mnt/new_ssd/projects/Polyp/yolov5/runs/train/kumc_yolov5s_2/weights/last.pt \
		--batch-size $(batch) --task $(task) --device $(device)