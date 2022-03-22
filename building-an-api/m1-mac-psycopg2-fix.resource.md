# Workaround For Macs With Psycopg2

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
