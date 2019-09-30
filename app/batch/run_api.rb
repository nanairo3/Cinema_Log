class RunApi < Batch
  def exec
    rails runner app/services/get_movies.rb
  end
end