require "tty-prompt"

prompt = TTY::Prompt.new
inp = prompt.select("What would you like to generate?", %w(Note Chord Melody))

p inp

case inp
when "Note"
    require_relative "note.rb"
    note
when "Chord"
    require_relative "chord.rb"
    chord
when "Melody"
    require_relative "melody.rb"
    melody
end
