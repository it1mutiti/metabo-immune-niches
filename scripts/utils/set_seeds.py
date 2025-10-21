#!/usr/bin/env python3
import random, numpy as np
try:
    import torch
except ImportError:
    torch = None

def set_all_seeds(seed=42):
    random.seed(seed)
    np.random.seed(seed)
    if torch:
        torch.manual_seed(seed)
        torch.cuda.manual_seed_all(seed)
        torch.backends.cudnn.deterministic = True
        torch.backends.cudnn.benchmark = False
    print(f"[seed] Global random seed set to {seed}")
