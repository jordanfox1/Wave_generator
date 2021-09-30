require 'wavefile'
require 'rainbow'
require_relative 'data'
require_relative 'methods'
include Notes::UserInterface

puts Rainbow("What do you want to name your file?").blue
OUTPUT_FILENAME = "./files/" + STDIN.gets.chomp + '.wav'

def chord
  # include Notes::UserInterface
  note_num = 4
  samples = []
  count = 0
  duration = nil

  while duration.nil?
    puts Rainbow("For how many seconds should your chord be played?").blue
    duration = STDIN.gets.chomp.to_i
    if duration < 1 || duration > 40 || !duration.is_a?(Integer)
      puts Rainbow("Please enter a number of seconds greater than 1 and less than 150!").yellow
      duration = nil
    end
  end

  while count <= note_num - 1
    frequency *= 2 if count == 3
    amplitude = 0.25
    num_samples = Notes.SAMPLE_RATE * duration

    case count
    when 0
      frequency = Notes.get_notes
      voice = generate_sinewave(num_samples, frequency, amplitude)
      voice_1 = voice
    when 1
      frequency = Notes.get_notes
      voice = generate_sinewave(num_samples, frequency, amplitude)
      voice_2 = voice
    when 2
      frequency = Notes.get_notes
      voice = generate_sinewave(num_samples, frequency, amplitude)
      voice_3 = voice
    when 3
      frequency = Notes.get_notes
      frequency *= 2
      voice = generate_sinewave(num_samples, frequency, amplitude)
      voice_4 = voice
    end

    if count >= 3
      samples = [voice_1, voice_2, voice_3, voice_4].transpose.map {|x| x.reduce(:+)}
      export_samples(samples.flatten)
    end
    count += 1
  end
  samples
end
