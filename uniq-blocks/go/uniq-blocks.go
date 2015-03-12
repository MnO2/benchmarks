package main

import (
    "io"
    "os"
)

func main() {
    file, err := os.Open("large_random.txt")
    if err != nil {
        return
    }

    bs := make([]byte, 512)
    m := make(map[string]int)
    for {
        _, err = file.Read(bs)
        if err != nil {
            if err == io.EOF {
                break
            }
            return
        }

        str := string(bs)
        _, ok := m[str]
        if !ok {
            m[str] = 1
        } else {
            m[str] += 1
        }
        //fmt.Println(str)
    }

    file.Close()
}
