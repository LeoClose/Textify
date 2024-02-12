# How to use Textify

When using Textify as your Speech2Text solution, you have two options:
1) Parsing a wav/mp3/ogg file
2) Recording users microphone input

## Connecting signals
Textify has two signals:
1) loading
2) received

### Loading signal
Loading signal returns waiting time for the API to load
```GDScript
Textify.connect("loading", apiLoading) # Returns waiting time
func apiLoading(time):
  pass
```
> [!NOTE]
>**if the API is loading while trying to process your audio, the plugin will make another request every 5s until it is loaded by default (feel free to change anything as you will)**
### Received signal
Received signal returns the text of speech recognized in your mp3/ogg/wav file
```GDScript
Textify.connect("received", receivedText) # Returns parsed text
func receivedText(text):
  pass
```

## Parsing a file
```GDScript
Textify.parse_file(fileLocation)
```



## Recording users microphone input
> [!IMPORTANT]
>**Before using, read [Setup](https://github.com/LeoClose/Textify/blob/main/docs/setup.md)**
### To start recording users microphone use:
```GDScript
Textify.start_recording()
```
### To stop recording users microphone:
```GDScript
Textify.stop_recording()
```
> [!NOTE]
>**after using stop_recording() the API will start processing your file, and when it finishes *received* signal will be emitted, but if the API hasn't loaded yet *loading* signal will be emitted**
