class SongsWorker
  require 'csv'
  include Sidekiq::Worker

  def perform(songs_file)
    CSV.foreach(songs_file, headers: true) do |song|
      Song.create(title: song[0], artist_id: Artist.find_or_create(name: song[1]).id)
    end
  end
end
