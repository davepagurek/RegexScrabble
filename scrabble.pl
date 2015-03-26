#!/usr/bin/perl

use File::Slurp;
use strict;
use warnings;

# Map letters to scrabble values
my %values = (
    e => 1,
    a => 1,
    i => 1,
    o => 1,
    n => 1,
    r => 1,
    t => 1,
    l => 1,
    s => 1,
    u => 1,
    d => 2,
    g => 2,
    b => 3,
    c => 3,
    m => 3,
    p => 3,
    f => 4,
    h => 4,
    v => 4,
    w => 4,
    y => 4,
    k => 5,
    j => 8,
    x => 8,
    q => 10,
    z => 10
);


# Get the sum of the scrabble values of the letters in a word
sub wordValue {
    my $word = shift;
    my $sum = 0;

    # Split the word into an array of individual letters
    for my $letter (split //, $word) {

        # If it's not in the table, the scrabble value is 0
        $sum += $values{$letter} || 0;
    }
    return $sum;
}

# Read in a dictionary file either from @ARGV or the default
my $dictionary = read_file($ARGV[0] || "twl-words.txt") or die "Can't open file: $!";

# Get letter inputs
while (<STDIN>) {
    chomp(my $letters = $_);


    my $highestScore = 0;
    my $highestWord = "";

    # Regex through the dictionary to find words only including the given letters/
    # First we find words (a break \b on each side makes of a word) using any number
    # of letters as long as every letter is in the inputted string
    my $lettersClass = "[$letters]";
    my @matches = $dictionary =~ /\b$lettersClass+\b/ig;

    # Go through the matches from the initial query
    WORD: for my $word (@matches) {

        # Check the number of occurrences of each letter: loop through the letters in the word
        LETTER: for my $letter (split "", $word) {

            # Get the number of times the letter occurs in the word with a RegEx
            my $wordOccurrences = () = $word =~ /$letter/g;

            # Get the number of times the letter occurs in the input string with a RegEx
            my $lettersOccurrences = () = $letters =~ /$letter/g;

            # Break out of the WORD loop if there are too many of a given type of letter in the word
            next WORD if ($wordOccurrences > $lettersOccurrences);
        }

        # If we've made it here, the word fits the input string, so we can check its score and save it
        # if it's the highest so far
        my $score = wordValue($word);
        if ($score > $highestScore) {
            $highestScore = $score;
            $highestWord = $word;
        }
    }

    # Display the results!
    if ($highestScore == 0) {
        print "$letters: no matches\n";
    } else {
        print "$letters: $highestWord has score of $highestScore\n";
    }
}
