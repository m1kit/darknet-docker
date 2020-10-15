FROM nvidia/cuda:10.1-cudnn7-devel-ubuntu18.04
ARG DEBIAN_FRONTEND=noninteractive

RUN apt update 
RUN apt install -y \
    wget pkg-config git build-essential libopencv-dev

# build darknet
WORKDIR /app
RUN git clone https://github.com/AlexeyAB/darknet.git
WORKDIR darknet
#RUN make OPENCV=1 GPU=1 CUDNN=1 CUDNN_HALF=1 AVX=0 OPENMP=0 -j $(nproc)
RUN make OPENCV=1 GPU=1 CUDNN=0 CUDNN_HALF=0 AVX=0 OPENMP=0 -j $(nproc)

RUN chmod +x darknet
RUN wget "https://github.com/AlexeyAB/darknet/releases/download/darknet_yolo_v3_optimal/yolov4.conv.137"

ENTRYPOINT ["/app/darknet/darknet"]

