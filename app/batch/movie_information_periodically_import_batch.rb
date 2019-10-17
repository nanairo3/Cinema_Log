class MovieInformationPeriodicallyImportBatch
  def self.exec
    MoviesAcquisitionApiSercvice.import
  end
end