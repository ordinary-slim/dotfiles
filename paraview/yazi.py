import os
import subprocess
import tempfile

from paraview.simple import OpenDataFile, Show, Render

def open_with_yazi():
    fd, chooser_file = tempfile.mkstemp(prefix="paraview-yazi-")
    os.close(fd)

    try:
        subprocess.run(
            [
                "ghostty",
                "-e",
                "yazi",
                "--chooser-file=" + chooser_file,
            ],
            check=False,
        )

        # Yazi was closed/cancelled without selecting anything.
        if not os.path.exists(chooser_file):
            return

        with open(chooser_file, "r") as f:
            paths = [
                line.strip()
                for line in f
                if line.strip()
            ]

        # Normal cancellation: just return to ParaView.
        if not paths:
            return

        filename = paths[0] if len(paths) == 1 else paths

        reader = OpenDataFile(filename)

        if reader is not None:
            Show(reader)
            Render()

    finally:
        try:
            os.unlink(chooser_file)
        except OSError:
            pass

open_with_yazi()
