#!/bin/bash

input_len_values=(64 256 1024 2048)
max_new_tokens_values=(1 64 256 1024 2048)
export ENABLE_INTRA_NODE_COMM=1
export MODEL_REPO=mistralai/Mixtral-8x7B-v0.1
torch_cmd="torchrun --standalone --nproc_per_node=8 generate.py --compile --compile_prefill --checkpoint_path checkpoints/$MODEL_REPO/model.pth"


# Loop over each combination of values
for input_len in "${input_len_values[@]}"; do
    for max_new_tokens in "${max_new_tokens_values[@]}"; do
        # Run the command with current values
        arg_cmd="--input-len ${input_len} --max_new_tokens ${max_new_tokens}"
        full_cmd="$torch_cmd $arg_cmd"
        echo "cmd = $full_cmd"
        eval "$full_cmd"

    done
done
