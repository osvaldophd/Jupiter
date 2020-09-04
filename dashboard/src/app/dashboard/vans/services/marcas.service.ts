import { Injectable } from '@angular/core';
import { HttpClient, HttpEvent } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Marca } from 'src/app/models/marca.model';
import { environment } from 'src/environments/environment';
import { TokenService } from 'src/app/services/token.service';
import { ListaMarcas } from '../models/listaMarcas.model';

@Injectable({
  providedIn: 'root'
})
export class MarcasService {

  api = environment.API;

  constructor(private http: HttpClient, private token: TokenService) { }

      getAll(): Observable<ListaMarcas> {
        return this.http.get<ListaMarcas>(`${this.api}marcas`);
      }
      getById(id: number): Observable<ListaMarcas> {
        return this.http.get<ListaMarcas>(`${this.api}marcas/${id}`);
      }

      create(data: Marca): Observable<Marca> {
        return this.http.post<Marca>(`${this.api}marcas`, data);
      }

      delete(id: number): Observable<Marca> {
        return this.http.delete<Marca>(`${this.api}marcas/${id}`);
      }
      

      update(id: number, data: Marca): Observable<Marca> {
        return this.http.put<Marca>(`${this.api}marcas/${id}`, data);
      }




}
