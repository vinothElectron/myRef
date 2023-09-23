class Solution:
    def longestStrChain(self, words) -> int:
        # Sort the words by their lengths
        words.sort(key=len)

        # Dictionary to store the longest chain length for each word
        longest_chain_length = {}

        # Initialize the answer
        max_chain_length = -1

        for word in words:
            # Initialize the chain length for the current word
            longest_chain_length[word] = 1

            # Try removing one character at a time from the word and check if the resulting word exists
            for i in range(len(word)):
                reduced_word = word[:i] + word[i + 1:]

                # If the reduced word exists in the dictionary
                if reduced_word in longest_chain_length:
                    # Update the chain length for the current word
                    longest_chain_length[word] = max(longest_chain_length[word], longest_chain_length[reduced_word] + 1)

            # Update the maximum chain length seen so far
            max_chain_length = max(max_chain_length, longest_chain_length[word])

        return max_chain_length
