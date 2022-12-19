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

jupyter: ## run jupyter
	jupyter notebook --port 8080

batch=40
exp=2
train_yolov5s: ## train simple yolov5s
	$(CONDA_ACTIVATE) yolov5
	git checkout polyp_kumc
	git pull
	python train.py --weights /mnt/new_ssd/projects/Polyp/yolov5/runs/train/kumc_yolov5s_$(exp)/weights/last.pt --data /mnt/new_ssd/projects/Polyp/kumc_project/KUMC/KUMC_Converted/dataset.yaml \
		--hyp data/hyps/hyp.scratch-high.yaml \
		--batch-size $(batch) --device $(device) --name kumc_yolov5s_

train_semi: ## semi supervised training
	$(CONDA_ACTIVATE) yolov5
	git checkout polyp_kumc
	git pull
	python train.py --weights /mnt/new_ssd/projects/Polyp/yolov5/runs/train/kumc_yolov5s_$(exp)/weights/last.pt \
		--data /mnt/new_ssd/projects/Polyp/kumc_project/KUMC/KUMC_Converted/dataset_semi.yaml \
		--hyp data/hyps/hyp.scratch-high.yaml \
		--batch-size $(batch) --device $(device) --name kumc_yolov5s_
batch=20
task=val
device=0
exp=2
val_yolov5s: ## val yolov5s 
	$(CONDA_ACTIVATE) yolov5
	git checkout polyp_kumc
	git pull
	python val.py --data /mnt/new_ssd/projects/Polyp/kumc_project/KUMC/KUMC_Converted/dataset.yaml \
		--weights /mnt/new_ssd/projects/Polyp/yolov5/runs/train/kumc_yolov5s_$(exp)/weights/last.pt \
		--batch-size $(batch) --task $(task) --device $(device)

conf=0.7
iou=0.45
detect: ## detect images in the folder to get the label
	$(CONDA_ACTIVATE) yolov5
	git pull
	python detect.py \
		--weights /mnt/new_ssd/projects/Polyp/yolov5/runs/train/kumc_yolov5s_$(exp)/weights/last.pt \
		--source /mnt/new_ssd/projects/Polyp/Data/semi-kvasir/images/ \
		--conf-thres ${conf} --iou-thres ${iou} \
		--save-txt --half --no-save
