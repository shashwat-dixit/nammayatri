{-
  Copyright 2022-23, Juspay India Pvt Ltd

  This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License

  as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version. This program

  is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY

  or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details. You should have received a copy of

  the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.
-}
{-# LANGUAGE DerivingStrategies #-}
{-# LANGUAGE TemplateHaskell #-}
{-# OPTIONS_GHC -Wno-orphans #-}

module Storage.Beam.DriverStats where

import qualified Data.Aeson as A
import qualified Data.HashMap.Internal as HM
import qualified Data.Map.Strict as M
import Data.Serialize
import qualified Data.Time as Time
import qualified Database.Beam as B
import Database.Beam.MySQL ()
import EulerHS.KVConnector.Types (KVConnector (..), MeshMeta (..), primaryKey, secondaryKeys, tableName)
import GHC.Generics (Generic)
import Kernel.Prelude hiding (Generic)
import Kernel.Types.Common hiding (id)
import Lib.Utils ()
import Lib.UtilsTH
import Sequelize

data DriverStatsT f = DriverStatsT
  { driverId :: B.C f Text,
    idleSince :: B.C f Time.UTCTime,
    totalRides :: B.C f Int,
    totalEarnings :: B.C f Money,
    bonusEarned :: B.C f Money,
    lateNightTrips :: B.C f Int,
    earningsMissed :: B.C f Money,
    totalDistance :: B.C f Double,
    ridesCancelled :: B.C f (Maybe Int),
    totalRidesAssigned :: B.C f (Maybe Int),
    updatedAt :: B.C f Time.UTCTime
  }
  deriving (Generic, B.Beamable)

instance B.Table DriverStatsT where
  data PrimaryKey DriverStatsT f
    = Id (B.C f Text)
    deriving (Generic, B.Beamable)
  primaryKey = Id . driverId

instance ModelMeta DriverStatsT where
  modelFieldModification = driverStatsTMod
  modelTableName = "driver_stats"
  modelSchemaName = Just "atlas_driver_offer_bpp"

type DriverStats = DriverStatsT Identity

instance FromJSON DriverStats where
  parseJSON = A.genericParseJSON A.defaultOptions

instance ToJSON DriverStats where
  toJSON = A.genericToJSON A.defaultOptions

deriving stock instance Show DriverStats

driverStatsTMod :: DriverStatsT (B.FieldModification (B.TableField DriverStatsT))
driverStatsTMod =
  B.tableModification
    { driverId = B.fieldNamed "driver_id",
      idleSince = B.fieldNamed "idle_since",
      totalRides = B.fieldNamed "total_rides",
      totalDistance = B.fieldNamed "total_distance",
      ridesCancelled = B.fieldNamed "rides_cancelled",
      totalRidesAssigned = B.fieldNamed "total_rides_assigned",
      totalEarnings = B.fieldNamed "total_earnings",
      bonusEarned = B.fieldNamed "bonus_earned",
      lateNightTrips = B.fieldNamed "late_night_trips",
      earningsMissed = B.fieldNamed "earnings_missed",
      updatedAt = B.fieldNamed "updated_at"
    }

psToHs :: HM.HashMap Text Text
psToHs = HM.empty

driverStatsToHSModifiers :: M.Map Text (A.Value -> A.Value)
driverStatsToHSModifiers =
  M.empty

driverStatsToPSModifiers :: M.Map Text (A.Value -> A.Value)
driverStatsToPSModifiers =
  M.empty

instance Serialize DriverStats where
  put = error "undefined"
  get = error "undefined"

$(enableKVPG ''DriverStatsT ['driverId] [])