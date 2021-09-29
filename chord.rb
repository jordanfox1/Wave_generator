require 'wavefile'
require 'tty-spinner'
require 'rainbow'
require_relative 'data'
require_relative 'methods'

puts Rainbow("What do you want to name your file?").blue
OUTPUT_FILENAME = "./files/" + gets.chomp + '.wav'

def chord
  include Notes::UserInterface
  note_num = 4
  samples = []
  count = 0

  puts "How long should your chord be played?"
  duration = gets.chomp.to_i

  while count <= note_num - 1
    frequency *= 2 if count == 3
    amplitude = 0.25
    num_samples = Notes.SAMPLE_RATE * duration

    case count
    when 0
      frequency = Notes.get_notes
      voice = generate_sample_data(num_samples, frequency, amplitude)
      voice_1 = voice
    when 1
      frequency = Notes.get_notes
      voice = generate_sample_data(num_samples, frequency, amplitude)
      voice_2 = voice
    when 2
      frequency = Notes.get_notes
      voice = generate_sample_data(num_samples, frequency, amplitude)
      voice_3 = voice
    when 3
      frequency = Notes.get_notes
      frequency *= 2
      voice = generate_sample_data(num_samples, frequency, amplitude)
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

def generate_sample_data(num_samples, frequency, amplitude)
  angle = 0.0
  offset = frequency / Notes.SAMPLE_RATE
  voice = [].fill(0.0, 0, num_samples)

  num_samples.times do |i|
    voice[i] = Math.sin(angle * Notes::TWO_PI) * amplitude
    angle += offset
    if angle >= 1.0
      offset -= 1.0
    end
  end
  voice
end
