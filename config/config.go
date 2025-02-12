package config

import (
	"fmt"
	"log"
	"os"
	"path"
	"strconv"
	"strings"
	"time"

	"github.com/go-ini/ini"
	"github.com/sirupsen/logrus"
	"gorm.io/gorm"
)

var (
	DB            *gorm.DB
	DynamicConfig map[string]interface{}
)

const (
	PageSizeBackend = 10
	DbMysql         = "mysql"
	DbSqlite        = "sqlite"
	DbPostgres      = "postgres"

	UserIdKey     = "userId"
	AdminIdKey    = "adminId"
	UserTokenKey  = "token"
	AdminTokenKey = "adminToken"

	PackageName       = "model"
	GenRootPath       = "./public/builder"
	RemoveTablePrefix = 1
)

// ConfigSection is a type alias for a map of strings to interfaces
type ConfigSection map[string]interface{}

func init() {
	err := InitConfig()
	if err != nil {
		log.Fatalf("Error initializing config: %v", err)
	}
}

func InitConfig() error {
	conf := "config.ini"
	cfg, err := ini.Load(conf)
	if err != nil {
		return fmt.Errorf("failed to load config file: %w", err)
	}

	DynamicConfig = make(map[string]interface{})

	for _, section := range cfg.Sections() {
		sectionName := section.Name()
		if sectionName == ini.DefaultSection {
			continue
		}

		sectionMap := make(ConfigSection)
		for _, key := range section.Keys() {
			sectionMap[key.Name()] = key.String()
		}
		DynamicConfig[sectionName] = sectionMap
	}

	// Ensure public path is absolute
	publicPath := GetString("server.public")
	if publicPath != "" && !path.IsAbs(publicPath) {
		workingDir, err := os.Getwd()
		if err != nil {
			return fmt.Errorf("failed to get working directory: %w", err)
		}
		if sectionMap, ok := DynamicConfig["server"].(ConfigSection); ok {
			sectionMap["public"] = path.Join(workingDir, publicPath)
		}
	}

	return nil
}

// PublicPath returns path to application public folder
func PublicPath() string {
	return GetString("server.public")
}

// GetUploadPath returns path to the img directory
func GetUploadPath() string {
	return path.Join(strings.TrimSpace(GetString("server.public")), "img")
}

// UploadsPath returns path to public/img folder
func UploadsPath() string {
	return path.Join(GetString("server.public"), "img")
}

// GetConnectionString returns a database connection string
func GetConnectionString() string {
	return fmt.Sprintf("%s:%s@tcp(%s:%s)/%s?charset=utf8&parseTime=True&loc=Local",
		GetString("mysql.user"),
		GetString("mysql.password"),
		GetString("mysql.host"),
		GetString("mysql.port"),
		GetString("mysql.db"),
	)
}

func get(key string) interface{} {
	parts := strings.Split(key, ".")
	if len(parts) != 2 {
		logrus.Warnf("Invalid config key format: %s (should be 'section.key')", key)
		return nil
	}
	section, key := parts[0], parts[1]

	sectionMap, ok := DynamicConfig[section]
	if !ok {
		logrus.Warnf("Config section not found: %s", section)
		return nil
	}

	configSection, ok := sectionMap.(ConfigSection)
	if !ok {
		logrus.Warnf("Invalid section type for: %s", section)
		return nil
	}

	value, exists := configSection[key]
	if !exists {
		logrus.Warnf("Config key not found: %s in section %s", key, section)
		return nil
	}

	return value
}

func GetString(key string, defaultValue ...string) string {
	if value := get(key); value != nil {
		if str, ok := value.(string); ok {
			return str
		}
	}
	if len(defaultValue) > 0 {
		return defaultValue[0]
	}
	return ""
}

func GetInt(key string, defaultValue ...int) int {
	if value := get(key); value != nil {
		if str, ok := value.(string); ok {
			if i, err := strconv.Atoi(str); err == nil {
				return i
			}
		}
	}
	if len(defaultValue) > 0 {
		return defaultValue[0]
	}
	return 0
}

func GetBool(key string, defaultValue ...bool) bool {
	if value := get(key); value != nil {
		if str, ok := value.(string); ok {
			b, err := strconv.ParseBool(str)
			if err == nil {
				return b
			}
		}
	}
	if len(defaultValue) > 0 {
		return defaultValue[0]
	}
	return false
}

// Add helper functions for different types
func GetDuration(key string, defaultValue ...time.Duration) time.Duration {
	if value := get(key); value != nil {
		if str, ok := value.(string); ok {
			if d, err := time.ParseDuration(str); err == nil {
				return d
			}
		}
	}
	if len(defaultValue) > 0 {
		return defaultValue[0]
	}
	return 0
}

func GetFloat64(key string, defaultValue ...float64) float64 {
	if value := get(key); value != nil {
		if str, ok := value.(string); ok {
			if f, err := strconv.ParseFloat(str, 64); err == nil {
				return f
			}
		}
	}
	if len(defaultValue) > 0 {
		return defaultValue[0]
	}
	return 0
}

func GetFloat(key string, defaultValue ...float32) float32 {
	if value := get(key); value != nil {
		if str, ok := value.(string); ok {
			if f, err := strconv.ParseFloat(str, 32); err == nil {
				return float32(f)
			}
		}
	}
	if len(defaultValue) > 0 {
		return defaultValue[0]
	}
	return 0
}
