#!/usr/bin/env python3

# whatthecommit.com
# https://github.com/ngerakines/commitment

# CLI implementation

import os
import random
import re

default_names = [
    "Ali",
    "Andy",
    "April",
    "Brannon",
    "Chris",
    "Cord",
    "Dan",
    "Darren",
    "David",
    "Edy",
    "Ethan",
    "Fanny",
    "Gabe",
    "Ganesh",
    "Greg",
    "Guillaume",
    "James",
    "Jason",
    "Jay",
    "Jen",
    "John",
    "Kelan",
    "Kim",
    "Lauren",
    "Marcus",
    "Matt",
    "Matthias",
    "Mattie",
    "Mike",
    "Nate",
    "Nick",
    "Pasha",
    "Patrick",
    "Paul",
    "Preston",
    "Qi",
    "Rachel",
    "Rainer",
    "Randal",
    "Ryan",
    "Sarah",
    "Stephen",
    "Steve",
    "Steven",
    "Sunakshi",
    "Todd",
    "Tom",
    "Tony",
]


def fill_line(message: str, names: list[str]) -> str:
    message = message.replace("XNAMEX", random.choice(names))
    message = message.replace("XUPPERNAMEX", random.choice(names).upper())
    message = message.replace("XLOWERNAMEX", random.choice(names).lower())

    # Replace XNUM variants with random numbers
    #   XNUM5,10X   start and end
    #   XNUM,10X    only end
    #   XNUM5,X     only start
    #   XNUM10X     just end
    #   XNUMX       no numbers, default range
    def num_repl(match):
        value = match.group(1)
        if "," in value:
            parts = value.split(",")
            start = int(parts[0]) if parts[0] else 1
            end = int(parts[1]) if parts[1] else 999
        elif value:
            start, end = 1, int(value)
        else:
            start, end = 1, 999
        if start > end:
            end = start * 2
        return str(random.randint(start, end))

    return re.sub(r"XNUM([0-9,]*)X", num_repl, message)


def get_files():
    import urllib.request

    base_dir = os.path.join(os.path.dirname(os.path.realpath(__file__)), "commitment")
    files = [
        (
            "https://raw.githubusercontent.com/ngerakines/commitment/refs/heads/main/commit_messages.txt",
            os.path.join(base_dir, "commit_messages.txt"),
        ),
        (
            "https://raw.githubusercontent.com/ngerakines/commitment/refs/heads/main/LICENSE",
            os.path.join(base_dir, "LICENSE"),
        ),
    ]

    success = True
    for url, dest in files:
        try:
            urllib.request.urlretrieve(url, dest)
        except Exception as e:
            print(f"Failed to download {url}: {e}")
            success = False
    return success


def main():
    messages_file = os.path.join(
        os.path.dirname(os.path.realpath(__file__)), "commitment/commit_messages.txt"
    )

    dir_name = os.path.dirname(messages_file)
    if not os.path.exists(dir_name):
        try:
            os.makedirs(dir_name)
        except Exception as e:
            print(f"Failed to create directory: {e}")
            return

    if not os.path.exists(messages_file):
        if not get_files():
            print("Could not retrieve commit messages. Exiting.")
            return

    try:
        with open(messages_file, encoding="utf-8") as f:
            messages = [line.strip() for line in f if line.strip()]
        print(fill_line(random.choice(messages), default_names))
    except Exception as e:
        print(f"Failed to read commit messages: {e}")


if __name__ == "__main__":
    main()
