package handlers

import (
	"encoding/json"
	"net/http"

	"github.com/evermos/boilerplate-go/internal/domain/course"
	"github.com/evermos/boilerplate-go/shared"
	"github.com/evermos/boilerplate-go/shared/failure"
	"github.com/evermos/boilerplate-go/transport/http/middleware"
	"github.com/evermos/boilerplate-go/transport/http/response"
	"github.com/go-chi/chi"
	"github.com/gofrs/uuid"
)

type CourseHandler struct {
	CourseService course.CourseService 
	AuthMiddleware *middleware.Authentication
}

func ProvideCourseHandler(courseService course.CourseService, authMiddleware *middleware.Authentication) CourseHandler {
	return CourseHandler{
		CourseService:     courseService,
		AuthMiddleware: authMiddleware,
	}
}


func (h *CourseHandler) Router(r chi.Router) {
	r.Route("/courses", func(r chi.Router) {

		r.Group(func(r chi.Router) {
			r.Use(h.AuthMiddleware.ValidateJWT)
			r.Use(h.AuthMiddleware.RoleCheck)
			r.Post("/", h.CreateCourse)
			r.Get("/", h.ReadCourse)
			// r.Put("/foo/{id}", h.UpdateFoo)
		})

	})
}

func (h *CourseHandler) CreateCourse(w http.ResponseWriter, r *http.Request) {
	decoder := json.NewDecoder(r.Body)
	var requestFormat course.CourseRequestFormat
	err := decoder.Decode(&requestFormat)
	if err != nil {
		response.WithError(w, failure.BadRequest(err))
		return
	}

	claims, ok := r.Context().Value(middleware.ClaimsKey("claims")).(shared.Claims)
	if !ok {
		response.WithMessage(w, http.StatusUnauthorized, "Unauthorized")
	}

	id, err := uuid.FromString(claims.UserId)
	if err != nil {
		response.WithError(w, failure.BadRequest(err))
		return
	}

	course, err := h.CourseService.Create(requestFormat, id )
	if err != nil {
		response.WithError(w, err)
		return
	}

	response.WithJSON(w, http.StatusCreated, course)
}

func (h *CourseHandler) ReadCourse(w http.ResponseWriter, r *http.Request) {
	
	claims, ok := r.Context().Value(middleware.ClaimsKey("claims")).(shared.Claims)
	if !ok {
		response.WithMessage(w, http.StatusUnauthorized, "Unauthorized")
	}

	id, err := uuid.FromString(claims.UserId)
	if err != nil {
		response.WithError(w, failure.BadRequest(err))
		return
	}

	courses, err := h.CourseService.Read(id)
	if err != nil {
		response.WithError(w, err)
		return
	}

	response.WithJSON(w, http.StatusCreated, courses)
}

