import { Injectable } from '@angular/core';
import { HttpClient, HttpEvent, HttpSentEvent } from '@angular/common/http';
import { environment } from 'src/environments/environment';
import { TokenService } from 'src/app/services/token.service';
import { Observable } from 'rxjs';
import { Vans } from 'src/app/models/vans.model';
import { filter, map, tap } from 'rxjs/operators';
import { CreateVan } from '../models/createVan.model';
import { ListVans } from '../models/listVans.model';

@Injectable({
  providedIn: 'root'
})
export class VansService {

  api = environment.API;

  constructor(private http: HttpClient, private token: TokenService) {

  }

  getAll(): Observable<ListVans> {
    return this.http.get<ListVans>(`${this.api}vans`);
  }

  getById(id: number): Observable<ListVans> {
    return this.http.get<ListVans>(`${this.api}vans/${id}`);
  }

  deteteVan(id: number): Observable<Vans> {
    return this.http.delete<Vans>(`${this.api}vans/${id}`);
  }

  create(data: CreateVan): Observable<CreateVan> {
    return this.http.post<CreateVan>(`${this.api}vans`, data);
  }

  update(id: number, data: CreateVan): Observable<CreateVan> {
    return this.http.put<CreateVan>(`${this.api}vans/${id}`, data);
  }

  getByMarcaId(){

  }
  /*
  setVan(data): Observable<HttpEvent<Vans>> {
    this.http.post<Vans>(this.api, data, this.token.TokenAutorization()).pipe(
        map(
          (res)=> {

          }

        )
    )
  }


  */
}
