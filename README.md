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
 
 Go output with:
 ```
const STREAK_LENGTH = 3 // Number of 'heads' in a row we consider a 'streak'
const NUMBER_OF_FLIPS = 100 // How many times with flip our coin
const ROUNDS_TO_PERFORM = 1000000 // A round consists of flipping a coin the desired times, finding 1 streak in it, and then checking the next flip after the streak.
```
`> Performed 1000000 rounds, and 999486 were successful, found 46.00% continued the streak.`
 
