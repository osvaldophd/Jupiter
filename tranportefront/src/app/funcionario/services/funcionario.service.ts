import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs/internal/Observable';
import { environment } from 'src/environments/environment';

@Injectable({
  providedIn: 'root'
})
export class FuncionarioService {

  api = environment.API;

  constructor(private http: HttpClient) { }


  getVans(): Observable<any>{
    return this.http.get(`${this.api}/vans`);
  }


  getMotorista(): Observable<any> {
    return this.http.get<any>(`${this.api}/funcionarios/motoristas`);
  }
}
