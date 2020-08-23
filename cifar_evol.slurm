#!/bin/sh
#SBATCH --partition=GPUQ
#SBATCH --account=share-ie-idi
#SBATCH --time=80:00:00
#SBATCH --nodes=2
#SBATCH --ntasks-per-node=2
#SBATCH --gres=gpu:1
#SBATCH --job-name="cifar_evol_bim"
#SBATCH --output=out/v2/cifar_evol_bim.out
#SBATCH --mail-user=jinzh@ntnu.no
#SBATCH --mail-type=ALL
cd ${SLURM_SUBMIT_DIR}
echo "we are running from this directory: $SLURM_SUBMIT_DIR"
echo " the name of the job is: $SLURM_JOB_NAME"
echo "Th job ID is $SLURM_JOB_ID"
echo "The job was run on these nodes: $SLURM_JOB_NODELIST"
echo "Number of nodes: $SLURM_JOB_NUM_NODES"
echo "We are using $SLURM_CPUS_ON_NODE cores"
echo "We are using $SLURM_CPUS_ON_NODE cores per node"
echo "We are using $SLURM_GPUS_ON_NODE GPUs per node"
echo "Total of $SLURM_NTASKS cores"

echo "CUDA_VISILE DEVICES: $CUDA_VISIBLE_DEVICES"

# Load required modules

module purge
module load GCC/8.3.0
module load CUDA/10.1.243
module load OpenMPI/3.1.4
echo "loading python"
module load Python/3.7.4
echo "loading tensorflow"
module load TensorFlow/1.15.0-Python-3.7.4


# Create environment if it doesn't exist
if [ ! -d "gpu_env" ]; then
  python3 -m venv gpu_env
fi

# Activate enviroment 
source gpu_env/bin/activate

#start running the program
cd adversarial-robustness-toolbox
echo "start running the program"
python cifar_evol_v1.py
deactivate

# Print information about the system
uname -a
