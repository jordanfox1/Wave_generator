require "wavefile"
require "tty-spinner"
require 'rainbow'
require_relative 'data.rb'
require_relative 'methods.rb'

puts "What do you want to name your file?"
OUTPUT_FILENAME = "./files/" + gets.chomp + '.wav'

def melody
  include Notes::UserInterface
  note_num = get_note_num
  samples = []
  count = 0

  while count <= note_num - 1
    waveform = :sine
    frequency = Notes.get_notes
    duration = get_note_durations
    amplitude = 0.25

    num_samples = Notes.SAMPLE_RATE * duration

    begin
      create_melody_samples(waveform, num_samples, frequency, amplitude, samples)
      count += 1
    rescue
      puts "there was an error"
    end
  end
  export_melody(samples.flatten)
end
