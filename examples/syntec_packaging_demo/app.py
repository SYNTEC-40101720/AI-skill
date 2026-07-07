from datetime import datetime
from pathlib import Path
import sys


def main():
    app_dir = Path(sys.executable).resolve().parent if getattr(sys, "frozen", False) else Path(__file__).resolve().parent
    marker = app_dir / "SYNTEC-demo-opened.txt"
    marker.write_text(
        f"SYNTEC demo opened at {datetime.now().isoformat(timespec='seconds')}\n",
        encoding="utf-8",
    )


if __name__ == "__main__":
    main()