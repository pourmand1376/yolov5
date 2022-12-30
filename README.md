# Automatic Realtime Aneurysm Detection

This repository contains the source code for aneurysm project. 

## Image Postprocessing
All code for image postprocessing is available here. Also we implemented making an RGB dataset here. 

[Link](https://github.com/pourmand1376/dataset_preprocess/tree/main/DICOM_Aneurysm)

There are actually two branches which we have created for this project. To start to see what I've done. I take your attention to my makefile. I have tried to make my code as clear as possible for others to replicate easily. 

## Aneurysm Sampler
This is where I have added sampler and normalized loss function and rgb ideas. 

I've also made sampler publicly available for anyone to use via a [pull request](https://github.com/ultralytics/yolov5/pull/8766) on original yolov5 repo. 

[Link](https://github.com/pourmand1376/yolov5/tree/sampler_aneurysm)

## 3D Aneurysm
This is where I have implemented 3D convolutional idea. 

[Link](https://github.com/pourmand1376/yolov5/tree/3d_aneurysm)


All trained models are available [here](https://huggingface.co/pourmand1376/yolov5-aneurysm).
