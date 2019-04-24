{-
 - Author: Nick Lewis, nlewis2016@my.fit.edu
 - Course: CSE 4250, Fall 2017
 - Project: Proj4, Decoding Text
 - Language implementation: Haskell 8.6.3
 -}

module Main where

main :: IO ()
main = interact (unlines.hoffman.lines)

-- Builds tree from first line , processes remaining lines as messages to be decoded
hoffman :: [String] -> [String]
hoffman [] = [""]
hoffman (pretree : queries) = map (decode tree) queries
  where
    (tree, _) = parse pretree

-- Binary Tree
-- prints either : Leaf c or Node (Tree) (Tree)
data Tree = TNil | Leaf Char | Node Tree Tree
  deriving (Eq, Show) -- Helps debugging

-- Peels off the first element and goes from there
parse :: String -> (Tree, String) -- choose this form to perform recursion and still retrieve tree
parse ('*':xs) = (Node lt rt, zs) -- If the element is a * then its an internal node
  where -- Since the tree is given in preorder first construct your self
    (lt, ys) = parse xs  -- Then construct your left branch
    (rt, zs) = parse ys  -- Then construct your right branch

parse (x:xs) = (Leaf x, xs) -- Otherwise its a leaf
parse [] = (TNil, "")

-- Functions are mutually recursive
-- Keeps the entire tree to loop once part has been decoded
decode :: Tree -> String -> String
decode _ "" = "" -- Base case : no more string to decode
decode tree msg = (c : decode tree re) -- Otherwise append the leaf char and decode rest
  where
    (c, re) = decodePart tree msg -- decompose msg -> leaf char and remainder msg

-- Traverses the tree until it finds a leaf
decodePart :: Tree -> String -> (Char, String)
decodePart (Leaf c) msg = (c, msg) -- Base case : Leaf return char and remaining msg
decodePart (Node lt _) ('0':xs) = decodePart lt xs -- Go left if 0
decodePart (Node _ rt) ('1':xs) = decodePart rt xs -- Go right if 1
decodePart (Node _ _) (_:_) = ('\0', "") -- if you are at an interior node with no msg left Err 1
decodePart (Node _ _) [] = ('\0', "") -- -Wall made me -_- same functionality as the last one
decodePart (TNil) _ = ('\0', "") -- -Wall made me -_- same functionality as the last one

-- Err 1
{-
  Not a valid message return the empty character to append on to what ever has already been decoded
-}
