require 'wavefile'
require 'tty-spinner'
require 'rainbow'
require_relative 'data'
require_relative 'methods'

puts Rainbow("What do you want to name your file?").blue
OUTPUT_FILENAME = "./files/" + gets.chomp + '.wav'

def note
  include Notes::UserInterface
  # note_num = 1
  frequency = Notes.get_notes
  duration = get_note_durations
  amplitude = 0.25
  offset = Notes::TWO_PI * frequency / Notes.SAMPLE_RATE
  angle = 0.0
  num_samples = Notes.SAMPLE_RATE * duration
  samples = sine(angle, offset, amplitude, num_samples)
  export_samples(samples)
end

# generate the array of samples ascociated with the given parameters
def sine(angle, offset, amplitude, num_samples)
  samples = []
  # this will ensure the correct array size, num_samples refers to the length of the samples array
  num_samples.to_i.times do
    # this will create a single sample of a sinewave at a given point in time
    # which is determined by the angle and offset values
    sample = amplitude * Math.sin(angle)
    # updating the angle so that waveform is represented of an interval of time
    angle += offset
    # populating the samples[] with the correct sample
    samples.push(sample)
  end
  samples
end