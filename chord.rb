gem "wavefile", "=1.1.1"
require "wavefile"

puts "What do you want to name your file?"
OUTPUT_FILENAME = gets.chomp + '.wav'
SAMPLE_RATE = 44100
# SECONDS_TO_GENERATE = 1
TWO_PI = 2 * Math::PI
RANDOM_GENERATOR = Random.new

def chord
  note_num = 3

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

    if count == 0
      puts "What is the first note?"
      frequency = gets.chomp.to_sym
    elsif count == 1
      puts "What is the second note?"
      frequency = gets.chomp.to_sym
    elsif count == 2
      puts "What is the third note?"
      frequency = gets.chomp.to_sym
    end

    notes.each do |k, _v|
      if frequency == k
        frequency = notes[frequency]
      end
    end

    duration = 3

    amplitude = 0.25

    num_samples = SAMPLE_RATE * duration

    case count
    when 0
      voice = generate_sample_data(waveform, num_samples, frequency, amplitude)
      voice_1 = voice
    when 1
      voice = generate_sample_data(waveform, num_samples, frequency, amplitude)
      voice_2 = voice
    when 2
      voice = generate_sample_data(waveform, num_samples, frequency, amplitude)
      voice_3 = voice
    end

    if count >= 2
      samples = [voice_1, voice_2, voice_3].transpose.map {|x| x.reduce(:+)}

      buffer = WaveFile::Buffer.new(samples, WaveFile::Format.new(:mono, :float, SAMPLE_RATE))

      WaveFile::Writer.new(OUTPUT_FILENAME, WaveFile::Format.new(:mono, :pcm_16, SAMPLE_RATE)) do |writer|
      writer.write(buffer)
      end
    end
    count += 1
  end
  samples
end

# number of chord note times, return an array of samples and add them together
def generate_sample_data(waveform, num_samples, frequency, amplitude)
  position_in_period = 0.0
  position_in_period_delta = frequency / SAMPLE_RATE

  voice = [].fill(0.0, 0, num_samples)

  num_samples.times do |i|
    # Add next sample to sample list. The sample value is determined by
    # plugging position_in_period into the appropriate wave function.
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

    # Constrain the period between 0.0 and 1.0.
    # That is, keep looping and re-looping over the same period.
    if position_in_period >= 1.0
      position_in_period -= 1.0
    end
  end
  voice
end

