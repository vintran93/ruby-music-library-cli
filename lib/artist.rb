class Artist
    extend Concerns::Findable

    attr_accessor :name, :songs
    
    @@all = []

    def initialize(name)
        @name = name
        @songs = []
    end

    def self.all
        @@all
    end

    def self.destroy_all 
        all.clear
    end

    def save
        @@all << self
    end

    def self.create(name)
        new(name).tap{|artist| artist.save}
    end

    def songs 
        Song.all.select { |s| s.artist == self }
    end

    def add_song(song)
        song.artist = self unless song.artist  # Does not assign artist if it already exists
    end

    def genres
        songs.collect{ |s| s.genre }.uniq
    end

end
