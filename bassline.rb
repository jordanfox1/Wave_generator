require 'wavefile'
require 'rainbow'
require_relative 'data'
require_relative 'methods'
include Notes::UserInterface

puts Rainbow("What do you want to name your file?").blue
OUTPUT_FILENAME = "./files/" + STDIN.gets.chomp + '.wav'

def bassline
  note_num = get_note_num
  count = 0
  samples = []
  while count <= note_num - 1
    frequency = (Notes.get_notes / 4)
    duration = get_note_durations
    amplitude = distortion

    num_samples = Notes.SAMPLE_RATE * duration

    begin
      voice = generate_sinewave(num_samples, frequency, amplitude)
      samples.push(voice)
      count += 1
    rescue
      puts Rainbow("Please input a single, valid note letter, then input the desired duration for that note").yellow
    end
  end
  export_samples(samples.flatten)
end

bassline