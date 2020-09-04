import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from 'src/environments/environment';
import { Funcionario } from '../models/funcionario.model';
import { createFuncionario } from '../models/createFuncionario.model';

@Injectable({
  providedIn: 'root'
})
export class FuncionariosService {

  api = environment.API;
  constructor(private http: HttpClient) { }

  getAll(): Observable<Funcionario> {
    return this.http.get<Funcionario>(`${this.api}funcionarios`);
  }

  getAllMotoristas(): Observable<Funcionario> {
    return this.http.get<Funcionario>(`${this.api}funcionarios/motoristas`);
  }
  
  getById(id: number): Observable<Funcionario> {
    return this.http.get<Funcionario>(`${this.api}funcionarios/${id}`)
  }

  getEscala(id: number) {
    return this.http.get(`${this.api}funcionarios/escala/${id}`)
  }

  deteteFnc(id: number): Observable<Funcionario> {
    return this.http.delete<Funcionario>(`${this.api}funcionarios/${id}`);
  }

  create(data: createFuncionario): Observable<createFuncionario>{
    return this.http.post<createFuncionario>(`${this.api}funcionarios`, data);
  }

  update(id: number, data: any ): Observable<createFuncionario> {
    return this.http.put<createFuncionario>(`${this.api}funcionarios/${id}`, data);
  }

}
