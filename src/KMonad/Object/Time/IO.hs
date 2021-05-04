module KMonad.Object.Time.IO

where

import KMonad.Prelude
import KMonad.Object.Time.Types
import KMonad.Object.Time.Operations

import qualified RIO.Time as T
import qualified Data.Time.Clock.System as T (getSystemTime)

--------------------------------------------------------------------------------
-- $io-tools

-- | Return the current time
getCurrentTime :: IO m => m Time
getCurrentTime = Time <$> T.getCurrentTime

-- | Return the current system-time (faster than getting time and converting)
getCurrentSystemTime :: IO m => m SystemTime
getCurrentSystemTime = liftIO T.getSystemTime

-- | Pause computation for some time
wait :: IO m => Ms -> m ()
wait = threadDelay . (1000*) . fromIntegral

-- | Create a tick every n deciseconds
metronome :: IO m => Ms -> m (m Time)
metronome d = pure $ wait (d * 100) >> getCurrentTime

