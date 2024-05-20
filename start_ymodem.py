#!/usr/bin/python3

import time
import serial
import subprocess
import sys

DEFAULT_PAYLOAD = "build/r5os.elf"
PROMPT = "StarFive # "


def wait_for_prompt(tty: serial.Serial):
    line = ""
    while not line.startswith(PROMPT):
        try:
            ch = tty.read().decode("ascii")
            if ch == '\n':
                print(f"[serial] {line}", file=sys.stderr)
                line = ""
            else:
                line = line + ch
        except UnicodeDecodeError:
            pass


def send_command(tty: serial.Serial, command: bytes):
    tty.write(b"\n")
    wait_for_prompt(tty)
    tty.write(command + b"\n")
    tty.readline()


def send_file(tty_file: str, payload_name: str):
    print(f"[start_ymodem] starting sz", file=sys.stderr)
    with open(tty_file, "wb") as stdout, open(tty_file, "rb") as stdin:
            process = subprocess.run(
                ["sz", payload_name],
                stdin=stdin,
                stdout=stdout
            )
    print(f"[start_ymodem] payload status = {process.returncode}", file=sys.stderr)
    if process.returncode != 0:
        raise Exception()


def print_output(tty: serial.Serial):
    ch = '?'
    while ch != '\0':
        try:
            ch = tty.read().decode("ascii")
            print(ch, end="")
            sys.stdout.flush()
        except UnicodeDecodeError:
            pass


if __name__ == "__main__":
    if len(sys.argv) < 2:
        print(f"usage: {sys.argv[0]} <device_name> [<payload>]", file=sys.stderr)
    else:
        device_name = sys.argv[1]
        payload = sys.argv[2] if len(sys.argv) >= 3 else DEFAULT_PAYLOAD

        with serial.Serial(device_name, 115200) as tty:
            print(f"[start_ymodem] waiting for prompt...", file=sys.stderr)
            send_command(tty, b"loady")
        
        time.sleep(1)
        print(f"[start_ymodem] sending payload...", file=sys.stderr)
        send_file(device_name, payload)
        
        with serial.Serial(device_name, 115200) as tty:    
            print(f"[start_ymodem] booting...", file=sys.stderr)
            send_command(tty, b"bootelf")
            print(f"[start_ymodem] booting complete", file=sys.stderr)
            print_output(tty)
