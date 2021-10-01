require "tty-prompt"
require "tty-spinner"
require "rainbow"
require_relative "help"
spinner = TTY::Spinner.new("[:spinner] ...", format: :pulse_2)

# This method conatains the menu of the application
def menu
    spinner = TTY::Spinner.new("[:spinner] ...", format: :pulse_2)
    puts Rainbow("Welcome to the wave generator!").blue
    prompt = TTY::Prompt.new
    inp = prompt.select("What would you like to generate?", %w(Note Chord Melody Bassline Help))
    case inp
    when "Note"
        require_relative "note.rb"
        note
        spinner.stop Rainbow("Check the files folder to find your note!").green
    when "Chord"
        require_relative "chord.rb"
        chord
        spinner.stop Rainbow("Check the files folder to find your chord!").green
    when "Melody"
        require_relative "melody.rb"
        melody
        spinner.stop Rainbow("Check the files folder to find your melody!").green
    when "Bassline"
        require_relative "bassline.rb"
        bassline
        spinner.stop Rainbow("Check the files folder to find your bassline!\nWARNING! turn down your speakers before listening").green
    else
        help = Help.new

        help_prompt = prompt.select("What do you need help with?", %w(Note_help Chord_help Melody_help Bassline_help))

        if help_prompt == "Melody_help"
            help.melody_help
        elsif help_prompt == "Note_help"
            help.note_help
        elsif help_prompt == "Chord_help"
            help.chord_help
        elsif help_prompt == "Bassline_help"
            help.bassline_help
        end
    end
end

# This statement just adds the option of accessing the functions with command line args
case ARGV[0]
when 'menu', nil
    menu
when 'note'
    require_relative 'note'
    note
    spinner.stop Rainbow("Check the files folder to find your note!").green
when 'chord'
    require_relative 'chord'
    chord
    spinner.stop Rainbow("Check the files folder to find your chord!").green
when 'melody'
    require_relative 'melody'
    melody
    spinner.stop Rainbow("Check the files folder to find your melody!").green
when 'bassline'
    require_relative 'bassline'
    bassline
    spinner.stop Rainbow("Check the files folder to find your bassline!").green
when 'help'
    puts Rainbow("To use this application's menu, please type 'ruby wave_generator'.
If you are familiar with the application, type the item you want to generate as a command line argument.
To see help for individual app functions, see the 'help' section in the menu.").green
end