module CCAR.Main.UserJoined 
	(UserJoined, userJoined)
where 

import Data.Text as T  hiding(foldl, foldr)
import Data.Aeson as J
import Control.Applicative as Appl
import Data.Aeson.Encode as En
import Data.Aeson.Types as AeTypes(Result(..), parse)
import Data.Text.Lazy.Encoding as E
import Data.Text.Lazy as L hiding(foldl, foldr)

{-- -
	Creating different files for different types is probably is the right way. We can't impose structure
	in a single file haskell app?!
--}
data UserJoined  = UserJoined {userNickName ::  T.Text};


parseUserJoined v = UserJoined <$> 
                    v .: "userNickName"


genUserJoined (UserJoined v ) = object [
                        "userNickName" .= v
                        , "commandType" .= ("UserJoined" :: T.Text) ]


instance ToJSON UserJoined where
	toJSON = genUserJoined

instance FromJSON UserJoined where
    parseJSON (Object v) = parseUserJoined v
    parseJSON _          = Appl.empty



userJoined :: T.Text -> IO T.Text
userJoined aText = return $ L.toStrict $ E.decodeUtf8 $ En.encode $ UserJoined aText

