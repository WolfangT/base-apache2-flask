#! /usr/bin/env python3

import sys
sys.path.append("/var/www/default")

from app import create_app
application = create_app()
