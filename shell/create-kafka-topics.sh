#!/usr/bin/env bash

set -xe

# -------------------------------------------------------
# -- configuration
# -------------------------------------------------------

KAFKA_ZOOKEEPERS="kafka-cp-zookeeper-headless:2181"
KAFKA_PARTITIONS=1
KAFKA_REPLICATION_FACTOR=1

# -------------------------------------------------------
# -- implementation
# -------------------------------------------------------

# create good topic
kafka-topics --zookeeper "${KAFKA_ZOOKEEPERS}" \
    --create \
    --topic "snowplow-collector-good" \
    --partitions "${KAFKA_PARTITIONS}" \
    --replication-factor "${KAFKA_REPLICATION_FACTOR}" \
    --config compression.type=gzip \
    --if-not-exists

# create bad topic
kafka-topics --zookeeper "${KAFKA_ZOOKEEPERS}" \
    --create \
    --topic "snowplow-collector-bad" \
    --partitions "${KAFKA_PARTITIONS}" \
    --replication-factor "${KAFKA_REPLICATION_FACTOR}" \
    --config compression.type=gzip \
    --if-not-exists

# create enriched topic
kafka-topics --zookeeper "${KAFKA_ZOOKEEPERS}" \
    --create \
    --topic "snowplow-enricher-enriched" \
    --partitions "${KAFKA_PARTITIONS}" \
    --replication-factor "${KAFKA_REPLICATION_FACTOR}" \
    --config compression.type=gzip \
    --if-not-exists

# create enriched bad topic
kafka-topics --zookeeper "${KAFKA_ZOOKEEPERS}" \
    --create \
    --topic "snowplow-enricher-bad" \
    --partitions "${KAFKA_PARTITIONS}" \
    --replication-factor "${KAFKA_REPLICATION_FACTOR}" \
    --config compression.type=gzip \
    --if-not-exists

# create enriched pii topic
kafka-topics --zookeeper "${KAFKA_ZOOKEEPERS}" \
    --create \
    --topic "snowplow-enricher-pii" \
    --partitions "${KAFKA_PARTITIONS}" \
    --replication-factor "${KAFKA_REPLICATION_FACTOR}" \
    --config compression.type=gzip \
    --if-not-exists
