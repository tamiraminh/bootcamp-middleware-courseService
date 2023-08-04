package course

import (
	"github.com/evermos/boilerplate-go/configs"
	"github.com/evermos/boilerplate-go/shared/failure"
	"github.com/gofrs/uuid"
)

type CourseService interface {
	Create(requestFormat CourseRequestFormat, userID uuid.UUID) (course Course, err error)
	ResolveCourseByUserId(userID uuid.UUID, order string, orderBy string, page int, limit int) (courses []Course, err error)
}

type CourseServiceImpl struct {
	CourseRepository CourseRepository
	Config           *configs.Config
}

func ProvideCourseServiceImpl(courseRepository CourseRepository, config *configs.Config) *CourseServiceImpl {
	s := new(CourseServiceImpl)
	s.CourseRepository = courseRepository
	s.Config = config

	return s
}

func (s *CourseServiceImpl) Create(requestFormat CourseRequestFormat, userID uuid.UUID) (course Course, err error) {
	course, err = course.NewFromRequestFormat(requestFormat, userID)
	if err != nil {
		return course, failure.BadRequest(err)
	}

	err = s.CourseRepository.Create(course)

	if err != nil {
		return
	}

	return
}


func (s *CourseServiceImpl) ResolveCourseByUserId(userID uuid.UUID,  order string, orderBy string, page int, limit int) (courses []Course, err error) {

	courses, err = s.CourseRepository.ResolveCourseByUserId(userID,  order , orderBy, page, limit)
	if err != nil {
		return
	}

	return
}