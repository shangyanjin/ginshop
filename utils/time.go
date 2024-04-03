package utils

import (
	"database/sql/driver"
	"fmt"
	"strconv"
	"time"
)

//重写 gorm time.Time 实现时间类型自动匹配

const TimeFormat = "2006-01-02 15:04:05"

type Time time.Time

// UnmarshalJSON 1. 为 Xtime 重写 UnmarshalJSON 方法，在此方法中实现自定义格式的转换；
func (t *Time) UnmarshalJSON(data []byte) (err error) {
	num, err := strconv.Atoi(string(data))
	if err != nil {
		return err
	}
	*t = Time(time.Unix(int64(num), 0))
	return
}

// MarshalJSON 2. 为 Xtime 重写 MarshaJSON 方法，在此方法中实现自定义格式的转换；
func (t Time) MarshalJSON() ([]byte, error) {
	return ([]byte)(strconv.FormatInt(time.Time(t).Unix(), 10)), nil
}

// Value 3. 为 Time 实现 Value 方法，写入数据库时会调用该方法将自定义时间类型转换并写入数据库；
func (t Time) Value() (driver.Value, error) {
	const (
		TimeStamp  = iota // 时间戳
		TimeString        // 时间字符串
	)

	var DefaultTimeType = TimeString
	if DefaultTimeType == TimeString {
		var zeroTime time.Time
		if time.Time(t).Unix() == zeroTime.UnixNano() {
			return nil, nil
		}
		return time.Time(t), nil //数据库字段 时间字符串
	}
	//默认时间戳
	return time.Time(t).Unix(), nil //数据库字段 时间戳
}

// Scan 4. 为 Time 实现 Scan 方法，读取数据库时会调用该方法将时间数据转换成自定义时间类型；
func (t *Time) Scan(v interface{}) error {

	switch value := v.(type) {
	case int64:
		*t = Time(time.Unix(value, 0))
	case string:
		parsedTime, err := time.Parse(TimeFormat, value)
		if err != nil {
			return err
		}
		*t = Time(parsedTime)
	case []byte:
		return t.Scan(string(value))
	case time.Time:
		*t = Time(value)
	default:
		return fmt.Errorf("can not convert %v to timestamp", v)
	}
	return nil
}
