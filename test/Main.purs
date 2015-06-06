module Test.Main where

import Prelude

import Console
import Control.Monad.Eff
import Control.Monad.Eff.Class
import Control.Monad.Error.Trans
import Control.Monad.Maybe.Trans
import Control.Monad.Reader.Trans
import Control.Monad.RWS.Trans
import Control.Monad.State.Trans
import Control.Monad.Writer.Trans
import Data.String ()

main :: Eff (console :: CONSOLE) Unit
main = do
  liftEff $ log "Testing Eff"
  void $ runMaybeT $ liftEff $ log "Testing MaybeT"
  void $ runErrorT $ liftEff $ log "Testing ErrorT"
  void $ flip runStateT 0 $ liftEff $ log "Testing StateT"
  void $ runWriterT (liftEff (log "Testing WriterT") :: WriterT String _ _)
  flip runReaderT unit $ liftEff $ log "Testing ReaderT"
  void $ runRWST (liftEff (log "Testing RWST") :: RWST _ String _ _ _) unit 0

  void $ flip runStateT 0 $ flip runReaderT unit $ runErrorT $ liftEff $ log "Testing StateT, ReaderT, ErrorT"
