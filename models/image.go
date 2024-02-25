package models

import "time"

//Image type contains image info
type Image struct {
	ID        uint64     `form:"id" gorm:"primary_key"`
	CreatedAt time.Time  `binding:"-" form:"-"`
	UpdatedAt time.Time  `binding:"-" form:"-"`
	DeletedAt *time.Time `binding:"-" form:"-"`
	URL       string  `form:"url"`
	ProductID uint64  `form:"product_id"`
	Hash      string  `gorm:"-" form:"-"`
	Product   Product `gorm:"save_associations:false" binding:"-" form:"-"`
}
