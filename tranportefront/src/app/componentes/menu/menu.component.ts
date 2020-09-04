import { Component, OnInit } from '@angular/core';
import { FormGroup, FormBuilder } from '@angular/forms';
import { AuthService } from 'src/app/services/auth.service';
import { TokenService } from 'src/app/services/token.service';
import { Router } from '@angular/router';

@Component({
  selector: 'app-menu',
  templateUrl: './menu.component.html',
  styleUrls: ['./menu.component.css']
})
export class MenuComponent implements OnInit {
 

  formlogin: FormGroup;
  errors: any = null;
  closemodal: any;

  constructor(private formbuild: FormBuilder, private auth: AuthService, private token: TokenService, private route: Router) {
    
    this.formlogin = this.formbuild.group({
      email: [''],
      password: ['']
    });
   }

  ngOnInit() {


  }

  closeModal(closemodal){
    this.closemodal = closemodal;
  }

  login() {
    this.auth.login(this.formlogin.value)
      .subscribe((res) => {
        this.token.setToken(res);
        this.closemodal.click();
        this.route.navigate(['/boleia']);
      },
        (error) => {
          if (error.error['error'] === "credencias_invalidas") {
            this.errors="Conta de Usuário Inválido..."
          }else{
            this.errors="Erro ao fazer login..."

          }
        }
      );

  }


}
