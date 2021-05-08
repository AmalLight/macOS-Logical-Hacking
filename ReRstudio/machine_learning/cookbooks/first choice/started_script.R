library ( keras )
library ( tidyverse )

x_data <- matrix ( rnorm( 1000 * 784 ) , nrow = 1000, ncol = 784 )
y_data <- matrix ( rnorm( 1000       ) , nrow = 1000, ncol =   1 )

dim ( x_data )
dim ( y_data )

print (
    c (
        "A Sequential model is appropriate for a plain stack" ,
        "of layers where each layer has exactly one"          ,
        "input tensor and one output tensor."
    )
)

model_sequential <- keras_model_sequential ()

# 2021-05-01 22:43:32.489321: W tensorflow/stream_executor/platform/default/dso_loader.cc:60] Could not load dynamic library 'libcudart.so.11.0'; dlerror: libcudart.so.11.0: cannot open shared object file: No such file or directory; LD_LIBRARY_PATH: /home/kaumi/anaconda/envs/r-reticulate/lib:/usr/lib/R/lib:/usr/lib/x86_64-linux-gnu:/usr/lib/jvm/default-java/lib/server
# 2021-05-01 22:43:32.489490: I tensorflow/stream_executor/cuda/cudart_stub.cc:29] Ignore above cudart dlerror if you do not have a GPU set up on your machine.
# 2021-05-01 22:43:34.752478: I tensorflow/compiler/jit/xla_cpu_device.cc:41] Not creating XLA devices, tf_xla_enable_xla_devices not set
# 2021-05-01 22:43:34.753392: I tensorflow/stream_executor/platform/default/dso_loader.cc:49] Successfully opened dynamic library libcuda.so.1
# 2021-05-01 22:43:34.781807: E tensorflow/stream_executor/cuda/cuda_driver.cc:328] failed call to cuInit: CUDA_ERROR_NO_DEVICE: no CUDA-capable device is detected
# 2021-05-01 22:43:34.781886: I tensorflow/stream_executor/cuda/cuda_diagnostics.cc:156] kernel driver does not appear to be running on this host (kaumi): /proc/driver/nvidia/version does not exist
# 2021-05-01 22:43:34.782453: I tensorflow/compiler/jit/xla_gpu_device.cc:99] Not creating XLA devices, tf_xla_enable_xla_devices not set


