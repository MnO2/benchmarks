import Control.Monad
import Data.List
import qualified Data.IntMap as I
import System.Environment

main = do
  [size] <- fmap (fmap read) getArgs
  let k = foldl' (\m n -> I.insert n n m) I.empty [1..size]
  print $ I.lookup 100 k
