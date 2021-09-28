require "rainbow"

class Help

    def note_help
        puts Rainbow("-Wave generator creates a .wav file of a user-determined note, chord or melody.\n-For a note, you will be prompted to enter a filename, note and duration.\n-The note you have chosen will be saved in the working directory, and you can then open and play it.").green
    end

    def chord_help
        puts Rainbow("-Wave generator creates a .wav file of a user-determined note, chord or melody.\n-For a chord, you will be prompted to enter a filename, and a number of desired notes for your chord (maximum of 5).\n-For each note, you will enter the note name E.G entering c, e, g, b will result in a c major 7 chord.\n-The chord you have created will be saved in the working directory, and you can then open and play it.").green
    end

    def melody_help
        puts Rainbow("-Wave generator creates a .wav file of a user-determined note, chord or melody.\n-For a melody, you will be prompted to enter a filename, and a number of desired notes for your melody (maximum of 50).\n-For each note, you will be prompted to enter the note name and duration.\n-The melody you have created will be saved in the working directory, and you can then open and play it.").green
    end

end

help = Help.new
# help.note_help
# help.chord_help
help.melody_help