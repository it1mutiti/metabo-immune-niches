#!/usr/bin/env python3
import os, json, argparse, datetime, hashlib

def compute_checksum(file_path):
    h = hashlib.sha256()
    with open(file_path, "rb") as f:
        for chunk in iter(lambda: f.read(8192), b""):
            h.update(chunk)
    return h.hexdigest()

def main():
    parser = argparse.ArgumentParser(description="Generate metadata.json for a dataset folder.")
    parser.add_argument("--dataset", required=True, help="Path to dataset folder")
    parser.add_argument("--cancer", required=True)
    parser.add_argument("--accession", required=True)
    parser.add_argument("--patient-id", required=True)
    parser.add_argument("--resolution-um", required=True, type=int)
    args = parser.parse_args()

    ds_path = os.path.abspath(args.dataset)
    if not os.path.isdir(ds_path):
        print(f"[ERROR] Dataset not found: {ds_path}")
        return

    checksum_file = None
    manifest = os.path.join(ds_path, "MANIFEST.sha256")
    if os.path.exists(manifest):
        checksum_file = compute_checksum(manifest)

    metadata = {
        "cancer": args.cancer,
        "platform": "10x Visium FFPE",
        "accession": args.accession,
        "patient_id": args.patient_id,
        "resolution_um": args.resolution_um,
        "checksum": checksum_file,
        "date_imported": datetime.datetime.now().strftime("%Y-%m-%d"),
    }

    with open(os.path.join(ds_path, "metadata.json"), "w") as f:
        json.dump(metadata, f, indent=2)
    print(f"[OK] metadata.json created for {ds_path}")

if __name__ == "__main__":
    main()
