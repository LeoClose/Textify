# How to use Textify

When using Textify as your Speech2Text solution, you have two options:
1) Parsing a wav/mp3/ogg file
2) Recording users microphone input

## Parsing a file
```GDScript
Textify.parse_file(fileLocation)
```

> [!IMPORTANT]
>**Before using, read [Setup](https://github.com/LeoClose/Textify/blob/main/docs/setup.md)**

## Recording users microphone input
### To start recording users microphone use:
```GDScript
Textify.start_recording()
```
### To stop recording users microphone and to initialize Speech2Text process use:
```GDScript
Textify.stop_recording()
```
> [!NOTE]
>**after using stop_recording() the API will start processing your file**
