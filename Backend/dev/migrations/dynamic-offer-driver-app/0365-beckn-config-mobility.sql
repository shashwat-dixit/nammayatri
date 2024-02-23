INSERT INTO
    atlas_driver_offer_bpp.beckn_config (
        id,
        domain,
        gateway_url,
        registry_url,
        subscriber_id,
        subscriber_url,
        merchant_id,
        merchant_operating_city_id,
        unique_key_id,
        created_at,
        updated_at,
        vehicle_category,
        on_search_ttl_sec,
        on_select_ttl_sec,
        on_init_ttl_sec,
        on_confirm_ttl_sec
    )
VALUES
    (
        'dd22a05d-29a3-42c8-9c8d-2de340f9b610',
        'MOBILITY',
        'http://localhost:8015/v1',
        'http://localhost:8020',
        'localhost:8013/beckn/cab/v1/da4e23a5-3ce6-4c37-8b9b-41377c3c1a52',
        'http://localhost:8013/beckn/cab/v1/da4e23a5-3ce6-4c37-8b9b-41377c3c1a52',
        'favorit0-0000-0000-0000-00000favorit',
        null,
        'localhost:8013/beckn/cab/v1/da4e23a5-3ce6-4c37-8b9b-41377c3c1a52',
        now(),
        now(),
        'AUTO_RICKSHAW',
        120,
        120,
        120,
        120
    ),
    (
        'dd22a05d-29a3-42c8-9c8d-2de340f9b609',
        'MOBILITY',
        'http://localhost:8015/v1',
        'http://localhost:8020',
        'localhost:8013/beckn/cab/v1/da4e23a5-3ce6-4c37-8b9b-41377c3c1a52',
        'http://localhost:8013/beckn/cab/v1/da4e23a5-3ce6-4c37-8b9b-41377c3c1a52',
        'favorit0-0000-0000-0000-00000favorit',
        null,
        'localhost:8013/beckn/cab/v1/da4e23a5-3ce6-4c37-8b9b-41377c3c1a52',
        now(),
        now(),
        'CAB',
        120,
        120,
        120,
        120
    );

UPDATE atlas_driver_offer_bpp.beckn_config
SET payment_params_json = '{"bankAccNumber": "xyz@upi","bankCode": "xyz"}'
WHERE domain = 'MOBILITY';