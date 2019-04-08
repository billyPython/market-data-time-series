DROP CONTINUOUS QUERY ticks_1m  ON mdts
DROP CONTINUOUS QUERY ticks_5m  ON mdts
DROP CONTINUOUS QUERY ticks_15m ON mdts
DROP CONTINUOUS QUERY ticks_30m ON mdts
DROP CONTINUOUS QUERY ticks_1h  ON mdts
DROP CONTINUOUS QUERY ticks_4h  ON mdts
DROP CONTINUOUS QUERY ticks_1d  ON mdts
DROP CONTINUOUS QUERY ticks_1w  ON mdts
DROP CONTINUOUS QUERY ticks_4w  ON mdts

CREATE CONTINUOUS QUERY ticks_1m  ON mdts BEGIN SELECT first(symbol), first(open) AS open, max(high) AS high, min(low) AS low, last(close) AS close, sum(volume) AS volume INTO ticks_1m  FROM ticks GROUP BY time(1m),  symbol END
CREATE CONTINUOUS QUERY ticks_5m  ON mdts BEGIN SELECT first(symbol), first(open) AS open, max(high) AS high, min(low) AS low, last(close) AS close, sum(volume) AS volume INTO ticks_5m  FROM ticks GROUP BY time(5m),  symbol END
CREATE CONTINUOUS QUERY ticks_15m ON mdts BEGIN SELECT first(symbol), first(open) AS open, max(high) AS high, min(low) AS low, last(close) AS close, sum(volume) AS volume INTO ticks_15m FROM ticks GROUP BY time(15m), symbol END
CREATE CONTINUOUS QUERY ticks_30m ON mdts BEGIN SELECT first(symbol), first(open) AS open, max(high) AS high, min(low) AS low, last(close) AS close, sum(volume) AS volume INTO ticks_30m FROM ticks GROUP BY time(30m), symbol END
CREATE CONTINUOUS QUERY ticks_1h  ON mdts BEGIN SELECT first(symbol), first(open) AS open, max(high) AS high, min(low) AS low, last(close) AS close, sum(volume) AS volume INTO ticks_1h  FROM ticks GROUP BY time(1h),  symbol END
CREATE CONTINUOUS QUERY ticks_4h  ON mdts BEGIN SELECT first(symbol), first(open) AS open, max(high) AS high, min(low) AS low, last(close) AS close, sum(volume) AS volume INTO ticks_4h  FROM ticks GROUP BY time(4h),  symbol END
CREATE CONTINUOUS QUERY ticks_1d  ON mdts BEGIN SELECT first(symbol), first(open) AS open, max(high) AS high, min(low) AS low, last(close) AS close, sum(volume) AS volume INTO ticks_1d  FROM ticks GROUP BY time(1d),  symbol END
CREATE CONTINUOUS QUERY ticks_1w  ON mdts BEGIN SELECT first(symbol), first(open) AS open, max(high) AS high, min(low) AS low, last(close) AS close, sum(volume) AS volume INTO ticks_1w  FROM ticks GROUP BY time(1w),  symbol END
CREATE CONTINUOUS QUERY ticks_4w  ON mdts BEGIN SELECT first(symbol), first(open) AS open, max(high) AS high, min(low) AS low, last(close) AS close, sum(volume) AS volume INTO ticks_4w  FROM ticks GROUP BY time(4w),  symbol END
