gem "wavefile", "=1.1.1"
require "wavefile"
require "tty-spinner"
require 'rainbow'

puts "What do you want to name your file?"
OUTPUT_FILENAME = gets.chomp + '.wav'
SAMPLE_RATE = 44100

TWO_PI = 2 * Math::PI
RANDOM_GENERATOR = Random.new

def melody
  puts 'how many notes are in your melody?'
  note_num = gets.chomp.to_i
  
  samples = []
  count = 0
 
  while count <= note_num - 1
    notes = { c: 261.63,
      csharp: 277.18,
      dflat: 277.18,
      d: 293.66,
      dsharp: 311.13,
      eflat: 311.13,
      e: 329.63,
      f: 349.23,
      fsharp: 369.99,
      gflat: 369.99,
      g: 392.00,
      gsharp: 415.30,
      aflat: 415.30,
      a: 440.00,
      asharp: 466.16,
      bflat: 466.16,
      b: 493.88,
    }

    waveform = :sine

    puts "What is the note?"
    frequency = gets.chomp.to_sym
    puts "How many seconds should it be played for?"
    duration = gets.chomp.to_f

    notes.each do |k, _v|
      if frequency == k
        frequency = notes[frequency]
      end
    end

    amplitude = 0.25

    num_samples = SAMPLE_RATE * duration

    voice = generate_sample_data(waveform, num_samples, frequency, amplitude)
    samples.push(voice)
    
    buffer = WaveFile::Buffer.new(samples.flatten, WaveFile::Format.new(:mono, :float, SAMPLE_RATE))

    WaveFile::Writer.new(OUTPUT_FILENAME, WaveFile::Format.new(:mono, :pcm_16, SAMPLE_RATE)) do |writer|
    writer.write(buffer)
    end

    count += 1
  end
  samples
end


def generate_sample_data(waveform, num_samples, frequency, amplitude)
  position_in_period = 0.0
  position_in_period_delta = frequency / SAMPLE_RATE

  voice = [].fill(0.0, 0, num_samples)

  num_samples.to_i.times do |i|

    if waveform == :sine
      voice[i] = Math::sin(position_in_period * TWO_PI) * amplitude
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