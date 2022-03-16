# Waveform Cross-Correlation 

1. Edit `parameter.m` file
2. Run `waveform_cc.m`



#### Input

* A directory with sac files. 

Structure: directoryName/StationName/sacfiles [Similar to `example` directory]

* Sac files

`Filename`: EVENTID.NETWORK.STATION.CHANNEL.sac

`StartTime`: Event Origin time

`EndTime`: 60-90 seconds or more depending on the event. 

`Header`: Should include P and S picks



#### Output

hypoDD.cc : File ready for hypoDD

growclust.cc: File ready for GrowClust





A version of this code was used in 

Mesimeri, M., Pankow, K. L., Baker, B., & Hale, J. M. (2021). Episodic earthquake swarms in the Mineral Mountains, Utah driven by the Roosevelt hydrothermal system. *Journal of Geophysical Research: Solid Earth*, 1–15. https://doi.org/10.1029/2021jb021659



Written in Matlab

Author: Maria Mesimeri