import sys
from io import BytesIO, TextIOWrapper
from pathlib import Path
from time import gmtime, sleep, strftime

import pyperclip
import pyperclipimg
import pyscreenshot as ImageGrab
from plyer import notification
from PyQt5 import QtCore, QtGui, QtWidgets

from screenshot import take_screenshot


class ScreenshotSelector(QtWidgets.QWidget):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("Select Area for Screenshot")
        self.setWindowFlags(
            QtCore.Qt.WindowStaysOnTopHint
            | QtCore.Qt.FramelessWindowHint
            | QtCore.Qt.Tool
        )
        self.setWindowOpacity(0.3)
        self.setAttribute(QtCore.Qt.WA_TranslucentBackground)
        self.screen_rect = QtWidgets.QApplication.screens()[0].geometry()
        print(QtWidgets.QApplication.screens())

        self.start_point = None
        self.end_point = None
        self.is_selecting = False

        print(self.screen_rect)
        # self.setGeometry(self.screen_rect)
        self.setGeometry(QtCore.QRect(0, 0, 10000, 10000))
        self.show()

        notification.notify(
            title="screenshot select",
            message="Select area for screenshot",
            app_name="screenshot-select.py",
        )

    def paintEvent(self, event):
        if self.start_point and self.end_point:
            painter = QtGui.QPainter(self)
            painter.setPen(QtGui.QPen(QtCore.Qt.red, 2))
            rect = QtCore.QRect(self.start_point, self.end_point)
            painter.drawRect(rect.normalized())

    def mousePressEvent(self, event):
        if event.button() == QtCore.Qt.LeftButton:
            self.start_point = event.pos()
            self.end_point = self.start_point
            self.is_selecting = True
            self.update()

    def mouseMoveEvent(self, event):
        if self.is_selecting:
            self.end_point = event.pos()
            self.update()

    def mouseReleaseEvent(self, event):
        if not event.button() == QtCore.Qt.LeftButton:
            return
        self.end_point = event.pos()
        self.is_selecting = False
        self.close()
        print(self.start_point, self.end_point)
        self.take_screenshot()

    def take_screenshot(self):
        gap = 50
        take_screenshot(
            bbox=(
                self.start_point.x(),
                self.start_point.y() + gap,
                self.end_point.x(),
                self.end_point.y() + gap,
            )
        )
        sys.exit(0)


if __name__ == "__main__":
    app = QtWidgets.QApplication(sys.argv)
    selector = ScreenshotSelector()
    sys.exit(app.exec_())
