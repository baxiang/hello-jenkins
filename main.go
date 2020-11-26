package main

import (
	"github.com/gin-gonic/gin"
)


type Response struct {
	Code int `json:"code"`
	Message string `json:"msg"`
	Data interface{} `json:"data"`
}

func main() {
	r := gin.Default()

	r.GET("/ping", func(c *gin.Context) {
		c.JSON(200, &Response{
			Code:    0,
			Message: "success",
			Data:    "pong",
		})
	})

	r.GET("/hi", func(c *gin.Context) {
		c.JSON(200, Response{
			Code:    0,
			Message: "ok",
			Data:    "hello golang",
		})
	})
	r.Run(":8088")
}
