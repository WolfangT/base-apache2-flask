# Default test app

import sys
import logging
from os import getenv
from pathlib import Path

from flask import Flask, request, render_template

INSTANCE_PATH = Path(getenv("INS_DIR")) / __name__
LOGGING_PATH = Path(getenv("LOG_DIR")) / __name__
INSTANCE_PATH.mkdir(parents=True, exist_ok=True)
LOGGING_PATH.mkdir(parents=True, exist_ok=True)

logger = logging.getLogger(__name__)


def create_app() -> Flask:
    """Configures and creates a server instance"""
    # Set up logging
    file_handler = logging.FileHandler(
        LOGGING_PATH / "access.log", mode="a", encoding="utf-8"
    )
    file_handler.setLevel(logging.DEBUG)
    console_handler = logging.StreamHandler(sys.stdout)
    console_handler.setLevel(logging.DEBUG)
    logger.addHandler(file_handler)
    logger.addHandler(console_handler)
    logger.setLevel(logging.DEBUG)

    logger.info("Starting default server")
    app = Flask(__name__, instance_path=str(INSTANCE_PATH))

    @app.route("/")
    @app.route("/index")
    def index():
        logger.info("Access from %s", request.remote_addr)
        return render_template("index.html")

    @app.route("/about")
    def about():
        return render_template("about.html")

    return app
