from flask import Flask, render_template

def create_app():
    print("starting app")
    app = Flask(__name__)

    @app.route('/')
    @app.route('/index')
    def index():
        return render_template('index.html')

    @app.route('/about')
    def about():
        return render_template('about.html')

    return app
