import { Injectable } from '@angular/core';
import { Observable, of, throwError } from 'rxjs';
import { tap, delay, catchError, map } from 'rxjs/operators';
import { TokenService } from './token.service';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { environment } from 'src/environments/environment';
import { error } from 'protractor';

@Injectable({
  providedIn: 'root'
})
export class AuthService {

  api = environment.API;
  isLoggedIn = true;

  constructor(private http: HttpClient, private token: TokenService) { }


  // store the URL so we can redirect after logging in
  redirectUrl: string;

  login(usuario): Observable<any>{

    return this.http.post<any>(`${this.api}/login`, usuario).pipe(
      tap( (val: any) => {
        this.isLoggedIn = true;
      })
    )


  }

  getUserReload(): Observable<any> {
    return       this.http.get(`${this.api}/me`, {
      headers: new HttpHeaders()
      .set('Authorization', `Bearer ${localStorage.getItem('usuario')}`)
      .set('Content-Type', 'application/json')
    });
  }

  logout(): void {
    this.token.removerToken();
    this.isLoggedIn = false;
  }
}
