# Wave_generator
This application relies on the gems 'wavefile' and contains an editted version of a program named 'nanosynth'. This application is for eductaional purposes only, and due credit should be given to the creator of these helpful programs.
The formulas for creating waveforms are from 'nanosynth'. and the formulas for writing audio into a wavfile format is from 'wavefile'.

if count >= 6
    samples = [voice_1, voice_2, voice_3, voice_4, voice_5, voice_6, voice_7].transpose.map {|x| x.reduce(:+)}


    samples