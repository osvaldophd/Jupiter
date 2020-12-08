import { Injectable } from '@angular/core';
import { HttpHeaders } from '@angular/common/http';
import { environment } from 'src/environments/environment';
import { CookieService } from './cookie.service';

@Injectable({
  providedIn: 'root'
})
export class TokenService {

  token: string;
  keyToken = environment.keyToken;

  constructor(private cookieService: CookieService) { }

  setToken(token){
    localStorage.setItem(this.keyToken, token);
  }

  removerToken(){
    localStorage.removeItem(this.keyToken);
    localStorage.removeItem('userprofile');
    this.cookieService.clenCookie();
  }

  verifyToken(): boolean {
    if(localStorage.getItem(this.keyToken)){
        return true;
     }
    return false;
  }

  getToken(){
    return localStorage.getItem(this.keyToken);
  }


  TokenAutorization(): any {
    const token = localStorage.getItem(this.keyToken);
    return {
      headers: new HttpHeaders().set('Authorization', ` Bearer ${token} `)
    };
  }
}
