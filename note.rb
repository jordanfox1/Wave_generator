
gem "wavefile", "=1.1.1"
require "wavefile"
require "tty-spinner"



OUTPUT_FILENAME = "mynote.wav"
SAMPLE_RATE = 44100
TWO_PI = 2 * Math::PI
RANDOM_GENERATOR = Random.new

def note
  spinner = TTY::Spinner.new("[:spinner] Loading ...", format: :pulse_2)
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
  
  puts 'what is your waveform?'
  waveform = gets.chomp.to_sym

  puts 'what is your note?'
  frequency = gets.chomp.to_sym

  notes.each do |k, _v|
    if frequency == k
      frequency = notes[frequency]
    end
  end

  puts 'how many seconds should your note play for?'
  duration = gets.chomp.to_f

  amplitude = 0.25

  num_samples = SAMPLE_RATE * duration
  samples = generate_sample_data(waveform, num_samples, frequency, amplitude)
  
  buffer = WaveFile::Buffer.new(samples, WaveFile::Format.new(:mono, :float, SAMPLE_RATE))
 
  WaveFile::Writer.new(OUTPUT_FILENAME, WaveFile::Format.new(:mono, :pcm_16, SAMPLE_RATE)) do |writer|
    writer.write(buffer)
    spinner.auto_spin
  end
end

def generate_sample_data(waveform, num_samples, frequency, amplitude)
  position_in_period = 0.0
  position_in_period_delta = frequency / SAMPLE_RATE
  
  samples = [].fill(0.0, 0, num_samples)

  num_samples.to_i.times do |i|

    if waveform == :sine
      samples[i] = Math::sin(position_in_period * TWO_PI) * amplitude
    elsif waveform == :square
      samples[i] = (position_in_period >= 0.5) ? amplitude : -amplitude
    elsif waveform == :saw
      samples[i] = ((position_in_period * 2.0) - 1.0) * amplitude
    elsif waveform == :triangle
      samples[i] = amplitude - (((position_in_period * 2.0) - 1.0) * amplitude * 2.0).abs
    elsif waveform == :noise
      samples[i] = RANDOM_GENERATOR.rand(-amplitude..amplitude)
    end

    position_in_period += position_in_period_delta

    if position_in_period >= 1.0
      position_in_period -= 1.0
    end
  end
  samples
end
