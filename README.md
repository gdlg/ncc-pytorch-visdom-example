# Durham NCC PyTorch example

This example is based on PyTorch MNIST example (https://github.com/pytorch/examples/tree/master/mnist) and has been adapted to work on NCC.

This example show how to use a separate web server such as Visdom to visualise information about the training of your neural network.

## Creating a virtual environment and installing

Run the following commands to create a Python virtual environment and install torch in the environment.
```
virtualenv3 env
source env/bin/activate
pip install torch torchvision visdom
```

Note that every time that you would like to work on this project, you must source this environment with:
```
source env/bin/activate
```

## Starting the Visdom server

Visdom is based on a web server which you must start beforehand. The server should be running as long as you need (both while you are running your job and after when you are analysing your data). Therefore it doesn’t make sense to start it inside your job because it will be destroyed as soon as the job finishes. Therefore the server should running on the head node for as long as you need it. It is good idea to leave the server running inside a tmux to keep the server running even when you disconnect from NCC.

Start the server with the following:
```
python -m visdom.server -port PORT
```
Replace PORT with a random port of your choice. Do *not* use the default port of Visdom because it is most likely already used by someone else, besides you wouldn’t want anyone else to mess up with your plots by mistake.

Once the server is started, you can connect to it in your web browser at the address: `http://ncc1.clients.dur.ac.uk:PORT`.

## Configuring your SLURM jobs

Have a look at the example SLURM batch file called `example.slurm`. This file defines how much resource to allocate to your job and how to run it. The file is divided in two parts. The first few lines starting with `#SBATCH` are interpreted by SLURM itself and used to determine how much resource to allocate to the job. The second part is a regular shell script which will be run on the compute node.

In `example.slurm`, replace the Visdom port with the port which you have chosen for you server. The training script will connect to Visdom server at this port on the head node and plot the loss function.

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

