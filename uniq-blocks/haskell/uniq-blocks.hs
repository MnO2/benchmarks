import           Control.Monad
import qualified Data.ByteString.Lazy as LB
import           Data.Foldable
import           Data.HashMap.Strict hiding (foldl')
import           Data.Int
import qualified Data.List            as DL
import           System.Environment

type DummyDedupe = HashMap LB.ByteString Int64

toBlocks :: Int64 -> LB.ByteString -> [LB.ByteString]
toBlocks n bs | LB.null bs = []
              | otherwise = let (block, rest) = LB.splitAt n bs
                            in block : toBlocks n rest

dedupeBlocks :: [LB.ByteString] -> DummyDedupe -> DummyDedupe
dedupeBlocks = flip $ DL.foldl' (\acc block -> insertWith (+) block 1 $! acc)

dedupeFile :: FilePath -> DummyDedupe -> IO DummyDedupe
dedupeFile fp dd = LB.readFile fp >>= return . (`dedupeBlocks` dd) . toBlocks 512

main :: IO ()
main = do
  dd <- getArgs >>= (`dedupeFile` empty) . head
  putStrLn . show . (*512) . size $ dd
  putStrLn . show . (*512) . foldl' (+) 0 $ dd
