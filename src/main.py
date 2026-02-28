import sys
from PySide6 import QtWidgets
from src.MainWindow import MainWindow
from src.get_mutex import GetMutex

# Slå GUI-only til her. Sæt til False når du vil aktivere enheder igen.
GUI_ONLY = True


def main():
    # (valgfrit) undgå flere instanser
    mutex = GetMutex()
    if (app := mutex).IsRunning():
        print("Application is already running")
        sys.exit()

    app = QtWidgets.QApplication(sys.argv)

    # Videregiv GUI-only flag til MainWindow
    window = MainWindow(app, gui_only=GUI_ONLY)
    window.show()

    app.exec()


if __name__ == "__main__":
    main()