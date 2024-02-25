package models

import (
	"gorm.io/gorm"
	"strings"
	"time"
)

//Order type contains buy order info
type Order struct {
	ID        uint64     `form:"id" gorm:"primary_key"`
	CreatedAt time.Time  `binding:"-" form:"-"`
	UpdatedAt time.Time  `binding:"-" form:"-"`
	DeletedAt *time.Time `binding:"-" form:"-"`
	FirstName  string    `form:"first_name"`
	MiddleName string    `form:"middle_name"`
	LastName   string    `form:"last_name"`
	Email      string    `form:"email"`
	Phone      string    `form:"phone"`
	Comment    string    `form:"comment"`
	ProductID uint64 `gorm:"index" binding:"-" form:"-"`
	Products   []Product `binding:"-" form:"-"`
}

//BeforeCreate gorm hook
func (o *Order) BeforeCreate(tx *gorm.DB) (err error) {
	o.Email = strings.TrimSpace(strings.ToLower(o.Email))
	return
}
