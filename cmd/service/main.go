package main

import (
	"net/http"

	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"

	_ "github.com/lib/pq"
)

func main() {
	//// Connect to postgreSql db
	//postgreSqlConn, err := sql.Open(
	//	"postgres",
	//	"user=postgres "+
	//		"password=postgres "+
	//		"dbname=bot_db "+
	//		"host=localhost "+
	//		"port=5432 "+
	//		"sslmode=disable ",
	//)
	//if err != nil {
	//	log.Fatal(err)
	//}
	//defer postgreSqlConn.Close()
	//if err := postgreSqlConn.Ping(); err != nil {
	//	log.Fatal(err)
	//}


	// Echo instance
	e := echo.New()

	// Middleware
	e.Use(middleware.Logger())
	e.Use(middleware.Recover())

	// Route => handler
	e.GET("/", func(c echo.Context) error {
		return c.String(http.StatusOK, "Hello, World!\n")
	})

	e.Logger.Fatal(e.Start(":1323"))
}