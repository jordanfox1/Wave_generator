module Notes
  # This page contains the reusable methods and data used by the functional parts of the application
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
        note_num = nil
        while note_num == nil
          puts Rainbow('Enter the number of notes').blue
          note_num = STDIN.gets.chomp.to_i
          if note_num < 1 || note_num > 50 || !note_num.is_a?(Integer)
            puts Rainbow(' Please enter a number of notes greater than zero and less than 50!').yellow
            note_num = nil
          end
        end
        return note_num
      end

      def get_notes
          frequency = nil
          while notes[frequency] == nil
            puts Rainbow("What is the note?").blue
            frequency = STDIN.gets.chomp.to_sym
            if notes[frequency] == nil
              puts Rainbow("Please enter a valid note!").yellow
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
        duration = nil
        while duration == nil
          puts Rainbow("How many seconds should it be played for?").blue
          duration = STDIN.gets.chomp.to_f
          if duration > 50 || duration == 0
          puts Rainbow("Please enter a length of seconds for your note to play.\n-This number can be less than one, but must be greater than zero!").yellow
          duration = nil
          end
        end
        return duration
      end
    end
end

def get_distortion
  amplitude = nil
  while amplitude == nil
    puts Rainbow("Do you want to add distortion? type 'y' or 'yes' or 'n' or 'no' for no.").blue
    dist = STDIN.gets.chomp

    case dist
    when 'y', 'yes'
      amplitude = 1.15
    when 'n', 'no'
      amplitude = 0.25 
    else puts Rainbow("Invalid input! type 'y' or 'yes' or 'n' or 'no' for no.").yellow
    end
  end
  amplitude
end