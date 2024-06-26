{-# OPTIONS_GHC -Wno-dodgy-exports #-}
{-# OPTIONS_GHC -Wno-orphans #-}
{-# OPTIONS_GHC -Wno-unused-imports #-}

module Storage.Queries.Ride (module Storage.Queries.Ride, module ReExport) where

import qualified Domain.Types.Booking.Type
import qualified Domain.Types.Ride
import Kernel.Beam.Functions
import Kernel.External.Encryption
import Kernel.Prelude
import Kernel.Types.Error
import qualified Kernel.Types.Id
import Kernel.Utils.Common (CacheFlow, EsqDBFlow, MonadFlow, fromMaybeM, getCurrentTime)
import qualified Sequelize as Se
import qualified Storage.Beam.Ride as Beam
import Storage.Queries.RideExtra as ReExport

findByBPPRideId :: (EsqDBFlow m r, MonadFlow m, CacheFlow m r) => (Kernel.Types.Id.Id Domain.Types.Ride.BPPRide -> m (Maybe Domain.Types.Ride.Ride))
findByBPPRideId (Kernel.Types.Id.Id bppRideId) = do findOneWithKV [Se.Is Beam.bppRideId $ Se.Eq bppRideId]

findById :: (EsqDBFlow m r, MonadFlow m, CacheFlow m r) => (Kernel.Types.Id.Id Domain.Types.Ride.Ride -> m (Maybe Domain.Types.Ride.Ride))
findById (Kernel.Types.Id.Id id) = do findOneWithKV [Se.Is Beam.id $ Se.Eq id]

findByRBId :: (EsqDBFlow m r, MonadFlow m, CacheFlow m r) => (Kernel.Types.Id.Id Domain.Types.Booking.Type.Booking -> m (Maybe Domain.Types.Ride.Ride))
findByRBId (Kernel.Types.Id.Id bookingId) = do findOneWithKV [Se.Is Beam.bookingId $ Se.Eq bookingId]

findRideByRideShortId :: (EsqDBFlow m r, MonadFlow m, CacheFlow m r) => (Kernel.Types.Id.ShortId Domain.Types.Ride.Ride -> m (Maybe Domain.Types.Ride.Ride))
findRideByRideShortId (Kernel.Types.Id.ShortId shortId) = do findOneWithKV [Se.Is Beam.shortId $ Se.Eq shortId]
