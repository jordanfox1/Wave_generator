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
end