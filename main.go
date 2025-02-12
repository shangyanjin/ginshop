package main

import (
	"encoding/gob"
	"flag"
	"fmt"
	"ginshop/config"
	"ginshop/middlewares"
	"ginshop/models"
	"ginshop/service"
	"net/http"

	"github.com/claudiu/gocron"
	"github.com/gin-contrib/sessions"
	"github.com/gin-contrib/sessions/memstore"
	"github.com/gin-gonic/gin"
	"github.com/sirupsen/logrus"
	csrf "github.com/utrack/gin-csrf"
)

func main() {
	gob.Register(service.CartType{})

	seed := flag.String("seed", "false", "Seed database: true, false")
	mode := flag.String("mode", "debug", "Application mode: debug, release, test")
	flag.Parse()

	gin.SetMode(*mode)

	initLogger()
	config.InitConfig()
	//models.InitMysql()
	models.InitSqlite()
	//models.AutoMigrate()
	//models.SeedDB()
	if *seed == "true" {
		models.SeedDB()
	}

	//Periodic tasks
	gocron.Every(1).Day().Do(service.CreateXMLSitemap)
	gocron.Start()

	// Creates a gin router with default middleware:
	// logger and recovery (crash-free) middleware
	router := gin.Default()
	router.StaticFS("/public", http.Dir(config.PublicPath())) //better use nginx to serve assets (Cache-Control, Etag, fast gzip, etc)
	service.LoadTemplates(router)                             //load default
	//setup sessions
	//setup sessions
	secretKey := config.GetString("server.session_secret")
	if len(secretKey) < 1 {
		secretKey = "default-secret-key" //default secret key
	}
	store := memstore.NewStore([]byte(secretKey))
	store.Options(sessions.Options{Path: "/", HttpOnly: true, MaxAge: 7 * 86400}) //Also set Secure: true if using SSL, you should though
	router.Use(sessions.Sessions("ginshop-session", store))
	router.Use(middlewares.ContextData())

	//setup csrf protection
	router.Use(csrf.Middleware(csrf.Options{
		Secret: secretKey,
		ErrorFunc: func(c *gin.Context) {
			logrus.Error("CSRF token mismatch")
			service.ShowErrorPage(c, 400, fmt.Errorf("CSRF token mismatch"))
			c.Abort()
		},
	}))

	router.GET("/", service.HomeGet)
	router.NoRoute(service.NotFound)
	router.NoMethod(service.MethodNotAllowed)

	if config.GetBool("server.signup_enabled") {
		router.GET("/signup", service.SignUpGet)
		router.POST("/signup", service.SignUpPost)
	}
	router.GET("/signin", service.SignInGet)
	router.POST("/signin", service.SignInPost)
	router.GET("/signout", service.SignoutGet)

	router.GET("/pages/:idslug", service.PageGet)
	router.GET("/c/:idslug", service.CategoryGet)
	router.GET("/p/:idslug", service.ProductGet)
	router.GET("/rss", service.RssGet)

	router.GET("/cart", service.CartGet)
	router.POST("/cart/add/:id", service.CartAdd)
	router.POST("/cart/delete/:id", service.CartDelete)

	router.GET("/new_order", service.OrderNew)
	router.POST("/new_order", service.OrderCreate)
	router.GET("/confirm_order/:id", service.OrderConfirm)

	router.GET("/search", service.SearchGet)

	router.POST("/orderconsult", service.OrderConsultPost)

	//admin area
	admin := router.Group("/admin")
	admin.Use(middlewares.AuthRequired(models.ADMIN))
	{
		admin.POST("/upload", service.UploadPost) //image upload

		admin.GET("/users", service.UserIndex)
		admin.GET("/new_user", service.UserNew)
		admin.POST("/new_user", service.UserCreate)
		admin.GET("/users/:id/edit", service.UserEdit)
		admin.POST("/users/:id/edit", service.UserUpdate)
		admin.POST("/users/:id/delete", service.UserDelete)

		admin.GET("/pages", service.PageIndex)
		admin.GET("/new_page", service.PageNew)
		admin.POST("/new_page", service.PageCreate)
		admin.GET("/pages/:id/edit", service.PageEdit)
		admin.POST("/pages/:id/edit", service.PageUpdate)
		admin.POST("/pages/:id/delete", service.PageDelete)

		admin.GET("/menus", service.MenuIndex)
		admin.GET("/new_menu", service.MenuNew)
		admin.POST("/new_menu", service.MenuCreate)
		admin.GET("/menu/:id/edit", service.MenuEdit)
		admin.POST("/menu/:id/edit", service.MenuUpdate)
		admin.POST("/menu/:id/delete", service.MenuDelete)

		admin.GET("/menu/:id", service.MenuItemIndex)
		admin.GET("/menu/:id/new_item", service.MenuItemNew)
		admin.POST("/menu/:id/new_item", service.MenuItemCreate)
		admin.GET("/menu/:id/edit/:itemid", service.MenuItemEdit)
		admin.POST("/menu/:id/edit/:itemid", service.MenuItemUpdate)
		admin.POST("/menu/:id/delete/:itemid", service.MenuItemDelete)

		admin.GET("/categories", service.CategoryIndex)
		admin.GET("/new_category", service.CategoryNew)
		admin.POST("/new_category", service.CategoryCreate)
		admin.GET("/categories/:id/edit", service.CategoryEdit)
		admin.POST("/categories/:id/edit", service.CategoryUpdate)
		admin.POST("/categories/:id/delete", service.CategoryDelete)

		admin.GET("/products", service.ProductIndex)
		admin.GET("/new_product", service.ProductNew)
		admin.POST("/new_product", service.ProductCreate)
		admin.GET("/products/:id/edit", service.ProductEdit)
		admin.POST("/products/:id/edit", service.ProductUpdate)
		admin.POST("/products/:id/delete", service.ProductDelete)

		admin.POST("/new_image", service.ImageCreate)
		admin.POST("/images/:id/delete", service.ImageDelete)

		admin.GET("/settings", service.SettingIndex)
		admin.GET("/new_setting", service.SettingNew)
		admin.POST("/new_setting", service.SettingCreate)
		admin.GET("/settings/:id/edit", service.SettingEdit)
		admin.POST("/settings/:id/edit", service.SettingUpdate)
		admin.POST("/settings/:id/delete", service.SettingDelete)

		admin.GET("/orders", service.OrderIndex)
		admin.GET("/orders/:id", service.OrderGet)
		admin.POST("/orders/:id/delete", service.OrderDelete)

		admin.GET("/slides", service.SlideIndex)
		admin.GET("/new_slide", service.SlideNew)
		admin.POST("/new_slide", service.SlideCreate)
		admin.GET("/slides/:id/edit", service.SlideEdit)
		admin.POST("/slides/:id/edit", service.SlideUpdate)
		admin.POST("/slides/:id/delete", service.SlideDelete)
	}

	//manager area
	manager := router.Group("/manager")
	manager.Use(middlewares.AuthRequired(models.MANAGER))
	{
		manager.GET("/orders", service.OrderIndex)
		manager.GET("/orders/:id", service.OrderGet)
		manager.GET("/manage", service.ManageGet)
		manager.POST("/manage", service.ManagePost)
	}

	//customer area
	customer := router.Group("/customer")
	customer.Use(middlewares.AuthRequired(models.CUSTOMER))
	{
		customer.GET("/orders", service.OrderIndex)
		customer.GET("/orders/:id", service.OrderGet)
		customer.GET("/manage", service.ManageGet)
		customer.POST("/manage", service.ManagePost)
	}

	// Listen and server on 0.0.0.0:8081
	router.Run(":80")
}

// initLogger initializes logrus logger with some defaults
func initLogger() {
	logrus.SetFormatter(&logrus.TextFormatter{})
	if gin.Mode() == gin.DebugMode {
		logrus.SetLevel(logrus.DebugLevel)
	}
}
