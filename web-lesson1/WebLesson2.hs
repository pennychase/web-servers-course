{-# OPTIONS_GHC -Wall #-}

module WebLesson1 where

-- network
import Network.Socket (Socket)

-- network-simple
import qualified Network.Simple.TCP as NS


--------------------------------------------------------------------------------
--  Lesson 1: Sockets
--------------------------------------------------------------------------------

server :: (Socket -> IO ()) -> IO a
server f =
    NS.serve NS.HostAny "8000" $ \(socket, _socketAddress) ->
        f socket
