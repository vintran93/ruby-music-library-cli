class Song
    attr_accessor :name, :artist, :genre

    @@all = []

    def initialize(name, artist=nil, genre=nil)
        @name = name
        self.artist=(artist) if artist != nil
        self.genre=(genre) if genre != nil
    end

    def self.all
        @@all
    end

    def self.destroy_all
        all.clear
    end

    def save
        self.class.all << self
    end

    def self.create(name)
        song = self.new(name)
        song.save
        return song
    end

    def artist=(artist)
        @artist = artist
        artist.add_song(self)
    end

    def genre=(genre)
     @genre = genre
    end

    def self.find_by_name(name)
        all.detect{ |s| s.name == name }
    end

    def self.find_or_create_by_name(name)
        find_by_name(name) || create(name)
    end

    def self.new_from_filename(filename)
        array = filename.split(" - ")
    
        song_name = array[1]
        artist_name = array[0]
        genre_name = array[2].split(".mp3").join
    
        artist = Artist.find_or_create_by_name(artist_name)
        genre = Genre.find_or_create_by_name(genre_name)
        self.new(song_name, artist, genre)
    end

    def self.create_from_filename(filename)
        self.new_from_filename(filename).save
    end

    def import
        files.each{ |f| Song.create_from_filename(f) }
    end
end 
