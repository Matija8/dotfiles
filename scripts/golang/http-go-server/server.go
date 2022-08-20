package main

import (
	"fmt"
	"net/http"
)

// https://gobyexample.com/http-servers

func main() {
	http.HandleFunc("/hello", getHello)
	// Test by:
	// curl localhost:8090/hello

	http.HandleFunc("/headers", getHeaders)
	// Test by:
	// curl localhost:8090/headers

	var port = 8090
	fmt.Println("Listening on port=", port)
	http.ListenAndServe(fmt.Sprintf(":%d", port), nil)
}

func getHello(responseWriter http.ResponseWriter, req *http.Request) {
	fmt.Println("hello route hit")
	fmt.Fprintf(responseWriter, "hello\n")
}

func getHeaders(responseWriter http.ResponseWriter, req *http.Request) {

	for name, headers := range req.Header {
		for _, h := range headers {
			fmt.Fprintf(responseWriter, "%v: %v\n", name, h)
		}
	}
}
