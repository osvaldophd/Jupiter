import { Injectable, Injector } from '@angular/core';
import { Observable, of } from 'rxjs';
import { tap, delay, flatMap } from 'rxjs/operators';
import { TokenService } from './token.service';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { environment } from 'src/environments/environment';

@Injectable({
  providedIn: 'root'
})
export class AuthService {

  api = environment.API;

  constructor(
    private http: HttpClient,
    private token: TokenService,
    private injector: Injector
  ) { }
  isLoggedIn = false;
  keyToken = environment.keyToken;

  // store the URL so we can redirect after logging in
  redirectUrl: string;

  login(usuario): Observable<any> {

    return this.http.post<any>(`${this.api}login`, usuario).pipe(
      tap((val: any) => {
        this.isLoggedIn = true;
      })
    )
  }

  getUser(): Observable<any> {
    return this.http.get(`${this.api}me`);
  }

  getUserReload(): Observable<any> {
    return this.http.get(`${this.api}me`, {
      headers: new HttpHeaders()
        .set('Authorization', `Bearer ${localStorage.getItem('usuario')}`)
        .set('Content-Type', 'application/json')
    });
  }

  VerifyisLoged(): boolean {
    const gettoken = localStorage.getItem('usuario');
    if (gettoken) {
      return true;
    }
    return false;
  }

  logout(): void {
    this.token.removerToken();
    this.isLoggedIn = false;
  }
}
