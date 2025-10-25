#!/usr/bin/env python3
import os, json, hashlib, time
def walk_hash(root):
    out=[]
    for r,_,files in os.walk(root):
        for f in files:
            p=os.path.join(r,f)
            h=hashlib.sha256(open(p,'rb').read()).hexdigest()
            out.append({"file": p, "sha256": h, "size_bytes": os.path.getsize(p)})
    return out
os.makedirs("manifests", exist_ok=True)
manifest = {
  "generated_utc": time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime()),
  "base": os.getcwd(),
  "raw": walk_hash("data/raw") if os.path.isdir("data/raw") else [],
  "external": walk_hash("data/external") if os.path.isdir("data/external") else []
}
with open("manifests/data_manifest.json","w") as fh:
  json.dump(manifest, fh, indent=2)
print("OK :: manifests/data_manifest.json (raw:", len(manifest["raw"]), "external:", len(manifest["external"]), ")")
