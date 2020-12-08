import { Injectable } from '@angular/core';
import { environment } from 'src/environments/environment';

@Injectable({
  providedIn: 'root'
})
export class CookieService {

  keyCookie = environment.keyCookie;
  domain = environment.domain;
  urlTorenRedirect = environment.urlTorenRedirect;

  constructor() { }

  // setCookie(name, value, days) {
  //   var expires = "";
  //   if (days) {
  //     var date = new Date();
  //     date.setTime(date.getTime() + (1 * 64 * 1000));
  //     expires = "; expires=" + date.toUTCString();
  //   }
  //   document.cookie = name + "=" + (value || "") + expires + "; path=/";
  // }

  setCookie(token){
    var data = new Date();
    data.setTime(data.getTime() + 1 * 64 * 1000);
    document.cookie = `${this.keyCookie}= ${token} ;expires=${data} ;domain=${this.domain}`;
    return window.location.href = this.urlTorenRedirect;
  }

  clenCookie(){
    const token = '';
    var data = new Date();
    data.setTime(data.getTime() + 1 * 64 * 1000);
    document.cookie = `${this.keyCookie}= ${token} ;expires=${data} ;domain=${this.domain}`;
  }

  getCookie() {
    var nameEQ = this.keyCookie + "=";
    var ca = document.cookie.split(';');
    for (var i = 0; i < ca.length; i++) {
      var c = ca[i];
      while (c.charAt(0) == ' ') c = c.substring(1, c.length);
      if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length, c.length);
    }
    return null;
  }
  
  deleteCookie() {
    document.cookie = this.keyCookie + '=; Max-Age=-99999999;';
  }



}
