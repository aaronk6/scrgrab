# SCRGRAB.EXE

**Utility for Windows 3.x that will take a screenshot and exit (no UI) – for use in conjunction with Windows httpd.**

`scrgrab.exe` is expected to be called via *cgi-win*. It will take a screenshot in BMP format and will prepare the HTTP response to be picked up and returned to the client by the webserver.

You can see it live in action on **[win311.aaron.cc](https://win311.aaron.cc)** (or scroll down to the bottom of this page).

## Usage

The following assumes you have *Windows httpd* set up correctly (it must reside in `C:\httpd`!).

* Get `PROJECT1.EXE` from this repository and rename it to `SCRGRAB.EXE`.
* Put `SCRGRAB.EXE` in `C:\HTTPD\HTDOCS\CGI-WIN`.

**You can now call http://example.com/cgi-win/scrgrab.exe to get a screenshot from your Windows box.** 

Note that example.com is a placeholder for the hostname or IP address of your web server.

(**TODO:** Rename files in the repository, so the resulting EXE file is already called `SCRGRAB.EXE`.)

## Arguments

Arguments according to *cgi-win* specification:

```
scrgrab.exe PROFILE INPUT_FILE OUTPUT_FILE
```

This is just FYI—when called via cgi-win, Windows httpd will provide these arguments automatically.

## Output

The following HTTP response will be written to `OUTPUT_FILE` where Windows httpd will pick it up and return it to the client.

```
HTTP/1.0 200 OK
Content-Type: image/bmp

[BINARY_DATA]
```

## Caveats

This tool is not designed to handle multiple requests at the same time. It is assumed that a reverse proxy ensures that `/cgi-win/scrgrab.exe` isn’t called simulationous and delivers cached responses while another request is in progress.

<a href="https://github.com/aaronk6/win311-uberspace-ansible/blob/master/roles/nginx/templates/proxy.conf">You can find my NGINX configuration here</a>. The relevant lines are:

```
proxy_cache_lock on;
proxy_cache_key $uri;
proxy_cache_use_stale updating;
```

## Screenshot

This screenshot was actually generated by `scrgrab.exe`—just now!

<img src="https://win311.aaron.cc/cgi-win/scrgrab.exe" width="640" height="480" alt="">

