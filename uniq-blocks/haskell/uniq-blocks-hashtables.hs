import           Control.Monad
import qualified Data.ByteString.Lazy as LB
import           Data.HashTable.IO
import           Data.Int
import           System.Environment

type DummyDedupe = CuckooHashTable LB.ByteString Int64

toBlocks :: Int64 -> LB.ByteString -> [LB.ByteString]
toBlocks n bs | LB.null bs = []
              | otherwise = let (block, rest) = LB.splitAt n bs
                            in block : toBlocks n rest

dedupeBlocks :: [LB.ByteString] -> DummyDedupe -> IO DummyDedupe
dedupeBlocks blocks dd = do 
  forM_ blocks (\blk -> insert dd blk 1)
  return dd

dedupeFile :: FilePath -> DummyDedupe -> IO DummyDedupe
dedupeFile fp dd = LB.readFile fp >>= (`dedupeBlocks` dd) . toBlocks 512

main :: IO ()
main = do
  args <- getArgs
  dd <- newSized 10000000
  dd' <- dedupeFile (head args) dd
  return ()
