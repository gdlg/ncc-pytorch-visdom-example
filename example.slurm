#!/bin/bash
#SBATCH -N 1 # Request a single node
#SBATCH -c 4 # Request four CPU cores
#SBATCH --gres=gpu # Request one gpu
#SBATCH -p res-gpu-small # Use the res-gpu-small partition
#SBATCH --qos=short # Use the short QOS
#SBATCH -t 1-0 # Set maximum walltime to 1 day
#SBATCH --job-name=example # Name of the job
#SBATCH --mem=4G # Request 4Gb of memory

# Load the global bash profile
source /etc/profile

# Load your Python environment
source env/bin/activate

# Run the code
# -u means unbuffered stdio
# Connect to the visdom server on ncc1
# Replace PORT with the actual port of the Visdom server.
python -u main.py --visdom_server http://ncc1.clients.dur.ac.uk --visdom_port PORT

