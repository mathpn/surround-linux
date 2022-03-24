# Surround Linux
This is a collection of simple scripts that automate the process of configuring
virtual surround sound on linux distros using pulseaudio.

## What is virtual surround?
Many modern audio sources provide 5.1 or even more audio channels. If you're
using headphones, all this spatial information is lost when squeezing the audio
into two channels. However, it is possible to emulate the spatial perception of
sound position using some [fancy tricks](https://en.wikipedia.org/wiki/Virtual_surround).

In this case, we're using head-related impulse responses (HRIR) derived from
[head-related transfer functions (HRTF)](https://en.wikipedia.org/wiki/Head-related_transfer_function).

HRIR files are publicly available thanks to [Salscheider](https://github.com/olesalscheider),
who used two also publicly available databases ([here](https://sound.media.mit.edu/resources/KEMAR.html)
and [here](http://recherche.ircam.fr/equipes/salles/listen/)) to generate those files.

These scripts were inspired by a very good [how to](https://forum.endeavouros.com/t/howto-setting-up-virtual-surround-sound-for-headphones/6889) written by jonathon.

## Usage
### Downloading
Please run download.sh to download necessary data:
    bash download.sh

This will create a data folder in you current directory. **If you just want a very
simple way**: please continue to read after *setting up*, I promise it's easy.

Inside it, there are two folders.
In data/hrir_listen/demos you will find many .ogg audio files containing demo audios
of many different HRTF measured from different real people.

If you want the **best possible** experience, listen patiently and choose which one
yields the best spatial perception and note the **four-digit number** at the end
of the file name.

### Setting up
Now, run the run.sh script:
    bash run.sh

Follow the instructions on the screen. If you choose the easy path, type 0 when
asked for the audio number. You'll have to logout and login again before changes
take effect.

You may use pavucontrol or (if you're running a GNOME environment) the [Sound 
Input & Output Device Chooser](https://extensions.gnome.org/extension/906/sound-output-device-chooser/) 
GNOME extension to easily switch between output devices.

**Use VirtualSurround as output when listening to surround content**, e.g.,
movies and video-games. Using VirtualSurround on stereo content may distort
the audio a bit.

### Fix
On some linux distros you won't see VirtualSurround as a sound output just yet.
You'll have to run fix.sh as root:
    sudo bash fix.sh

This will add your current user as part of the audio group, which should fix
things up.

Enjoy!
