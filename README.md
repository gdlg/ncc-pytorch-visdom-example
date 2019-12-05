# Durham NCC PyTorch example

This example is based on PyTorch MNIST example (https://github.com/pytorch/examples/tree/master/mnist) and has been adapted to work on NCC.

## Creating a virtual environment and installing

Run the following commands to create a Python virtual environment and install torch in the environment.
```
virtualenv3 env
source env/bin/activate
pip install torch torchvision
```

Note that every time that you would like to work on this project, you must source this environment with:
```
source env/bin/activate
```

## Configuring your SLURM jobs

Have a look at the example SLURM batch file called `example.slurm`. This file defines how much resource to allocate to your job and how to run it. The file is divided in two parts. The first few lines starting with `#SBATCH` are interpreted by SLURM itself and used to determine how much resource to allocate to the job. The second part is a regular shell script which will be run on the compute node.

## Running your code

To submit a job:
```
sbatch example.slurm
```
This command will send your job to the job queue and output the ID of the job.

To check the status of your job:
```
squeue
```
Look for the job id. Note that if you can’t find your job in the list, this means that your job already completed; this often happens if there was an error early on and your job crashed within seconds of starting.

The job output is written by SLURM in a file called `slurm-JOBID.out`. This file is written in real time however it might be updated only once in a while if your application is caching stdio. To avoid this problem with python, python must be run with the -u option (see `example.slurm`).

You can also cancel a job using:
```
scancel JOBID
```

While your job is running, start the program called `stop` (for SLURM top). It is similar to the well known Linux tool `htop` but adapted to SLURM. It will show a few real-time statistics about your job. This is useful to spot issues such as: not using the GPU, underutilising the GPU, high CPU or memory usage, etc.

