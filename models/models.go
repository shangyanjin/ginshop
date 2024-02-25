package models

import (
	"fmt"
	"ginshop/config"
	"github.com/fiam/gounidecode/unidecode"
	"gorm.io/driver/mysql"
	"gorm.io/gorm"
	"regexp"
	"strings"
	"time"
)


//Model is a tuned version of gorm.Model
type Model struct {
	ID        uint64     `form:"id" gorm:"primary_key"`
	CreatedAt time.Time  `binding:"-" form:"-"`
	UpdatedAt time.Time  `binding:"-" form:"-"`
	DeletedAt *time.Time `binding:"-" form:"-"`
}

var db *gorm.DB

//SetDB establishes connection to database and saves its handler into db *gorm.DB
func SetDB(connection string) {
	var err error
	////db, err = gorm.Open("postgres", connection)
	//db, err = gorm.Open("mysql", connection)
	//if err != nil {
	//	panic(err.Error())
	//}
	conf:=config.GetConfig()
	dsn := fmt.Sprintf("%s:%s@tcp(%s:%s)/%s?charset=utf8&parseTime=True&loc=Local",
		conf.Database.User,
		conf.Database.Password,
		conf.Database.Host,
		conf.Database.Port,
		conf.Database.Name,
	)

	// Open a connection to the database using GORM
	db, err = gorm.Open(mysql.Open(dsn), &gorm.Config{})
	if err != nil {
		panic(err.Error())
	}



}



//GetDB returns database handler
func GetDB() *gorm.DB {
	return db
}

//AutoMigrate runs gorm auto migration
func AutoMigrate() {
	db.AutoMigrate(&User{}, &Page{}, &Menu{}, &MenuItem{}, &Category{}, &Product{}, &Image{}, &Setting{}, &Order{}, &Slide{})
}

//truncate truncates string to n runes
func truncate(s string, n int) string {
	runes := []rune(s)
	if len(runes) > n {
		return string(runes[:n])
	}
	return s
}

//createSlug makes url slug out of string
func createSlug(s string) string {
	s = strings.ToLower(unidecode.Unidecode(s))                     //transliterate if it is not in english
	s = regexp.MustCompile("[^a-z0-9\\s]+").ReplaceAllString(s, "") //spaces
	s = regexp.MustCompile("\\s+").ReplaceAllString(s, "-")         //spaces
	return s
}
