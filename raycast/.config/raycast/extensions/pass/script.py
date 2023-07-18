#!/usr/bin/env python3

import subprocess
import sys

from pathlib import Path

PASSWORD_STORE_PATH = Path("~/.password-store").expanduser()
PASSWORD_PATH = (PASSWORD_STORE_PATH / Path(f"{sys.argv[1]}.gpg")).resolve()


def execute_command(args, capture_output=True):
    return subprocess.run(args, check=True, text=True, capture_output=capture_output)


if PASSWORD_PATH.exists():
    try:
        password_args = [
            "--pinentry-mode",
            "loopback",
            "--passphrase",
            f"{sys.argv[2]}",
        ]
        content = execute_command(
            [
                "gpg",
                "--decrypt",
                *(password_args if sys.argv[2] else []),
                f"{PASSWORD_PATH}",
            ]
        )
        copied = execute_command(["pass", "-c", f"{sys.argv[1]}"])

        print(f"🔑 {content.stdout}")
        print(f"🤖 {copied.stdout}")
    except subprocess.CalledProcessError as e:
        print("Couldn't decrypt the file!")
else:
    execute_command(["pass"], capture_output=False)
    print(f"\nNot found: {sys.argv[1]}")
