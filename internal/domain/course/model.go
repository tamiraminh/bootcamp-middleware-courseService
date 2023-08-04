package course

import (
	"encoding/json"
	"time"

	"github.com/evermos/boilerplate-go/shared"
	"github.com/evermos/boilerplate-go/shared/nuuid"
	"github.com/gofrs/uuid"
	"github.com/guregu/null"
)

type Course struct {
	Id			uuid.UUID `db:"id"`
	Title		string `db:"title"`
	Content		string `db:"content"`
	UserId		uuid.UUID `db:"userId"`
	CreatedAt   time.Time   `db:"createdAt"`
	CreatedBy   uuid.UUID   `db:"createdBy"`
	UpdatedAt   null.Time   `db:"updatedAt"`
	UpdatedBy   nuuid.NUUID `db:"updatedBy"`
	DeletedAt   null.Time   `db:"deletedAt"`
	DeletedBy   nuuid.NUUID `db:"deletedBy"`
}

func (c *Course) IsDeleted() (deleted bool) {
	return c.DeletedAt.Valid && c.DeletedBy.Valid
}

func (c Course) MarshalJSON() ([]byte, error) {
	return json.Marshal(c.ToResponseFormat())
}

func (c *Course) Validate() (err error) {
	validator := shared.GetValidator()
	return validator.Struct(c)
}



func (c Course) NewFromRequestFormat(req CourseRequestFormat, userID uuid.UUID) (newCourse Course, err error) {
	courseId, _ := uuid.NewV4()
	newCourse = Course{
		Id: courseId,
		Title: req.Title,
		Content: req.Content,
		UserId: userID,
		CreatedAt:   time.Now(),
		CreatedBy:   userID,
	}

	err = newCourse.Validate()

	return
}

func (c Course) ToResponseFormat() CourseResponseFormat {
	resp := CourseResponseFormat{
		Id: c.Id,
		Title: c.Title,
		Content: c.Content,
		UserId: c.UserId,
		CreatedAt: c.CreatedAt,
		CreatedBy: c.CreatedBy,
		UpdatedAt: c.UpdatedAt,
		UpdatedBy: c.UpdatedBy,
		DeletedAt: c.DeletedAt,
		DeletedBy: c.DeletedBy,
	}


	return resp
}

type CourseRequestFormat struct {
	Title		string `json:"title"`
	Content		string `json:"content"`
}


type CourseResponseFormat struct {
	Id			uuid.UUID `json:"id"`
	Title		string `json:"title"`
	Content		string `json:"content"`
	UserId		uuid.UUID `json:userId`
	CreatedAt   time.Time   `json:"createdAt"`
	CreatedBy   uuid.UUID   `json:"createdBy"`
	UpdatedAt   null.Time   `json:"updatedAt,omitempty"`
	UpdatedBy   nuuid.NUUID `json:"updatedBy,omitempty"`
	DeletedAt   null.Time   `json:"deletedAt,omitempty"`
	DeletedBy   nuuid.NUUID `json:"deletedBy,omitempty"`
}

