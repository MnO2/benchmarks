import Control.Monad
import Data.List
import System.Environment
import qualified Data.Judy as J

main = do
  [size] <- fmap (fmap read) getArgs
  j <- J.new :: IO (J.JudyL Int)
  forM_ [1..size] $ \n -> J.insert (fromIntegral n) n j
  print =<< J.lookup 100 j
