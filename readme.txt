Polly

To Do:
If all syllables are de-selected, the rhyme read out for all types should read something like "Choose a syllable to rhyme!"

If all syllables are de-selected, the positioning of the syllable selector changes because there are no more large letters. Fix this positioning.

Put a dash between syllables in the syllable selector.

Size of syllable selector container changes based on how many syllables in the word. Make it adaptive.

When a split match rhyme has many rhymes (more than 10-15), inlcude small button allowing user to see all the rhymes. This button must be available for each syllable.

When a word has multiple pronunciations, ask "Did you mean (word) like (rhymes of first pronunciation), or (word) like (rhymes from second pronunciation)?"

Create history. Searching a rhyme yields two things in the url: rhyme and complete-match. If the user switches to split-match, the url changes to reflect that. If the user then searches another word, the rhyme in thr url will change, but the type will still be split-match. This way, people can share links specifically to the word and type of rhyme they want to share. Add two more parameters, both numbers. The first denotes which pronunciations is being used, the second defines the pattern for which syllables are being rhymed.

After mapping all single vowel-to-consonants combination, search for syllables with multiple 
vowels.
Make alternative rhyme-map algorithm: 
  1. Selects the pronunciation symbols from the selected syllables
  2. Finds the vowel and the following consonant/combo of consonants
  3. Searches through other words for exact matches.
  Less durable, but requires no mapping. May need to use as placeholder if 
  manual rhyme mapping doesn't come out well.
Explore how to use original master rhyme map (as opposed to stress free rhyme map) to include stresses in the codification. NOTE: Upon checking rhymes, this is extremely important.



Note on Special Characters:
  Underlined th will be represented with ~
  Underlined k will be represented with +
  A u with a dot over it will be represented by u

Pollysyllabic Rhyme Matcher

Parse all the words in the dictionary, getting the words coupled with their pronunciation symbols.
(Starting out with the most commonly used 5000, as parsing the whole dictionary will take some time)

Research rhyming, develop rhyme map to compare phonetic symbol syllables and determine if they rhyme.

User types in word, the word is broken down into its syllables, and the user then clicks on the syllables that he/she wants to rhyme. Three different views are returned to the User. They are Complete Match, Split Match, and Split Match Extended.

Complete Match: One word results. Each has the complete rhyme pattern, indicated by the selected syllables of user's word, within it. Rhyming syllables are underlined/highlighted. (They are highlighted here using parantheses)

Word: factory
Selected Syllables: fac - ry
Matches:
(fac)ul(ty)
(blas)phe(my)
ca(pa)ci(ty)

Split Match: Single syllable matches to each selected syllable. If adjacent syllables are selected, offer perfect word matches for them as well. The rhymes for each syllable will be in a different column, and each column will be able to scroll vertically and independently of one other.
Perfect word matches would be words that have the same amount of syllables as the number of selected syllables adjacent to one another, and rhyming perfectly with them. 

Word: meditation
Selected Syllables: med - ta tion
Matches:
med     -     ta      tion     ta-tion
red     -     lay     sin      nation
sled    -     grey    win      anklet
bed     -     may     shin     wasted
bread   -     hey     grin     aces

Version 2 plan: Should include successive syllable selections, not just adjacent ones. In the example above, there should also be a column for med-ta.

Split Match Extended: Larger words that have one syllable that rhymes with of one of the syllables within them. Similar to split match, in that individual columns scroll independently. Rhyming syllables are highlighted, similar to the Complete Match. (Again, highlighted here by parentheses)

Word: factory
Selected: fa - ry
Matches:
      fac - -        - - ry
  at(tack) - -     - con(cede)
    (pass)ive -    - be(lieve)
cata(ract) - -      - - (trea)ty

Be able to choose between different pronunciations?
e.g. User types in "live". They need to be able to choose between the different pronunciations.
possible solution: Compare all pronuncations for inputed word. Use rhyming map to see if there are any that dont rhyme, offer these non-rhyme-matches.