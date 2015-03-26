<h1>RegexScrabble</h1>
Find the best scrabble word that can be made with a given hand using Regular Expressions!

So in CS 138 we had an assignment where, using hash tables in C++, we had to produce the hgihest scoring Scrabble word given a hand of letters. This was reasonably fast, but the code is sort of messy. You know what is really good at looking through large volumes of text? Regular expressions!

So here's a version written in Perl using RegExes to do the heavy lifting. On my core i5 laptop, this runs faster than the C++ version.

<h2>Running the code</h2>
To run using the example dictionary specified:
```
perl scrabble.pl
```

Or, to specify your own dictionary of whitespace-separated words:
```
perl scrabble.pl dictionaryfile.txt
```

Once running, type a jumble of letters (your scrabble hand) and it will output the best word and its score.
