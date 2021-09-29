require 'wavefile'
require 'tty-spinner'
require 'rainbow'
require_relative 'data'
require_relative 'methods'

puts Rainbow("What do you want to name your file?").blue
OUTPUT_FILENAME = "./files/" + gets.chomp + '.wav'

def melody
  include Notes::UserInterface
  note_num = get_note_num
  samples = []
  count = 0

  while count <= note_num - 1
    frequency = Notes.get_notes
    duration = get_note_durations
    amplitude = 0.25
    offset = Notes::TWO_PI * frequency / Notes.SAMPLE_RATE
    angle = 0.0

    num_samples = Notes.SAMPLE_RATE * duration

    begin
      create_melody_samples(num_samples, amplitude, samples, angle, offset)
      count += 1
    rescue
      puts Rainbow("Please input a single valid note letter, then input the desired duration for that note").yellow
    end
  end
  export_samples(samples.flatten)
end
