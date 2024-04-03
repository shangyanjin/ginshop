package config

import (
	"fmt"
	"os"
	"path"
	"time"

	"github.com/spf13/viper"
)

var Config ConfigConfiguration

// Config contains application configuration for active gin mode
type ConfigConfiguration struct {
	Server   ServerConfiguration
	Database DatabaseConfiguration
	Redis    RedisConfiguration  `mapstructure:"redis"`
	Jwt      JwtConfiguration    `mapstructure:"jwt"`
	File     FileConfiguration   `mapstructure:"file"`
	Mail     MailConfiguration   `mapstructure:"mail"`
	Alipay   AlipayConfiguration `mapstructure:"alipay"`
}

// ServerConfiguration contains server configuration
type ServerConfiguration struct {
	Host               string        `mapstructure:"host"`
	Port               string        `mapstructure:"port"`
	Mode               string        `mapstructure:"mode"`
	Public             string        `mapstructure:"public"`
	Domain             string        `mapstructure:"domain"`
	SessionSecret      string        `mapstructure:"session_secret"`
	SigningKey         string        `mapstructure:"signing_key"`
	SignUpEnabled      bool          `mapstructure:"signup_enabled"`
	PublicURL          string        `mapstructure:"publicurl"`
	PublicPrefix       string        `mapstructure:"publicprefix"`
	TokenSecret        string        `mapstructure:"token_secret"`
	TokenExpiresIn     time.Duration `mapstructure:"token_expired_in"`
	TokenMaxAge        int           `mapstructure:"token_maxage"`
	GoogleClientID     string        `mapstructure:"google_client_id"`
	GoogleClientSecret string        `mapstructure:"google_client_secret"`
	InitSqlFile        string        `mapstructure:"init_sql_file"`
}

// DatabaseConfiguration contains database connection info
type DatabaseConfiguration struct {
	Host        string
	Port        string
	Db          string //database name
	User        string
	Password    string
	TablePrefix string //table prefix
}

// MailConfiguration contains smtp mailer info
type MailConfiguration struct {
	From     string //from email
	SMTP     string //smtp server address
	Port     string //smtp port
	User     string //smtp user login
	Password string //smtp user password
}

// RedisConfiguration contains Redis connection info
type RedisConfiguration struct {
	Host     string `mapstructure:"host"`
	Port     int    `mapstructure:"port"`
	Password string `mapstructure:"password"`
	Database int    `mapstructure:"database"`
}

// JwtConfiguration contains JWT configuration
type JwtConfiguration struct {
	SigningKey  string `mapstructure:"signing_key"`
	ExpiredTime int    `mapstructure:"expired_time"`
}

// FileConfiguration contains file storage configuration
type FileConfiguration struct {
	Path string `mapstructure:"path"`
}

// AlipayConfiguration contains Alipay configuration
type AlipayConfiguration struct {
	AppId            string `mapstructure:"app_id"`
	PrivateKey       string `mapstructure:"private_key"`
	AppPublicCert    string `mapstructure:"app_public_cert"`
	AlipayRootCert   string `mapstructure:"alipay_root_cert"`
	AlipayPublicCert string `mapstructure:"alipay_public_cert"`
	ReturnURL        string `mapstructure:"return_url"`
	NotifyURL        string `mapstructure:"notify_url"`
	TradePagePay     string `mapstructure:"trade_page_pay"`
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

func InitConfig() *ConfigConfiguration {
	viper.SetConfigName("config.toml") // name of config file (without extension)
	viper.SetConfigType("toml")        // REQUIRED if the config file does not have the extension in the name
	viper.AddConfigPath(".")           // optionally look for config in the working directory
	err := viper.ReadInConfig()        // Find and read the config file
	if err != nil {                    // Handle errors reading the config file
		panic(fmt.Errorf("Fatal error config file: %w \n", err))
	}

	err = viper.Unmarshal(&Config)
	if err != nil {
		panic(fmt.Errorf("unable to decode into struct, %v", err))
	}

	if !path.IsAbs(Config.Server.Public) {
		workingDir, err := os.Getwd()
		if err != nil {
			panic(err)
		}
		Config.Server.Public = path.Join(workingDir, Config.Server.Public)
	}
	return &Config
}

// GetConfig returns actual config
func GetConfig() *ConfigConfiguration {
	return &Config
}

// PublicPath returns path to application public folder
func PublicPath() string {
	return Config.Server.Public
}

// UploadsPath returns path to public/uploads folder
func UploadsPath() string {
	return path.Join(Config.Server.Public, "uploads")
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
		Config.Database.Host,
		Config.Database.User,
		Config.Database.Password,
		Config.Database.Db)
}
