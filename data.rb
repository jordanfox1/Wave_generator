module Notes
    TWO_PI = 2 * Math::PI
    
    def self.notes
      return { 
          c: 261.63,
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
    end

    def self.SAMPLE_RATE
        return 44100
    end

    module UserInterface
      def get_note_num
        puts 'how many notes are in your melody?'
        note_num = gets.chomp.to_i
        return note_num
      end

      def get_notes
          frequency = nil

          while notes[frequency] == nil
            puts "What is the note?"
            frequency = gets.chomp.to_sym
            if notes[frequency] == nil
              puts "invalid input"
            end
          end

          notes.each do |k, _v|
              if frequency == k
                frequency = notes[frequency]
              end
            end

          return frequency
      end

      def get_note_durations
          puts "How many seconds should it be played for?"
          duration = gets.chomp.to_f
          return duration
      end  
    end
end

# class Foo
#   def method
#   end

#   def self.method_two
#   end
# end

# Foo.method_two

# thing = new Foo()
# thing.method