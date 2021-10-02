# Wave_generator

Welcome to my first terminal application, the wave_generator. The Kanban board which assisted this application can be found here: https://trello.com/b/z7IDcCcU/terminal

The an outline of the application's control flow is represented by a flow-chart which can be viewed here:

https://lucid.app/lucidchart/b5c4a8e2-701d-41ff-9833-6f1107bb4737/edit?viewport_loc=-31%2C176%2C2265%2C1140%2C0_0&invitationId=inv_6bb795a9-44a4-407b-a714-0116450094d0


# Software development plan

The idea of this application is to be a simple introduction to sound design and synthesis. It provides users with a very simple way to create and listen to their own music. By being limited in its depth of functionality, it allows for a straight-forward experience which happens very quickly, and gives immediate output to the user.

This application allows a user to enter a note, or series of notes that they choose, and generates the corresponding sine waves which are outputted as a .wav file that the user can listen to, or use however they choose. Users can create their own chords, melodies and basslines.

This application provides a means for a user to create their own music despite lack of musical ability, equipment or ideas. This application is ideal for people who do not desire to learn how to use a complex DAW, and instead, want to create their own easy, predictable music instantly.  

It is intended to be used by primarily game-developers to get quick sounds for a game, musicians, who want to listen to how a chord or note sounds and may be limited in their musical ability or experience, and anyone in general who would like to make their own songs or sounds in the form of a wav file. It may also be used by people who are interested in using ruby for audio programming. They are free to look at the source code and see exactly which steps are being taken to produce the sounds.

This application may be used by anyone who has installed ruby. They need only to download the .zip folder from github, install the dependencies, navigate to the correct directory in their terminal and run the command ruby wave_generator. Files created by the user are saved in the ‘files’ folder, which is in the working directory.

# Features

## Generate a note

The user may choose to generate a specific note, which will be converted into a floating point number that represents the frequency which corresponds to that specific note. This application follows the standard frequency values of equal temperament tuning e.g, the note ‘a’ is represented by a frequency value of 440hz. This application, however, may be easily altered to follow any possibility of tunings. Though, for the purposes of this assignment, I chose to use equal temperament, as that is the tuning with which I am most familiar. The user will then enter a desired duration for that note in seconds. For example, 0.5, or half of one second. 
A sine wave is generated in the following way: the frequency, sample rate and amplitude values are created, either by the user, in the case of frequencies, or as hard-coded values to be used and re-used throughout the program, the period of a sine wave is calculated by its frequency which is a Hertz value, and since a sine wave completes a 360 degree revolution for each period, we can calculate the range of angles of the sine wave during each period. These angles are represented as an array of amplitude values or ‘samples’.
The array of samples is then given to the ‘wavefile’ gem which writes them into a buffer and exports them as the relevant .wav file.

## Generate a chord
The chord function uses the same procedure, except to a greater extent. The user is prompted to enter a series of notes and durations which are all converted into their own separate array of samples. The indexes of all arrays are then added together and divided by the number of arrays, to represent the final array, which will be 4 sine waves layered on top of one another. The polyphony number of the chord feature is hardcoded at 4, and for the fourth note, the frequency is doubled, which results in the note being in a higher register to the others. This prevents chords from sounding overly muddy.

## Generate a melody

The melody function, again follows the same steps, except the user may enter up to 50 notes each with a duration of up to 50 seconds. The notes are converted into their corresponding arrays and the arrays are appended in order. This will result in the individual voices being played one after the other, which is also technically considered a melody.

## Generate a bassline

The bassline function, follows the same procedure as the melody, except the user may choose to add clipping distortion to their final .wav file, this is achieved by raising the amplitude value of the note above their maximum thresholds, which results in the notes being cut off at their peaks, at which point they are more representative of a square wave than a sine wave. All the frequencies of the bassline function are lowered by two octaves or, halved, then halved again.

All functions handle all types of input errors I could think of when creating the app, the numbers of notes and durations are all capped, and the user is prompted and re-prompted when they give incorrect input.

# User Interaction outline

When the user runs the application, they are brought to a menu which they can select which feature they would like to use, or select ‘help’ which contains a more detailed explanation of the usage of each feature. The user can also choose to run a specific feature by given that feature’s name as a command line argument, for example, 
>$ ruby wave_generator chord

brings the user directly to the chord feature and bypasses the menu.

Each feature handles input errors as follows: the user is prompted for input, the user gives incorrect input, the user is shown a message indicating correct usage and is prompted for input again. This cycle repeats until the user gives correct input.

# Installation, and dependencies

This application is written in ruby and requires it to run: https://rubyinstaller.org/

This application uses the following gems:
- ‘tty-promt’ https://rubygems.org/gems/tty-prompt/versions/0.23.1
- ‘wavefile’ https://rubygems.org/gems/wavefile/versions/1.1.1
- ‘rainbow’ https://rubygems.org/gems/rainbow
- ‘tty-spinner’ https://rubygems.org/gems/tty-spinner

These gems will need to be installed in order for this application to run correctly. The user must also download a copy of the application from it’s git repository:
https://github.com/jordanfox1/Wave_generator
change into its working directory and run ruby wave_generator

# Usage

In order to use this application, from the applcation's working directory, run the command:
>$ bash wave_generator.sh

This will run a script which installs bundler, and then installs all of the dependencies, then runs the application. After that you can run the application with the command:
>$ ruby wave_generator.rb

or, alternitavely, install the dependencies manually and the above command or the following:

> ruby application/main.rb

This application's gem dependency 'tty-prompt' is known to have issues when used on windows systems. I encountered this issue when testing the app also. If the tty-prompt menu is not working, you can bypass it completely by passing the feature you wish to access as a command line argument E.G

> ruby application/main.rb chord

to create a chord.


# Tests

The tests included in this application are written with test-unit and test the following methods which are essential:
* Get_note_durations_test - this tests that method runs correctly when the user gives an input of 30, (which indicates that it runs correctly when given any valid input) the test fails if the method returns the incorrect value.
* Get_note_num_test - this tests the feature that determines the number of notes given by the user. It does this in a similar way as above, If the method returns a number other than that specified in the test, it will not pass
* Get_notes_test - this tests whether a note will be converted into the correct frequency, and uses a test input of ‘a’ and 440.0 hz which is the frequency value of an ‘a’ note.

# References

http://topherlee.com/software/pcm-tut-sine.html

https://pages.mtu.edu/~suits/notefreqs.html
