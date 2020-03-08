{-# OPTIONS_GHC -Wall -fno-warn-unused-imports #-}

module WebLesson2 where

-- base
import qualified Data.List as List

-- bytestring
import qualified Data.ByteString            as BS
import qualified Data.ByteString.Lazy       as LBS
import qualified Data.ByteString.Char8      as ASCII
import qualified Data.ByteString.Lazy.Char8 as LASCII
import qualified Data.ByteString.Builder    as BSB

-- network
import           Network.Socket                 (Socket)
import qualified Network.Socket.ByteString      as Socket
import qualified Network.Socket.ByteString.Lazy as LSocket

-- network-simple
import qualified Network.Simple.TCP as NS


--------------------------------------------------------------------------------
--  Lesson 1: Sockets
--------------------------------------------------------------------------------

-- In lesson 1, we introduced sockets and defined this foundation for all
-- of the servers we're going to write. The argument 'f' is how we specify
-- what our server will do each time a new client opens a connection. The
-- connection is represented by a *socket*, to which we can read and write
-- byte strings.

server :: (Socket -> IO ()) -> IO a
server f =
    NS.serve NS.HostAny "8000" $ \(socket, _socketAddress) ->
        f socket


--------------------------------------------------------------------------------
--  Lesson 2: Say Hello to RFC 7230
--------------------------------------------------------------------------------

helloResponse_byteString :: BS.ByteString
helloResponse_byteString =
    asciiLines
        [ "HTTP/1.1 200 OK"
        , "Content-Type: text/plain; charset=us-ascii"
        , "Content-Length: 7"
        , ""
        , "Hello!\n"
        ]

asciiLines :: [String] -> BS.ByteString
asciiLines xs =
    ASCII.pack (List.intercalate "\r\n" xs)

sayHello :: Socket -> IO ()
sayHello socket =
    Socket.sendAll socket helloResponse_byteString
