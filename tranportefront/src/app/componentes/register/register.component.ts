import { Component, OnInit } from '@angular/core';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { UsuarioService } from 'src/app/services/usuario.service';
import { UserRegister } from 'src/app/models/registarUser.model';

@Component({
  selector: 'app-register',
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.css']
})
export class RegisterComponent implements OnInit {

  formregistar: FormGroup;
  resultado: boolean = false;
  mask = {
    matricula: [/[A-Z]/, /[A-Z]/, '-', /\d/, /\d/, '-', /[A-Z]/, /[A-Z]/],
    telefone: [/[0-9]/, /[0-9]/, /[0-9]/, ' ', /[0-9]/, /[0-9]/, /[0-9]/, ' ', /[0-9]/, /[0-9]/, /[0-9]/],
    bi:  [/[0-9]/, /[0-9]/, /[0-9]/, /[0-9]/, /[0-9]/, /[0-9]/, /[0-9]/, /[0-9]/, /[0-9]/,  /[A-Z]/, /[A-Z]/, /[0-9]/, /[0-9]/, /[0-9]/ ]
  };

  constructor(private formbuild: FormBuilder, private usuarioService: UsuarioService) {
    this.formregistar = this.formbuild.group({
      name: ['', Validators.required],
      email: ['', Validators.email],
      contacto: ['', Validators.required],
      password: ['', [Validators.required, Validators.minLength(5)]],
      genero: ['', Validators.required]
    });
  }

  ngOnInit() {

  }

  registar() {
    console.log(this.formregistar.value);

    const userRegister: UserRegister = {
      nome: this.formregistar.get('name').value,
      genero: this.formregistar.get('genero').value,
      usuario: {
        name: (this.formregistar.get('name').value).toLowerCase(),
        email: this.formregistar.get('email').value,
        password: this.formregistar.get('password').value,
        roles: [3]
      },
      contactos: [
        { contacto: this.formregistar.get('contacto').value, "tipo":"telemovel" }
      ],
    }


    console.log(userRegister)
    this.usuarioService.register(userRegister).subscribe(
      (res) => {

        this.formregistar.reset();
        this.formregistar.markAsPristine();
        this.resultado = true

        console.log(res);
      }
    )
  }

  get name() { return this.formregistar.get('name'); }
  get email() { return this.formregistar.get('email'); }
  get contacto() { return this.formregistar.get('contacto'); }
  get password() { return this.formregistar.get('password'); }
  get genero() { return this.formregistar.get('genero'); }

}
