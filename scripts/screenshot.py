from io import BytesIO, TextIOWrapper
from pathlib import Path
from time import gmtime, sleep, strftime

import pyperclip
import pyperclipimg
import pyscreenshot as ImageGrab
from plyer import notification


def take_screenshot(bbox=None):
    folder = Path(__file__).parent / "screenshots"
    file = folder / strftime("%Y-%m-%d-%H-%M-%S.png", gmtime())
    file.parent.mkdir(exist_ok=True)
    im = ImageGrab.grab(bbox=bbox)
    im.save(file)
    pyperclipimg.copy(file)
    notification.notify(
        title="screenshot",
        message="Screenshot copied to clipboard",
        app_name="screenshot.py",
    )
    # im.show()


def main():
    take_screenshot()


if __name__ == "__main__":
    main()
