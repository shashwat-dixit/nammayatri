ALTER TABLE atlas_driver_offer_bpp.transporter_config ADD COLUMN driver_location_accuracy_buffer Int DEFAULT 10 NOT NULL;
ALTER TABLE atlas_driver_offer_bpp.transporter_config ADD COLUMN route_deviation_threshold Int DEFAULT 50 NOT NULL;