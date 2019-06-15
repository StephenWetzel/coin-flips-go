// Testing this paper https://papers.ssrn.com/sol3/papers.cfm?abstract_id=2627354
// "If you select a flip from a finite sequence coin flips because it is preceded by several heads, then it is more likely to be a tails."
// If you flip a coin 100 times and record the results.  Then, select a random 'streak' of 3 consecutive heads.  The odds that the next flip will be heads is not 50%.  It's closer to 45%.

// We represent flips with an array of 0s and 1s.  1 for heads, and 0 for tails.

package main
import "fmt"
import "math/rand"
import "time"

// Return an array of random flips, of the given length
func create_flips(number_of_flips int) ([]int) {
  flips := make([]int, number_of_flips)
  for ii := range flips {
    flips[ii] = rand.Intn(2) // 1 is heads, 0 is tails
  }
  return flips
}

// Is this a streak?  Starting at index flip_number and looking at the next steak_length flips, if they are all heads then this is true
func streak_found(flips []int, flip_number, streak_length int) (bool) {
  if flips[flip_number] != 1 { return false } // Not heads
  for ii := 0; ii < streak_length; ii++ { // Check if any of the flips in this potential streak don't match the first
    if flips[flip_number] != flips[flip_number + ii] { return false }
  }
  return true
}

// Find a streak by picking random spots in our array of flips and then checking for a streak there.  Return as soon as we find one.
func find_streak_random(flips []int, streak_length int) (int) {
  tries := 2 * len(flips) + 10 // Since it's random we need to give up at some point.  This is purely my gut feeling for what is 'enough' tries.
  for try_number := 0; try_number < tries; try_number++ {
    flip_number := rand.Intn(len(flips) - streak_length)  // For a 100 flip array and 3 flip streak, this is 100 - 3 = 97 -> 0...96
    if streak_found(flips, flip_number, streak_length) {
      return flip_number
    }
  }
  return -1 // This represents a failure to find any streaks of the desired length in this array of flips
}


func main() {
  const STREAK_LENGTH = 1 // Number of 'heads' in a row we consider a 'streak'
  const NUMBER_OF_FLIPS = 3 // How many times with flip our coin
  const ROUNDS_TO_PERFORM = 100000 // A round consists of flipping a coin the desired times, finding 1 streak in it, and then checking the next flip after the streak.

  count := 0.0
  completed_rounds := 0.0 // A completed round is any where we are able to find a streak

  rand.Seed(time.Now().UnixNano())
  for round_num := 0; round_num < ROUNDS_TO_PERFORM; round_num++ {
    flips := create_flips(NUMBER_OF_FLIPS) // Generate our random array of flips
    streak_index := find_streak_random(flips, STREAK_LENGTH)
    if streak_index < 0 { continue } // We failed to find a streak in this array of flips
    streak_continued := flips[streak_index] == flips[streak_index + STREAK_LENGTH] // The key test
    completed_rounds++
    if streak_continued { count++ }
  }
  percent_continued_streak := (100.0 * count / completed_rounds)
  fmt.Printf("Performed %v rounds, and %v were successful, found %.2f%% continued the streak.\n", ROUNDS_TO_PERFORM, completed_rounds, percent_continued_streak)
}
