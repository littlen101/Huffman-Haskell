# Huffman-Haskell
Decoding binary strings into text based off of given DFS tree

Project Description:

Input :
Read the input from the standard input stream. The first line of input is the binary tree encoding two or more printable
US-ASCII characters (but not '*'). Every internal node has two branches. The rest of the input consists of zero or more lines 
of binary digits. The digits represent a single message of length zero or more. The binary digits are a correctly encoded string
of the given characters.

(i.e.)\
\*\*B\*\*DECA\
10110101\
0010100\
0001010100\
011100


Output:
Decode each message and print the US-ASCII characters of the decoded message on its own line.

(i.e.)\
ACE\
BAD\
BED\
CAB

