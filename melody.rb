
require "wavefile"
require "tty-spinner"
require 'rainbow'
require_relative 'data.rb'

puts "What do you want to name your file?"
OUTPUT_FILENAME = "./files/" + gets.chomp + '.wav'

RANDOM_GENERATOR = Random.new

def melody
  notes = Notes.notes
  
  puts 'how many notes are in your melody?'
  note_num = gets.chomp.to_i

  
  samples = []
  count = 0
 
  while count <= note_num - 1
    waveform = :sine

    frequency = nil
    while notes[frequency] == nil
      puts "What is the note?"
      frequency = gets.chomp.to_sym

      if notes[frequency] == nil
        puts "invalid input"
      end
    end

    puts "How many seconds should it be played for?"
    duration = gets.chomp.to_f

    notes.each do |k, _v|
      if frequency == k
        frequency = notes[frequency]
      end
    end

    amplitude = 0.25

    num_samples = Notes.SAMPLE_RATE * duration
    begin
      voice = generate_sample_data(waveform, num_samples, frequency, amplitude)
      samples.push(voice)
      

      count += 1
    rescue
      puts "there was an error"
    end
  end      
  buffer = WaveFile::Buffer.new(samples.flatten, WaveFile::Format.new(:mono, :float, Notes.SAMPLE_RATE))

  WaveFile::Writer.new(OUTPUT_FILENAME, WaveFile::Format.new(:mono, :pcm_16, Notes.SAMPLE_RATE)) do |writer|
    writer.write(buffer)
  end    
  samples
end


def generate_sample_data(waveform, num_samples, frequency, amplitude)
  position_in_period = 0.0
  position_in_period_delta = frequency / Notes.SAMPLE_RATE

  voice = [].fill(0.0, 0, num_samples)

  num_samples.to_i.times do |i|

    if waveform == :sine
      voice[i] = Math::sin(position_in_period * Notes::TWO_PI) * amplitude
    elsif waveform == :square
      voice[i] = (position_in_period >= 0.5) ? amplitude : -amplitude
    elsif waveform == :saw
      voice[i] = ((position_in_period * 2.0) - 1.0) * amplitude
    elsif waveform == :triangle
      voice[i] = amplitude - (((position_in_period * 2.0) - 1.0) * amplitude * 2.0).abs
    elsif waveform == :noise
      voice[i] = RANDOM_GENERATOR.rand(-amplitude..amplitude)
    end

    position_in_period += position_in_period_delta


    if position_in_period >= 1.0
      position_in_period -= 1.0
    end
  end
  voice
end