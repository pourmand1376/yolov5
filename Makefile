.ONESHELL:

SHELL = /bin/bash
CONDA_ACTIVATE = source $$(conda info --base)/etc/profile.d/conda.sh ; conda activate ; conda activate

install:
	$(CONDA_ACTIVATE) yolov5
	pip install -r requirements.txt

train_yolov5l_basic:
	$(CONDA_ACTIVATE) yolov5
	git checkout sampler_aneurysm
	git pull
	python train.py \
		--weights /mnt/new_ssd/projects/Anevrism/Models/pourmand/yolov5/runs/train/exp10/weights/best.pt \
		--data /mnt/new_ssd/projects/Anevrism/Data/brain_cta/output_folder/database.yaml \
		--hyp data/hyps/hyp.aneurisym.yaml \
		--epochs 200 --batch-size 50 --device 1 --save-period 5  \
		--weighted_sampler 

train_yolov5m_midlabel:
$(CONDA_ACTIVATE) yolov5
	git checkout sampler_aneurysm
	git pull
	python train.py \
		--weights /mnt/new_ssd/projects/Anevrism/Models/pourmand/yolov5/runs/train/exp27/weights/best.pt \
		--data /mnt/new_ssd/projects/Anevrism/Data/brain_cta/output_3dim/database.yaml \
		--hyp data/hyps/hyp.aneurisym.yaml \
		--epochs 200 --batch-size 50 --device 1 --save-period 5  \
		--weighted_sampler 
	