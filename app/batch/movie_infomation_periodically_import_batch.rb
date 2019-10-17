class MovieInfomationPeriodicallyImportBatch
  def self.exec
    ImportMoviesSercvice.api_execution
  end
end