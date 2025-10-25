import datetime
from datetime import timezone

timestamp_utc = datetime.datetime.now(timezone.utc).isoformat() + "Z"
