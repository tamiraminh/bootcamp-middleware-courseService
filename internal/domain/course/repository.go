package course

import (
	"github.com/evermos/boilerplate-go/infras"
	"github.com/evermos/boilerplate-go/shared/failure"
	"github.com/evermos/boilerplate-go/shared/logger"
	"github.com/gofrs/uuid"
	"github.com/jmoiron/sqlx"
)

var (
	courseQueries = struct {
		insertCourse string
	} {
		insertCourse: `
			INSERT INTO course (
				id,
				title,
				content,
				userId,
				createdAt,
				createdBy,
				updatedAt,
				updatedBy,
				deletedAt,
				deletedBy
			) VALUES (
				:id,
				:title,
				:content,
				:userId,
				:createdAt,
				:createdBy,
				:updatedAt,
				:updatedBy,
				:deletedAt,
				:deletedBy
			)
		`,
	}
)

type CourseRepository interface {
	Create(course Course) (err error)
	ResolveCourseByUserId(userID uuid.UUID,  order string, orderBy string, page int, limit int) (courses []Course, err error)
	// ExistsByID(id uuid.UUID) (exists bool, err error)
	// ResolveByID(id uuid.UUID) (course Course, err error)
	// ResolveItemsByCourseIDs(ids []uuid.UUID) (CourseItems []CourseItem, err error)
	// Update(course Course) (err error)
}

type CourseRepositoryMySQL struct {
	DB *infras.MySQLConn
}

func ProvideCourseRepositoryMySQL(db *infras.MySQLConn) *CourseRepositoryMySQL {
	s := new(CourseRepositoryMySQL)
	s.DB = db
	return s
}


func (r *CourseRepositoryMySQL) Create(course Course) (err error) {
	exists, err := r.ExistsByID(course.Id)
	if err != nil {
		logger.ErrorWithStack(err)
		return
	}

	if exists {
		err = failure.Conflict("create", "course", "already exists")
		logger.ErrorWithStack(err)
		return
	}

	return r.DB.WithTransaction(func(tx *sqlx.Tx, e chan error) {
		if err := r.txCreate(tx, course); err != nil {
			e <- err
			return
		}

		e <- nil
	})
}

func (r *CourseRepositoryMySQL) ExistsByID(id uuid.UUID) (exists bool, err error) {
	err = r.DB.Read.Get(
		&exists,
		"SELECT COUNT(id) FROM Course WHERE id = ?",
		id.String())
	if err != nil {
		logger.ErrorWithStack(err)
	}

	return
}


func (r *CourseRepositoryMySQL) txCreate(tx *sqlx.Tx, course Course) (err error) {
	stmt, err := tx.PrepareNamed(courseQueries.insertCourse)
	if err != nil {
		logger.ErrorWithStack(err)
		return
	}
	defer stmt.Close()

	_, err = stmt.Exec(course)
	if err != nil {
		logger.ErrorWithStack(err)
	}

	return
}


func (r *CourseRepositoryMySQL) ResolveCourseByUserId(userID uuid.UUID, order string, orderBy string, page int, limit int) (courses []Course, err error) {
	query := "SELECT * FROM course WHERE userId = " + "'" +  userID.String() + "'" 
	
	if orderBy != "" {
		query += " ORDER BY " + orderBy
	}
	if order != "" {
		query += " " + order
	}
	var offset int
	if page >= 0 {
		offset = (page-1)*limit
	}

	query += " LIMIT ? OFFSET ? ;"


	err = r.DB.Read.Select(
		&courses,
		query, limit, offset)
	if err != nil {
		logger.ErrorWithStack(err)
	}

	return
}
