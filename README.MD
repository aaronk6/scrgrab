# SCRGRAB

Utility for Windows 3.x that is expected to be called via Windows httpd cgi-win.

It will take a screenshot, write it to `C:\HTTPD\HTDOCS\SCRGRAB.BMP` (hard-coded), and return

## Usage

The following assumes you have *Windows httpd* correctly set up.

* Rename `PROJECT1.EXE` to `SCRGRAB.EXE`.
* Put `SCRGRAB.EXE` in `C:\HTTPD\HTDOCS\CGI-WIN`.

**You can now call http://example.com/cgi-win/scrgrab.exe to get a screenshot from your Windows box.** 

Note that example.com is a placeholder for the hostname or IP address of your web server.

(**TODO:** Rename files in the repository, so the resulting EXE file is already called `SCRGRAB.EXE`.)

## Arguments

Arguments according to cgi-win specification:

```
scrgrab.exe PROFILE INPUT_FILE OUTPUT_FILE
```

## Output

The following HTTP response will be written to `OUTPUT_FILE` where the webserver will pick it up and send it to the client. This will redirect the client to the freshly generated screenshot.

```
HTTP/1.0 302 Found
Location: /scrgrab.bmp
```

(**TODO:** Avoid redirect and directly write full HTTP response (including body) to OUTPUT_FILE.)

