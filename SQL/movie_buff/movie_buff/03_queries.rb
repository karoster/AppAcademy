def what_was_that_one_with(those_actors)
  # Find the movies starring all `those_actors` (an array of actor names).
  # Show each movie's title and id.
  Actor
    .joins(:movies)
    .group(:'movies.id', :'movies.title')
    .having('COUNT(movies.title) >= 2')
    .where(actors: {name: those_actors})
    .select(:'movies.title', :'movies.id')
    #.uniq
end

def golden_age
  # Find the decade with the highest average movie score.
  Movie
    .group('FLOOR(yr/10) * 10')
    .order('AVG(score) DESC')
    .limit(1)
    .pluck('FLOOR(yr/10) * 10').first.to_i


end

def costars(name)
  # List the names of the actors that the named actor has ever
  # appeared with.
  # Hint: use a subquery
  Actor
    .joins(:movies)
    .where(movies: {id: Movie
      .joins(:actors)
      .where(actors: {name: name})
      .pluck(:id) }
    )
    .where.not(name: name)
    .uniq
    .pluck(:name)
end

def actor_out_of_work
  # Find the number of actors in the database who have not appeared in a movie
  Actor
    .left_outer_joins(:movies)
    .pluck('SUM(CASE WHEN movies.id IS NULL THEN 1 END)').first
end

def starring(whazzername)
  # Find the movies with an actor who had a name like `whazzername`.
  # A name is like whazzername if the actor's name contains all of the
  # letters in whazzername, ignoring case, in order.

  # ex. "Sylvester Stallone" is like "sylvester" and "lester stone" but
  # not like "stallone sylvester" or "zylvester ztallone"
  
  matcher = "%#{whazzername.split(//).join('%')}%"
  Movie.joins(:actors).where('UPPER(actors.name) LIKE UPPER(?)', matcher)


end

def longest_career
  # Find the 3 actors who had the longest careers
  # (the greatest time between first and last movie).
  # Order by actor names. Show each actor's id, name, and the length of
  # their career.

end
