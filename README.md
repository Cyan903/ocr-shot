# ocr-shot

![code-size](https://img.shields.io/github/languages/code-size/cyan903/ocr-shot) ![last-commit](https://img.shields.io/github/last-commit/cyan903/ocr-shot) ![license](https://img.shields.io/github/license/cyan903/ocr-shot)

A containerized wrapper for [manga_ocr](https://github.com/kha-white/manga-ocr) with an HTTP server that processes screenshots and extracts text. Includes a shell script that enables screenshots to be uploaded without saving the image to disk.

## Usage

Any POST request to `/` with a file in the form will work. `client.sh` contains a script which will take a screenshot and make the request without storing the file on the disk.

```sh
$ curl --request POST \
  --url $API_URL \
  --header 'Content-Type: multipart/form-data' \
  --header 'User-Agent: insomnium/0.2.3-a' \
  --form file=@/path/to/image.png

# With the client script
$ ./src/client.sh
```

## Installation

```sh
$ cp .env.example .env
$ vi .env
$ docker compose up
```

## License

[MIT](MIT)
