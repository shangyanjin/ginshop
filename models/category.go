package models

import (
	"fmt"
	"gorm.io/gorm"
	"strings"
	"time"
)

//Category type contains product category info
type Category struct {
	ID        uint64     `form:"id" gorm:"primary_key"`
	CreatedAt time.Time  `binding:"-" form:"-"`
	UpdatedAt time.Time  `binding:"-" form:"-"`
	DeletedAt *time.Time `binding:"-" form:"-"`
	Title           string  `form:"title"`
	Slug            string  `form:"slug"`
	Excerpt         string  `form:"excerpt"`
	Description     string  `form:"description"`
	MetaKeywords    string  `form:"meta_keywords"`
	MetaDescription string  `form:"meta_description"`
	Published       bool    `form:"published"`
	ParentID        *uint64 `form:"parent_id"`
	Products        []Product
	Class           string     `form:"class"`
	Ord             int        `form:"ord"`
	Children        []Category `gorm:"foreignkey:ParentID"`
}

//URL returns category url
func (c *Category) URL() string {
	return fmt.Sprintf("/c/%d-%s", c.ID, c.Slug)
}

//BeforeSave gorm hook
func (c *Category) BeforeSave(tx *gorm.DB) (err error) {
	if strings.TrimSpace(c.Slug) == "" {
		c.Slug = createSlug(c.Title)
	}
	return
}

//IDs returns a slice of category id and ids of its children
func (c *Category) IDs() []uint64 {
	var children []Category
	var ids []uint64
	db.Where("parent_id = ?", c.ID).Find(&children).Pluck("id", &ids)
	ids = append(ids, c.ID)
	return ids
}

//GetParent returns parent item
func (c *Category) GetParent() Category {
	parent := Category{}
	if c.ParentID != nil {
		db.First(&parent, *c.ParentID)
	}
	return parent
}
