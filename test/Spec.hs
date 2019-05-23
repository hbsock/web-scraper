import Test.QuickCheck
import CmdParser (isInputInvalid, Inputs (..))

instance Arbitrary Inputs where
    arbitrary = Inputs <$> arbitrary 
        <*> arbitrary
        <*> arbitrary
        <*> arbitrary
        <*> arbitrary

prop_input :: Inputs -> Bool
prop_input input = True

main :: IO ()
main = do
    quickCheck $ prop_input
