{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -Wno-missing-safe-haskell-mode #-}
module Paths_reimman_hs (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/liam/.cabal/bin"
libdir     = "/home/liam/.cabal/lib/x86_64-linux-ghc-9.0.2/reimman-hs-0.1.0.0-inplace-reimman-hs"
dynlibdir  = "/home/liam/.cabal/lib/x86_64-linux-ghc-9.0.2"
datadir    = "/home/liam/.cabal/share/x86_64-linux-ghc-9.0.2/reimman-hs-0.1.0.0"
libexecdir = "/home/liam/.cabal/libexec/x86_64-linux-ghc-9.0.2/reimman-hs-0.1.0.0"
sysconfdir = "/home/liam/.cabal/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "reimman_hs_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "reimman_hs_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "reimman_hs_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "reimman_hs_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "reimman_hs_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "reimman_hs_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
