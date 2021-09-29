require_relative 'data.rb'
require "wavefile"

def create_melody_samples(num_samples, amplitude, samples, angle, offset)
    voice = sine(angle, offset, amplitude, num_samples)
    samples.push(voice)
    return samples
end

def export_samples(samples)
    buffer = WaveFile::Buffer.new(samples, WaveFile::Format.new(:mono, :float, Notes.SAMPLE_RATE))

    WaveFile::Writer.new(OUTPUT_FILENAME, WaveFile::Format.new(:mono, :pcm_16, Notes.SAMPLE_RATE)) do |writer|
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
    # updating the angle so that waveform is represented over an interval of time
    angle += offset
      if angle >= 1.0
        angle -= 1.0
      end
      # populating the samples[] with the correct sample
    samples.push(sample)
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