import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from 'src/environments/environment';

@Injectable({
  providedIn: 'root'
})
export class MunicipiosService {

  api = environment.API;

  constructor(private http: HttpClient) { }

  getMunicipios(): Observable<any>{
    return this.http.get<any>(`${this.api}municipios`);
  }

}
