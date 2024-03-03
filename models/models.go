package models

import (
	"fmt"
	"github.com/fiam/gounidecode/unidecode"
	"gorm.io/driver/mysql"
	"gorm.io/driver/postgres"
	"gorm.io/driver/sqlite"
	"gorm.io/gorm"
	"gorm.io/gorm/logger"
	"goweb/config"
	"log"
	"os"
	"regexp"
	"strings"
	"time"
)

// Model is a tuned version of gorm.Model
type Model struct {
	ID        uint64     `form:"id" gorm:"primary_key"`
	CreatedAt time.Time  `binding:"-" form:"-"`
	UpdatedAt time.Time  `binding:"-" form:"-"`
	DeletedAt *time.Time `binding:"-" form:"-"`
}

var db *gorm.DB

// SetDB establishes connection to database and saves its handler into db *gorm.DB

func InitSqlite() {
	var err error

	// Create a logger that outputs logs to standard output device and set log level to Info
	newLogger := logger.New(
		log.New(os.Stdout, "\r\n", log.LstdFlags), // io.Writer
		logger.Config{
			SlowThreshold:             time.Second, // Slow query threshold is 1 second
			LogLevel:                  logger.Info, // Log level is set to Info
			IgnoreRecordNotFoundError: true,        // Ignore ErrRecordNotFound error
			Colorful:                  true,        // Enable colorful printing
		},
	)

	// Open SQLite3 database connection using custom log configuration
	db, err = gorm.Open(sqlite.Open("sql.db"), &gorm.Config{
		Logger: newLogger, // Pass the logger configuration to GORM
	})

	if err != nil {
		panic(err)
	}
 }



func InitMysql() {
	var err error
	////db, err = gorm.Open("postgres", connection)
	//db, err = gorm.Open("mysql", connection)
	//if err != nil {
	//	panic(err.Error())
	//}
	conf := config.GetConfig()
	dsn := fmt.Sprintf("%s:%s@tcp(%s:%s)/%s?charset=utf8&parseTime=True&loc=Local",
		conf.Database.User,
		conf.Database.Password,
		conf.Database.Host,
		conf.Database.Port,
		conf.Database.Db,
	)
	// Create a logger that outputs logs to standard output device and set log level to Info
	newLogger := logger.New(
		log.New(os.Stdout, "\r\n", log.LstdFlags), // io.Writer
		logger.Config{
			SlowThreshold:             time.Second, // Slow query threshold is 1 second
			LogLevel:                  logger.Info, // Log level is set to Info
			IgnoreRecordNotFoundError: true,        // Ignore ErrRecordNotFound error
			Colorful:                  true,        // Enable colorful printing
		},
	)

	// Open database connection using custom log configuration
	db, err = gorm.Open(mysql.New(mysql.Config{
		DSN:                       dsn,   // Data Source Name
		DefaultStringSize:         256,   // Default size for string fields
		DisableDatetimePrecision:  true,  // Disable time precision, not supported in MySQL versions prior to 5.6
		DontSupportRenameIndex:    true,  // Use drop and recreate method for renaming indexes, not supported in MySQL 5.7 and earlier versions
		DontSupportRenameColumn:   true,  // Use `change` for renaming columns, not supported in MySQL 8 and earlier versions
		SkipInitializeWithVersion: false, // Automatically configure based on current MySQL version
	}), &gorm.Config{
		Logger: newLogger, // Pass the logger configuration to GORM
	})

	if err != nil {
		panic(err)
	}

}



func InitPostgres() *gorm.DB {
	conf := config.GetConfig()
	sqlInfo := fmt.Sprintf("host=%s port=%s user=%s password=%s dbname=%s sslmode=disable",
		conf.Database.Host,
		conf.Database.Port,
		conf.Database.User,
		conf.Database.Password,
		conf.Database.Db)

	db, err := gorm.Open(postgres.Open(sqlInfo), &gorm.Config{})
	log.Println(err)

	fmt.Println("🚀 Connected Successfully to the Database")
	return db
}



// GetDB returns database handler
func GetDB() *gorm.DB {
	return db
}

// AutoMigrate runs gorm auto migration
func AutoMigrate() {
	db.AutoMigrate(&User{}, &Page{}, &Menu{}, &MenuItem{}, &Category{}, &Product{}, &Image{}, &Setting{}, &Order{}, &Slide{})
}

// truncate truncates string to n runes
func truncate(s string, n int) string {
	runes := []rune(s)
	if len(runes) > n {
		return string(runes[:n])
	}
	return s
}

// createSlug makes url slug out of string
func createSlug(s string) string {
	s = strings.ToLower(unidecode.Unidecode(s))                     //transliterate if it is not in english
	s = regexp.MustCompile("[^a-z0-9\\s]+").ReplaceAllString(s, "") //spaces
	s = regexp.MustCompile("\\s+").ReplaceAllString(s, "-")         //spaces
	return s
}
