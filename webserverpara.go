package main

import (
	"fmt"
	"io"
	"io/ioutil"
	"net/http"
	"os"
	"strconv"
	"time"
)

var start_time int64
var flag int64
var time_to_unhealthy int64 = 0
var unhealthy_number int64 = 0

func IndexHandler(w http.ResponseWriter, r *http.Request) {
	//打印请求主机地址
	fmt.Println(time.Now().String())
	fmt.Println(r.Host)
	//打印请求头信息
	fmt.Printf("header content:[%v]\n", r.Header)

	//获取 post 请求中 form 里边的数据
	fmt.Printf("form content:[%s, %s]\n", r.PostFormValue("username"), r.PostFormValue("passwd"))

	//读取请求体信息
	bodyContent, err := ioutil.ReadAll(r.Body)
	if err != nil && err != io.EOF {
		fmt.Printf("read body content failed, err:[%s]\n", err.Error())
		return
	}
	fmt.Printf("body content:[%s]\n", string(bodyContent))
	//返回响应内容
	var nowtime int64
	nowtime = time.Now().Unix()
	if nowtime-start_time < time_to_unhealthy {
		fmt.Fprintf(w, strconv.FormatInt(time.Now().Unix(), 10))
	} else if flag < unhealthy_number {
		w.WriteHeader(500)
		fmt.Fprintf(w, "fail")
		flag++
	} else {
		fmt.Fprintf(w, strconv.FormatInt(time.Now().Unix(), 10))
	}
}

func main() {
	http.HandleFunc("/", IndexHandler)
	start_time = time.Now().Unix()
	flag = 0
	if len(os.Args) == 3 {
		time_to_unhealthy, _ = strconv.ParseInt(os.Args[1], 10, 64)
		unhealthy_number, _ = strconv.ParseInt(os.Args[2], 10, 64)
	}
	http.ListenAndServe(":8002", nil)
}
