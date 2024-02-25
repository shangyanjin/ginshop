package models

import (
	"fmt"
	"gorm.io/gorm"
	"strings"
	"time"
)

//Page type contains page info
type Page struct {
	ID        uint64     `form:"id" gorm:"primary_key"`
	CreatedAt time.Time  `binding:"-" form:"-"`
	UpdatedAt time.Time  `binding:"-" form:"-"`
	DeletedAt *time.Time `binding:"-" form:"-"`
	Title           string `form:"title"`
	Description     string `form:"description"`
	Slug            string `form:"slug"`
	Published       bool   `form:"published"`
	MetaKeywords    string `form:"meta_keywords"`
	MetaDescription string `form:"meta_description"`
}

//URL returns article url
func (p *Page) URL() string {
	return fmt.Sprintf("/pages/%d-%s", p.ID, p.Slug)
}

//BeforeSave gorm hook
func (p *Page) BeforeSave(tx *gorm.DB) (err error) {
	if strings.TrimSpace(p.Slug) == "" {
		p.Slug = createSlug(p.Title)
	}
	return
}
