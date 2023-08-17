{-
  Copyright 2022-23, Juspay India Pvt Ltd

  This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License

  as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version. This program

  is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY

  or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details. You should have received a copy of

  the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.
-}
{-# LANGUAGE DerivingStrategies #-}
{-# LANGUAGE StandaloneDeriving #-}
{-# LANGUAGE TemplateHaskell #-}
{-# OPTIONS_GHC -Wno-missing-signatures #-}
{-# OPTIONS_GHC -Wno-orphans #-}

module Storage.Beam.HotSpotConfig where

import Data.Serialize
import qualified Database.Beam as B
import Database.Beam.MySQL ()
import EulerHS.KVConnector.Types (KVConnector (..), MeshMeta (..), primaryKey, secondaryKeys, tableName)
import GHC.Generics (Generic)
import Kernel.Prelude hiding (Generic)
import Lib.UtilsTH
import Sequelize

data HotSpotConfigT f = HotSpotConfigT
  { id :: B.C f Text,
    hotSpotGeoHashPrecision :: B.C f Int,
    blockRadius :: B.C f Int,
    minFrequencyOfHotSpot :: B.C f Int,
    nearbyGeohashPrecision :: B.C f Int,
    weightOfManualPickup :: B.C f Int,
    weightOfManualSaved :: B.C f Int,
    weightOfAutoPickup :: B.C f Int,
    weightOfAutoSaved :: B.C f Int,
    weightOfTripStart :: B.C f Int,
    weightOfTripEnd :: B.C f Int,
    weightOfSpecialLocation :: B.C f Int,
    shouldTakeHotSpot :: B.C f Bool,
    maxNumHotSpotsToShow :: B.C f Int
  }
  deriving (Generic, B.Beamable)

instance B.Table HotSpotConfigT where
  data PrimaryKey HotSpotConfigT f
    = Id (B.C f Text)
    deriving (Generic, B.Beamable)
  primaryKey = Id . id

type HotSpotConfig = HotSpotConfigT Identity

hotSpotConfigTMod :: HotSpotConfigT (B.FieldModification (B.TableField HotSpotConfigT))
hotSpotConfigTMod =
  B.tableModification
    { id = B.fieldNamed "id",
      hotSpotGeoHashPrecision = B.fieldNamed "hot_spot_geo_hash_precision",
      blockRadius = B.fieldNamed "block_radius",
      minFrequencyOfHotSpot = B.fieldNamed "min_frequency_of_hot_spot",
      nearbyGeohashPrecision = B.fieldNamed "nearby_geohash_precision",
      weightOfManualPickup = B.fieldNamed "weight_of_manual_pickup",
      weightOfManualSaved = B.fieldNamed "weight_of_manual_saved",
      weightOfAutoPickup = B.fieldNamed "weight_of_auto_pickup",
      weightOfAutoSaved = B.fieldNamed "weight_of_auto_saved",
      weightOfTripStart = B.fieldNamed "weight_of_trip_start",
      weightOfTripEnd = B.fieldNamed "weight_of_trip_end",
      weightOfSpecialLocation = B.fieldNamed "weight_of_special_location",
      shouldTakeHotSpot = B.fieldNamed "should_take_hot_spot",
      maxNumHotSpotsToShow = B.fieldNamed "max_num_hot_spots_to_show"
    }

defaultHotSpotConfig :: HotSpotConfig
defaultHotSpotConfig =
  HotSpotConfigT
    { id = "",
      hotSpotGeoHashPrecision = 0,
      blockRadius = 0,
      minFrequencyOfHotSpot = 0,
      nearbyGeohashPrecision = 0,
      weightOfManualPickup = 0,
      weightOfManualSaved = 0,
      weightOfAutoPickup = 0,
      weightOfAutoSaved = 0,
      weightOfTripStart = 0,
      weightOfTripEnd = 0,
      weightOfSpecialLocation = 0,
      shouldTakeHotSpot = False,
      maxNumHotSpotsToShow = 0
    }

$(enableKVPG ''HotSpotConfigT ['id] [])

$(mkTableInstances ''HotSpotConfigT "hot_spot_config" "atlas_app")