# Workaround For Macs With Psycopg2

<iframe src="https://adaacademy.hosted.panopto.com/Panopto/Pages/Embed.aspx?id=0c9b3132-749b-471d-af77-ae60010ab1d3&autoplay=false&offerviewer=true&showtitle=true&showbrand=true&captions=true&interactivity=all" height="405" width="720" style="border: 1px solid #464646;" allowfullscreen allow="autoplay"></iframe>

On some M1 Macs with Big Sur (10.14.6) and Postgres (10.14.6) or higher installed, an error regarding `psycopg2` is thrown when attempting to install dependencies with:

```bash
pip install -r requirements.txt
```

When this occurs Pip is having trouble installing `psycopg2` a library which helps SQLAlchemy connect to Postgres. To get it to install  `psycopg2` successfully, we will need to install the `psycopg2-binary` package globally and the `openssl` library.

```bash
pip3 install psycopg2-binary --force-reinstall --no-cache-dir
```

and

```bash
brew install openssl
```

Then you can activate your virtual environment and install the dependencies with `pip3 install -r requirements.txt`.
