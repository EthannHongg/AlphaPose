FROM ubuntu:20.04

RUN apt-get update \
        && apt-get install --no-install-recommends -y \
        git \
        python3-pip \
        libgomp1 \
        libglib2.0-0 \
        libsm6 \
        libxext6 \
        libxrender-dev \
        && rm -rf /var/lib/apt/lists/*
        
# install requirements
COPY requirements.txt .
RUN pip3 install --no-cache-dir -r requirements.txt -f https://download.pytorch.org/whl/torch_stable.html

COPY . .

RUN pip install gdown && \
    gdown 1D47msNOOiJKvPOXlnpyzdKA3k6E97NTC -O models/yolo/yolov3-spp.weights&& \
    gdown 1OPORTWB2cwd5YTVBX-NE8fsauZJWsrtW -O models/sppe/duc_se.pth

# RUN git clone https://github.com/Walter0807/MotionBERT.git /motionbert

# # Assuming the requirements.txt of MotionBERT doesn't conflict with the AlphaPose requirements.
# # If it does, there might be need to handle the dependencies more selectively.
# WORKDIR /motionbert
# RUN pip install -r requirements.txt

# # Not sure about the PyTorch CUDA version specified, as you mentioned a CPU version. If needed, this can be adjusted.
# RUN pip install torch torchvision torchaudio

# # Download the model checkpoint
# RUN gdown 1V-3dTU5_Fp2p6hqTk27SUrP5JBlqbQRm -O checkpoint/pose3d/FT_MB_lite_MB_ft_h36m_global_lite/best_epoch.bin

# # Switching back to root for further operations, if any.
# WORKDIR /