module Test.Main where

import Control.Monad.Eff
import Control.Monad.Eff.Class

import Control.Monad.Maybe.Trans
import Control.Monad.Error.Trans
import Control.Monad.State.Trans
import Control.Monad.Writer.Trans
import Control.Monad.Reader.Trans
import Control.Monad.RWS.Trans

import Debug.Trace

main :: Eff (trace :: Trace) Unit
main = do
  liftEff $ trace "Testing Eff"
  void $ runMaybeT $ liftEff $ trace "Testing MaybeT"
  void $ runErrorT $ liftEff $ trace "Testing ErrorT"
  void $ flip runStateT 0 $ liftEff $ trace "Testing StateT"
  void $ runWriterT (liftEff (trace "Testing WriterT") :: WriterT String _ _) 
  flip runReaderT unit $ liftEff $ trace "Testing ReaderT"
  void $ runRWST (liftEff (trace "Testing RWST") :: RWST _ String _ _ _) unit 0

  void $ flip runStateT 0 $ flip runReaderT unit $ runErrorT $ liftEff $ trace "Testing StateT, ReaderT, ErrorT"
