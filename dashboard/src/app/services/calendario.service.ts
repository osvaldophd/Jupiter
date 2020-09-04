import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from 'src/environments/environment';
import { map } from 'rxjs/operators';
import { GetFuncionarioEscalaModel } from '../dashboard/calendario/models/getfuncionarioescala.model';

@Injectable({
  providedIn: 'root'
})
export class CalendarioService {

  api = `${environment.API}funcionarios-escalas`;
  apiCreate =  `${environment.API}gerar-escala-automaticamente`;

  constructor(private http: HttpClient) { }

  getAll(): Observable<GetFuncionarioEscalaModel> {
    return this.http.get<GetFuncionarioEscalaModel>(this.api);
  }

  getById(id: number): Observable<any> {
    return this.http.get(`${this.api}/${id}`);
  }

  create(data): Observable<any> {
    return this.http.post(this.apiCreate, data);
  }

  update(id: number, data: any): Observable<any> {
    return this.http.put(`${this.api}/${id}`, data);
  }

  delete(id: number): Observable<any>{
    return this.http.delete(`${this.api}/${id}`);
  }

}
