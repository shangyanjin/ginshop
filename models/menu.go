package models

import "time"

//Menu type contains menu info
type Menu struct {
	ID        uint64     `form:"id" gorm:"primary_key"`
	CreatedAt time.Time  `binding:"-" form:"-"`
	UpdatedAt time.Time  `binding:"-" form:"-"`
	DeletedAt *time.Time `binding:"-" form:"-"`
	Code  string `form:"code" binding:"required"`
	Title string `form:"title" binding:"required"`
	Items []MenuItem
}
