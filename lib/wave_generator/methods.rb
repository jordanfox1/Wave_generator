require_relative 'data.rb'
require "wavefile"

def create_melody_samples(num_samples, frequency, amplitude)
    voice = generate_sinewave(num_samples, frequency, amplitude)
    samples.push(voice)
    return samples
end

def export_samples(samples)
    buffer = WaveFile::Buffer.new(samples, WaveFile::Format.new(:mono, :float, Notes.SAMPLE_RATE))

    WaveFile::Writer.new(OUTPUT_FILENAME, WaveFile::Format.new(:mono, :pcm_16, Notes.SAMPLE_RATE)) do |writer|
      writer.write(buffer)
    end
end

def generate_sinewave(num_samples, frequency, amplitude)
  angle = 0.0
  offset = frequency / Notes.SAMPLE_RATE
  samples = [].fill(0.0, 0, num_samples)
  num_samples.to_i.times do |sample|
    samples[sample] = Math.sin(angle * Notes::TWO_PI) * amplitude
    angle += offset
    if angle >= 1.0
      angle -= 1.0
    end
  end
  samples
end