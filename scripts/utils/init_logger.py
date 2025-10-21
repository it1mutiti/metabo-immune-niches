#!/usr/bin/env python3
import logging, os, datetime, subprocess, hashlib

def init_logger(name="pipeline", log_dir="results/logs"):
    os.makedirs(log_dir, exist_ok=True)
    timestamp = datetime.datetime.now().strftime("%Y%m%d_%H%M%S")
    log_path = os.path.join(log_dir, f"{name}_{timestamp}.log")

    logging.basicConfig(
        filename=log_path,
        level=logging.INFO,
        format="%(asctime)s | %(levelname)s | %(name)s | %(message)s",
        datefmt="%Y-%m-%d %H:%M:%S",
    )

    log = logging.getLogger(name)
    try:
        commit = subprocess.getoutput("git rev-parse --short HEAD")
        env_hash = hashlib.sha256(
            open("environment/conda.lock", "rb").read()
        ).hexdigest()[:10]
        log.info(f"Git commit: {commit}")
        log.info(f"Environment digest: {env_hash}")
    except Exception as e:
        log.warning(f"Metadata logging skipped: {e}")
    return log
