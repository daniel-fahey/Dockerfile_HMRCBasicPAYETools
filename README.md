# HMRC Basic PAYE Tools in a docker container

**I am not affiliated to HMRC in any way. I have not developed this software. This is completely
unofficial.**

**I am not qualified to give tax advice. You are responsible for all your financial affairs.**

**You are responsible for persisting your data.**

## TL;DR
```
$ podman run --init --replace --name paye -p 46729:46729 -v persist:/home/paye_user/HMRC knowthydata/payetools-rti
0 inaccessible rows before starting
0 SubmissionDirtyData models to inspect
0 of 0 stale submissions for 2018 and earlier
0 EmployerPCD to inspect
0 inaccessible rows after employer delete
0 EmployerPCD to remain
No systemtrayicon available
Validating models...

0 errors found
May 08, 2024 - 16:17:14
Django version 1.6, using settings 'mysite.settings'
Starting development server at http://127.0.0.1:46729/
Quit the server with CONTROL-C.
# to quit (in another terminal):
$ podman stop paye
```
Will run an ephemeral container that saves all data to the `persist` directly where you run the above command on your host system.
If you start the container again with that command it will read the previously saved data from that directory.

## About
HMRC is the UK government's tax office. They provide software for reporting PAYE (Pay As You Earn)
employee income tax. All I've done is packaged it up in a docker container for easy use. HMRC provide
builds for Windows, Mac and Linux so you might prefer to just install directly on your system, see
[their instructions](https://www.gov.uk/basic-paye-tools) for instructions.

The Basic PAYE Tools are pretty basic, make sure this is what you want before using it. There are
plenty of other software packages you can use (free and paid). There is a link from the tools'
homepage (above) to other options.

## Persisting your data

The container runs as the user `paye_user`, and saves data into the home directory of that user. This
means all data go will be saved in `/home/paye_user/HMRC`. It is a good idea to mount this to a host
directory or a docker volume so that your data will persist across containers. The software also has
import and export functions which you can use.
