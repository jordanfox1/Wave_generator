require 'wavefile'
require 'tty-spinner'
require 'rainbow'
require_relative 'data'
require_relative 'methods'
include Notes::UserInterface

puts Rainbow("What do you want to name your file?").blue
OUTPUT_FILENAME = "./files/" + STDIN.gets.chomp + '.wav'

def note
  frequency = Notes.get_notes
  duration = get_note_durations
  amplitude = 0.25
  num_samples = Notes.SAMPLE_RATE * duration
  samples = generate_sinewave(num_samples.to_i, frequency, amplitude)
  export_samples(samples)
end