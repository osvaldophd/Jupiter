import { Injectable } from '@angular/core';
import {
  HttpEvent, HttpInterceptor, HttpHandler, HttpRequest
} from '@angular/common/http';

import { Observable } from 'rxjs';
import { environment } from 'src/environments/environment';
import { SwalService } from 'src/app/services/swal.service';

/** Classe responsavel por passar token em uma url do site que é acessada */
@Injectable()
export class AuthInterceptor implements HttpInterceptor {

  keyToken = environment.keyToken;

  constructor(private swalService: SwalService) {

  }

  intercept(req: HttpRequest<any>, next: HttpHandler):
    Observable<HttpEvent<any>> {

    const curentUrl: Array<any> = req.url.split('/');
    const apiUrl: Array<any> = environment.API.split('/');
    const token = localStorage.getItem(this.keyToken);

    if(curentUrl[2] === apiUrl[2]){
        const newReq = req.clone({ setHeaders : { Authorization: `Bearer ${token}`, 'Content-Type': 'application/json' }});
        return next.handle(newReq);
    }
    if (!token) {
      this.swalService.swalItervalRedirect('Atenticação de Usuário', 'A sua sessão expirou', 1000, true, '/login');
    }

    return next.handle(req);


  }
}