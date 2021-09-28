
require "wavefile"

OUTPUT_FILENAME = "mynote.wav"
SAMPLE_RATE = 44100
TWO_PI = 2 * Math::PI
RANDOM_GENERATOR = Random.new

def note

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
  
  # puts 'what is your waveform?'
  # waveform = gets.chomp.to_sym

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

  offset = TWO_PI * frequency / SAMPLE_RATE
  angle = 0.0

  num_samples = SAMPLE_RATE * duration
  samples = sine(angle, offset, amplitude, num_samples)
  
  buffer = WaveFile::Buffer.new(samples, WaveFile::Format.new(:mono, :float, SAMPLE_RATE))
 
  WaveFile::Writer.new(OUTPUT_FILENAME, WaveFile::Format.new(:mono, :pcm_16, SAMPLE_RATE)) do |writer|
    writer.write(buffer)
  end
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

note