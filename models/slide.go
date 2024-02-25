package models

import "time"

//Slide type contains carousel slide info
type Slide struct {
	ID        uint64     `form:"id" gorm:"primary_key"`
	CreatedAt time.Time  `binding:"-" form:"-"`
	UpdatedAt time.Time  `binding:"-" form:"-"`
	DeletedAt *time.Time `binding:"-" form:"-"`
	Title         string `form:"title" binding:"required"`
	Content       string `form:"content"`
	NavigationURL string `form:"navigation_url"`
	FileURL       string `form:"file_url"`
	Ord           int    `form:"ord"`
}
