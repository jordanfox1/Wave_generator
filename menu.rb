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
        spinner.stop("Your note has been saved in the working directory")
    when "Chord"
        require_relative "chord.rb"
        chord
        spinner.stop("Your chord has been saved in the working directory")
    when "Melody"
        require_relative "melody.rb"
        melody
        spinner.stop("Your melody has been saved in the working directory")
    else
        help = Help.new

        help_promp = prompt.select("What do you need help with?", %w(Note Chord Melody_help Help))

        if help_promp == "Melody_help"
            help.melody_help
        end
        
        
    end
end

menu