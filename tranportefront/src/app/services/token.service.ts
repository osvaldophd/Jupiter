import { Injectable } from '@angular/core';
import { HttpHeaders } from '@angular/common/http';

@Injectable({
  providedIn: 'root'
})
export class TokenService {

  token: string;

  constructor() { }

  setToken(user:any){
    localStorage.setItem('usuario', user.token);
    localStorage.setItem('funcionario', JSON.stringify(user.usuario.funcionario));
  }

  removerToken(){
    localStorage.removeItem('usuario');
    localStorage.removeItem('funcionario');
  }

  verifyToken(): boolean {

    if(localStorage.getItem('usuario')){

        return true;
     }
    return false;
  }

  getToken(){
    return localStorage.getItem('usuario');
  }


  TokenAutorization(): any {
    const token = localStorage.getItem('usuario');
    return {
      headers: new HttpHeaders().set('Authorization', ` Bearer ${token} `)
    };
  }
}
