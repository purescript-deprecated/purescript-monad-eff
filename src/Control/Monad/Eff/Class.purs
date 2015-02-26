module Control.Monad.Eff.Class 
  ( MonadEff
  , liftEff
  ) where

import Data.Monoid

import Control.Monad.Eff

import Control.Monad.Maybe.Trans
import Control.Monad.Error.Trans
import Control.Monad.State.Trans
import Control.Monad.Writer.Trans
import Control.Monad.Reader.Trans
import Control.Monad.RWS.Trans
import Control.Monad.Trans

class (Monad m) <= MonadEff eff m where
  liftEff :: forall a. Eff eff a -> m a

instance monadEffEff :: MonadEff eff (Eff eff) where
  liftEff = id

instance monadEffMaybe :: (Monad m, MonadEff eff m) => MonadEff eff (MaybeT m) where
  liftEff = lift <<< liftEff

instance monadEffError :: (Monad m, MonadEff eff m) => MonadEff eff (ErrorT e m) where
  liftEff = lift <<< liftEff

instance monadEffState :: (Monad m, MonadEff eff m) => MonadEff eff (StateT s m) where
  liftEff = lift <<< liftEff

instance monadEffWriter :: (Monad m, Monoid w, MonadEff eff m) => MonadEff eff (WriterT w m) where
  liftEff = lift <<< liftEff

instance monadEffReader :: (Monad m, MonadEff eff m) => MonadEff eff (ReaderT r m) where
  liftEff = lift <<< liftEff

instance monadEffRWS :: (Monad m, Monoid w, MonadEff eff m) => MonadEff eff (RWST r w s m) where
  liftEff = lift <<< liftEff


