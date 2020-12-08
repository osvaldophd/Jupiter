import { Injectable } from '@angular/core';
import { HttpHeaders } from '@angular/common/http';
import { Usuario } from 'src/app/models/usuariologin';


@Injectable({
  providedIn: 'root'
})
export class TokenService {

  token: string;

  constructor() { }

  setToken(token, funcionario: Usuario){
    localStorage.setItem('usuario', token);
    localStorage.setItem('funcionario', JSON.stringify(funcionario));
  }


  removerToken(){
    localStorage.removeItem('usuario');
    localStorage.removeItem('funcionario');
  }

  verifyToken(): boolean {

    if(localStorage.getItem('usuario')){
        return true;
     }
     
    this.removerToken();
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
