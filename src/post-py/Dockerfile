FROM python:3.6.0-alpine

WORKDIR /app

ENV POST_DATABASE_HOST=post_db \
    POST_DATABASE=posts

COPY helpers.py \
     post_app.py \
     requirements.txt \
     ./

RUN pip install -r /app/requirements.txt

ENTRYPOINT ["python3", "post_app.py"]
