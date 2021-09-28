require_relative "menu.rb"

def note_help
    puts Rainbow("-Wave generator creates a .wav file of a user-determined note, chord or melody.
-For a note, you will be prompted to enter a filename, note and duration.
-The note you have chosen will be saved in the working directory, and you can then open and play it.").green
end

def chord_help
    puts Rainbow("-Wave generator creates a .wav file of a user-determined note, chord or melody.
-For a chord, you will be prompted to enter a filename, and a number of desired notes for your chord (maximum of 5).
-For each note, you will enter the note name E.G entering c, e, g, b will result in a c major 7 chord.
-The chord you have created will be saved in the working directory, and you can then open and play it.").green
end

def melody_help
    puts Rainbow("-Wave generator creates a .wav file of a user-determined note, chord or melody.
-For a melody, you will be prompted to enter a filename, and a number of desired notes for your melody (maximum of 50).
-For each note, you will be prompted to enter the note name and duration.
-The melody you have created will be saved in the working directory, and you can then open and play it.").green
end