import { Injectable } from '@angular/core';
import { HttpClient, HttpEvent } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Profile } from './../profile.modul';
import { environment } from 'src/environments/environment';
import { TokenService } from 'src/app/services/token.service';

@Injectable({
  providedIn: 'root'
})
export class ProfileService {

  api = environment.API;

  constructor(private http: HttpClient, private token: TokenService) { }

      getAll(): Observable<Profile> {
        return this.http.post<Profile>(`${this.api}me`, {});
      }
      /* getById(id: number): Observable<ListaMarcas> {
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
      } */




}
