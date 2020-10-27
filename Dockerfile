# ---- Build ----
FROM python:3.9.0-alpine3.12  AS build
RUN apk add git
WORKDIR /app
COPY . /app
RUN python setup.py sdist

# --- Release ----
FROM alpine:3.12 AS release
RUN apk add python3-dev postgresql-dev py3-pip gcc musl-dev
COPY --from=build /app/dist ./tmp/dist
RUN pip3 install /tmp/dist/*.tar.gz
