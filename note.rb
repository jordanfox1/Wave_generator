

gem "wavefile", "=1.1.1"
require "wavefile"

OUTPUT_FILENAME = "mynote.wav"
SAMPLE_RATE = 44100
# SECONDS_TO_GENERATE = 1
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
  # Read the command-line arguments.
  waveform = :sine

  frequency = ARGV[0].to_sym

  notes.each do |k, _v|
    if frequency == k
      frequency = notes[frequency]
    end
  end

  duration = ARGV[1].to_i

  amplitude = ARGV[2].to_f   # Should be between 0.0 (silence) and 1.0 (full volume).
                             # Amplitudes above 1.0 will result in clipping distortion.

  # Generate sample data at the given frequency and amplitude.
  # The sample rate indicates how many samples we need to generate for
  # 1 second of sound.

  num_samples = SAMPLE_RATE * duration
  samples = generate_sample_data(waveform, num_samples, frequency, amplitude)
  

  buffer = WaveFile::Buffer.new(samples, WaveFile::Format.new(:mono, :float, SAMPLE_RATE))
  # Write the Buffer containing our samples to a monophonic Wave file
  WaveFile::Writer.new(OUTPUT_FILENAME, WaveFile::Format.new(:mono, :pcm_16, SAMPLE_RATE)) do |writer|
    writer.write(buffer)
  end
  # Wrap the array of samples in a Buffer, so that it can be written to a Wave file
  # by the WaveFile gem. Since we generated samples with values between -1.0 and 1.0,
  # the sample format should be :float 
end

# The dark heart of NanoSynth, the part that actually generates the audio data
def generate_sample_data(waveform, num_samples, frequency, amplitude)
  position_in_period = 0.0
  position_in_period_delta = frequency / SAMPLE_RATE

  # Initialize an array of samples set to 0.0. Each sample will be replaced with
  # an actual value below.
  samples = [].fill(0.0, 0, num_samples)

  num_samples.times do |i|
    # Add next sample to sample list. The sample value is determined by
    # plugging position_in_period into the appropriate wave function.
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

    # Constrain the period between 0.0 and 1.0.
    # That is, keep looping and re-looping over the same period.
    if position_in_period >= 1.0
      position_in_period -= 1.0
    end
  end

  samples

end

note
