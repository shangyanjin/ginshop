package config

import (
	"fmt"
	"github.com/spf13/viper"
	"os"
	"path"
	"time"
)

// Configs contains application configurations for all gin modes
type Configs struct {
	Debug   Config
	Release Config
}

// Config contains application configuration for active gin mode
type Config struct {
	Public        string `json:"public"`
	Domain        string `json:"domain"`
	SessionSecret string `json:"session_secret"`
	SignupEnabled bool   `json:"signup_enabled"` //always set to false in release mode (config.toml)
	Database DatabaseConfig
	SMTP     SMTPConfig

	DBHost     string `mapstructure:"POSTGRES_HOST"`
	DBUsername string `mapstructure:"POSTGRES_USER"`
	DBPassword string `mapstructure:"POSTGRES_PASSWORD"`
	DBName     string `mapstructure:"POSTGRES_DB"`
	DBPort     string `mapstructure:"POSTGRES_PORT"`

	ServerPort string `mapstructure:"PORT"`

	TokenSecret    string        `mapstructure:"TOKEN_SECRET"`
	TokenExpiresIn time.Duration `mapstructure:"TOKEN_EXPIRED_IN"`
	TokenMaxAge    int           `mapstructure:"TOKEN_MAXAGE"`
}

// DatabaseConfig contains database connection info
type DatabaseConfig struct {
	Host     string
	Port     string
	Db       string //database name
	User     string
	Password string
}

// SMTPConfig contains smtp mailer info
type SMTPConfig struct {
	From     string //from email
	SMTP     string //smtp server address
	Port     string //smtp port
	User     string //smtp user login
	Password string //smtp user password
}

// current loaded config
var config Config


func LoadConfig()  *Config{
	viper.SetConfigName("config") // name of config file (without extension)
	viper.SetConfigType("toml")   // REQUIRED if the config file does not have the extension in the name
	viper.AddConfigPath(".")      // optionally look for config in the working directory
	err := viper.ReadInConfig()   // Find and read the config file
	if err != nil {               // Handle errors reading the config file
		panic(fmt.Errorf("Fatal error config file: %w \n", err))
	}

	err = viper.Unmarshal(&config)
	if err != nil {
		panic(fmt.Errorf("unable to decode into struct, %v", err))
	}

	if !path.IsAbs(config.Public) {
		workingDir, err := os.Getwd()
		if err != nil {
			panic(err)
		}
		config.Public = path.Join(workingDir, config.Public)
	}
	return &config
}


// GetConfig returns actual config
func GetConfig() *Config {
	return &config
}

// PublicPath returns path to application public folder
func PublicPath() string {
	return config.Public
}

// UploadsPath returns path to public/uploads folder
func UploadsPath() string {
	return path.Join(config.Public, "uploads")
}

// GetConnectionString returns a database connection string
func GetConnectionString() string {
	//dsn := fmt.Sprintf("%s:%s@tcp(%s:%s)/%s?charset=utf8&parseTime=True&loc=Local",
	//	config.Database.User,
	//	config.Database.Password,
	//	config.Database.Host,
	//	config.Database.Port,
	//	config.Database.Name,
	//)
	//return dsn
	return fmt.Sprintf("host=%s user=%s password=%s dbname=%s sslmode=disable",
		config.Database.Host,
		config.Database.User,
		config.Database.Password,
		config.Database.Db)
}
