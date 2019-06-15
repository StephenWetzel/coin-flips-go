# Testing this paper https://papers.ssrn.com/sol3/papers.cfm?abstract_id=2627354
# "If you select a flip from a finite sequence coin flips because it is preceded by several heads, then it is more likely to be a tails."
# If you flip a coin 100 times and record the results.  Then, select a random 'streak' of 3 consecutive heads.  The odds that the next flip will be heads is not 50%.  It's closer to 45%.

# We represent flips with an array of 0s and 1s.  1 for heads, and 0 for tails.

# Is this a streak?  Starting at index flip_number and looking at the next steak_length flips, if they are all heads then this is true
def streak_found?(flips, flip_number, streak_length)
  return false if flips[flip_number] != 1 # Not heads
  (1..streak_length).each do |ii|
    return false if flips[flip_number] != flips[flip_number + ii - 1] # Check if any of the flips in this potential streak don't match the first
  end
  return true
end

# Instead of finding a streak by randomly picking spots in the collection of flips, we start at the first flip and go through it sequentially until we find one.  Finding streaks this way makes the probability of the next flip being heads 50% again.
def find_streak_sequential(flips, streak_length)
  flips.count.times do |ii|
    return ii if streak_found?(flips, ii, streak_length)
  end
  return nil
end

# Find a streak by picking random spots in our array of flips and then checking for a streak there.  Return as soon as we find one.
def find_streak_random(flips, streak_length)
  tries = 2 * flips.count + 10 # Since it's random we need to give up at some point.  This is purely my gut feeling for what is 'enough' tries.
  # We could be more sophisticated here by randomizing a list of numbers that represent flip array indexes, but this is good enough.
  tries.times do
    flip_number = rand(flips.count - streak_length) # For a 100 flip array and 3 flip streak, this is 100 - 3 = 97 -> 0...96
    return flip_number if streak_found?(flips, flip_number, streak_length)
  end
  return nil # This represents a failure to find any streaks of the desired length in this array of flips
end

STREAK_LENGTH = 1 # Number of 'heads' in a row we consider a 'streak'
NUMBER_OF_FLIPS = 3 # How many times with flip our coin
ROUNDS_TO_PERFORM = 10000 # A round consists of flipping a coin the desired times, finding 1 streak in it, and then checking the next flip after the streak.
PRINT_EXTRA_LOGS = false

streak_continued_count = 0
completed_rounds = 0 # A completed round is any where we are able to find a streak

(1..ROUNDS_TO_PERFORM).each do |ii|
  flips = Array.new(NUMBER_OF_FLIPS) { rand(0..1) } # Generate our random array of flips
  streak_index = find_streak_random(flips, STREAK_LENGTH)
  print "\n#{flips} streak found on index: #{streak_index}" if PRINT_EXTRA_LOGS
  next if streak_index.nil? # We failed to find a streak in this array of flips
  streak_continued = flips[streak_index] == flips[streak_index + STREAK_LENGTH] # The key test
  print ", continued: #{streak_continued}" if PRINT_EXTRA_LOGS
  completed_rounds += 1
  streak_continued_count += 1 if streak_continued
end

percent_contiued_streak = (100.0 * streak_continued_count / completed_rounds).round(2)
print "\nPerformed #{ROUNDS_TO_PERFORM} rounds, and #{completed_rounds} were successful, found #{percent_contiued_streak}% continued the streak.\n"


