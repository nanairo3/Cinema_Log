class MovieInfomationPeriodicallyImportBatch
  def self.exec
    MoviesAcquisitionApiSercvice.import
  end
end