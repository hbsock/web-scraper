import Test.QuickCheck
import CmdParser (isInputInvalid, Inputs (..))
import System.FilePath (isValid)
import Network.URI (isURI)


instance Arbitrary Inputs where
    arbitrary = Inputs <$> arbitrary 
        <*> arbitrary
        <*> arbitrary
        <*> arbitrary
        <*> arbitrary

prop_input :: Inputs -> Bool
prop_input inputs = case isInputInvalid inputs of
        Just(_) -> invalid_cond == True
        Nothing -> invalid_cond == False
    where invalid_cond = or [ (low inputs) > (high inputs),
                            (low inputs) < 0,
                            (high inputs) < 0,
                            not . isValid $ (output_dir inputs),
                            not . isURI $ (base_url inputs)]

main :: IO ()
main = do
    quickCheck $ prop_input
