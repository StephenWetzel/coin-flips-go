# coin-flips-go
Testing https://papers.ssrn.com/sol3/papers.cfm?abstract_id=2627354 in both Ruby and Go

From the author of the paper:
> If you select a flip from a finite sequence coin flips because it is preceded by several heads, then it is more likely to be a tails.   Overlooking this fact is the hot hand fallacy fallacy and it invalidates the conclusions of the original hot hand fallacy study (and its replications).  When this fact is accounted for, we find that the hot hand is not a cognitive illusion.

In other words, if you flip a coin 100 times and record all the results, then pick a random 'streak' of 3 heads, the odds that the next flip in the record is heads is not 50%, but closer to 45%. 

I started out writting a quick script in Ruby to prove it to myself.  Then I decided to rewrite it in a compiled language so it would be faster.  I choose Go since I had never used it before and wanted to try it out.  Go was about 10x faster than Ruby.

Ruby output with:
```
STREAK_LENGTH = 1 # Number of 'heads' in a row we consider a 'streak'
NUMBER_OF_FLIPS = 3 # How many times with flip our coin
ROUNDS_TO_PERFORM = 10000 # A round consists of flipping a coin the desired times, finding 1 streak in it, and then checking the next flip after the streak.
```

 `> Performed 10000 rounds, and 7547 were successful, found 41.54% continued the streak.`
 
I started out with the Go version identical to the Ruby version, but then I modified it so the Go version loops through different combinations of numbers of flips and streak lengths and tests them all.

The Go version now takes in 3 command line flags:
```
-streak=3 Number of 'heads' in a row we consider a 'streak'
-flips=100 How many times with flip our coin
-rounds=10000 A round consists of flipping a coin the desired times, finding 1 streak in it, and then checking the next flip after the streak.
```

 ```
> ./flips -streak=10 -flips=1000
Looking for a streak of length  1 in    10 total flips. Performed 10000 rounds, and   9973 were successful, found 45.29% continued the streak.
Looking for a streak of length  1 in   100 total flips. Performed 10000 rounds, and  10000 were successful, found 49.43% continued the streak.
Looking for a streak of length  1 in  1000 total flips. Performed 10000 rounds, and  10000 were successful, found 49.91% continued the streak.
Looking for a streak of length  2 in    10 total flips. Performed 10000 rounds, and   8203 were successful, found 38.16% continued the streak.
Looking for a streak of length  2 in   100 total flips. Performed 10000 rounds, and  10000 were successful, found 47.72% continued the streak.
Looking for a streak of length  2 in  1000 total flips. Performed 10000 rounds, and  10000 were successful, found 50.15% continued the streak.
Looking for a streak of length  3 in    10 total flips. Performed 10000 rounds, and   4797 were successful, found 34.88% continued the streak.
Looking for a streak of length  3 in   100 total flips. Performed 10000 rounds, and   9995 were successful, found 45.84% continued the streak.
Looking for a streak of length  3 in  1000 total flips. Performed 10000 rounds, and  10000 were successful, found 49.78% continued the streak.
Looking for a streak of length  4 in    10 total flips. Performed 10000 rounds, and   2152 were successful, found 35.83% continued the streak.
Looking for a streak of length  4 in   100 total flips. Performed 10000 rounds, and   9637 were successful, found 40.61% continued the streak.
Looking for a streak of length  4 in  1000 total flips. Performed 10000 rounds, and  10000 were successful, found 49.21% continued the streak.
Looking for a streak of length  5 in    10 total flips. Performed 10000 rounds, and    985 were successful, found 37.36% continued the streak.
Looking for a streak of length  5 in   100 total flips. Performed 10000 rounds, and   7860 were successful, found 38.66% continued the streak.
Looking for a streak of length  5 in  1000 total flips. Performed 10000 rounds, and  10000 were successful, found 48.91% continued the streak.
Looking for a streak of length  6 in    10 total flips. Performed 10000 rounds, and    388 were successful, found 35.82% continued the streak.
Looking for a streak of length  6 in   100 total flips. Performed 10000 rounds, and   5190 were successful, found 35.24% continued the streak.
Looking for a streak of length  6 in  1000 total flips. Performed 10000 rounds, and   9996 were successful, found 46.68% continued the streak.
Looking for a streak of length  7 in    10 total flips. Performed 10000 rounds, and    140 were successful, found 40.71% continued the streak.
Looking for a streak of length  7 in   100 total flips. Performed 10000 rounds, and   2997 were successful, found 33.83% continued the streak.
Looking for a streak of length  7 in  1000 total flips. Performed 10000 rounds, and   9761 were successful, found 42.40% continued the streak.
Looking for a streak of length  8 in    10 total flips. Performed 10000 rounds, and     52 were successful, found 36.54% continued the streak.
Looking for a streak of length  8 in   100 total flips. Performed 10000 rounds, and   1634 were successful, found 33.60% continued the streak.
Looking for a streak of length  8 in  1000 total flips. Performed 10000 rounds, and   8365 were successful, found 38.27% continued the streak.
Looking for a streak of length  9 in    10 total flips. Performed 10000 rounds, and     17 were successful, found 47.06% continued the streak.
Looking for a streak of length  9 in   100 total flips. Performed 10000 rounds, and    784 were successful, found 33.04% continued the streak.
Looking for a streak of length  9 in  1000 total flips. Performed 10000 rounds, and   6037 were successful, found 35.80% continued the streak.
Looking for a streak of length 10 in    10 total flips. Performed 10000 rounds, and      0 were successful, found NaN% continued the streak.
Looking for a streak of length 10 in   100 total flips. Performed 10000 rounds, and    381 were successful, found 30.71% continued the streak.
Looking for a streak of length 10 in  1000 total flips. Performed 10000 rounds, and   3615 were successful, found 33.91% continued the streak.
```
 
