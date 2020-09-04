import { Injectable } from '@angular/core';
import { HttpClient, HttpEvent } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Marca } from 'src/app/models/marca.model';
import { environment } from 'src/environments/environment';
import { TokenService } from 'src/app/services/token.service';
import { Modelo } from 'src/app/models/modelo.model';
import { map } from 'rxjs/operators';


@Injectable({
  providedIn: 'root'
})
export class ModelosService {

  api = environment.API;

  constructor(private http: HttpClient) { }

  getAll(): Observable<Modelo> {
    return this.http.get<Modelo>(`${this.api}modelos`).pipe(
        map((res: any) =>  res.data )
    )
   
  }
  getById(id: number): Observable<Modelo> {
    return this.http.get<Modelo>(`${this.api}modelos/${id}`);
  }

  create(data: Modelo): Observable<Modelo> {
    return this.http.post<Modelo>(`${this.api}modelos`, data);
  }

  update(id: number, data: Modelo): Observable<Marca> {
    return this.http.put<Modelo>(`${this.api}modelos/${id}`, data);
  }

  delete(id: number): Observable<Modelo>{
    return this.http.delete<Modelo>(`${this.api}modelos/${id}`);
  }



}
