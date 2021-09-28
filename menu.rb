require "tty-prompt"
require "tty-spinner"

spinner = TTY::Spinner.new("[:spinner] ...", format: :pulse_2)


prompt = TTY::Prompt.new
inp = prompt.select("What would you like to generate?", %w(Note Chord Melody))

p inp

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
end