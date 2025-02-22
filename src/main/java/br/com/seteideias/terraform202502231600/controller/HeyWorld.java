package br.com.seteideias.terraform202502231600.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RequestMapping("/api")
@RestController
public class HeyWorld {

    @GetMapping("/hello")
    public String hello(){
        return "hello  world";
    }
}
