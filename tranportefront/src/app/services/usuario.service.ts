import { Injectable } from '@angular/core';
import { environment } from 'src/environments/environment';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { createFuncionario } from '../funcionario/models/createFuncionario.model';

@Injectable({
  providedIn: 'root'
})
export class UsuarioService {
  api = environment.API;

  constructor(private http: HttpClient) { }

  register(usuario: any): Observable<any> {
    return this.http.post<any>(`${this.api}/funcionarios`, usuario)
  }

  update(id: number, data: any ): Observable<createFuncionario> {
    return this.http.put<createFuncionario>(`${this.api}/funcionarios/${id}`, data);
  }

  getUsuario(): Observable<any> {
    return this.http.post(`${this.api}/me`, null);
  }
}
