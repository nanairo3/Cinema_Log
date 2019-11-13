# frozen_string_literal: true

class MovieInformationPeriodicallyImportBatch
  def self.exec
    MoviesAcquisitionApiSercvice.import
  end
end