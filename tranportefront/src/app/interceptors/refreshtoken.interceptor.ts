import { Injectable, Injector } from '@angular/core';
import { HttpEvent, HttpInterceptor, HttpHandler, HttpRequest, HttpErrorResponse, HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { catchError, tap, flatMap } from 'rxjs/operators';
import { AuthService } from '../services/auth.service';
import { environment } from 'src/environments/environment';
import { ThrowStmt } from '@angular/compiler';
import { SwalService } from '../services/swal.service';
/** Classe responsavel por passar token em uma url do site que é acessada */

@Injectable()
export class RefreshTokenInterceptor implements HttpInterceptor {

    api = environment.API;

    constructor(private injector: Injector,  private swal: SwalService) { }

    intercept(req: HttpRequest<any>, next: HttpHandler): Observable<HttpEvent<any>> {


        return next.handle(req).pipe(

            catchError((error: any, caught: Observable<any>): Observable<any> => {

                if (error.statusText === 'Unauthorized' || error.status === 401) {

                    const http = this.injector.get(HttpClient);
                    return http.post(`${this.api}/refresh`, {}).pipe(
                        flatMap((data : {access_token: string}) => {
                            localStorage.setItem('usuario', data.access_token);
                            const newReq = req.clone({ setHeaders : { Authorization: `Bearer ${data.access_token}`, 'Content-Type': 'application/json' }});
                            return next.handle(newReq);
                        })
                    )

                }

                if (error.status === 500) {
                    this.swal.swalTitleText('Não foi possível iniciar a sessão', 'O servidor remoto não está disponível, tente mais tarde!', 'error');
                }

                return error;
            }));




    }
}
