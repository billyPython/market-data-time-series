USE mdts

DELETE FROM ticks_1m
DELETE FROM ticks_5m
DELETE FROM ticks_15m
DELETE FROM ticks_30m
DELETE FROM ticks_1h
DELETE FROM ticks_4h
DELETE FROM ticks_1d
DELETE FROM ticks_1w
DELETE FROM ticks_4w

DROP CONTINUOUS QUERY ticks_1m  ON mdts
DROP CONTINUOUS QUERY ticks_5m  ON mdts
DROP CONTINUOUS QUERY ticks_15m ON mdts
DROP CONTINUOUS QUERY ticks_30m ON mdts
DROP CONTINUOUS QUERY ticks_1h  ON mdts
DROP CONTINUOUS QUERY ticks_4h  ON mdts
DROP CONTINUOUS QUERY ticks_1d  ON mdts
DROP CONTINUOUS QUERY ticks_1w  ON mdts
DROP CONTINUOUS QUERY ticks_4w  ON mdts

CREATE CONTINUOUS QUERY ticks_1m  ON mdts BEGIN SELECT first(symbol) AS symbol, first(open) AS open, max(high) AS high, min(low) AS low, last(close) AS close, sum(volume) AS volume, count(volume) AS tick_volume INTO ticks_1m  FROM ticks GROUP BY time(1m),  symbol END
CREATE CONTINUOUS QUERY ticks_5m  ON mdts BEGIN SELECT first(symbol) AS symbol, first(open) AS open, max(high) AS high, min(low) AS low, last(close) AS close, sum(volume) AS volume, count(volume) AS tick_volume INTO ticks_5m  FROM ticks GROUP BY time(5m),  symbol END
CREATE CONTINUOUS QUERY ticks_15m ON mdts BEGIN SELECT first(symbol) AS symbol, first(open) AS open, max(high) AS high, min(low) AS low, last(close) AS close, sum(volume) AS volume, count(volume) AS tick_volume INTO ticks_15m FROM ticks GROUP BY time(15m), symbol END
CREATE CONTINUOUS QUERY ticks_30m ON mdts BEGIN SELECT first(symbol) AS symbol, first(open) AS open, max(high) AS high, min(low) AS low, last(close) AS close, sum(volume) AS volume, count(volume) AS tick_volume INTO ticks_30m FROM ticks GROUP BY time(30m), symbol END
CREATE CONTINUOUS QUERY ticks_1h  ON mdts BEGIN SELECT first(symbol) AS symbol, first(open) AS open, max(high) AS high, min(low) AS low, last(close) AS close, sum(volume) AS volume, count(volume) AS tick_volume INTO ticks_1h  FROM ticks GROUP BY time(1h),  symbol END
CREATE CONTINUOUS QUERY ticks_4h  ON mdts BEGIN SELECT first(symbol) AS symbol, first(open) AS open, max(high) AS high, min(low) AS low, last(close) AS close, sum(volume) AS volume, count(volume) AS tick_volume INTO ticks_4h  FROM ticks GROUP BY time(4h),  symbol END
CREATE CONTINUOUS QUERY ticks_1d  ON mdts BEGIN SELECT first(symbol) AS symbol, first(open) AS open, max(high) AS high, min(low) AS low, last(close) AS close, sum(volume) AS volume, count(volume) AS tick_volume INTO ticks_1d  FROM ticks GROUP BY time(1d),  symbol END
CREATE CONTINUOUS QUERY ticks_1w  ON mdts BEGIN SELECT first(symbol) AS symbol, first(open) AS open, max(high) AS high, min(low) AS low, last(close) AS close, sum(volume) AS volume, count(volume) AS tick_volume INTO ticks_1w  FROM ticks GROUP BY time(1w),  symbol END
CREATE CONTINUOUS QUERY ticks_4w  ON mdts BEGIN SELECT first(symbol) AS symbol, first(open) AS open, max(high) AS high, min(low) AS low, last(close) AS close, sum(volume) AS volume, count(volume) AS tick_volume INTO ticks_4w  FROM ticks GROUP BY time(4w),  symbol END

SELECT first(symbol) as symbol, first(open) AS open, max(high) AS high, min(low) AS low, last(close) AS close, sum(volume) AS volume, count(volume) AS tick_volume INTO ticks_4w  FROM ticks GROUP BY time(4w),  symbol
SELECT first(symbol) as symbol, first(open) AS open, max(high) AS high, min(low) AS low, last(close) AS close, sum(volume) AS volume, count(volume) AS tick_volume INTO ticks_1w  FROM ticks GROUP BY time(1w),  symbol
SELECT first(symbol) as symbol, first(open) AS open, max(high) AS high, min(low) AS low, last(close) AS close, sum(volume) AS volume, count(volume) AS tick_volume INTO ticks_1d  FROM ticks GROUP BY time(1d),  symbol
SELECT first(symbol) as symbol, first(open) AS open, max(high) AS high, min(low) AS low, last(close) AS close, sum(volume) AS volume, count(volume) AS tick_volume INTO ticks_4h  FROM ticks GROUP BY time(4h),  symbol
SELECT first(symbol) as symbol, first(open) AS open, max(high) AS high, min(low) AS low, last(close) AS close, sum(volume) AS volume, count(volume) AS tick_volume INTO ticks_1h  FROM ticks GROUP BY time(1h),  symbol
SELECT first(symbol) as symbol, first(open) AS open, max(high) AS high, min(low) AS low, last(close) AS close, sum(volume) AS volume, count(volume) AS tick_volume INTO ticks_30m FROM ticks GROUP BY time(30m), symbol
SELECT first(symbol) as symbol, first(open) AS open, max(high) AS high, min(low) AS low, last(close) AS close, sum(volume) AS volume, count(volume) AS tick_volume INTO ticks_15m FROM ticks GROUP BY time(15m), symbol
SELECT first(symbol) as symbol, first(open) AS open, max(high) AS high, min(low) AS low, last(close) AS close, sum(volume) AS volume, count(volume) AS tick_volume INTO ticks_5m  FROM ticks GROUP BY time(5m),  symbol
SELECT first(symbol) as symbol, first(open) AS open, max(high) AS high, min(low) AS low, last(close) AS close, sum(volume) AS volume, count(volume) AS tick_volume INTO ticks_1m  FROM ticks GROUP BY time(1m),  symbol
