@echo off
CLS
ECHO.
ECHO This installation will take a few minutes - please be patient.
ECHO.
SET PATH=%PATH%;C:\Program Files\Docker\Docker\resources\bin\
docker load -i C:\Windows\System32\speechmatics.tar
ECHO.
ECHO Adding license info...
ECHO.
docker run -it -d --name speechmatics --restart always -p 9000:9000 -e LICENSE_TOKEN=eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJmZWF0dXJlcyI6WyJNQVBSVCIsIkFQUiIsIkFTUyIsIkxBTlkiXSwiY29udHJhY3RpZCI6IjM4NiIsImlzX3RyaWFsIjpmYWxzZSwiZXhwIjoxNjk2NDY0MDAwLCJqdGkiOiI2NzA2ZDQzNTIzNzI0ODRiYWIwZDMxYjEzZjlkNWU3NyIsImlhdCI6MTYwMjc3NzYzNSwiaXNzIjoiU3BlZWNobWF0aWNzIiwibmJmIjoxNjAxODU2MDAwLCJzdWIiOiJVUyBBcm15In0.HVcHmOSVe7Ey9WtxYwwzz08MThvPzDUYc_9GxRupItELeuL_YB6L0TmF69nT8nO9En5X1nITq4YjjY40ZX8VbD3HJouW4CxBQTAyRDakyoVZj82p-As0zKI7e-3-9bw-t-GFt7-B8jBkAwkSz71nn5c-GjhSz-IbneNlQ34Bp2-reqiT91RCVqtQNfTeAPMaHCP9XNXntL8tq36bXYgsCJhAsfoSDqWkK2BwD8RG0nMdEpfiNu0cjIh4JY8xuctHE6xYwd1NWEpxxfPzZ69PnfpQ49Jk2_uRdloz0QyNxMer4o6gsAnhe_acDeMUs_EDQM4X3Z_qIxs2Dnw2MCpGSQ speechmatics-docker-public.jfrog.io/rt-asr-transcriber-en:1.0.0
ECHO.
ECHO Exiting...
ECHO.
exit