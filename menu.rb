require "tty-prompt"
require "tty-spinner"
require "rainbow"
require_relative "help.rb"

def menu
    spinner = TTY::Spinner.new("[:spinner] ...", format: :pulse_2)

    puts Rainbow("Welcome to the wave generator!").blue
    prompt = TTY::Prompt.new
    inp = prompt.select("What would you like to generate?", %w(Note Chord Melody Help))

    case inp
    when "Note"
        require_relative "note.rb"
        note
        spinner.stop Rainbow("Check the files folder to find your note!").green
    when "Chord"
        require_relative "chord.rb"
        chord
        spinner.stop Rainbow("Check the files folder to find your chord!").green
    when "Melody"
        require_relative "melody.rb"
        melody
        spinner.stop Rainbow("Check the files folder to find your melody!").green
    else
        help = Help.new

        help_prompt = prompt.select("What do you need help with?", %w(Note_help Chord_help Melody_help))

        if help_prompt == "Melody_help"
            help.melody_help
        elsif help_prompt == "Note_help"
            help.note_help
        elsif help_prompt == "Chord_help"
            help.chord_help
        end
    end
end

menu