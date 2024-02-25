package models

import (
	"fmt"
	"gorm.io/gorm"
	"strings"
	"time"
)

//Product type contains product info
type Product struct {
	ID        uint64     `form:"id" gorm:"primary_key"`
	CreatedAt time.Time  `binding:"-" form:"-"`
	UpdatedAt time.Time  `binding:"-" form:"-"`
	DeletedAt *time.Time `binding:"-" form:"-"`
	Title           string   `form:"title"`
	Description     string   `form:"description"`
	MetaKeywords    string   `form:"meta_keywords"`
	MetaDescription string   `form:"meta_description"`
	CategoryID      uint64   `form:"category_id"`
	Published       bool     `form:"published"`
	Slug            string   `form:"slug"`
	Category        Category `binding:"-" form:"-"`
	ImageIds        []uint64 `form:"imageids" gorm:"-"` //hack
	DefaultImageID  uint64   `form:"defaultimageid"`
	Recommended     bool     `form:"recommended"`
	Images          []Image
	Orders []Order `gorm:"foreignkey:ProductID" binding:"-" form:"-"`
}

//URL returns product url
func (p *Product) URL() string {
	return fmt.Sprintf("/p/%d-%s", p.ID, p.Slug)
}

//BeforeSave gorm hook
func (p *Product) BeforeSave(tx *gorm.DB) (err error) {
	if strings.TrimSpace(p.Slug) == "" {
		p.Slug = createSlug(p.Title)
	}
	return
}

//DefaultImage returns url of the default product img
func (p *Product) DefaultImage() string {
	img := Image{}
	if p.DefaultImageID > 0 {
		db.First(&img, p.DefaultImageID)
	} else {
		db.Where("product_id = ?", p.ID).First(&img)
	}

	return img.URL
}
